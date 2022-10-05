module github.com/owncloud/ocis/v2

go 1.18

require (
	github.com/CiscoM31/godata v1.0.5
	github.com/Masterminds/semver v1.5.0
	github.com/MicahParks/keyfunc v1.4.0
	github.com/armon/go-radix v1.0.0
	github.com/blevesearch/bleve/v2 v2.3.4
	github.com/blevesearch/bleve_index_api v1.0.3
	github.com/coreos/go-oidc/v3 v3.4.0
	github.com/cs3org/go-cs3apis v0.0.0-20220929083235-bb0b1a236d6c
	github.com/cs3org/reva/v2 v2.10.1-0.20221004120309-40430d529c4e
	github.com/disintegration/imaging v1.6.2
	github.com/ggwhite/go-masker v1.0.9
	github.com/go-chi/chi/v5 v5.0.7
	github.com/go-chi/cors v1.2.1
	github.com/go-chi/render v1.0.2
	github.com/go-ldap/ldap/v3 v3.4.4
	github.com/go-ldap/ldif v0.0.0-20200320164324-fd88d9b715b3
	github.com/go-micro/plugins/v4/client/grpc v1.1.0
	github.com/go-micro/plugins/v4/events/natsjs v1.1.0
	github.com/go-micro/plugins/v4/logger/zerolog v1.1.0
	github.com/go-micro/plugins/v4/registry/consul v1.1.0
	github.com/go-micro/plugins/v4/registry/etcd v1.1.0
	github.com/go-micro/plugins/v4/registry/kubernetes v1.1.0
	github.com/go-micro/plugins/v4/registry/mdns v1.1.0
	github.com/go-micro/plugins/v4/registry/memory v1.1.0
	github.com/go-micro/plugins/v4/registry/nats v1.1.0
	github.com/go-micro/plugins/v4/server/grpc v1.1.1
	github.com/go-micro/plugins/v4/server/http v1.1.0
	github.com/go-micro/plugins/v4/wrapper/breaker/gobreaker v1.1.0
	github.com/go-micro/plugins/v4/wrapper/monitoring/prometheus v1.1.0
	github.com/go-micro/plugins/v4/wrapper/trace/opencensus v1.1.0
	github.com/go-ozzo/ozzo-validation/v4 v4.3.0
	github.com/gofrs/uuid v4.3.0+incompatible
	github.com/golang-jwt/jwt/v4 v4.4.2
	github.com/golang/protobuf v1.5.2
	github.com/gookit/config/v2 v2.1.6
	github.com/gorilla/mux v1.8.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.11.3
	github.com/jellydator/ttlcache/v2 v2.11.1
	github.com/justinas/alice v1.2.0
	github.com/libregraph/idm v0.3.1-0.20220808071235-17bb032176de
	github.com/libregraph/lico v0.54.1-0.20220325072321-31efc3995d63
	github.com/mitchellh/mapstructure v1.5.0
	github.com/mohae/deepcopy v0.0.0-20170929034955-c48cc78d4826
	github.com/nats-io/nats-server/v2 v2.9.2
	github.com/oklog/run v1.1.0
	github.com/olekukonko/tablewriter v0.0.5
	github.com/onsi/ginkgo v1.16.5
	github.com/onsi/ginkgo/v2 v2.2.0
	github.com/onsi/gomega v1.20.2
	github.com/orcaman/concurrent-map v1.0.0
	github.com/owncloud/libre-graph-api-go v0.17.0
	github.com/pkg/errors v0.9.1
	github.com/prometheus/client_golang v1.13.0
	github.com/rs/zerolog v1.28.0
	github.com/sirupsen/logrus v1.9.0
	github.com/spf13/cobra v1.5.0
	github.com/stretchr/testify v1.8.0
	github.com/test-go/testify v1.1.4
	github.com/thejerf/suture/v4 v4.0.2
	github.com/tus/tusd v1.9.2
	github.com/urfave/cli/v2 v2.17.1
	github.com/xhit/go-simple-mail/v2 v2.12.0
	go-micro.dev/v4 v4.9.0
	go.etcd.io/bbolt v1.3.6
	go.etcd.io/etcd/client/v3 v3.5.5
	go.opencensus.io v0.23.0
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.36.1
	go.opentelemetry.io/otel v1.10.0
	go.opentelemetry.io/otel/exporters/jaeger v1.10.0
	go.opentelemetry.io/otel/sdk v1.10.0
	go.opentelemetry.io/otel/trace v1.10.0
	golang.org/x/crypto v0.0.0-20220926161630-eccd6366d1be
	golang.org/x/exp v0.0.0-20220518171630-0b5c67f07fdf
	golang.org/x/image v0.0.0-20220321031419-a8550c1d254a
	golang.org/x/net v0.0.0-20220921155015-db77216a4ee9
	golang.org/x/oauth2 v0.0.0-20220822191816-0ebed06d0094
	golang.org/x/term v0.0.0-20220722155259-a9ba230a4035
	golang.org/x/text v0.3.7
	google.golang.org/genproto v0.0.0-20220920201722-2b89144ce006
	google.golang.org/grpc v1.49.0
	google.golang.org/protobuf v1.28.1
	gopkg.in/yaml.v2 v2.4.0
	gotest.tools/v3 v3.3.0
	stash.kopano.io/kgol/oidc-go v0.3.4
	stash.kopano.io/kgol/rndm v1.1.1
)

