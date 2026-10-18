# Lab Target: OFBIZ CVE-2023-51467

## Overview

- **Vulnerability**: CVE-2023-51467
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8591
- **Container Name**: `cyberlab_ofbiz_cve_2023_51467`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8591
[cyberlab_ofbiz_cve_2023_51467] (vulhub/ofbiz:18.12.10)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve_2023_51467
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8591/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['U_z2OCAkoLk', 'Lab: Cross-Site WebSocket Hijacking (no Burp Collaborator needed!)']
