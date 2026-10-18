# Lab Target: VULAPPS_WORDPRESS_W_4

## Overview

- **Vulnerability**: WordPress Form Submissions Blind SQL Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8694
- **Container Name**: `cyberlab_vulapps_wordpress_w_4`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8694
[cyberlab_vulapps_wordpress_w_4] (medicean/vulapps:w_wordpress_4)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_w_4
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8694/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=cPUVsX9qmA8
