# Lab Target: VULHUB_JAVA_RMI_BIND_DESERIALIZATION

## Overview
- **Vulnerability**: Java RMI Registry Bind Remote Code Execution Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8830
- **Container Name**: `cyberlab_vulhub_java_rmi_bind_deserialization`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8830
[cyberlab_vulhub_java_rmi_bind_deserialization] (vulhub/java:rmi-bind)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_java_rmi_bind_deserialization
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8830/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CxBI2RRg-Mk
