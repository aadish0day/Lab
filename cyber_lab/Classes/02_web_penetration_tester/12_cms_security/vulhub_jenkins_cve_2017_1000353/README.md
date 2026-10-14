# Lab Target: VULHUB_JENKINS_CVE_2017_1000353

## Overview
- **Vulnerability**: Jenkins Java SignedObject Deserialization RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8821
- **Container Name**: `cyberlab_vulhub_jenkins_cve_2017_1000353`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8821
[cyberlab_vulhub_jenkins_cve_2017_1000353] (vulhub/jenkins:2.56)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_jenkins_cve_2017_1000353
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8821/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0KYDTt5DiNM
