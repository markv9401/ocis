# Auto generated binary variables helper managed by https://github.com/bwplotka/bingo v0.6. DO NOT EDIT.
# All tools are designed to be build inside $GOBIN.
BINGO_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
GOPATH ?= $(shell go env GOPATH)
GOBIN  ?= $(firstword $(subst :, ,${GOPATH}))/bin
GO     ?= $(shell which go)

# Below generated variables ensure that every time a tool under each variable is invoked, the correct version
# will be used; reinstalling only if needed.
# For example for bingo variable:
#
# In your main Makefile (for non array binaries):
#
#include .bingo/Variables.mk # Assuming -dir was set to .bingo .
#
#command: $(BINGO)
#	@echo "Running bingo"
#	@$(BINGO) <flags/args..>
#
BINGO := $(GOBIN)/bingo-v0.6.0
$(BINGO): $(BINGO_DIR)/bingo.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/bingo-v0.6.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=bingo.mod -o=$(GOBIN)/bingo-v0.6.0 "github.com/bwplotka/bingo"

BUF := $(GOBIN)/buf-v1.3.1
$(BUF): $(BINGO_DIR)/buf.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/buf-v1.3.1"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=buf.mod -o=$(GOBIN)/buf-v1.3.1 "github.com/bufbuild/buf/cmd/buf"

BUILDIFIER := $(GOBIN)/buildifier-v0.0.0-20220323134444-a9f46b2bb3de
$(BUILDIFIER): $(BINGO_DIR)/buildifier.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/buildifier-v0.0.0-20220323134444-a9f46b2bb3de"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=buildifier.mod -o=$(GOBIN)/buildifier-v0.0.0-20220323134444-a9f46b2bb3de "github.com/bazelbuild/buildtools/buildifier"

CALENS := $(GOBIN)/calens-v0.2.0
$(CALENS): $(BINGO_DIR)/calens.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/calens-v0.2.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=calens.mod -o=$(GOBIN)/calens-v0.2.0 "github.com/restic/calens"

GO_LICENSES := $(GOBIN)/go-licenses-v1.0.1-0.20220408034444-fd2d9ec868aa
$(GO_LICENSES): $(BINGO_DIR)/go-licenses.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/go-licenses-v1.0.1-0.20220408034444-fd2d9ec868aa"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=go-licenses.mod -o=$(GOBIN)/go-licenses-v1.0.1-0.20220408034444-fd2d9ec868aa "github.com/google/go-licenses"

GOLANGCI_LINT := $(GOBIN)/golangci-lint-v1.47.3
$(GOLANGCI_LINT): $(BINGO_DIR)/golangci-lint.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/golangci-lint-v1.47.3"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=golangci-lint.mod -o=$(GOBIN)/golangci-lint-v1.47.3 "github.com/golangci/golangci-lint/cmd/golangci-lint"

HUGO := $(GOBIN)/hugo-v0.94.0
$(HUGO): $(BINGO_DIR)/hugo.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/hugo-v0.94.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=hugo.mod -o=$(GOBIN)/hugo-v0.94.0 "github.com/gohugoio/hugo"

MOCKERY := $(GOBIN)/mockery-v2.10.4
$(MOCKERY): $(BINGO_DIR)/mockery.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/mockery-v2.10.4"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=mockery.mod -o=$(GOBIN)/mockery-v2.10.4 "github.com/vektra/mockery/v2"

MUTAGEN := $(GOBIN)/mutagen-v0.13.1
$(MUTAGEN): $(BINGO_DIR)/mutagen.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/mutagen-v0.13.1"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=mutagen.mod -o=$(GOBIN)/mutagen-v0.13.1 "github.com/mutagen-io/mutagen/cmd/mutagen"

PROTOC_GEN_DOC := $(GOBIN)/protoc-gen-doc-v1.5.0
$(PROTOC_GEN_DOC): $(BINGO_DIR)/protoc-gen-doc.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/protoc-gen-doc-v1.5.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=protoc-gen-doc.mod -o=$(GOBIN)/protoc-gen-doc-v1.5.0 "github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc"

PROTOC_GEN_GO := $(GOBIN)/protoc-gen-go-v1.28.0
$(PROTOC_GEN_GO): $(BINGO_DIR)/protoc-gen-go.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/protoc-gen-go-v1.28.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=protoc-gen-go.mod -o=$(GOBIN)/protoc-gen-go-v1.28.0 "google.golang.org/protobuf/cmd/protoc-gen-go"

PROTOC_GEN_MICRO := $(GOBIN)/protoc-gen-micro-v1.0.0
$(PROTOC_GEN_MICRO): $(BINGO_DIR)/protoc-gen-micro.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/protoc-gen-micro-v1.0.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=protoc-gen-micro.mod -o=$(GOBIN)/protoc-gen-micro-v1.0.0 "github.com/go-micro/generator/cmd/protoc-gen-micro"

PROTOC_GEN_MICROWEB := $(GOBIN)/protoc-gen-microweb-v0.0.0-20220808092353-b5d6c3960e19
$(PROTOC_GEN_MICROWEB): $(BINGO_DIR)/protoc-gen-microweb.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/protoc-gen-microweb-v0.0.0-20220808092353-b5d6c3960e19"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=protoc-gen-microweb.mod -o=$(GOBIN)/protoc-gen-microweb-v0.0.0-20220808092353-b5d6c3960e19 "github.com/owncloud/protoc-gen-microweb"

PROTOC_GEN_OPENAPIV2 := $(GOBIN)/protoc-gen-openapiv2-v2.10.0
$(PROTOC_GEN_OPENAPIV2): $(BINGO_DIR)/protoc-gen-openapiv2.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/protoc-gen-openapiv2-v2.10.0"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=protoc-gen-openapiv2.mod -o=$(GOBIN)/protoc-gen-openapiv2-v2.10.0 "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2"

REFLEX := $(GOBIN)/reflex-v0.3.1
$(REFLEX): $(BINGO_DIR)/reflex.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/reflex-v0.3.1"
	@cd $(BINGO_DIR) && $(GO) build -mod=mod -modfile=reflex.mod -o=$(GOBIN)/reflex-v0.3.1 "github.com/cespare/reflex"

