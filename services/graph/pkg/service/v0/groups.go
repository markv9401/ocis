package svc

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/url"
	"sort"
	"strings"

	"github.com/CiscoM31/godata"
	libregraph "github.com/owncloud/libre-graph-api-go"
	"github.com/owncloud/ocis/v2/services/graph/pkg/service/v0/errorcode"

	ctxpkg "github.com/cs3org/reva/v2/pkg/ctx"
	"github.com/cs3org/reva/v2/pkg/events"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/render"
)

const memberRefsLimit = 20

// GetGroups implements the Service interface.
func (g Graph) GetGroups(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Interface("query", r.URL.Query()).Msg("calling get groups")
	sanitizedPath := strings.TrimPrefix(r.URL.Path, "/graph/v1.0/")
	odataReq, err := godata.ParseRequest(r.Context(), sanitizedPath, r.URL.Query())
	if err != nil {
		logger.Debug().Err(err).Interface("query", r.URL.Query()).Msg("could not get groups: query error")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, err.Error())
		return
	}

	groups, err := g.identityBackend.GetGroups(r.Context(), r.URL.Query())
	if err != nil {
		logger.Debug().Err(err).Msg("could not get groups: backend error")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
	}

	groups, err = sortGroups(odataReq, groups)
	if err != nil {
		logger.Debug().Err(err).Interface("query", r.URL.Query()).Msg("cannot get groups: could not sort groups according to query")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, err.Error())
		return
	}
	render.Status(r, http.StatusOK)
	render.JSON(w, r, &listResponse{Value: groups})
}

// PostGroup implements the Service interface.
func (g Graph) PostGroup(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("calling post group")
	grp := libregraph.NewGroup()
	err := json.NewDecoder(r.Body).Decode(grp)
	if err != nil {
		logger.Debug().Err(err).Interface("body", r.Body).Msg("could not create group: invalid request body")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, fmt.Sprintf("invalid request body: %s", err.Error()))
		return
	}

	if _, ok := grp.GetDisplayNameOk(); !ok {
		logger.Debug().Err(err).Interface("group", grp).Msg("could not create group: missing required attribute")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "Missing Required Attribute")
		return
	}

	// Disallow user-supplied IDs. It's supposed to be readonly. We're either
	// generating them in the backend ourselves or rely on the Backend's
	// storage (e.g. LDAP) to provide a unique ID.
	if _, ok := grp.GetIdOk(); ok {
		logger.Debug().Msg("could not create group: id is a read-only attribute")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "group id is a read-only attribute")
		return
	}

	if grp, err = g.identityBackend.CreateGroup(r.Context(), *grp); err != nil {
		logger.Debug().Interface("group", grp).Msg("could not create group: backend error")
		errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		return
	}

	if grp != nil && grp.Id != nil {
		currentUser := ctxpkg.ContextMustGetUser(r.Context())
		g.publishEvent(events.GroupCreated{Executant: currentUser.Id, GroupID: *grp.Id})
	}
	render.Status(r, http.StatusOK)
	render.JSON(w, r, grp)
}

// PatchGroup implements the Service interface.
func (g Graph) PatchGroup(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("calling patch group")
	groupID := chi.URLParam(r, "groupID")
	groupID, err := url.PathUnescape(groupID)
	if err != nil {
		logger.Debug().Str("id", groupID).Msg("could not change group: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
		return
	}

	if groupID == "" {
		logger.Debug().Msg("could not change group: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}
	changes := libregraph.NewGroup()
	err = json.NewDecoder(r.Body).Decode(changes)
	if err != nil {
		logger.Debug().Err(err).Interface("body", r.Body).Msg("could not change group: invalid request body")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, fmt.Sprintf("invalid request body: %s", err.Error()))
		return
	}

	if memberRefs, ok := changes.GetMembersodataBindOk(); ok {
		// The spec defines a limit of 20 members maxium per Request
		if len(memberRefs) > memberRefsLimit {
			logger.Debug().
				Int("number", len(memberRefs)).
				Int("limit", memberRefsLimit).
				Msg("could not create group, exceeded members limit")
			errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest,
				fmt.Sprintf("Request is limited to %d members", memberRefsLimit))
			return
		}
		memberIDs := make([]string, 0, len(memberRefs))
		for _, memberRef := range memberRefs {
			memberType, id, err := g.parseMemberRef(memberRef)
			if err != nil {
				logger.Debug().
					Str("memberref", memberRef).
					Msg("could not change group: Error parsing member@odata.bind values")
				errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "Error parsing member@odata.bind values")
				return
			}
			logger.Debug().Str("membertype", memberType).Str("memberid", id).Msg("add group member")
			// The MS Graph spec allows "directoryObject", "user", "group" and "organizational Contact"
			// we restrict this to users for now. Might add Groups as members later
			if memberType != "users" {
				logger.Debug().
					Str("type", memberType).
					Msg("could not change group: could not add member, only user type is allowed")
				errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "Only user are allowed as group members")
				return
			}
			memberIDs = append(memberIDs, id)
		}
		err = g.identityBackend.AddMembersToGroup(r.Context(), groupID, memberIDs)
	}

	if err != nil {
		logger.Debug().Err(err).Msg("could not change group: backend could not add members")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
		return
	}
	render.Status(r, http.StatusNoContent)
	render.NoContent(w, r)
}

