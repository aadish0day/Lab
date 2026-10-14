# Lab Target: VULAPPS_TPGETSHELL

## Overview
- **Vulnerability**: ThinkPHP tpgetshell Arbitrary Code Execution Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8688
- **Container Name**: `cyberlab_vulapps_tpgetshell`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8688
[cyberlab_vulapps_tpgetshell] (virink/tpgetshell)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_tpgetshell
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8688/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=aSSISGkplfc
