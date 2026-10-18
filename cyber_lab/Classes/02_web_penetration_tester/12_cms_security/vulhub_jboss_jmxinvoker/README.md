# Lab Target: VULHUB_JBOSS_JMXINVOKER

## Overview

- **Vulnerability**: JBoss Application Server JMXInvokerServlet Deserialization RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8829
- **Container Name**: `cyberlab_vulhub_jboss_jmxinvoker`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8829
[cyberlab_vulhub_jboss_jmxinvoker] (vulhub/jboss:6.1.0)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_jboss_jmxinvoker
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8829/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=o8IBMWr-drg
