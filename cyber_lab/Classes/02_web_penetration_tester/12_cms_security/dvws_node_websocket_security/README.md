# DVWS-Node - WebSocket-Security

## Overview

- **Vulnerability ID**: DVWS-NODE
- **Application**: DVWS-Node
- **Port Allocation**: Port 8478
- **CLI Shortcut**: `./lab start dvws-node-websocket-security`

## Vulnerability Description

Damn Vulnerable Web Sockets application demonstrating WebSocket hijacking, injection, and CSWSH.

## Quick Start

```bash
# Start target environment
./lab start dvws-node-websocket-security

# View container status
./lab status

# Open interactive shell inside target
./lab shell dvws-node-websocket-security
```

## Verification & Exploitation

```bash
curl http://localhost:8478/
```

## Video Walkthrough

- Walkthrough: [DVWS-Node WebSocket-Security Security Assessment Walkthrough](https://www.youtube.com/watch?v=3SKkwoMIhK0)
