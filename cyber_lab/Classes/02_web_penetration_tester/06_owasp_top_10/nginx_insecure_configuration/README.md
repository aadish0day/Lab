# Nginx Insecure Configuration Laboratory (Alias Traversal, CRLF, Header Overwrite)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Nginx Insecure Configuration Laboratory (Alias Traversal, CRLF, Header Overwrite)** (Nginx Misconfiguration Patterns).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/nginx_insecure_configuration`
* **Default Port(s)**: `8221:8080, 8223:8081, 8224:8082`
* **CLI Shortcut**: `./lab start nginx-misconfig`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_nginx_misconfig`
* **Upstream Image**: `vulhub/nginx:1`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Comprehensive Nginx server block misconfiguration lab covering alias traversal, CRLF injection, and directive overwrite.

### Technical Root Cause
Covers three major Nginx configuration flaws: 1) `location /files { alias /home/; }` allows directory traversal via `/files..`; 2) `$uri` in redirects allows CRLF header injection; 3) `add_header` in nested blocks overwrites parent security headers.

---

## Defensive Remediation & Hardening
Always add a trailing slash to `alias` definitions matching `location` blocks. Avoid `$uri` in redirects. Explicitly repeat security headers in nested child blocks.

---

## Verified Video Walkthrough
* **Video Title**: [What is Nginx? And why is it in front of your app?](https://www.youtube.com/watch?v=S8GEy4Gvkro)
* **Direct URL**: https://www.youtube.com/watch?v=S8GEy4Gvkro
