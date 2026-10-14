# Lab Target: VULHUB_XSTREAM_CVE_2021_29505

## Overview
- **Vulnerability**: XStream Remote Code Execution Target (CVE-2021-29505)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8776
- **Container Name**: `cyberlab_vulhub_xstream_cve_2021_29505`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8776
[cyberlab_vulhub_xstream_cve_2021_29505] (vulhub/xstream:1.4.16)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_xstream_cve_2021_29505
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8776/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HtdGLZOuXXA
