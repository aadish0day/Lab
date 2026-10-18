# Lab Target: TEAMCITY CVE-2023-42793

## Overview

- **Vulnerability**: CVE-2023-42793
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8605
- **Container Name**: `cyberlab_teamcity_cve_2023_42793`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8605
[cyberlab_teamcity_cve_2023_42793] (vulhub/teamcity:2023.05.3)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/teamcity_cve_2023_42793
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8605/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['YA-mL9Z8SNI', 'DVGA - Damn Vulnerable GraphQL Application | GraphQL Exploitation - Part - 2 | DVGA']
