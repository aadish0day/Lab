# Lab Target: SKF_DES_PICKLE_2

## Overview

- **Vulnerability**: OWASP-SKF Python Advanced Pickle Deserialization Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8727
- **Container Name**: `cyberlab_skf_des_pickle_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8727
[cyberlab_skf_des_pickle_2] (blabla1337/owasp-skf-lab:des-pickle-2)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_des_pickle_2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8727/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=vwbUSHUYZnc
