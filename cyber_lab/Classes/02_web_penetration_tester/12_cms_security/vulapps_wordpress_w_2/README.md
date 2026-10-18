# Lab Target: VULAPPS_WORDPRESS_W_2

## Overview

- **Vulnerability**: WordPress XML-RPC Brute Force and SSRF Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8692
- **Container Name**: `cyberlab_vulapps_wordpress_w_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8692
[cyberlab_vulapps_wordpress_w_2] (medicean/vulapps:w_wordpress_2)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_w_2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8692/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=zneRNme9h3U
