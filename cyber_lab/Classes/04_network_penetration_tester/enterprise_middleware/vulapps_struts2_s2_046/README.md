# Lab Target: VULAPPS_STRUTS2_S2_046

## Overview

- **Vulnerability**: Apache Struts2 S2-046 Multipart Content-Disposition RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8702
- **Container Name**: `cyberlab_vulapps_struts2_s2_046`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8702
[cyberlab_vulapps_struts2_s2_046] (medicean/vulapps:s_struts2_s2-046)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_struts2_s2_046
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8702/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=__65_GFERKs
