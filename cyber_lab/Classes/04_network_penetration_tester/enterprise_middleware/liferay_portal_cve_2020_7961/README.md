# Lab Target: LIFERAY-PORTAL CVE-2020-7961

## Overview
- **Vulnerability**: CVE-2020-7961
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8594
- **Container Name**: `cyberlab_liferay_portal_cve_2020_7961`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8594
[cyberlab_liferay_portal_cve_2020_7961] (vulhub/liferay-portal:7.2.0-ga1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/liferay_portal_cve_2020_7961
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8594/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['VkV_UPeVpPU', 'HackTheBox ~ Feline Walkthrough [Java Deserialization & Docker exploits f/ OSCP/OSWE]']
