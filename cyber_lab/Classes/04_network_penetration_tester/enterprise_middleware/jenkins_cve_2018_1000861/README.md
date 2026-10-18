# Lab Target: JENKINS CVE-2018-1000861

## Overview

- **Vulnerability**: CVE-2018-1000861
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8597
- **Container Name**: `cyberlab_jenkins_cve_2018_1000861`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8597
[cyberlab_jenkins_cve_2018_1000861] (vulhub/jenkins:2.138)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/jenkins_cve_2018_1000861
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8597/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['WUHzpDdauAw', 'Microsoft Entra ID INSECURE DEFAULTS']
