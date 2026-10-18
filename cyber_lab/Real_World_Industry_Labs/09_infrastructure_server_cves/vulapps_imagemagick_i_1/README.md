# Lab Target: VULAPPS_IMAGEMAGICK_I_1

## Overview

- **Vulnerability**: ImageMagick Shell Parameter Injection RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8738
- **Container Name**: `cyberlab_vulapps_imagemagick_i_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8738
[cyberlab_vulapps_imagemagick_i_1] (medicean/vulapps:i_imagemagick_1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_imagemagick_i_1
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8738/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=sQ4TtFdaiRA
