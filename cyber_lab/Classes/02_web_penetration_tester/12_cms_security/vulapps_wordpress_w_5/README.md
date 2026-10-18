# Lab Target: VULAPPS_WORDPRESS_W_5

## Overview

- **Vulnerability**: WordPress Avatar Upload Path Traversal Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8695
- **Container Name**: `cyberlab_vulapps_wordpress_w_5`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8695
[cyberlab_vulapps_wordpress_w_5] (medicean/vulapps:w_wordpress_5)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_w_5
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8695/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Ju3Wc6S0GhM
