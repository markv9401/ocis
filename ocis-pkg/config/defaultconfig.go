package config

import (
	appProvider "github.com/owncloud/ocis/v2/services/app-provider/pkg/config/defaults"
	appRegistry "github.com/owncloud/ocis/v2/services/app-registry/pkg/config/defaults"
	audit "github.com/owncloud/ocis/v2/services/audit/pkg/config/defaults"
	authbasic "github.com/owncloud/ocis/v2/services/auth-basic/pkg/config/defaults"
	authbearer "github.com/owncloud/ocis/v2/services/auth-bearer/pkg/config/defaults"
	authmachine "github.com/owncloud/ocis/v2/services/auth-machine/pkg/config/defaults"
	frontend "github.com/owncloud/ocis/v2/services/frontend/pkg/config/defaults"
	gateway "github.com/owncloud/ocis/v2/services/gateway/pkg/config/defaults"
	graph "github.com/owncloud/ocis/v2/services/graph/pkg/config/defaults"
	groups "github.com/owncloud/ocis/v2/services/groups/pkg/config/defaults"
	idm "github.com/owncloud/ocis/v2/services/idm/pkg/config/defaults"
	idp "github.com/owncloud/ocis/v2/services/idp/pkg/config/defaults"
	nats "github.com/owncloud/ocis/v2/services/nats/pkg/config/defaults"
	notifications "github.com/owncloud/ocis/v2/services/notifications/pkg/config/defaults"
	ocdav "github.com/owncloud/ocis/v2/services/ocdav/pkg/config/defaults"
	ocs "github.com/owncloud/ocis/v2/services/ocs/pkg/config/defaults"
	proxy "github.com/owncloud/ocis/v2/services/proxy/pkg/config/defaults"
	search "github.com/owncloud/ocis/v2/services/search/pkg/config/defaults"
	settings "github.com/owncloud/ocis/v2/services/settings/pkg/config/defaults"
	sharing "github.com/owncloud/ocis/v2/services/sharing/pkg/config/defaults"
	storagepublic "github.com/owncloud/ocis/v2/services/storage-publiclink/pkg/config/defaults"
	storageshares "github.com/owncloud/ocis/v2/services/storage-shares/pkg/config/defaults"
	storageSystem "github.com/owncloud/ocis/v2/services/storage-system/pkg/config/defaults"
	storageusers "github.com/owncloud/ocis/v2/services/storage-users/pkg/config/defaults"
	store "github.com/owncloud/ocis/v2/services/store/pkg/config/defaults"
	thumbnails "github.com/owncloud/ocis/v2/services/thumbnails/pkg/config/defaults"
	users "github.com/owncloud/ocis/v2/services/users/pkg/config/defaults"
	web "github.com/owncloud/ocis/v2/services/web/pkg/config/defaults"
	webdav "github.com/owncloud/ocis/v2/services/webdav/pkg/config/defaults"
)

func DefaultConfig() *Config {
	return &Config{
		OcisURL: "https://localhost:9200",
		Runtime: Runtime{
			Port: "9250",
			Host: "localhost",
		},

		AppProvider:       appProvider.DefaultConfig(),
		AppRegistry:       appRegistry.DefaultConfig(),
		Audit:             audit.DefaultConfig(),
		AuthBasic:         authbasic.DefaultConfig(),
		AuthBearer:        authbearer.DefaultConfig(),
		AuthMachine:       authmachine.DefaultConfig(),
		Frontend:          frontend.DefaultConfig(),
		Gateway:           gateway.DefaultConfig(),
		Graph:             graph.DefaultConfig(),
		Groups:            groups.DefaultConfig(),
		IDM:               idm.DefaultConfig(),
		IDP:               idp.DefaultConfig(),
		Nats:              nats.DefaultConfig(),
		Notifications:     notifications.DefaultConfig(),
		OCDav:             ocdav.DefaultConfig(),
		OCS:               ocs.DefaultConfig(),
		Proxy:             proxy.DefaultConfig(),
		Search:            search.FullDefaultConfig(),
		Settings:          settings.DefaultConfig(),
		Sharing:           sharing.DefaultConfig(),
		StoragePublicLink: storagepublic.DefaultConfig(),
		StorageShares:     storageshares.DefaultConfig(),
		StorageSystem:     storageSystem.DefaultConfig(),
		StorageUsers:      storageusers.DefaultConfig(),
		Store:             store.DefaultConfig(),
		Thumbnails:        thumbnails.DefaultConfig(),
		Users:             users.DefaultConfig(),
		Web:               web.DefaultConfig(),
		WebDAV:            webdav.DefaultConfig(),
	}
}
