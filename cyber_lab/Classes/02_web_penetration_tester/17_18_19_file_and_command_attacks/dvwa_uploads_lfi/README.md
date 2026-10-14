# File Upload, LFI, RFI & Command Injection Lab

## Overview
Bypass file upload extension filters, execute Local/Remote File Inclusion (LFI/RFI) with PHP wrappers, and exploit Command Injection.

- **Default Port / Access**: `8087`
- **Directory**: `Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/dvwa_uploads_lfi`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:8087` (Reset DB and login `admin`/`password`).
2. Command Injection: Input `127.0.0.1; whoami; id; cat /etc/passwd` in the Ping tool.
3. File Inclusion (LFI): Browse to `?page=../../../../etc/passwd` or use PHP wrapper: `php://filter/convert.base64-encode/resource=index.php`.
4. File Upload Bypass: Upload a PHP webshell disguised as an image (`shell.php.jpg`), bypass MIME checks, and execute it via LFI or direct path.

---

## YouTube Walkthroughs & Solving Guides

- [CryptoCat - DVWA File Inclusion (LFI/RFI) Walkthrough](https://www.youtube.com/watch?v=KY58WcX7OZ4)
- [CryptoCat - DVWA File Upload Walkthrough](https://www.youtube.com/watch?v=K7XBQWAZdZ4)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
