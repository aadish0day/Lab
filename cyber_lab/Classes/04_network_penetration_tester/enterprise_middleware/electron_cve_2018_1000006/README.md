# Lab Target: ELECTRON CVE-2018-1000006

## Overview

- **Vulnerability**: CVE-2018-1000006
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8656
- **Container Name**: `cyberlab_electron_cve_2018_1000006`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8656
[cyberlab_electron_cve_2018_1000006] (vulhub/electron:wine)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/electron_cve_2018_1000006
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8656/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=YA-mL9Z8SNI
