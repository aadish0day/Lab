# Lab Target: MAGENTO 2.2-SQLI

## Overview

- **Vulnerability**: 2.2-SQLI
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8572
- **Container Name**: `cyberlab_magento_2_2_sqli`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8572
[cyberlab_magento_2_2_sqli] (vulhub/magento:2.2.7)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/magento_2_2_sqli
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8572/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['RCJdPiogUIk', "Don't make random HTTP requests."]
