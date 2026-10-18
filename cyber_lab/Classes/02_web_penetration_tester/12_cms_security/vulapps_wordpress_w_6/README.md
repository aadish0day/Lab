# Lab Target: VULAPPS_WORDPRESS_W_6

## Overview

- **Vulnerability**: WordPress Plugin File Upload Remote Code Execution
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8769
- **Container Name**: `cyberlab_vulapps_wordpress_w_6`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8769
[cyberlab_vulapps_wordpress_w_6] (medicean/vulapps:w_wordpress_6)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_w_6
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8769/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=o8IBMWr-drg
