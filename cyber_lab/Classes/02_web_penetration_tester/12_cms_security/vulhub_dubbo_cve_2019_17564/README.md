# Lab Target: VULHUB_DUBBO_CVE_2019_17564

## Overview
- **Vulnerability**: Apache Dubbo HTTP Invoker Deserialization RCE (CVE-2019-17564)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8828
- **Container Name**: `cyberlab_vulhub_dubbo_cve_2019_17564`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8828
[cyberlab_vulhub_dubbo_cve_2019_17564] (vulhub/dubbo:2.7.3)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_dubbo_cve_2019_17564
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8828/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=B7p8dIB7bFg
