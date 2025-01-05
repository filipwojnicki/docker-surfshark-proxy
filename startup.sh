#!/bin/sh

# Verify sockd.conf exists
if [ ! -f /etc/sockd.conf ]; then
    echo "ERROR: /etc/sockd.conf not found"
    exit 1
fi

# Check sockd.conf permissions
chmod 644 /etc/sockd.conf

#Create a tun device see: https://www.kernel.org/doc/Documentation/networking/tuntap.txt
if [ ! -c /dev/net/tun ]; then
    echo "INFO: Creating tun interface /dev/net/tun"
    mkdir -p /dev/net
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

echo "$SURFSHARK_USER" > vpn-auth.txt
echo "$SURFSHARK_PASSWORD" >> vpn-auth.txt

#Return traffic that went through OpenVPN works.
gw=$(ip route | awk '/default/ {print $3}')
if [ -n "$LOCAL_NETWORK" ]; then
	NETWORKS=$(echo $LOCAL_NETWORK | tr "," "\n")
	for NETWORK in $NETWORKS
	do
		ip route add to ${NETWORK} via $gw dev eth0
	done	
fi
ip route add to 192.168.1.0/24 via $gw dev eth0

# Start privoxy
echo "INFO: Privoxy will be started"
privoxy --no-daemon &

sleep 2

openvpn --config config.ovpn --auth-user-pass vpn-auth.txt --auth-nocache --script-security 2 --up /vpn/sockd.sh