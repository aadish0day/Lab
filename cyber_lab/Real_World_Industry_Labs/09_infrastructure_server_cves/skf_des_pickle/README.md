# Lab Target: SKF_DES_PICKLE

## Overview
- **Vulnerability**: OWASP-SKF Python Pickle Deserialization Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8726
- **Container Name**: `cyberlab_skf_des_pickle`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8726
[cyberlab_skf_des_pickle] (blabla1337/owasp-skf-lab:des-pickle)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_des_pickle
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8726/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=inWWhr5tnEA
