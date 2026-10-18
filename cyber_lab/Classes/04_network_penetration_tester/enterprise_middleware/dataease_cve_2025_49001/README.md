# Lab Target: DATAEASE CVE-2025-49001

## Overview

- **Vulnerability**: CVE-2025-49001
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8657
- **Container Name**: `cyberlab_dataease_cve_2025_49001`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8657
[cyberlab_dataease_cve_2025_49001] (vulhub/dataease:2.10.7)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/dataease_cve_2025_49001
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8657/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=OQCgmftU-Og
