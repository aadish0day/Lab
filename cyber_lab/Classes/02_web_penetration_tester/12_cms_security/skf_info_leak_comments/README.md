# Lab Target: SKF_INFO_LEAK_COMMENTS

## Overview
- **Vulnerability**: OWASP-SKF HTML Comments Information Disclosure Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8812
- **Container Name**: `cyberlab_skf_info_leak_comments`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8812
[cyberlab_skf_info_leak_comments] (blabla1337/owasp-skf-lab:info-leakeage-comments)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_info_leak_comments
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8812/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=zneRNme9h3U
