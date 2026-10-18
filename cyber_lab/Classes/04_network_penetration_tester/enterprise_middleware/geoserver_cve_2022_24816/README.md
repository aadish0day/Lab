# Lab Target: GEOSERVER CVE-2022-24816

## Overview

- **Vulnerability**: CVE-2022-24816
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8651
- **Container Name**: `cyberlab_geoserver_cve_2022_24816`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8651
[cyberlab_geoserver_cve_2022_24816] (vulhub/geoserver:2.17.2)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/geoserver_cve_2022_24816
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8651/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=k5HZI6CfHw4
