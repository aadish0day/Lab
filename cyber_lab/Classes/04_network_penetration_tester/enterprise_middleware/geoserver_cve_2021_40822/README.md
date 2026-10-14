# Lab Target: GEOSERVER CVE-2021-40822

## Overview
- **Vulnerability**: CVE-2021-40822
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8652
- **Container Name**: `cyberlab_geoserver_cve_2021_40822`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8652
[cyberlab_geoserver_cve_2021_40822] (vulhub/geoserver:2.19.1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/geoserver_cve_2021_40822
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8652/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=trN9g-H7Dac
