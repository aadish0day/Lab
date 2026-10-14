# VAmPI - Vulnerable REST API (OWASP API Top 10)

## Overview
Practice attacking REST APIs: BOLA (Broken Object Level Authorization), User enumeration, Mass Assignment, and Token manipulation.

- **Default Port / Access**: `5000`
- **Directory**: `Classes/02_web_penetration_tester/03_api_penetration_testing/rest_vampi`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Import Swagger/OpenAPI documentation from `http://localhost:5000/openapi.json` into Postman or Caido/Burp Suite.
3. Register a new user at `POST /users/v1/register` and obtain JWT auth bearer token.
4. Test BOLA / IDOR: Send `GET /users/v1/_debug` or query other usernames at `GET /users/v1/{username}` using your standard token.
5. Exploit regex password validation flaws and mass assignment in user role updates.

---

## YouTube Walkthroughs & Solving Guides

- [API Pentesting Part 1 | Postman + Burp Suite](https://www.youtube.com/watch?v=xDotz4iOVNQ)
- [InsiderPhD - Go Hack Yourself: API Hacking for Beginners](https://www.youtube.com/watch?v=IO4FjTflU6s)
- [NahamSec - 2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
