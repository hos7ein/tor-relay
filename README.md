# tor-relay

[![CI](https://github.com/hos7ein/tor-relay/actions/workflows/markdown-check.yml/badge.svg)](https://github.com/hos7ein/tor-relay/actions/workflows/markdown-check.yml) [![CI](https://github.com/hos7ein/tor-relay/actions/workflows/pr-check.yml/badge.svg)](https://github.com/hos7ein/tor-relay/actions/workflows/pr-check.yml) [![CI](https://github.com/hos7ein/tor-relay/actions/workflows/release.yml/badge.svg)](https://github.com/hos7ein/tor-relay/actions/workflows/release.yml) [![CI](https://github.com/hos7ein/tor-relay/actions/workflows/quadlet-check.yml/badge.svg)](https://github.com/hos7ein/tor-relay/actions/workflows/quadlet-check.yml)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/hos7ein/ansible-fedora-packages/graphs/commit-activity)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/hos7ein/ansible-fedora-packages)

[![ForTheBadge built-with-love](http://ForTheBadge.com/images/badges/built-with-love.svg)](https://GitHub.com/hos7ein/)
[![forthebadge](https://forthebadge.com/images/badges/powered-by-coffee.svg)](https://fedorafans.com)

## Table of contents

- [tor-relay](#tor-relay)
  - [Table of contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Requirements](#requirements)
    - [Deploy Tor Middle relay](#deploy-tor-middle-relay)
    - [Deploy Tor Bridge relay](#deploy-tor-bridge-relay)
    - [Deploy Tor Exit relay](#deploy-tor-exit-relay)
    - [Environment variables](#environment-variables)
    - [User / Group Identifiers](#user--group-identifiers)
    - [Open nyx](#open-nyx)
  - [Contributing](#contributing)
  - [Contact](#contact)
  - [License](#license)

## Introduction

Container image to setup a Tor relay with [nyx](https://nyx.torproject.org/) monitoring

## Requirements

- `Docker` or `Podman`

### Deploy Tor Middle relay

```bash
docker run -d \
    --restart always \
    -v /path/to/tor-relay-data:/var/lib/tor:rw \
    -v /etc/localtime:/etc/localtime:ro \
    -p 9001:9001 \
    -e RELAY_NICKNAME='ChangeMe' \
    -e USER_ID=$(id -u) \
    -e GROUP_ID=$(id -g) \
    -e CONTACT_EMAIL='tor[at]example[dot]com' \
    --name tor-relay \
    ghcr.io/hos7ein/tor-relay:latest
```

### Deploy Tor Bridge relay

```bash
docker run -d \
    --restart always \
    -v /path/to/tor-relay-data:/var/lib/tor:rw \
    -v /etc/localtime:/etc/localtime:ro \
    -p 9001:9001 \
    -e RELAY_TYPE='bridge' \
    -e RELAY_NICKNAME='ChangeMe' \
    -e USER_ID=$(id -u) \
    -e GROUP_ID=$(id -g) \
    -e CONTACT_EMAIL='tor[at]example[dot]com' \
    --name tor-relay \
    ghcr.io/hos7ein/tor-relay:latest
```

### Deploy Tor Exit relay

```bash
docker run -d \
    --restart always \
    -v /path/to/tor-relay-data:/var/lib/tor:rw \
    -v /etc/localtime:/etc/localtime:ro \
    -p 9001:9001 \
    -e RELAY_TYPE='exit' \
    -e RELAY_NICKNAME='ChangeMe' \
    -e USER_ID=$(id -u) \
    -e GROUP_ID=$(id -g) \
    -e CONTACT_EMAIL='tor[at]example[dot]com' \
    --name tor-relay \
    ghcr.io/hos7ein/tor-relay:latest
```

### Environment variables

| Name                         | Description                                                                  | Default value |
| ---------------------------- |:----------------------------------------------------------------------------:| -------------:|
| **USER_ID**                  | The user ID to run tor as, to match host user                                | 1000          |
| **GROUP_ID**                 | The group ID to run tor as, to match host user                               | 1000          |
| **RELAY_TYPE**               | The type of relay (bridge, middle or exit)                                   | middle        |
| **RELAY_NICKNAME**           | The nickname of your relay                                                   | ChangeMe      |
| **CONTACT_GPG_FINGERPRINT**  | Your GPG ID or fingerprint                                                   | none          |
| **CONTACT_NAME**             | Your name                                                                    | none          |
| **CONTACT_EMAIL**            | Your contact email                                                           | none          |
| **RELAY_BANDWIDTH_RATE**     | Limit how much traffic will be allowed through your relay (must be > 20KB/s) | 100 KBytes    |
| **RELAY_BANDWIDTH_BURST**    | Allow temporary bursts up to a certain amount                                | 200 KBytes    |
| **RELAY_ORPORT**             | Default port used for incoming Tor connections (ORPort)                      | 9001          |
| **RELAY_DIRPORT**            | Default port used for directory (DirPort)                                    | 9030          |
| **RELAY_CTRLPORT**           | Default port used for control interface (ControlPort)                        | 9051          |
| **RELAY_ACCOUNTING_MAX**     | Default threshold for sent and recieve (AccountingMax)                       | 1 GBytes      |
| **RELAY_ACCOUNTING_START**   | threshold rest (AccountingStart)                                             | day 00:00     |

### User / Group Identifiers

When using volumes (`-v` flags), permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `USER_ID` and group `GROUP_ID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `USER_ID=1000` and `GROUP_ID=1000`, to find yours use `id your_user` as below:

```bash
id your_user
```

Example output:

```text
uid=1000(your_user) gid=1000(your_user) groups=1000(your_user)
```

### Open nyx

```bash
docker exec -it tor-relay nyx
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Contact

[![Personal website](https://img.shields.io/badge/website-000000?style=for-the-badge&logo=About.me&logoColor=white 'https://fedorafans.com')](https://fedorafans.com)

[![X (formerly Twitter)](https://img.shields.io/badge/X-formerly%20Twitter-black?style=for-the-badge&logo=x)](https://x.com/hos7ein)

## License

`tor-relay` source code is available under the GPL-3.0 [License](/LICENSE).
