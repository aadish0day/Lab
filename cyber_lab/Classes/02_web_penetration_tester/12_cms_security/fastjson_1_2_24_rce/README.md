# Lab Target: FASTJSON 1.2.24-RCE

## Overview

- **Vulnerability**: 1.2.24-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8579
- **Container Name**: `cyberlab_fastjson_1_2_24_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8579
[cyberlab_fastjson_1_2_24_rce] (vulhub/fastjson:1.2.24)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/fastjson_1_2_24_rce
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8579/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['SWzxoK6DAE4', '1 - Brute Force (low/med/high) - Damn Vulnerable Web Application (DVWA)']
