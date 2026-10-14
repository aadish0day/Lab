# Lab Target: SKF_RFI_REMOTE_INCLUSION

## Overview
- **Vulnerability**: OWASP-SKF Remote File Inclusion Vulnerability Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8844
- **Container Name**: `cyberlab_skf_rfi_remote_inclusion`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8844
[cyberlab_skf_rfi_remote_inclusion] (blabla1337/owasp-skf-lab:rfi-remote-inclusion)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_rfi_remote_inclusion
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8844/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-bKEWqcyEBY
