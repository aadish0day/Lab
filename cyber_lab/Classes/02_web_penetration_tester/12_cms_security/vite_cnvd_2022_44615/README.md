# Vite - CNVD-2022-44615

## Overview
- **Vulnerability ID**: CNVD-2022-44615
- **Application**: Vite
- **Port Allocation**: Port 8463
- **CLI Shortcut**: `./lab start vite-cnvd-2022-44615`

## Vulnerability Description
Vite development server arbitrary file read and path traversal vulnerability.

## Quick Start
```bash
# Start target environment
./lab start vite-cnvd-2022-44615

# View container status
./lab status

# Open interactive shell inside target
./lab shell vite-cnvd-2022-44615
```

## Verification & Exploitation
```bash
curl http://localhost:8463/
```

## Video Walkthrough
- Walkthrough: [Vite CNVD-2022-44615 Security Assessment Walkthrough](https://www.youtube.com/watch?v=-dc_vLdYEtA)
