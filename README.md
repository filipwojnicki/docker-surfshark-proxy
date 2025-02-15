# Docker Surfshark VPN Container

A Docker container that runs Surfshark VPN with SOCKS proxy support.

## Prerequisites

- Docker installed on your system
- Active Surfshark VPN subscription
- Surfshark credentials (username and password)

## Features

- OpenVPN connection to Surfshark servers
- SOCKS proxy support (port 1080)
- HTTP proxy support (port 8118)
- Kill switch enabled by default
- IPv6 disabled for security
- Local network access support

## Environment Variables

| Variable           | Description                           | Required |
| ------------------ | ------------------------------------- | -------- |
| SURFSHARK_USER     | Surfshark OpenVPN username            | Yes      |
| SURFSHARK_PASSWORD | Surfshark OpenVPN password            | Yes      |
| LOCAL_NETWORK      | Local network CIDR for return routing | No       |

## Usage

To run the container, use the following command:

Get credentials from [surfshark](https://my.surfshark.com/vpn/manual-setup/main/openvpn)

Choose your server config from [surfshark configuration](https://my.surfshark.com/vpn/api/v1/server/configurations) and save it: config.ovpn

```bash
docker build -t myimage .
```

```bash
docker compose up -d
```

or

```bash
docker run -d --name surfshark1 --cap-add NET_ADMIN --device /dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=1 --sysctl net.ipv4.conf.eth0.route_localnet=1 -e SURFSHARK_USER= -e SURFSHARK_PASSWORD= -e LOCAL_NETWORK=192.168.1.0/24,10.1.1.0/24,172.20.0.0/24 -p 8111:8118 -p 1081:1080 --dns 1.1.1.1 myimage
```

Inspired by [docker-surfshark](https://github.com/ilteoood/docker-surfshark)

## Support

[Support](https://buymeacoffee.com/meastr0)
