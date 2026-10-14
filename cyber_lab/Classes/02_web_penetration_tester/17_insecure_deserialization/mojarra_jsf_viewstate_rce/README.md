# Mojarra JSF ViewState Deserialization Remote Code Execution

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Mojarra JSF ViewState Deserialization Remote Code Execution** (Mojarra JSF 2.1.28).

* **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/mojarra_jsf_viewstate_rce`
* **Default Port(s)**: `8201:8080`
* **CLI Shortcut**: `./lab start mojarra-viewstate-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_mojarra`
* **Upstream Image**: `vulhub/mojarra:2.1.28`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
JavaServer Faces (JSF) Mojarra unencrypted client-side ViewState parameter deserialization.

### Technical Root Cause
When `javax.faces.STATE_SAVING_METHOD` is set to `client` without enabling ViewState encryption, Mojarra deserializes the base64-encoded `javax.faces.ViewState` parameter, enabling standard Java gadget chain execution.

---

## Defensive Remediation & Hardening
Configure server-side state saving (`javax.faces.STATE_SAVING_METHOD=server`) or enforce strong AES encryption with HMAC signatures for client-side view states.

---

## Verified Video Walkthrough
* **Video Title**: [Insecure Deserialization Attack Explained](https://www.youtube.com/watch?v=jwzeJU_62IQ)
* **Direct URL**: https://www.youtube.com/watch?v=jwzeJU_62IQ
