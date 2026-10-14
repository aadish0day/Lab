# Lab Target: SKF_JS_GRAPHQL

## Overview
- **Vulnerability**: OWASP-SKF Node.js GraphQL Introspection & Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8785
- **Container Name**: `cyberlab_skf_js_graphql`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8785
[cyberlab_skf_js_graphql] (blabla1337/owasp-skf-lab:js-graphql)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_graphql
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8785/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=EpXabc1XdmM
