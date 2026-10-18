# Lab Target: PHPMYADMIN CVE-2016-5734

## Overview

- **Vulnerability**: CVE-2016-5734
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8565
- **Container Name**: `cyberlab_phpmyadmin_cve_2016_5734`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8565
[cyberlab_phpmyadmin_cve_2016_5734] (vulhub/phpmyadmin:4.4.15.6)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/phpmyadmin_cve_2016_5734
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8565/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Pc4tzsn-ats', 'HackTheBox - Ariekei']
