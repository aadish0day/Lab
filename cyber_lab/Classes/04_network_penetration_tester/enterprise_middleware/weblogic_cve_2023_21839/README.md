# Lab Target: WEBLOGIC CVE-2023-21839

## Overview

- **Vulnerability**: CVE-2023-21839
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8580 (HTTP) / port 7001 (T3)
- **Container Name**: `cyberlab_weblogic_cve_2023_21839`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       +--> HTTP Port 8580 (Web Interface)
       +--> T3/IIOP Port 7001 (T3 Deserialization)
       v
[cyberlab_weblogic_cve_2023_21839] (vulhub/weblogic:12.2.1.3-2018)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve_2023_21839
docker compose up -d
```

## Attack Verification

```bash
# Verify WebLogic HTTP/Console service
curl -i http://localhost:8580/console/login/LoginForm.jsp

# Test WebLogic root endpoint
curl -i http://localhost:8580/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['SZ5QaCNt-mA', 'Abusing CI/CD - Top Ways to Reach Production - Omer Gil, Cider Security']
