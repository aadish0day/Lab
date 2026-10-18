# Lab Target: NEO4J CVE-2021-34371

## Overview

- **Vulnerability**: CVE-2021-34371
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8623
- **Container Name**: `cyberlab_neo4j_cve_2021_34371`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8623
[cyberlab_neo4j_cve_2021_34371] (vulhub/neo4j:3.4.18)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/neo4j_cve_2021_34371
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8623/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=ew-fnre3bl0
