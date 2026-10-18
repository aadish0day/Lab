# Lab Target: ECSHOP COLLECTION_LIST-SQLI

## Overview

- **Vulnerability**: COLLECTION_LIST-SQLI
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8630
- **Container Name**: `cyberlab_ecshop_collection_list_sqli`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8630
[cyberlab_ecshop_collection_list_sqli] (vulhub/ecshop:4.0.6)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/ecshop_collection_list_sqli
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8630/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=YO8rsCMVUyY
