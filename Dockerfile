FROM alpine:latest

WORKDIR /vpn

ENV SURFSHARK_USER=
ENV SURFSHARK_PASSWORD=
ENV SURFSHARK_CONFIGS_ENDPOINT=https://my.surfshark.com/vpn/api/v1/server/configurations
ENV CONNECTION_TYPE=udp
ENV LAN_NETWORK=
ENV ENABLE_SOCKS_SERVER=
ENV OVPN_CONFIGS=
ENV ENABLE_KILL_SWITCH=true

HEALTHCHECK --interval=60s --timeout=10s --start-period=30s CMD curl -s https://api.surfshark.com/v1/server/user | grep '"secured":true'

COPY startup.sh .
COPY sockd.conf /etc/
COPY config .
COPY sockd.sh .
COPY config.ovpn .

RUN apk add --update --no-cache openvpn wget unzip coreutils curl privoxy dante-server \
    && chmod +x ./startup.sh \
    && chmod +x ./sockd.sh

RUN ls -la /vpn

ENTRYPOINT [ "./startup.sh" ]
