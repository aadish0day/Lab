# Port Scanning & Network Reconnaissance Lab

## Overview

Learn network discovery, port scanning, service enumeration, vulnerability detection via Nmap Scripting Engine (NSE), and banner grabbing against a live multi-service target environment.

- **Primary Web Port**: `http://localhost:8081` (Apache 2.2.22 / Shellshock CGI)
- **SSH Port**: `2222` (OpenSSH 7.7)
- **FTP Port**: `2121` (vsftpd Alpine FTP)
- **Directory**: `Classes/01_cyber_security_ethical_hacking/scanning_and_recon`

---

## Target Services & Architecture

This lab exposes a multi-port reconnaissance target composed of three distinct network services:

| Service        | Container Name          | Host Port | Target Port | Software / Details                                         |
| :------------- | :---------------------- | :-------- | :---------- | :--------------------------------------------------------- |
| **Web (HTTP)** | `cyberlab_01_recon_web` | `8081`    | `80/tcp`    | Apache 2.2.22 (Debian), CGI Shellshock vulnerable endpoint |
| **SSH**        | `cyberlab_01_recon_ssh` | `2222`    | `22/tcp`    | OpenSSH 7.7 (protocol 2.0)                                 |
| **FTP**        | `cyberlab_01_recon_ftp` | `2121`    | `21/tcp`    | vsftpd 2.0.8+ (Alpine Linux FTP Server)                    |

---

## How to Solve & Practice

### 1. Start the Lab Environment

From this directory:

```bash
docker compose up -d
```

Or from the `cyber_lab` root directory:

```bash
./lab start recon
```

### 2. Host Discovery & Ping Sweep

Perform ICMP and ARP/TCP host discovery against localhost:

```bash
nmap -sn 127.0.0.1
```

### 3. TCP Port Scanning & Service Enumeration

Scan the target's open ports and run service version detection (`-sV`):

```bash
nmap -sV -p 2121,2222,8081 127.0.0.1
```

**Expected Output:**

```text
PORT     STATE SERVICE VERSION
2121/tcp open  ftp     vsftpd 2.0.8 or later
2222/tcp open  ssh     OpenSSH 7.7 (protocol 2.0)
8081/tcp open  http    Apache httpd 2.2.22 ((Debian))
Service Info: Host: Welcome
```

### 4. Interactive Banner Grabbing

Inspect service banners and identify software versions manually using Netcat:

- **FTP Banner (Port 2121):**

  ```bash
  nc -vn -w 2 127.0.0.1 2121
  ```

  _Expected Response:_ `220 Welcome Alpine ftp server https://hub.docker.com/r/delfer/alpine-ftp-server/`

- **SSH Banner (Port 2222):**

  ```bash
  nc -vn -w 2 127.0.0.1 2222
  ```

  _Expected Response:_ `SSH-2.0-OpenSSH_7.7`

- **HTTP Banner & Server Header (Port 8081):**
  ```bash
  printf "HEAD / HTTP/1.0\r\n\r\n" | nc -vn 127.0.0.1 8081
  ```
  _Expected Response:_ `Server: Apache/2.2.22 (Debian)`

### 5. NSE Vulnerability Scanning

Run Nmap Scripting Engine (NSE) vulnerability checks against the HTTP service:

```bash
nmap -sV --script http-shellshock --script-args uri=/cgi-bin/vulnerable -p 8081 127.0.0.1
```

**Expected Output:**

```text
PORT     STATE SERVICE VERSION
8081/tcp open  http    Apache httpd 2.2.22 ((Debian))
| http-shellshock:
|   VULNERABLE:
|   HTTP Shellshock vulnerability
|     State: VULNERABLE (Exploitable)
|     IDs:  CVE:CVE-2014-6271
```

Or execute the broader vulnerability scan suite:

```bash
nmap -sV --script vuln -p 8081 --script-args uri=/cgi-bin/vulnerable 127.0.0.1
```

### 6. HTTP Web Service Verification

Query the web server endpoint directly using `curl`:

```bash
curl -i http://127.0.0.1:8081/
```

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
