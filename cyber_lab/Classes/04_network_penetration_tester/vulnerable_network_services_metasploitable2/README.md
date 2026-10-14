# Metasploitable2 Multi-Service Network Pentest Suite

## Overview
Full vulnerable operating system container exposing FTP, SSH, Telnet, HTTP, and SMB services for comprehensive network exploitation.

- **Default Port / Access**: `21, 22, 23, 80, 445`
- **Directory**: `Classes/04_network_penetration_tester/vulnerable_network_services_metasploitable2`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Scan open ports with service enumeration: `nmap -sV -p 21,22,23,80,445 127.0.0.1`.
3. Enumerate weak credentials across services (default `msfadmin`/`msfadmin`, `user`/`user`).
4. Test RCE on HTTP management interfaces (TWiki, phpMyAdmin, Mutillidae).
5. Exploit vulnerable network services and escalate privileges to root.

---

## YouTube Walkthroughs & Solving Guides

- [Metasploitable 2 Full Walkthrough](https://www.youtube.com/watch?v=5nk1a1Jl_jk)
- [Metasploitable 2 Capture The Flag Walkthrough](https://www.youtube.com/watch?v=dZtWJhDi_ao)
- [Metasploitable 2 Series Introduction & Overview](https://www.youtube.com/watch?v=Sic9KyksCtE)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
