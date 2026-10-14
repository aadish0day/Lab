# DVGA - Damn Vulnerable GraphQL Application

## Overview
Attack GraphQL endpoints: Schema Introspection, Denial of Service (Batching / Circular Queries), and Injection.

- **Default Port / Access**: `5013`
- **Directory**: `Classes/02_web_penetration_tester/03_api_penetration_testing/graphql_dvga`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:5013`.
2. Perform schema introspection using InQL extension or Burp Suite: query `__schema { types { name } }`.
3. Find hidden administrative queries or sensitive fields (e.g. `pastes`, `systemHealth`, internal user emails).
4. Test Batching Attacks to brute-force OTP or credentials in a single HTTP request.
5. Execute SQLi / Injection inside GraphQL arguments.

---

## YouTube Walkthroughs & Solving Guides

- [Graphql Endpoint Analysis | Damn Vulnerable Graphql Application](https://www.youtube.com/watch?v=In-XF5sY1Yo)
- [DVGA - Damn Vulnerable GraphQL Application Exploitation Part 2](https://www.youtube.com/watch?v=YA-mL9Z8SNI)
- [Farah Hawa - HACKING GraphQL FOR BEGINNERS](https://www.youtube.com/watch?v=OQCgmftU-Og)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
