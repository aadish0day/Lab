# Lab Target: SKF_SQLI_TIME_BASED

## Overview
- **Vulnerability**: OWASP-SKF Time-Based Blind SQL Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8839
- **Container Name**: `cyberlab_skf_sqli_time_based`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8839
[cyberlab_skf_sqli_time_based] (blabla1337/owasp-skf-lab:sqli-time-based)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_sqli_time_based
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8839/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Jf3ZeL7lGog