require (
	contrib.go.opencensus.io/exporter/prometheus v0.4.1 // indirect
	github.com/Azure/go-ntlmssp v0.0.0-20220621081337-cb9428e4ac1e // indirect
	github.com/BurntSushi/toml v1.2.0 // indirect
	github.com/Masterminds/goutils v1.1.1 // indirect
	github.com/Masterminds/sprig v2.22.0+incompatible // indirect
	github.com/Microsoft/go-winio v0.5.2 // indirect
	github.com/ProtonMail/go-crypto v0.0.0-20220824120805-4b6e5c587895 // indirect
	github.com/ReneKroon/ttlcache/v2 v2.11.0 // indirect
	github.com/RoaringBitmap/roaring v0.9.4 // indirect
	github.com/acomagu/bufpipe v1.0.3 // indirect
	github.com/ajg/form v1.5.1 // indirect
	github.com/alexedwards/argon2id v0.0.0-20211130144151-3585854a6387 // indirect
	github.com/amoghe/go-crypt v0.0.0-20220222110647-20eada5f5964 // indirect
	github.com/armon/go-metrics v0.4.1 // indirect
	github.com/asaskevich/govalidator v0.0.0-20210307081110-f21760c49a8d // indirect
	github.com/aws/aws-sdk-go v1.44.94 // indirect
	github.com/beevik/etree v1.1.0 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/bitly/go-simplejson v0.5.0 // indirect
	github.com/bits-and-blooms/bitset v1.2.1 // indirect
	github.com/blevesearch/geo v0.1.13 // indirect
	github.com/blevesearch/go-porterstemmer v1.0.3 // indirect
	github.com/blevesearch/gtreap v0.1.1 // indirect
	github.com/blevesearch/mmap-go v1.0.4 // indirect
	github.com/blevesearch/scorch_segment_api/v2 v2.1.2 // indirect
	github.com/blevesearch/segment v0.9.0 // indirect
	github.com/blevesearch/snowballstem v0.9.0 // indirect
	github.com/blevesearch/upsidedown_store_api v1.0.1 // indirect
	github.com/blevesearch/vellum v1.0.8 // indirect
	github.com/blevesearch/zapx/v11 v11.3.5 // indirect
	github.com/blevesearch/zapx/v12 v12.3.5 // indirect
	github.com/blevesearch/zapx/v13 v13.3.5 // indirect
	github.com/blevesearch/zapx/v14 v14.3.5 // indirect
	github.com/blevesearch/zapx/v15 v15.3.5 // indirect
	github.com/bluele/gcache v0.0.2 // indirect
	github.com/bmizerany/pat v0.0.0-20210406213842-e4b6760bdd6f // indirect
	github.com/bombsimon/logrusr/v3 v3.0.0 // indirect
	github.com/cenkalti/backoff v2.2.1+incompatible // indirect
	github.com/ceph/go-ceph v0.15.0 // indirect
	github.com/cespare/xxhash/v2 v2.1.2 // indirect
	github.com/cevaris/ordered_map v0.0.0-20190319150403-3adeae072e73 // indirect
	github.com/cloudflare/circl v1.2.0 // indirect
	github.com/coreos/go-oidc v2.2.1+incompatible // indirect
	github.com/coreos/go-semver v0.3.0 // indirect
	github.com/coreos/go-systemd/v22 v22.4.0 // indirect
	github.com/cpuguy83/go-md2man/v2 v2.0.2 // indirect
	github.com/crewjam/httperr v0.2.0 // indirect
	github.com/crewjam/saml v0.4.6 // indirect
	github.com/cubewise-code/go-mime v0.0.0-20200519001935-8c5762b177d8 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/deckarep/golang-set v1.8.0 // indirect
	github.com/desertbit/timer v0.0.0-20180107155436-c41aec40b27f // indirect
	github.com/dgraph-io/ristretto v0.1.0 // indirect
	github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f // indirect
	github.com/dlclark/regexp2 v1.4.0 // indirect
	github.com/dustin/go-humanize v1.0.0 // indirect
	github.com/emirpasic/gods v1.18.1 // indirect
	github.com/emvi/iso-639-1 v1.0.1 // indirect
	github.com/eternnoir/gncp v0.0.0-20170707042257-c70df2d0cd68 // indirect
	github.com/evanphx/json-patch/v5 v5.5.0 // indirect
	github.com/fatih/color v1.13.0 // indirect
	github.com/felixge/httpsnoop v1.0.1 // indirect
	github.com/fsnotify/fsnotify v1.5.4 // indirect
	github.com/gabriel-vasile/mimetype v1.4.0 // indirect
	github.com/gdexlab/go-render v1.0.1 // indirect
	github.com/go-acme/lego/v4 v4.4.0 // indirect
	github.com/go-asn1-ber/asn1-ber v1.5.4 // indirect
	github.com/go-chi/chi v4.1.2+incompatible // indirect
	github.com/go-git/gcfg v1.5.0 // indirect
	github.com/go-git/go-billy/v5 v5.3.1 // indirect
	github.com/go-git/go-git/v5 v5.4.2 // indirect
	github.com/go-kit/log v0.2.0 // indirect
	github.com/go-logfmt/logfmt v0.5.1 // indirect
	github.com/go-logr/logr v1.2.3 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-micro/plugins/v4/store/nats-js v1.1.0 // indirect
	github.com/go-micro/plugins/v4/store/redis v1.1.0 // indirect
	github.com/go-redis/redis/v8 v8.10.0 // indirect
	github.com/go-sql-driver/mysql v1.6.0 // indirect
	github.com/go-task/slim-sprig v0.0.0-20210107165309-348f09dbbbc0 // indirect
	github.com/gobwas/httphead v0.1.0 // indirect
	github.com/gobwas/pool v0.2.1 // indirect
	github.com/gobwas/ws v1.0.4 // indirect
	github.com/gofrs/flock v0.8.1 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang-jwt/jwt v3.2.2+incompatible // indirect
	github.com/golang/geo v0.0.0-20210211234256-740aa86cb551 // indirect
	github.com/golang/glog v1.0.0 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/gomodule/redigo v1.8.9 // indirect
	github.com/google/go-cmp v0.5.8 // indirect
	github.com/google/go-querystring v1.1.0 // indirect
	github.com/google/uuid v1.3.0 // indirect
	github.com/gookit/goutil v0.5.12 // indirect
	github.com/gorilla/handlers v1.5.1 // indirect
	github.com/gorilla/schema v1.2.0 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware v1.3.0 // indirect
	github.com/hashicorp/consul/api v1.15.2 // indirect
	github.com/hashicorp/go-cleanhttp v0.5.2 // indirect
	github.com/hashicorp/go-hclog v1.3.1 // indirect
	github.com/hashicorp/go-immutable-radix v1.3.1 // indirect
	github.com/hashicorp/go-msgpack v1.1.5 // indirect
	github.com/hashicorp/go-plugin v1.4.4 // indirect
	github.com/hashicorp/go-rootcerts v1.0.2 // indirect
	github.com/hashicorp/golang-lru v0.5.4 // indirect
	github.com/hashicorp/serf v0.10.0 // indirect
	github.com/hashicorp/yamux v0.0.0-20211028200310-0bc27b27de87 // indirect
	github.com/huandu/xstrings v1.3.2 // indirect
	github.com/iancoleman/strcase v0.2.0 // indirect
	github.com/imdario/mergo v0.3.13 // indirect
	github.com/inconshreveable/mousetrap v1.0.0 // indirect
	github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/jonboulle/clockwork v0.2.2 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/juliangruber/go-intersect v1.1.0 // indirect
	github.com/kevinburke/ssh_config v1.2.0 // indirect
	github.com/klauspost/compress v1.15.11 // indirect
	github.com/klauspost/cpuid/v2 v2.0.9 // indirect
	github.com/longsleep/go-metrics v1.0.0 // indirect
	github.com/mattermost/xml-roundtrip-validator v0.1.0 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.16 // indirect
	github.com/mattn/go-runewidth v0.0.13 // indirect
	github.com/mattn/go-sqlite3 v2.0.3+incompatible // indirect
	github.com/matttproud/golang_protobuf_extensions v1.0.1 // indirect
	github.com/maxymania/go-system v0.0.0-20170110133659-647cc364bf0b // indirect
	github.com/mendsley/gojwk v0.0.0-20141217222730-4d5ec6e58103 // indirect
	github.com/miekg/dns v1.1.50 // indirect
	github.com/mileusna/useragent v1.2.0 // indirect
	github.com/minio/highwayhash v1.0.2 // indirect
	github.com/minio/md5-simd v1.1.2 // indirect
	github.com/minio/minio-go/v7 v7.0.32 // indirect
	github.com/minio/sha256-simd v1.0.0 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/go-homedir v1.1.0 // indirect
	github.com/mitchellh/go-testing-interface v1.14.1 // indirect
	github.com/mitchellh/hashstructure v1.1.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/mschoch/smat v0.2.0 // indirect
	github.com/nats-io/jwt/v2 v2.3.0 // indirect
	github.com/nats-io/nats.go v1.17.0 // indirect
	github.com/nats-io/nkeys v0.3.0 // indirect
	github.com/nats-io/nuid v1.0.1 // indirect
	github.com/nxadm/tail v1.4.8 // indirect
	github.com/oxtoacart/bpool v0.0.0-20190530202638-03653db5a59c // indirect
	github.com/patrickmn/go-cache v2.1.0+incompatible // indirect
	github.com/pkg/xattr v0.4.7 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/pquerna/cachecontrol v0.1.0 // indirect
	github.com/prometheus/alertmanager v0.24.0 // indirect
	github.com/prometheus/client_model v0.2.0 // indirect
	github.com/prometheus/common v0.37.0 // indirect
	github.com/prometheus/procfs v0.8.0 // indirect
	github.com/prometheus/statsd_exporter v0.22.4 // indirect
	github.com/rivo/uniseg v0.2.0 // indirect
	github.com/rs/cors v1.8.2 // indirect
	github.com/rs/xid v1.4.0 // indirect
	github.com/russellhaering/goxmldsig v1.1.1 // indirect
	github.com/russross/blackfriday/v2 v2.1.0 // indirect
	github.com/sciencemesh/meshdirectory-web v1.0.4 // indirect
	github.com/sergi/go-diff v1.2.0 // indirect
	github.com/sethvargo/go-password v0.2.0 // indirect
	github.com/shurcooL/httpfs v0.0.0-20190707220628-8d4bc4ba7749 // indirect
	github.com/shurcooL/vfsgen v0.0.0-20200824052919-0d455de96546 // indirect
	github.com/sony/gobreaker v0.5.0 // indirect
	github.com/spacewander/go-suffix-tree v0.0.0-20191010040751-0865e368c784 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	github.com/stretchr/objx v0.4.0 // indirect
	github.com/toorop/go-dkim v0.0.0-20201103131630-e1cd1a0a5208 // indirect
	github.com/trustelem/zxcvbn v1.0.1 // indirect
	github.com/wk8/go-ordered-map v1.0.0 // indirect
	github.com/xanzy/ssh-agent v0.3.2 // indirect
	github.com/xrash/smetrics v0.0.0-20201216005158-039620a65673 // indirect
	go.etcd.io/etcd/api/v3 v3.5.5 // indirect
	go.etcd.io/etcd/client/pkg/v3 v3.5.5 // indirect
	go.opentelemetry.io/otel/internal/metric v0.27.0 // indirect
	go.opentelemetry.io/otel/metric v0.27.0 // indirect
	go.uber.org/atomic v1.10.0 // indirect
	go.uber.org/multierr v1.8.0 // indirect
	go.uber.org/zap v1.23.0 // indirect
	golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4 // indirect
	golang.org/x/sync v0.0.0-20220907140024-f12130a52804 // indirect
	golang.org/x/sys v0.0.0-20220928140112-f11e5e49a4ec // indirect
	golang.org/x/time v0.0.0-20220922220347-f3bd1da661af // indirect
	golang.org/x/tools v0.1.12 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	gopkg.in/ini.v1 v1.66.2 // indirect
	gopkg.in/square/go-jose.v2 v2.6.0 // indirect
	gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 // indirect
	gopkg.in/warnings.v0 v0.1.2 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	stash.kopano.io/kgol/kcc-go/v5 v5.0.1 // indirect
)
