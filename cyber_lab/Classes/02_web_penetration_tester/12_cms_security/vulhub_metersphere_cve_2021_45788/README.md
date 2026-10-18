# Lab Target: VULHUB_METERSPHERE_CVE_2021_45788

## Overview

- **Vulnerability**: MeterSphere Plugin File Read Target (CVE-2021-45788)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8765
- **Container Name**: `cyberlab_vulhub_metersphere_cve_2021_45788`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8765
[cyberlab_vulhub_metersphere_cve_2021_45788] (vulhub/metersphere:1.15.3)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_metersphere_cve_2021_45788
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8765/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=w-eJM2Pc0KI
