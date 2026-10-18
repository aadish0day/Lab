# Lab Target: VULHUB_JETTY_CVE_2021_28164

## Overview

- **Vulnerability**: Eclipse Jetty WEB-INF Information Disclosure (CVE-2021-28164)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8773
- **Container Name**: `cyberlab_vulhub_jetty_cve_2021_28164`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8773
[cyberlab_vulhub_jetty_cve_2021_28164] (vulhub/jetty:9.4.37)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_jetty_cve_2021_28164
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8773/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Hv8H7ZgNdi4
