# Metasploitable2 Multi-Service Network Pentest Suite

## Overview

Full vulnerable operating system container exposing FTP, SSH, Telnet, HTTP, and SMB services for comprehensive network exploitation.

- **Default Port / Access**:
  - FTP: `2121` (vsftpd 2.3.4)
  - SSH: `2222` (OpenSSH 4.7p1)
  - Telnet: `2323` (Linux telnetd)
  - HTTP: `8082` (Apache 2.2.8 - Mutillidae, DVWA, phpMyAdmin, TWiki)
  - SMB: `4450` (Samba 3.0.20-Debian)
  - Backdoor: `6200` (vsftpd 2.3.4 backdoor root shell)
- **Directory**: `Classes/04_network_penetration_tester/vulnerable_network_services_metasploitable2`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Scan open ports with service enumeration: `nmap -sV -p 2121,2222,2323,8082,4450,6200 127.0.0.1`.
3. Enumerate weak credentials across services (default `msfadmin`/`msfadmin`, `user`/`user`).
4. Test RCE on HTTP management interfaces (`http://localhost:8082/` for TWiki, phpMyAdmin, Mutillidae).
5. Exploit vulnerable network services and escalate privileges to root (e.g. trigger vsftpd backdoor on port 2121 and connect to root shell on port 6200).

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
