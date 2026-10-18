# Lab Target: OFBIZ CVE-2024-45195

## Overview

- **Vulnerability**: CVE-2024-45195
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8589
- **Container Name**: `cyberlab_ofbiz_cve_2024_45195`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8589
[cyberlab_ofbiz_cve_2024_45195] (vulhub/ofbiz:18.12.15)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve_2024_45195
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8589/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['TxUlDttIWY8', 'Redis NoSQL Database Exploit Using SSH | CTF Walkthrough']
