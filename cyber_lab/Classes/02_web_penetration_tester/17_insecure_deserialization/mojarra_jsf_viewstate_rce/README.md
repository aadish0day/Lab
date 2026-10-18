# Mojarra JSF ViewState Deserialization Remote Code Execution

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Mojarra JSF ViewState Deserialization Remote Code Execution** (Mojarra JSF 2.1.28).

- **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/mojarra_jsf_viewstate_rce`
- **Default Port(s)**: `8201:8080`
- **CLI Shortcut**: `./lab start mojarra-viewstate-rce`
- **Source of Truth**: [Vulhub Mojarra JSF ViewState Deserialization](https://github.com/vulhub/vulhub/tree/master/mojarra/jsf-viewstate-deserialization)

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_mojarra_viewstate`
- **Upstream Image**: `vulhub/mojarra:2.1.28` (JDK 7u21 + Mojarra 2.1.28)
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 400 MB RAM limit

---

## Vulnerability Mechanics

JavaServer Faces (JSF) Mojarra unencrypted client-side ViewState parameter deserialization.

### Technical Root Cause

Mojarra before 2.1.29-08 and 2.0.11-04 is not configured to encrypt the ViewState by default when `javax.faces.STATE_SAVING_METHOD` is client-side. The base64/gzipped `javax.faces.ViewState` POST parameter is passed directly into `ObjectInputStream.readObject()`, permitting Java gadget chain exploitation (such as the standard `Jdk7u21` gadget chain) to execute arbitrary operating system commands.

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

### 3. Check Web Demo Page

```bash
curl -i http://localhost:8201/
```

---

## Defensive Remediation & Hardening

1. Upgrade Mojarra to version 2.1.29-08 / 2.0.11-04 or newer.
2. Configure server-side state saving:
   ```xml
   <context-param>
       <param-name>javax.faces.STATE_SAVING_METHOD</param-name>
       <param-value>server</param-value>
   </context-param>
   ```
3. If client-side saving is necessary, enforce ViewState encryption with a strong AES key and HMAC verification.

---

## Verified Video Walkthrough

- **Video Title**: [Insecure Deserialization Attack Explained](https://www.youtube.com/watch?v=jwzeJU_62IQ)
- **Direct URL**: https://www.youtube.com/watch?v=jwzeJU_62IQ
