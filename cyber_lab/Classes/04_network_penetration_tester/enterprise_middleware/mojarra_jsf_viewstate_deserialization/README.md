# Mojarra - JSF-VIEWSTATE-DESERIALIZATION

## Overview

- **Vulnerability ID**: JSF-VIEWSTATE-DESERIALIZATION
- **Application**: Mojarra
- **Port Allocation**: Port 8445
- **CLI Shortcut**: `./lab start mojarra-jsf-viewstate-deseri`

## Vulnerability Description

JavaServer Faces (JSF) is a standard for building Web applications, and Mojarra is a framework that implements JSF. The Mojarra that before 2.1.29-08 and 2.0.11-04, is not configured to encrypt the ViewState, so the web application may have a serious remote code execution (RCE) vulnerability.

## Quick Start

```bash
# Start target environment
./lab start mojarra-jsf-viewstate-deseri

# View container status
./lab status

# Open interactive shell inside target
./lab shell mojarra-jsf-viewstate-deseri
```

## Verification & Exploitation

```bash
curl http://localhost:8445/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
