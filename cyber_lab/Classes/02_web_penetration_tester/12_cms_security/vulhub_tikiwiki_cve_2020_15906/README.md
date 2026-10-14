# Lab Target: VULHUB_TIKIWIKI_CVE_2020_15906

## Overview
- **Vulnerability**: TikiWiki Authentication Bypass Target (CVE-2020-15906)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8760
- **Container Name**: `cyberlab_vulhub_tikiwiki_cve_2020_15906`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8760
[cyberlab_vulhub_tikiwiki_cve_2020_15906] (vulhub/tikiwiki:21.1)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_tikiwiki_cve_2020_15906
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8760/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=9UAQ1VzSq8Q
