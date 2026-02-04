#!/bin/bash
# check_dns_ping.sh - Checks connectivity to Google DNS (8.8.8.8)
# Author: Alexander Stevenson

echo "=== DNS Server Connectivity Test ==="
echo "Timestamp: $(date)"
echo "Testing connectivity to Google DNS (8.8.8.8)..."

# Ping 8.8.8.8 with 4 packets and 3-second timeout
ping -c 4 -W 3 8.8.8.8 >/dev/null 2>&1

# Check the exit code
if [ $? -eq 0 ]; then
    echo "DNS server reachable."
    echo "✓ Successfully connected to 8.8.8.8 (Google DNS)"
    exit 0
else
    echo "DNS server unreachable."
    echo "✗ Failed to connect to 8.8.8.8 (Google DNS)"
    exit 1
fi
