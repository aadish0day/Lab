# Lab Target: SKF_JS_GRAPHQL_MUTATION

## Overview
- **Vulnerability**: OWASP-SKF Node.js GraphQL Mutation Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8786
- **Container Name**: `cyberlab_skf_js_graphql_mutation`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8786
[cyberlab_skf_js_graphql_mutation] (blabla1337/owasp-skf-lab:js-graphql-mutation)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_graphql_mutation
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8786/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=inWWhr5tnEA
