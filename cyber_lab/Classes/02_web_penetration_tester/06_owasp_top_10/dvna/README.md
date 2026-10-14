# Damn Vulnerable NodeJS Application (DVNA): Modern JS & Server-Side Runtime Flaws

## Overview

Damn Vulnerable NodeJS Application (DVNA), developed by AppSecco, is a vulnerable web platform built specifically to demonstrate vulnerabilities inherent to modern JavaScript runtimes, the Node.js event-driven architecture, Express.js middleware, and Sequelize Object-Relational Mapping (ORM).

While traditional web application flaws like SQL injection behave differently across database dialects, JavaScript environments introduce unique vulnerability classes: prototype pollution altering runtime prototypes across unrelated requests, regular expression denial-of-service (ReDoS) freezing single-threaded event loops, and dynamic `eval()` remote execution.

- **Primary Interface**: `http://localhost:8117`
- **Docker Shortcut**: `./lab start dvna`
- **Container Name**: `cyberlab_02_dvna_node`
- **RAM Footprint**: ~140 MB (Standalone SQLite embedded engine)

---

## Architecture & Technology Stack

```
+-------------------------------------------------------------+
|                     Client Browser / Postman                |
+-------------------------------------------------------------+
                               |
                        HTTP Port 8117
                               v
+-------------------------------------------------------------+
|                DVNA Container (appsecco/dvna:sqlite)        |
|                                                             |
|  [Node.js v14/16 + Express.js Web Framework]                |
|    - Single-Threaded V8 Event Loop                          |
|    - Passport.js Session & Local Authentication             |
|    - EJS Server-Side Template Rendering Engine              |
|                                                             |
|  [Sequelize ORM + Embedded SQLite Database]                 |
|    - In-Memory / File-backed SQLite Storage                 |
|    - User models, products, orders, and privileges          |
+-------------------------------------------------------------+
```

---

## Key Vulnerability Domains & Attack Exercises

### 1. JavaScript Prototype Pollution
* **Mechanism**: Merging unvalidated user JSON properties directly into an object without filtering dangerous keys (`__proto__`, `constructor.prototype`).
* **Exploitation Impact**: When an attacker injects a property into `Object.prototype`, every object created in the entire Node.js process inherits that property, leading to authentication bypass or logic hijacking.
* **Attack Payload**:
  ```json
  {
    "__proto__": {
      "isAdmin": true
    }
  }
  ```

### 2. Regular Expression Denial of Service (ReDoS)
* **Mechanism**: Exploiting catastrophic backtracking in unoptimized regular expressions used for user input validation (such as email validation or username formats).
* **Exploitation Impact**: Because Node.js runs on a single thread, an input that triggers exponential backtracking causes 100% CPU utilization, freezing the event loop and blocking all concurrent users from receiving responses.
* **Attack Payload**:
  ```text
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!
  ```
  against vulnerable regexes of the form `^(a+)+$`.

### 3. Mass Assignment via Sequelize ORM
* **Target Endpoint**: User profile update (`POST /app/profile`)
* **Vulnerability Mechanism**: Directly passing `req.body` into `User.update()` without specifying an `attributes` or `fields` whitelist:
  ```javascript
  User.update(req.body, { where: { id: req.user.id } });
  ```
* **Attack Walkthrough**:
  Intercept the profile update request and inject the administrative privilege parameter:
  ```json
  {
    "name": "Attacker",
    "email": "attacker@cyberlab.local",
    "role": "admin",
    "isAdmin": true
  }
  ```
  The ORM updates the user's role to administrator in the database.

### 4. Server-Side Template Injection (SSTI) in EJS
* **Target Feature**: User profile display or customized greeting templates.
* **Vulnerability Mechanism**: Concatenating unescaped user input into template strings before rendering.
* **Attack Payload**:
  ```text
  <%= global.process.mainModule.require('child_process').execSync('id').toString() %>
  ```

---

## Defensive Remediation & Hardening

1. **Defending Against Prototype Pollution**:
   - Use `Object.create(null)` for key-value stores to prevent inheriting from `Object.prototype`.
   - Freeze the prototype in production: `Object.freeze(Object.prototype)`.
   - Sanitize JSON keys to drop `__proto__`, `constructor`, and `prototype`.
2. **Preventing Mass Assignment**:
   - Explicitly define the allowable fields in Sequelize queries:
     ```javascript
     User.update(req.body, {
       fields: ['name', 'bio'],
       where: { id: req.user.id }
     });
     ```
3. **Mitigating ReDoS**:
   - Use safe regular expression engines (e.g., `re2`) or strictly validate input length before applying regex checks.

---

## Video Walkthroughs & Technical References

- [Learning Web Security Using NodeGoat](https://www.youtube.com/watch?v=h51jm1o82fI)
- [Security with Node.js - OWASP Top 10](https://www.youtube.com/watch?v=jbMuwu7jicI)
- [AppSecco DVNA GitHub Repository](https://github.com/appsecco/dvna)
- [OWASP Server-Side JavaScript Injection Guidelines](https://owasp.org/www-community/attacks/Server_Side_JavaScript_Injection)
