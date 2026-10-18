# Snort: Intrusion Detection & Prevention (IDS/IPS) Lab

## Overview

Write custom packet inspection rules, analyze PCAP traffic, and detect network attacks (port scans, Nmap, reverse shells).

- **Default Port / Access**: `Host Network Mode`
- **Directory**: `Classes/03_network_security/ids_ips_snort`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Inspect active Snort rules inside `/etc/snort/rules`.
3. Write a rule to alert on ICMP ping sweeps: `alert icmp any any -> $HOME_NET any (msg:"ICMP Ping Detected"; sid:1000001; rev:1;)`
4. Trigger the alert from another terminal: `ping -c 3 127.0.0.1` or `nmap -sS 127.0.0.1`.
5. Verify alert output in `/var/log/snort/alert`.

---

## YouTube Walkthroughs & Solving Guides

- [HackerSploit - How To Create Rules with Snort](https://www.youtube.com/watch?v=2kNpK-2KLq4)
- [Jon Good - Snort 101: Install and Configure Snort](https://www.youtube.com/watch?v=UAKq1S-VxJ8)
- [David Bombal - Custom Snort Rules & Investigation](https://www.youtube.com/watch?v=8Rrb7t6758E)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
