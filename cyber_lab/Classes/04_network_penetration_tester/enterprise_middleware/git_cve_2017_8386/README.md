# Lab Target: GIT CVE-2017-8386

## Overview
- **Vulnerability**: CVE-2017-8386
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8648
- **Container Name**: `cyberlab_git_cve_2017_8386`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8648
[cyberlab_git_cve_2017_8386] (vulhub/git:2.12.2-with-openssh)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/git_cve_2017_8386
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8648/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Pc4tzsn-ats
