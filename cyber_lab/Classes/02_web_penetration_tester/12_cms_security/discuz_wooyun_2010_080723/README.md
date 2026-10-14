# Lab Target: DISCUZ WOOYUN-2010-080723

## Overview
- **Vulnerability**: WOOYUN-2010-080723
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8637
- **Container Name**: `cyberlab_discuz_wooyun_2010_080723`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8637
[cyberlab_discuz_wooyun_2010_080723] (vulhub/discuz:7.2)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/discuz_wooyun_2010_080723
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8637/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=dPEsjj3eONU
