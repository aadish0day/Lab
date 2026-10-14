# OWASP crAPI - Completely Ridiculous API

## Overview
Production-grade microservices target simulating a modern connected-vehicle platform with full OWASP API Top 10 vulnerabilities.

- **Default Port / Access**: `8888 (Web), 8025 (MailHog)`
- **Directory**: `Classes/02_web_penetration_tester/03_api_penetration_testing/crapi_microservices`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:8888`.
2. Inspect MailHog inbox at `http://localhost:8025` to intercept signup verification codes and password reset links.
3. BOLA / IDOR Challenge: Query another user's vehicle location data via `/identity/api/v2/vehicle/{vehicleId}/location`.
4. Broken Function Level Authorization: Change mechanical service request status via unprotected admin endpoints.
5. JWT secret brute-force and tampering.

---

## YouTube Walkthroughs & Solving Guides

- [OWASP API Top 10 crAPI - Course Overview](https://www.youtube.com/watch?v=trN9g-H7Dac)
- [Shadow Academy: Hacking crAPI](https://www.youtube.com/watch?v=wACOKEivJyU)
- [BOLA Vulnerability crAPI application Walkthrough](https://www.youtube.com/watch?v=wsVtR4Mza98)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
