# Lab Target: VULAPPS_WORDPRESS_BASE_LAMP

## Overview

- **Vulnerability**: WordPress Core Media Attachment Arbitrary Code Execution
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8691
- **Container Name**: `cyberlab_vulapps_wordpress_base_lamp`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8691
[cyberlab_vulapps_wordpress_base_lamp] (medicean/vulapps:w_wordpress_1)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_base_lamp
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8691/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=C-Uck0h5L9s
