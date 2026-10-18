# Lab Target: H2DATABASE CVE-2018-10054

## Overview

- **Vulnerability**: CVE-2018-10054
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8641
- **Container Name**: `cyberlab_h2database_cve_2018_10054`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8641
[cyberlab_h2database_cve_2018_10054] (vulhub/spring-with-h2database:1.4.197)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/h2database_cve_2018_10054
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8641/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=4teLzdM26l4
