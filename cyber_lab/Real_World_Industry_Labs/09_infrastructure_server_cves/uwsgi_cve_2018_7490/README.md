# Lab Target: UWSGI CVE-2018-7490

## Overview
- **Vulnerability**: CVE-2018-7490
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8603
- **Container Name**: `cyberlab_uwsgi_cve_2018_7490`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8603
[cyberlab_uwsgi_cve_2018_7490] (vulhub/uwsgi-php:2.0.16)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/uwsgi_cve_2018_7490
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8603/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['XjgxQ6gHfyU', 'Game Of Active Directory, Learn how to attack and detect AD attacks']
