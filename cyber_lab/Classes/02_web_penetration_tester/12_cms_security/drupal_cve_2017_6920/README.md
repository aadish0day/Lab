# Lab Target: DRUPAL CVE-2017-6920

## Overview

- **Vulnerability**: CVE-2017-6920
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8635
- **Container Name**: `cyberlab_drupal_cve_2017_6920`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8635
[cyberlab_drupal_cve_2017_6920] (vulhub/drupal:8.3.0)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/drupal_cve_2017_6920
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8635/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0-abhd-CLwQ
