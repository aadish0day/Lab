# Lab Target: OFBIZ CVE-2023-49070

## Overview

- **Vulnerability**: CVE-2023-49070
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8592
- **Container Name**: `cyberlab_ofbiz_cve_2023_49070`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8592
[cyberlab_ofbiz_cve_2023_49070] (vulhub/ofbiz:18.12.09)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve_2023_49070
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8592/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Uw_la2zhVTY', 'Unleashing ETERNAL RED (Exploit Walkthrough - Sambacry/CVE-2017-7494)']
