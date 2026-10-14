# Lab Target: JIRA CVE-2019-11581

## Overview
- **Vulnerability**: CVE-2019-11581
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8625
- **Container Name**: `cyberlab_jira_cve_2019_11581`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8625
[cyberlab_jira_cve_2019_11581] (vulhub/jira:8.1.0)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/jira_cve_2019_11581
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8625/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jwzeJU_62IQ
