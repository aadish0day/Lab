# NoSQL Injection & MongoDB Exploitation Lab

## Overview
Exploit NoSQL queries in Node.js and MongoDB applications using operator injection (`$ne`, `$gt`, `$regex`) and authentication bypass.

- **Default Port / Access**: `3001`
- **Directory**: `Classes/02_web_penetration_tester/22_nosql_injection/nosql_injection_lab`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:3001`.
2. Authentication Bypass: Intercept login request in Burp and change JSON body from `{"username": "admin", "password": "test"}` to `{"username": "admin", "password": {"$ne": null}}`.
3. Data Extraction with Regex: Use `{"$regex": "^a.*"}` to brute-force usernames, passwords, or reset tokens character by character.
4. Command execution via MongoDB `$where` clause injections.

---

## YouTube Walkthroughs & Solving Guides

- [NoSQL Injection Basic Tutorial & Walkthrough](https://www.youtube.com/watch?v=4TJlREKMZMk)
- [TCM Security - NoSQLi Tutorial & Labs](https://www.youtube.com/watch?v=5SmDLBQxmXw)
- [Exploiting NoSQL Operator Injection to Bypass Authentication](https://www.youtube.com/watch?v=DBNmAJaWcGk)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
