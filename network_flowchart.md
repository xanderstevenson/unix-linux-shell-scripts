# Network Connectivity Scripts Flowchart

## Overview
This flowchart illustrates the logic for three network connectivity diagnostic scripts.

## Script 1: check_google_ping.sh
```
START
  │
  ├─→ Ping google.com
  │     │
  │     ├─ SUCCESS → Print "Network is up"
  │     │
  │     └─ FAILED → Print "Network is down"
  │
END
```

## Script 2: check_dns_ping.sh
```
START
  │
  ├─→ Ping 8.8.8.8 (Google DNS)
  │     │
  │     ├─ SUCCESS → Print "DNS server reachable"
  │     │
  │     └─ FAILED → Print "DNS server unreachable"
  │
END
```

## Script 3: check_dns_resolution.sh
```
START
  │
  ├─→ nslookup example.com
  │     │
  │     ├─ SUCCESS → Print "DNS resolution working"
  │     │              Display IP address
  │     │
  │     └─ FAILED → Print "DNS resolution failed"
  │
END
```

## Combined Network Test Flow
```
START
  │
  ├─→ Check Internet Connectivity (ping google.com)
  │     │
  │     ├─ SUCCESS → Continue to DNS tests
  │     │
  │     └─ FAILED → Report network issue and exit
  │
  ├─→ Check DNS Server (ping 8.8.8.8)
  │     │
  │     ├─ SUCCESS → Continue to DNS resolution
  │     │
  │     └─ FAILED → Report DNS server issue
  │
  ├─→ Check DNS Resolution (nslookup example.com)
  │     │
  │     ├─ SUCCESS → All tests passed
  │     │
  │     └─ FAILED → Report DNS resolution issue
  │
END
```

## Error Handling
- Each script includes timeout parameters
- Scripts return appropriate exit codes (0 for success, 1 for failure)
- Verbose output for debugging
- Timestamps for all operations
