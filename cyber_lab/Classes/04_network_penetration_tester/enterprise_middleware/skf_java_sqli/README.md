# Lab Target: SKF_JAVA_SQLI

## Overview
- **Vulnerability**: OWASP-SKF SQL Injection Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8778
- **Container Name**: `cyberlab_skf_java_sqli`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8778
[cyberlab_skf_java_sqli] (blabla1337/owasp-skf-lab:sqli)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_java_sqli
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8778/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=4TJlREKMZMk
