# Lab Target: VULHUB_GHOSTSCRIPT_CVE_2019_6116

## Overview
- **Vulnerability**: Ghostscript Safer Mode Bypass Command Execution (CVE-2019-6116)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8826
- **Container Name**: `cyberlab_vulhub_ghostscript_cve_2019_6116`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8826
[cyberlab_vulhub_ghostscript_cve_2019_6116] (vulhub/ghostscript:9.26)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_ghostscript_cve_2019_6116
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8826/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=QjPFjd8GJWY
