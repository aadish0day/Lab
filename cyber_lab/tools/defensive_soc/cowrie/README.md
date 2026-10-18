# Cowrie Honeypot: SSH & Telnet Deception & Threat Intelligence

## Overview

Deploy and analyze a medium-to-high interaction **Cowrie honeypot** designed to emulate an authentic Unix system over SSH and Telnet. Cowrie captures brute-force attacks, logs entire interactive shell sessions, records raw terminal keystrokes for playback, and automatically quarantines files downloaded by adversaries via `curl`, `wget`, or SFTP.

- **Default Port / Access**:
  - SSH Honeypot: `localhost:2223`
  - Telnet Honeypot: `localhost:2324`
- **Default Accepted Credentials**: Any standard credential pair (e.g., `root:root`, `admin:admin`, `root:123456`)
- **Directory**: `Classes/03_network_security/cowrie_honeypot`

---

## Architecture & Threat Intelligence Workflow

```
[Attacker / Scanner]
        |
        |  (Port 2223: SSH / Port 2324: Telnet)
        v
+--------------------------------------------------------------+
|                   COWRIE HONEYPOT CONTAINER                  |
|                                                              |
|  1. Credential Capture  --> var/log/cowrie/cowrie.json       |
|  2. Shell Emulation     --> Simulated Debian GNU/Linux       |
|  3. Malware Quarantine  --> var/lib/cowrie/downloads/ (SHA256) |
|  4. TTY Session Log     --> var/lib/cowrie/tty/ (Playlog)    |
+--------------------------------------------------------------+
```

1. **Credential Harvesting**: Logs every authentication attempt (username, password, source IP, SSH client version/banner).
2. **Fake Filesystem & Command Emulation**: Mimics commands like `cat`, `ls`, `uname`, `ps`, `iptables`, and fake `/etc/passwd`.
3. **Malware Quarantine**: When an attacker runs `wget` or `curl`, Cowrie intercepts the download, saves the binary named by its SHA256 hash in the quarantine directory, and prevents real outbound propagation.
4. **Session Replay (TTY Playlog)**: Cowrie records all terminal I/O timing and escape sequences, enabling defenders to re-watch the intruder's terminal session as a movie.

---

## How to Solve & Practice

### 1. Start the Honeypot

```bash
docker compose up -d
```

### 2. Simulate an Attacker Attack

From another terminal on your machine, connect to Cowrie over SSH:

```bash
ssh root@127.0.0.1 -p 2223
# When prompted for password, enter: root (or any password)
```

Once inside Cowrie's simulated shell:

```bash
# 1. Enumerate the system
id
uname -a
cat /etc/issue

# 2. Simulate malware download
wget https://raw.githubusercontent.com/mfontani/malware-samples/master/eicar.com.txt -O /tmp/malware.sh
chmod +x /tmp/malware.sh
exit
```

### 3. Extract Credential and Command Logs

Inspect the live JSON log inside the Cowrie container:

```bash
# View login events (usernames and passwords attempted)
docker exec cyberlab_cowrie_honeypot bash -c \
  "cat /cowrie/cowrie-git/var/log/cowrie/cowrie.json | jq 'select(.eventid==\"cowrie.login.success\" or .eventid==\"cowrie.login.failed\") | {timestamp, src_ip, username, password}'"

# View all shell commands entered by the attacker
docker exec cyberlab_cowrie_honeypot bash -c \
  "cat /cowrie/cowrie-git/var/log/cowrie/cowrie.json | jq 'select(.eventid==\"cowrie.command.input\") | {timestamp, src_ip, input}'"
```

### 4. Inspect Quarantined Malware

Check the quarantined downloads folder inside the container:

```bash
docker exec cyberlab_cowrie_honeypot ls -la /cowrie/cowrie-git/var/lib/cowrie/downloads/

# Inspect file hashes and metadata
docker exec cyberlab_cowrie_honeypot bash -c \
  "cat /cowrie/cowrie-git/var/log/cowrie/cowrie.json | jq 'select(.eventid==\"cowrie.session.file_download\") | {url, outfile, shasum}'"
```

### 5. Replay the Attacker's Session (TTY Replay)

Cowrie saves full terminal session files in `/cowrie/cowrie-git/var/lib/cowrie/tty/`:

```bash
# Locate latest session file
SESSION_FILE=$(docker exec cyberlab_cowrie_honeypot bash -c "ls -t /cowrie/cowrie-git/var/lib/cowrie/tty/ | head -n 1")

# Replay the attacker's keystrokes in real time
docker exec -it cyberlab_cowrie_honeypot /cowrie/cowrie-git/bin/playlog "/cowrie/cowrie-git/var/lib/cowrie/tty/$SESSION_FILE"
```

---

## YouTube Walkthroughs & Solving Guides

- [drillerbyte - Cowrie Honeypot Setup & Live Attack Simulation | Kali Linux + Ubuntu](https://www.youtube.com/watch?v=kr_z5sH2szs)
- [All Things IT - How to Set Up Cowrie Honeypot | HomeLab Part 6](https://www.youtube.com/watch?v=KUYqhE8l4ms)
- [screeck - Setup a honeypot and catch hackers for FREE | cowrie tutorial](https://www.youtube.com/watch?v=jo-eaptc9Bw)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
