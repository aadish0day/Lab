# Lab Target: VULHUB_JETTY_CVE_2021_34429

## Overview

- **Vulnerability**: Eclipse Jetty Information Disclosure Target (CVE-2021-34429)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8772
- **Container Name**: `cyberlab_vulhub_jetty_cve_2021_34429`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8772
[cyberlab_vulhub_jetty_cve_2021_34429] (vulhub/jetty:9.4.40)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_jetty_cve_2021_34429
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8772/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=MiaEWNruYdI
