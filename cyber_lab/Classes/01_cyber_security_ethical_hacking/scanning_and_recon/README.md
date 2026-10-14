# Port Scanning & Network Reconnaissance Lab

## Overview
Learn network discovery, port scanning, service enumeration, and banner grabbing against live targets.

- **Default Port / Access**: `8081`
- **Directory**: `Classes/01_cyber_security_ethical_hacking/scanning_and_recon`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Perform network ping sweep and host discovery: `nmap -sn 127.0.0.1`
3. Run full TCP port scan with service detection: `nmap -sS -sV -p- -T4 localhost -p 8081`
4. Perform vulnerability and NSE script scan: `nmap --script vuln -p 8081 localhost`
5. Grab service banner using netcat: `nc -vn 127.0.0.1 8081`

---

## YouTube Walkthroughs & Solving Guides

- [NetworkChuck - Nmap Tutorial to find Network Vulnerabilities](https://www.youtube.com/watch?v=4t4kBkMsDbQ)
- [The Cyber Mentor - Full Ethical Hacking Course (Network Scanning & Tactics)](https://www.youtube.com/watch?v=WnN6dbos5u8)
- [David Bombal - How Nmap really works (Wireshark & Port Scanning)](https://www.youtube.com/watch?v=F2PXe_o7KqM)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
