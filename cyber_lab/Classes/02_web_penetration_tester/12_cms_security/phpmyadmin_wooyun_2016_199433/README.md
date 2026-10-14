# Lab Target: PHPMYADMIN WOOYUN-2016-199433

## Overview
- **Vulnerability**: WOOYUN-2016-199433
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8564
- **Container Name**: `cyberlab_phpmyadmin_wooyun_2016_199433`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8564
[cyberlab_phpmyadmin_wooyun_2016_199433] (vulhub/phpmyadmin:2.8.0.4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/phpmyadmin_wooyun_2016_199433
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8564/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['PLHmcXCljNg', 'How to Secure .NET 10 APIs with Keycloak and OAuth 2.0']
