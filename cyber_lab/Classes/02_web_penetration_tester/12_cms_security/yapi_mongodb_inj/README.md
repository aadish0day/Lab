# YApi - mongodb-inj

## Overview
- **Vulnerability ID**: MONGODB-INJ
- **Application**: YApi
- **Port Allocation**: Port 8469
- **CLI Shortcut**: `./lab start yapi-mongodb-inj`

## Vulnerability Description
YApi API management platform unauthenticated mock script execution and MongoDB injection.

## Quick Start
```bash
# Start target environment
./lab start yapi-mongodb-inj

# View container status
./lab status

# Open interactive shell inside target
./lab shell yapi-mongodb-inj
```

## Verification & Exploitation
```bash
curl http://localhost:8469/
```

## Video Walkthrough
- Walkthrough: [YApi mongodb-inj Security Assessment Walkthrough](https://www.youtube.com/watch?v=1OvVwZgqnlo)
