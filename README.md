# ownCloud Infinite Scale

[![Rocket chat](https://img.shields.io/badge/Chat%20on%20Rocket.Chat-blue?logo=data:image/png;base64,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)](https://talk.owncloud.com/channel/infinitescale)
[![Build Status](https://drone.owncloud.com/api/badges/owncloud/ocis/status.svg)](https://drone.owncloud.com/owncloud/ocis)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=owncloud_ocis&metric=security_rating)](https://sonarcloud.io/dashboard?id=owncloud_ocis)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=owncloud_ocis&metric=coverage)](https://sonarcloud.io/dashboard?id=owncloud_ocis)
[![Go Report](https://goreportcard.com/badge/github.com/owncloud/ocis)](https://goreportcard.com/report/github.com/owncloud/ocis)
[![Go Doc](https://godoc.org/github.com/owncloud/ocis?status.svg)](http://godoc.org/github.com/owncloud/ocis)
[![oCIS docker image](https://img.shields.io/docker/v/owncloud/ocis?label=oCIS%20docker%20image&logo=docker&sort=semver)](https://hub.docker.com/r/owncloud/ocis)

**ownCloud Infinite Scale is currently in a technical preview state. It will be subject to a lot of changes and is not yet ready for general production deployments.**

## Run ownCloud Infinite Scale

Please see [Getting Started](https://owncloud.dev/ocis/getting-started/)

## Documentation

*   **Development Documentation**  
Please see [Development Documentation - Getting Started](https://owncloud.dev/ocis/development/getting-started/)

*   **Admin Documentation**  
Please see [Admin Documentation - Introduction to Infinite Scale](https://doc.owncloud.com/ocis/next/)

## Security

If you find a security issue please contact [security@owncloud.com](mailto:security@owncloud.com) first

## Contributing

Please refer to our [Contribution Guidelines](CONTRIBUTING.md).

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2020-2021 ownCloud GmbH <https://owncloud.com>
```
