# Fastjson 1.2.83 Remote Command Execution (CVE-2022-25845)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Fastjson 1.2.83 Remote Command Execution** via the `jar:` protocol (CVE-2022-25845).

- **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_cve_2022_25845`
- **Default Port(s)**: `8254:8090`
- **CLI Shortcut**: `./lab start fastjson-1283-rce`
- **Source of Truth**: [Vulhub Fastjson 1.2.83-rce](https://github.com/vulhub/vulhub/tree/master/fastjson/1.2.83-rce)

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_fastjson_25845`
- **Upstream Image**: `vulhub/fastjson:1.2.83`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 400 MB RAM limit

---

## Vulnerability Mechanics

Even with `autoType` disabled (default) and no gadget classes on classpath, Fastjson 1.2.83 remains exploitable through JVM's `jar:` protocol. While handling `@type`, `checkAutoType` performs an `@JSONType` annotation probe that calls `getResourceAsStream` on `<typeName>.class` before validating the class name, allowing remote JAR loading and instantiation.

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
curl -i http://localhost:8254/
```

### 4. Send Test JSON Object

```bash
curl -i -X POST -H "Content-Type: application/json" \
  http://localhost:8254/ \
  -d '{"name":"cyberlab", "role":"tester"}'
```

---

## Defensive Remediation & Hardening

1. Enable `safeMode` globally (`-Dfastjson.parser.safeMode=true`) which completely disables autoType and class resolution.
2. Upgrade to Fastjson2 with explicit class safelists.

---

## Verified Video Walkthrough

- **Video Title**: [CVE-2026-16723: Fastjson RCE — The Safe Version Is the Vulnerable Version](https://www.youtube.com/watch?v=FLsg8Q4GJ3M)
- **Direct URL**: https://www.youtube.com/watch?v=FLsg8Q4GJ3M
