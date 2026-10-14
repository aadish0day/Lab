# Lab Target: DISCUZ X3.4-ARBITRARY-FILE-DELETION

## Overview
- **Vulnerability**: X3.4-ARBITRARY-FILE-DELETION
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8636
- **Container Name**: `cyberlab_discuz_x3_4_arbitrary_file_deletion`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8636
[cyberlab_discuz_x3_4_arbitrary_file_deletion] (vulhub/discuz:x3.4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/discuz_x3_4_arbitrary_file_deletion
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8636/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=iI9Dz3zN4d8
