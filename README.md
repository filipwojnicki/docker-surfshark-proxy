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

Inspired by [docker-surfshark](https://github.com/ilteoood/docker-surfshark)

## Support

[Support](https://buymeacoffee.com/meastr0)
