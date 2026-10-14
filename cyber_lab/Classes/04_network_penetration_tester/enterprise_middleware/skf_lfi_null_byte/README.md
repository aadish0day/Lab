# Lab Target: SKF_LFI_NULL_BYTE

## Overview
- **Vulnerability**: OWASP-SKF LFI with Null Byte Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8849
- **Container Name**: `cyberlab_skf_lfi_null_byte`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8849
[cyberlab_skf_lfi_null_byte] (blabla1337/owasp-skf-lab:lfi-null-byte)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_lfi_null_byte
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8849/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=1OvVwZgqnlo
