# Lab Target: JOOMLA CVE-2017-8917

## Overview

- **Vulnerability**: CVE-2017-8917
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8574
- **Container Name**: `cyberlab_joomla_cve_2017_8917`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8574
[cyberlab_joomla_cve_2017_8917] (vulhub/joomla:3.7.0)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/joomla_cve_2017_8917
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8574/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['RYzbA72sbv8', 'Juiceshop - insecure OWASP webshop walkthrough']
