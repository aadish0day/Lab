# Tomcat - CVE-2017-12615-PUT-RCE

## Overview

- **Vulnerability ID**: CVE-2017-12615
- **Application**: Tomcat
- **Port Allocation**: Port 8535
- **CLI Shortcut**: `./lab start tomcat-cve-2017-12615-put-rce`

## Vulnerability Description

Apache Tomcat HTTP PUT method enabled arbitrary JSP file upload leading to remote code execution.

## Quick Start

```bash
# Start target environment
./lab start tomcat-cve-2017-12615-put-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell tomcat-cve-2017-12615-put-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8535/
```

## Video Walkthrough

- Walkthrough: [Tomcat CVE-2017-12615-PUT-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=I6VhjRBNU2c)
