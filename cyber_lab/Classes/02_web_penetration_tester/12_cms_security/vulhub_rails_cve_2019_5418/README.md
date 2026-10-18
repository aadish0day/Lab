# Lab Target: VULHUB_RAILS_CVE_2019_5418

## Overview

- **Vulnerability**: Ruby on Rails File Content Disclosure & RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8689
- **Container Name**: `cyberlab_vulhub_rails_cve_2019_5418`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8689
[cyberlab_vulhub_rails_cve_2019_5418] (vulhub/rails:5.2.2.1)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_rails_cve_2019_5418
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8689/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=kxtgTiRJ-wg
