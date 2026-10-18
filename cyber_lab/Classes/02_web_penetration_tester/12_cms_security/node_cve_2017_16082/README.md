# Lab Target: NODE CVE-2017-16082

## Overview

- **Vulnerability**: CVE-2017-16082
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8570
- **Container Name**: `cyberlab_node_cve_2017_16082`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8570
[cyberlab_node_cve_2017_16082] (postgres:9.6)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/node_cve_2017_16082
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8570/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['QjPFjd8GJWY', 'HTTP Request Smuggling Explained (with James Kettle)']
