# Lab Target: DRUPAL CVE-2018-7600

## Overview

- **Vulnerability**: CVE-2018-7600
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8634
- **Container Name**: `cyberlab_drupal_cve_2018_7600`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8634
[cyberlab_drupal_cve_2018_7600] (vulhub/drupal:8.5.0)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/drupal_cve_2018_7600
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8634/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lJeAgQQaDEw
