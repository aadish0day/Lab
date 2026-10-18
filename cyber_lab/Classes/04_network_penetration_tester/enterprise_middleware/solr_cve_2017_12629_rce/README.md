# Lab Target: SOLR CVE-2017-12629-RCE

## Overview

- **Vulnerability**: CVE-2017-12629-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8587
- **Container Name**: `cyberlab_solr_cve_2017_12629_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8587
[cyberlab_solr_cve_2017_12629_rce] (vulhub/solr:7.0.1)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/solr_cve_2017_12629_rce
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8587/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['TZUg4PUfS1M', "CAS Quick Tour - Apereo's Central Authentication Service (CAS) Single Sign-On"]
