# DNS Tunneling & Data Exfiltration Lab (Iodine)

## Overview

Establish covert TCP-over-DNS tunnels to bypass firewall restrictions and practice detecting DNS tunneling with Wireshark.

- **Default Port / Access**: `5353/udp`
- **Directory**: `Classes/03_network_security/dns_tunneling`

---

## How to Solve & Practice

1. Start the Iodine DNS tunnel server: `docker compose up -d`
2. Connect an iodine client or dig utility to test DNS record query responses: `dig @localhost -p 5353 tunnel.lab.local`.
3. Observe base64/hex-encoded TXT and NULL query traffic.
4. Inspect captured packets in Wireshark and write a display filter to detect high-entropy DNS request lengths: `dns.qry.name.len > 50`.

---

## YouTube Walkthroughs & Solving Guides

- [Data Exfiltration, Firewall Evasion, and DNS Encapsulation with Iodine](https://www.youtube.com/watch?v=rrZ3xh4pfm8)
- [Hak5 - Get Free WiFi by Tunneling Through DNS](https://www.youtube.com/watch?v=EexflA75B7A)
- [DNS Tunneling Identification and Defense](https://www.youtube.com/watch?v=CaFo83TlpPM)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
