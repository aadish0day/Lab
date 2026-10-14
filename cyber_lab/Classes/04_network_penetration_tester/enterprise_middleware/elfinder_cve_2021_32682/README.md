# Lab Target: ELFINDER CVE-2021-32682

## Overview
- **Vulnerability**: CVE-2021-32682
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8654
- **Container Name**: `cyberlab_elfinder_cve_2021_32682`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8654
[cyberlab_elfinder_cve_2021_32682] (vulhub/elfinder:2.1.58)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/elfinder_cve_2021_32682
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8654/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=wsVtR4Mza98
