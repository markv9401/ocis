// Code generated by protoc-gen-micro. DO NOT EDIT.
// source: pkg/proto/v0/accounts.proto

package proto

import (
	fmt "fmt"
	math "math"

	proto "github.com/golang/protobuf/proto"

	context "context"

	client "github.com/micro/go-micro/client"

	server "github.com/micro/go-micro/server"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ client.Option
var _ server.Option

// Client API for SettingsService service

type SettingsService interface {
	Set(ctx context.Context, in *SettingsRequest, opts ...client.CallOption) (*SettingsResponse, error)
	Get(ctx context.Context, in *AccountQueryRequest, opts ...client.CallOption) (*SettingsResponse, error)
}

type settingsService struct {
	c    client.Client
	name string
}

func NewSettingsService(name string, c client.Client) SettingsService {
	if c == nil {
		c = client.NewClient()
	}
	if len(name) == 0 {
		name = "settingsservice"
	}
	return &settingsService{
		c:    c,
		name: name,
	}
}

func (c *settingsService) Set(ctx context.Context, in *SettingsRequest, opts ...client.CallOption) (*SettingsResponse, error) {
	req := c.c.NewRequest(c.name, "SettingsService.Set", in)
	out := new(SettingsResponse)
	err := c.c.Call(ctx, req, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *settingsService) Get(ctx context.Context, in *AccountQueryRequest, opts ...client.CallOption) (*SettingsResponse, error) {
	req := c.c.NewRequest(c.name, "SettingsService.Get", in)
	out := new(SettingsResponse)
	err := c.c.Call(ctx, req, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// Server API for SettingsService service

type SettingsServiceHandler interface {
	Set(context.Context, *SettingsRequest, *SettingsResponse) error
	Get(context.Context, *AccountQueryRequest, *SettingsResponse) error
}

func RegisterSettingsServiceHandler(s server.Server, hdlr SettingsServiceHandler, opts ...server.HandlerOption) error {
	type settingsService interface {
		Set(ctx context.Context, in *SettingsRequest, out *SettingsResponse) error
		Get(ctx context.Context, in *AccountQueryRequest, out *SettingsResponse) error
	}
	type SettingsService struct {
		settingsService
	}
	h := &settingsServiceHandler{hdlr}
	return s.Handle(s.NewHandler(&SettingsService{h}, opts...))
}

type settingsServiceHandler struct {
	SettingsServiceHandler
}

func (h *settingsServiceHandler) Set(ctx context.Context, in *SettingsRequest, out *SettingsResponse) error {
	return h.SettingsServiceHandler.Set(ctx, in, out)
}

func (h *settingsServiceHandler) Get(ctx context.Context, in *AccountQueryRequest, out *SettingsResponse) error {
	return h.SettingsServiceHandler.Get(ctx, in, out)
}
