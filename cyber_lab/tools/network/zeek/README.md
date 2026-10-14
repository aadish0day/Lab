# Zeek Network Security Monitor & Web Wireshark Analysis Suite

## Overview
Perform enterprise Network Security Monitoring (NSM) and deep packet analysis. Zeek (formerly Bro) translates raw network packet streams into high-fidelity, structured semantic event logs (`conn.log`, `dns.log`, `ssl.log`, `http.log`, `files.log`), computes TLS client fingerprints (**JA3/JA4**), and extracts transferred payloads. Inspect and validate captured traffic visually using the integrated **Web Wireshark** browser GUI.

- **Default Port / Access**:
  - Web Wireshark GUI: `http://localhost:3003` (via browser, no client installation required)
  - Zeek Analysis Container: `cyberlab_zeek`
- **Shared Storage**:
  - PCAP Directory: `Classes/03_network_security/zeek_network_analysis/pcaps`
  - Zeek Logs Directory: `Classes/03_network_security/zeek_network_analysis/zeek_logs`
- **Directory**: `Classes/03_network_security/zeek_network_analysis`

---

## Semantic Logging & Core Architecture

```
                       [ Network Traffic / PCAP File ]
                                      |
                     +----------------+---------------+
                     |                                |
                     v                                v
         +-----------------------+        +-----------------------+
         |  Zeek Protocol Engine |        |     Web Wireshark     |
         |      (cyberlab_zeek)  |        | (cyberlab_web_wireshark)|
         +-----------+-----------+        +-----------+-----------+
                     |                                |
   +-----------------+-----------------+              |
   | Semantic Structured Logs (UID Pivoting)           v
   | - conn.log  (Sessions, Bytes, Flags)    Port 3003 (Browser UI)
   | - dns.log   (Queries, Responses, DGA)   Packet payload inspection
   | - ssl.log   (Certs, SNI, JA3/JA4 hashes)
   | - http.log  (URIs, User-Agents, Methods)
   +-----------------------------------+
```

### Key Zeek Concepts:
1. **The UID (Unique Identifier)**: Every flow in Zeek is assigned a globally unique session identifier (e.g., `Cd3X483K5K70m7zL2a`). If a connection starts in `conn.log`, the exact same `uid` links to the corresponding request in `http.log`, the TLS handshake in `ssl.log`, and any files dumped in `files.log`.
2. **Connection State Flags (`conn_state`)**:
   - `S0`: Connection attempt seen, no reply (potential port scan or filtered firewall).
   - `SF`: Normal establishment and graceful termination.
   - `REJ`: Connection attempt rejected (RST or ICMP unreachable).
   - `RSTO` / `RSTR`: Connection aborted by originator or responder.
3. **JA3 / JA4 TLS Fingerprinting**: Hashes calculated from client TLS parameters (cipher suites, extensions, elliptic curves). Malware families (Cobalt Strike, TrickBot, Emotet) retain consistent JA3 hashes regardless of IP or domain changes.

---

## How to Solve & Practice

### 1. Start the Environment
```bash
docker compose up -d
```
Open `http://localhost:3003` in your browser to verify Web Wireshark is live.

### 2. Place or Download a Sample PCAP
Place any `.pcap` or `.pcapng` file into `./pcaps`:
```bash
# Example: Download an active threat pcap (e.g. Cobalt Strike or TrickBot sample)
curl -sL "https://raw.githubusercontent.com/brown3321/Zeek-Tutorial/master/samples/exercise_traffic.pcap" -o pcaps/sample.pcap
```

### 3. Process the PCAP with Zeek
Execute Zeek inside the container against the sample PCAP:
```bash
docker exec -it cyberlab_zeek zeek -C -r /workspace/pcaps/sample.pcap local
```
Zeek will generate all semantic log files inside `/workspace/zeek_logs` (visible on the host in `./zeek_logs`).

### 4. Query and Hunt Using `zeek-cut`

#### A. Session Overview (`conn.log`):
```bash
docker exec -it cyberlab_zeek bash -c \
  "cat /workspace/zeek_logs/conn.log | zeek-cut uid id.orig_h id.resp_h id.resp_p proto conn_state orig_bytes resp_bytes"
```

#### B. Investigate Suspicious DNS Queries (`dns.log`):
```bash
docker exec -it cyberlab_zeek bash -c \
  "cat /workspace/zeek_logs/dns.log | zeek-cut ts uid query answers qtype_name"
```
Look for domain generation algorithms (DGAs), unusually long base64/hex subdomains (DNS tunneling), or high query volumes to unfamiliar TLDs.

#### C. Extract TLS Details and JA3 Fingerprints (`ssl.log`):
```bash
docker exec -it cyberlab_zeek bash -c \
  "cat /workspace/zeek_logs/ssl.log | zeek-cut uid server_name ja3 ja3s subject"
```
Match observed JA3 hashes against threat intelligence databases (e.g., Abuse.ch SSLBL) to identify unauthorized C2 implants.

#### D. Correlate with Web Wireshark:
1. Copy the suspicious `uid` or IP/port identified in Zeek.
2. In Web Wireshark (`http://localhost:3003`), go to **File** -> **Open** and select `/config/pcaps/sample.pcap`.
3. Filter by packet details (e.g. `ip.addr == 192.168.1.50 && tcp.port == 443`).
4. Follow the TCP stream to view raw payload bytes and certificate attributes.

---

## YouTube Walkthroughs & Solving Guides

- [Black Hills Information Security - Introduction to Zeek Log Analysis w/ Troy Wojewoda](https://www.youtube.com/watch?v=a2Cp6VYQuvU)
- [Threat Hunter's Daily - Introduction to Zeek network security monitoring, conn.log and pivoting with Zeek UIDs](https://www.youtube.com/watch?v=-eLI0_OCEmk)
- [WireDogSec - Intro To Zeek Network Security Monitoring | TryHackMe Zeek Walkthrough](https://www.youtube.com/watch?v=DtYl3tpdx1c)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
