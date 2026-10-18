# XStream Polymorphic Unmarshaling Deserialization RCE (CVE-2021-29505)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **XStream Polymorphic Unmarshaling Deserialization RCE** (CVE-2021-29505).

- **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/xstream_cve_2021_29505`
- **Default Port(s)**: `8202:8080`
- **CLI Shortcut**: `./lab start xstream-deserialization-rce`
- **Source of Truth**: [Vulhub XStream CVE-2021-29505](https://github.com/vulhub/vulhub/tree/master/xstream/CVE-2021-29505)

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_xstream_29505`
- **Upstream Image**: `vulhub/xstream:1.4.16` (Spring Boot + XStream 1.4.16)
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 400 MB RAM limit

---

## Vulnerability Mechanics

XStream uses a blocklist mechanism when parsing XML text to defend against deserialization vulnerabilities. In 1.4.16 and earlier, blocklists are incomplete and attackers could use `sun.rmi.registry.RegistryImpl_Stub` or PriorityQueue gadget chains to trigger an outbound RMI/JNDI request and execute arbitrary commands.

---

## Verification & Health Check

### 1. Validate Configuration

```bash
docker compose config -q
```

### 2. Start Services

```bash
docker compose up -d
```

### 3. Check Web Endpoint

```bash
curl -i http://localhost:8202/
```

### 4. Send XML Object

```bash
curl -i -X POST -H "Content-Type: application/xml" \
  http://localhost:8202/ \
  -d '<string>cyberlab_test</string>'
```

---

## Defensive Remediation & Hardening

1. Upgrade XStream to version 1.4.17 or later.
2. Initialize and configure explicit class whitelisting with `XStream.setupDefaultSecurity()`:
   ```java
   xstream.addPermission(NoTypePermission.NONE);
   xstream.allowTypesByWildcard(new String[] {"com.mycompany.models.**"});
   ```

---

## Verified Video Walkthrough

- **Video Title**: [PoC Exploiting struts2-rest XStream Deserialization with Reverse Shell](https://www.youtube.com/watch?v=IrZOlqio0nw)
- **Direct URL**: https://www.youtube.com/watch?v=IrZOlqio0nw
