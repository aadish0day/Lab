# Fastjson 1.2.47 AutoType Bypass Deserialization RCE

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Fastjson 1.2.47 AutoType Bypass Deserialization RCE** (Fastjson 1.2.47 AutoType Bypass).

- **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_cve_2019_12086`
- **Default Port(s)**: `8205:8090`
- **CLI Shortcut**: `./lab start fastjson-autotype-bypass`
- **Source of Truth**: [Vulhub Fastjson 1.2.47-rce](https://github.com/vulhub/vulhub/tree/master/fastjson/1.2.47-rce)

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_fastjson_12086`
- **Upstream Image**: `vulhub/fastjson:1.2.45`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 400 MB RAM limit

---

## Vulnerability Mechanics

Fastjson AutoType bypass using `java.lang.Class` mapping cache injection to bypass blacklist checks and execute JNDI remote lookups.

### Technical Root Cause

Fastjson 1.2.47 contains an AutoType bypass flaw where sending a JSON payload containing `java.lang.Class` loads an arbitrary class into the internal `TypeUtils.mappings` cache. Subsequent keys deserialize classes like `java.net.URLClassLoader` or `com.sun.rowset.JdbcRowSetImpl` directly from cache without triggering AutoType security checks.

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

### 3. Check JSON Endpoint

```bash
curl -i http://localhost:8205/
```

### 4. Send Test JSON Object

```bash
curl -i -X POST -H "Content-Type: application/json" \
  http://localhost:8205/ \
  -d '{"name":"cyberlab", "role":"tester"}'
```

---

## Defensive Remediation & Hardening

Upgrade Fastjson to version 1.2.83 or migrate to Fastjson2 with `safeMode` enabled.

---

## Verified Video Walkthrough

- **Video Title**: [Insecure Deserialization Attack Explained](https://www.youtube.com/watch?v=jwzeJU_62IQ)
- **Direct URL**: https://www.youtube.com/watch?v=jwzeJU_62IQ
