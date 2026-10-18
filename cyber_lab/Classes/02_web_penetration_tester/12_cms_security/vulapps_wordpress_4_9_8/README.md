# Lab Target: VULAPPS_WORDPRESS_4_9_8

## Overview

- **Vulnerability**: WordPress 4.9.8 Vulnerable Core Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8690
- **Container Name**: `cyberlab_vulapps_wordpress_4_9_8`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8690
[cyberlab_vulapps_wordpress_4_9_8] (avfisherdocker/wordpress:4.9.8)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_4_9_8
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8690/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=S8GEy4Gvkro
