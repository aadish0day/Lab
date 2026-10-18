# Lab Target: SOLR CVE-2017-12629-XXE

## Overview

- **Vulnerability**: CVE-2017-12629-XXE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8586
- **Container Name**: `cyberlab_solr_cve_2017_12629_xxe`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8586
[cyberlab_solr_cve_2017_12629_xxe] (vulhub/solr:7.0.1)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/solr_cve_2017_12629_xxe
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8586/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['TUdmvq6FoNk', 'Exploit Walkthrough: CVE-2022-46169 - Authentication Bypass & RCE in Cacti 1.2.22']
