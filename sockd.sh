#!/bin/sh
# Start Dante SOCKS proxy in background
echo "INFO: Starting SOCKS proxy"
# Wait for tun interface
while ! ip link show tun0 >/dev/null 2>&1; do
    echo "Waiting for tun0 interface..."
    sleep 1
done

# Start sockd with debug logging
sockd -D -d 2

# Verify sockd is running
if ! pgrep sockd > /dev/null; then
    echo "ERROR: Failed to start SOCKS proxy"
    exit 1
fi