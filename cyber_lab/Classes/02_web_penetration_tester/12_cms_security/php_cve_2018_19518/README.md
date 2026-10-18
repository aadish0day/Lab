# Lab Target: PHP CVE-2018-19518

## Overview

- **Vulnerability**: CVE-2018-19518
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8568
- **Container Name**: `cyberlab_php_cve_2018_19518`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8568
[cyberlab_php_cve_2018_19518] (vulhub/php:5.6.38-apache)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/php_cve_2018_19518
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8568/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Q1VG5X6oPC4', 'Hashicorp Vault - Human vs. system auth methods - AppRole Pull Authentication - #3']
