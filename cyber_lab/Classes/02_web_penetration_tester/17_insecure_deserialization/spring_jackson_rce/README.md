# Jackson Databind Polymorphic Deserialization RCE (CVE-2017-7525)

## Overview

FasterXML Jackson Databind is a widely used Java library for serializing and deserializing JSON objects. When Polymorphic Deserialization is enabled (such as `enableDefaultTyping()`), Jackson serializes and deserializes Java type metadata inside JSON arrays (e.g. `["com.example.Class", {...}]`). In Jackson Databind versions prior to 2.8.9, attackers can specify arbitrary Java gadget classes on the classpath—such as `com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl` or Spring's `FileSystemXmlApplicationContext`—to achieve arbitrary Remote Code Execution.

- **Service Access**: `http://localhost:8171/`
- **Exploitation Endpoint**: `http://localhost:8171/exploit`
- **Docker Shortcut**: `./lab start spring-jackson-rce`
- **Container Name**: `cyberlab_02_spring_jackson_rce`
- **Upstream Image**: `vulhub/spring-with-jackson:2.8.8`
- **Source of Truth**: [Vulhub Jackson CVE-2017-7525](https://github.com/vulhub/vulhub/tree/master/jackson/CVE-2017-7525)
- **RAM Footprint**: ~300M

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

### 3. Check Web Endpoints

```bash
# Check root welcome page
curl -i http://localhost:8171/

# Check exploit endpoint
curl -i http://localhost:8171/exploit
```

---

## Defensive Remediation & Hardening

1. Upgrade `jackson-databind` to 2.8.9, 2.9.0, or newer.
2. Avoid `enableDefaultTyping()` without strict custom `PolymorphicTypeValidator` safelists.
3. Migrate to modern Jackson 2.10+ with `BasicPolymorphicTypeValidator`.

---

## Video Walkthroughs & Technical References

- [Jackson Databind CVE-2017-7525 Advisory](https://github.com/FasterXML/jackson-databind/issues/1599)
- [Vulhub Jackson Environment](https://github.com/vulhub/vulhub/tree/master/jackson/CVE-2017-7525)
- [Exploiting Jackson RCE: CVE-2017-7525](https://adamcaudill.com/2017/10/04/exploiting-jackson-rce-cve-2017-7525/)
