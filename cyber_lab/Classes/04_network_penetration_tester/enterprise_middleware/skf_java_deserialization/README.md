# Lab Target: SKF_JAVA_DESERIALIZATION

## Overview

- **Vulnerability**: OWASP-SKF Java Deserialization Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8777
- **Container Name**: `cyberlab_skf_java_deserialization`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8777
[cyberlab_skf_java_deserialization] (blabla1337/owasp-skf-lab:deserialization)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_java_deserialization
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8777/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=v3Dt3Lwb_-0