// GetGroup implements the Service interface.
func (g Graph) GetGroup(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("calling get group")
	groupID := chi.URLParam(r, "groupID")
	groupID, err := url.PathUnescape(groupID)
	if err != nil {
		logger.Debug().Str("id", groupID).Msg("could not get group: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
	}

	if groupID == "" {
		logger.Debug().Msg("could not get group: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}

	logger.Debug().
		Str("id", groupID).
		Interface("query", r.URL.Query()).
		Msg("calling get group on backend")
	group, err := g.identityBackend.GetGroup(r.Context(), groupID, r.URL.Query())
	if err != nil {
		logger.Debug().Err(err).Msg("could not get group: backend error")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
	}

	render.Status(r, http.StatusOK)
	render.JSON(w, r, group)
}

// DeleteGroup implements the Service interface.
func (g Graph) DeleteGroup(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("calling delete group")
	groupID := chi.URLParam(r, "groupID")
	groupID, err := url.PathUnescape(groupID)
	if err != nil {
		logger.Debug().Err(err).Str("id", groupID).Msg("could not delete group: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
		return
	}

	if groupID == "" {
		logger.Debug().Msg("could not delete group: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}

	logger.Debug().Str("id", groupID).Msg("calling delete group on backend")
	err = g.identityBackend.DeleteGroup(r.Context(), groupID)

	if err != nil {
		logger.Debug().Err(err).Msg("could not delete group: backend error")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
		return
	}

	currentUser := ctxpkg.ContextMustGetUser(r.Context())
	g.publishEvent(events.GroupDeleted{Executant: currentUser.Id, GroupID: groupID})
	render.Status(r, http.StatusNoContent)
	render.NoContent(w, r)
}

func (g Graph) GetGroupMembers(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("calling get group members")
	groupID := chi.URLParam(r, "groupID")
	groupID, err := url.PathUnescape(groupID)
	if err != nil {
		logger.Debug().Str("id", groupID).Msg("could not get group members: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
		return
	}

	if groupID == "" {
		logger.Debug().Msg("could not get group members: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}

	logger.Debug().Str("id", groupID).Msg("calling get group members on backend")
	members, err := g.identityBackend.GetGroupMembers(r.Context(), groupID)
	if err != nil {
		logger.Debug().Err(err).Msg("could not get group members: backend error")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
		return
	}

	render.Status(r, http.StatusOK)
	render.JSON(w, r, members)
}

// PostGroupMember implements the Service interface.
func (g Graph) PostGroupMember(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("Calling post group member")

	groupID := chi.URLParam(r, "groupID")
	groupID, err := url.PathUnescape(groupID)
	if err != nil {
		logger.Debug().
			Err(err).
			Str("id", groupID).
			Msg("could not add member to group: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
		return
	}

	if groupID == "" {
		logger.Debug().Msg("could not add group member: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}
	memberRef := libregraph.NewMemberReference()
	err = json.NewDecoder(r.Body).Decode(memberRef)
	if err != nil {
		logger.Debug().
			Err(err).
			Interface("body", r.Body).
			Msg("could not add group member: invalid request body")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, fmt.Sprintf("invalid request body: %s", err.Error()))
		return
	}
	memberRefURL, ok := memberRef.GetOdataIdOk()
	if !ok {
		logger.Debug().Msg("could not add group member: @odata.id reference is missing")
		errorcode.InvalidRequest.Render(w, r, http.StatusInternalServerError, "@odata.id reference is missing")
		return
	}
	memberType, id, err := g.parseMemberRef(*memberRefURL)
	if err != nil {
		logger.Debug().Err(err).Msg("could not add group member: error parsing @odata.id url")
		errorcode.InvalidRequest.Render(w, r, http.StatusInternalServerError, "Error parsing @odata.id url")
		return
	}
	// The MS Graph spec allows "directoryObject", "user", "group" and "organizational Contact"
	// we restrict this to users for now. Might add Groups as members later
	if memberType != "users" {
		logger.Debug().Str("type", memberType).Msg("could not add group member: Only users are allowed as group members")
		errorcode.InvalidRequest.Render(w, r, http.StatusInternalServerError, "Only users are allowed as group members")
		return
	}

	logger.Debug().Str("memberType", memberType).Str("id", id).Msg("calling add member on backend")
	err = g.identityBackend.AddMembersToGroup(r.Context(), groupID, []string{id})

	if err != nil {
		logger.Debug().Err(err).Msg("could not add group member: backend error")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
		return
	}

	currentUser := ctxpkg.ContextMustGetUser(r.Context())
	g.publishEvent(events.GroupMemberAdded{Executant: currentUser.Id, GroupID: groupID, UserID: id})
	render.Status(r, http.StatusNoContent)
	render.NoContent(w, r)
}

// DeleteGroupMember implements the Service interface.
func (g Graph) DeleteGroupMember(w http.ResponseWriter, r *http.Request) {
	logger := g.logger.SubloggerWithRequestID(r.Context())
	logger.Info().Msg("calling delete group member")

	groupID := chi.URLParam(r, "groupID")
	groupID, err := url.PathUnescape(groupID)
	if err != nil {
		logger.Debug().Err(err).Str("id", groupID).Msg("could not delete group member: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
		return
	}

	if groupID == "" {
		logger.Debug().Msg("could not delete group member: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}

	memberID := chi.URLParam(r, "memberID")
	memberID, err = url.PathUnescape(memberID)
	if err != nil {
		logger.Debug().Err(err).Str("id", memberID).Msg("could not delete group member: unescaping group id failed")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "unescaping group id failed")
		return
	}

	if memberID == "" {
		logger.Debug().Msg("could not delete group member: missing group id")
		errorcode.InvalidRequest.Render(w, r, http.StatusBadRequest, "missing group id")
		return
	}
	logger.Debug().Str("groupID", groupID).Str("memberID", memberID).Msg("calling delete member on backend")
	err = g.identityBackend.RemoveMemberFromGroup(r.Context(), groupID, memberID)

	if err != nil {
		logger.Debug().Err(err).Msg("could not delete group member: backend error")
		var errcode errorcode.Error
		if errors.As(err, &errcode) {
			errcode.Render(w, r)
		} else {
			errorcode.GeneralException.Render(w, r, http.StatusInternalServerError, err.Error())
		}
		return
	}
	currentUser := ctxpkg.ContextMustGetUser(r.Context())
	g.publishEvent(events.GroupMemberRemoved{Executant: currentUser.Id, GroupID: groupID, UserID: memberID})
	render.Status(r, http.StatusNoContent)
	render.NoContent(w, r)
}

func (g Graph) parseMemberRef(ref string) (string, string, error) {
	memberURL, err := url.ParseRequestURI(ref)
	if err != nil {
		return "", "", err
	}
	segments := strings.Split(memberURL.Path, "/")
	if len(segments) < 2 {
		return "", "", errors.New("invalid member reference")
	}
	id := segments[len(segments)-1]
	memberType := segments[len(segments)-2]
	return memberType, id, nil
}

func sortGroups(req *godata.GoDataRequest, groups []*libregraph.Group) ([]*libregraph.Group, error) {
	var sorter sort.Interface
	if req.Query.OrderBy == nil || len(req.Query.OrderBy.OrderByItems) != 1 {
		return groups, nil
	}
	switch req.Query.OrderBy.OrderByItems[0].Field.Value {
	case "displayName":
		sorter = groupsByDisplayName{groups}
	default:
		return nil, fmt.Errorf("we do not support <%s> as a order parameter", req.Query.OrderBy.OrderByItems[0].Field.Value)
	}

	if req.Query.OrderBy.OrderByItems[0].Order == "desc" {
		sorter = sort.Reverse(sorter)
	}
	sort.Sort(sorter)
	return groups, nil
}
