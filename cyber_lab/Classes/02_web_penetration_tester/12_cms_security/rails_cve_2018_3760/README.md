# Lab Target: RAILS CVE-2018-3760

## Overview

- **Vulnerability**: CVE-2018-3760
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8562
- **Container Name**: `cyberlab_rails_cve_2018_3760`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8562
[cyberlab_rails_cve_2018_3760] (vulhub/rails:5.0.7)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/rails_cve_2018_3760
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8562/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['PHe0jWGXjiI', 'Adminer - CVE-2021-21311 - SSRF']
