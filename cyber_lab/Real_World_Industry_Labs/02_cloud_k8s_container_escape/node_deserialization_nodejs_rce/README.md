# Node-Deserialization - NodeJS-RCE

## Overview

- **Vulnerability ID**: NODE-DESER
- **Application**: Node-Deserialization
- **Port Allocation**: Port 8483
- **CLI Shortcut**: `./lab start node-deserialization-nodejs-rce`

## Vulnerability Description

NodeJS unserialize vulnerability demonstrating prototype manipulation and arbitrary code execution.

## Quick Start

```bash
# Start target environment
./lab start node-deserialization-nodejs-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell node-deserialization-nodejs-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8483/
```

## Video Walkthrough

- Walkthrough: [Node-Deserialization NodeJS-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=5SmDLBQxmXw)
