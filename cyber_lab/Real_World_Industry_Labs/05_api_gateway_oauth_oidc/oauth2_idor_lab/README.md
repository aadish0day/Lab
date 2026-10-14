# Enterprise OAuth 2.0 & OIDC SSO Pentesting (Keycloak)

## Overview
Test modern Single Sign-On (SSO) and Identity Provider flows: Redirect URI poisoning, scope escalation, CSRF in OAuth state, and token forgery.

- **Default Port / Access**: `8093`
- **Directory**: `Real_World_Industry_Labs/05_api_gateway_oauth_oidc/oauth2_idor_lab`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:8093`.
2. Login to Administration Console using `admin` / `admin`.
3. Analyze client `Valid Redirect URIs` settings and test wildcard / path traversal bypasses to leak authorization codes.
4. Test OAuth CSRF by stripping or replaying the `state` parameter.
5. Inspect and tamper with JWT ID tokens and evaluate scope escalation from `read:profile` to `admin:all`.

---

## YouTube Walkthroughs & Solving Guides

- [Milan Jovanovic - How to Secure APIs with Keycloak and OAuth 2.0](https://www.youtube.com/watch?v=PLHmcXCljNg)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
