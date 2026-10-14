# Lab Target: SKF_RACE_CONDITION_FILE

## Overview
- **Vulnerability**: OWASP-SKF File Write Race Condition Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8846
- **Container Name**: `cyberlab_skf_race_condition_file`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8846
[cyberlab_skf_race_condition_file] (blabla1337/owasp-skf-lab:race-condition-file-write)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_race_condition_file
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8846/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=inWWhr5tnEA
