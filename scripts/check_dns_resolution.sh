#!/bin/bash
# check_dns_resolution.sh - Tests DNS resolution for example.com
# Author: Alexander Stevenson

echo "=== DNS Resolution Test ==="
echo "Timestamp: $(date)"
echo "Testing DNS resolution for example.com..."

# Use nslookup to resolve example.com
nslookup_result=$(nslookup example.com 2>/dev/null)

# Check if nslookup was successful
if [ $? -eq 0 ]; then
    echo "DNS resolution working."
    echo "✓ Successfully resolved example.com"
    
    # Extract and display the IP address
    ip_address=$(echo "$nslookup_result" | grep -A 1 "Name:" | grep "Address:" | awk '{print $2}' | head -1)
    if [ -n "$ip_address" ]; then
        echo "IP Address: $ip_address"
    fi
    
    exit 0
else
    echo "DNS resolution failed."
    echo "✗ Failed to resolve example.com"
    exit 1
fi
