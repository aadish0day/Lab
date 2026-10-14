# Lab Target: VULHUB_OWNCLOUD_CVE_2023_49103

## Overview
- **Vulnerability**: ownCloud Information Disclosure Target (CVE-2023-49103)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8761
- **Container Name**: `cyberlab_vulhub_owncloud_cve_2023_49103`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8761
[cyberlab_vulhub_owncloud_cve_2023_49103] (owncloud/server:10.13.1)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_owncloud_cve_2023_49103
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8761/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0KYDTt5DiNM
