# Lab Target: FASTJSON 1.2.83-RCE

## Overview

- **Vulnerability**: 1.2.83-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8577
- **Container Name**: `cyberlab_fastjson_1_2_83_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8577
[cyberlab_fastjson_1_2_83_rce] (vulhub/fastjson:1.2.83)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/fastjson_1_2_83_rce
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8577/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['SN6EVIG4c-0', 'Server-Side Template Injections Explained']
