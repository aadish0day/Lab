# Lab Target: JOOMLA CVE-2015-8562

## Overview
- **Vulnerability**: CVE-2015-8562
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8575
- **Container Name**: `cyberlab_joomla_cve_2015_8562`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8575
[cyberlab_joomla_cve_2015_8562] (vulhub/joomla:3.4.5)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/joomla_cve_2015_8562
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8575/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['S8GEy4Gvkro', 'What is Nginx? And why is it in front of your app?']
