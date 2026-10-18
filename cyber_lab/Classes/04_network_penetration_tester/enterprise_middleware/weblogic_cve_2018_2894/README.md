# Lab Target: WEBLOGIC CVE-2018-2894

## Overview

- **Vulnerability**: CVE-2018-2894
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8581
- **Container Name**: `cyberlab_weblogic_cve_2018_2894`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8581
[cyberlab_weblogic_cve_2018_2894] (vulhub/weblogic:12.2.1.3-2018)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve_2018_2894
docker compose up -d
```

## Attack Verification

```bash
# Verify WebLogic HTTP/Console service (internal port 7001 forwarded to 8581)
curl -i http://localhost:8581/console/login/LoginForm.jsp

# Access Web Service Test Page (CVE-2018-2894 vulnerable endpoint)
curl -i http://localhost:8581/ws_utc/config.do
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Sic9KyksCtE', 'How To - Metasploitable 2 Series Introduction']
