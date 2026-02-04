#!/bin/bash
# check_google_ping.sh - Checks connectivity to google.com
# Author: Alexander Stevenson

echo "=== Google Connectivity Test ==="
echo "Timestamp: $(date)"
echo "Testing connectivity to google.com..."

# Ping google.com with 4 packets and 3-second timeout
ping -c 4 -W 3 google.com >/dev/null 2>&1

# Check the exit code
if [ $? -eq 0 ]; then
    echo "Network is up."
    echo "✓ Successfully connected to google.com"
    exit 0
else
    echo "Network is down."
    echo "✗ Failed to connect to google.com"
    exit 1
fi
