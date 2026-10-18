# Lab Target: OFBIZ CVE-2024-45507

## Overview

- **Vulnerability**: CVE-2024-45507
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8588
- **Container Name**: `cyberlab_ofbiz_cve_2024_45507`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8588
[cyberlab_ofbiz_cve_2024_45507] (vulhub/ofbiz:18.12.15)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve_2024_45507
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8588/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['TvK0qH18ous', 'Cloud Security: Introduction to CloudGoat and Walkthrough (Cloud_Breach_S3)']
