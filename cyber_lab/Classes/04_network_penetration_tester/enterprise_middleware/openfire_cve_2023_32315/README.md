# Openfire - CVE-2023-32315

## Overview
- **Vulnerability ID**: CVE-2023-32315
- **Application**: Openfire
- **Port Allocation**: Port 8452
- **CLI Shortcut**: `./lab start openfire-cve-2023-32315`

## Vulnerability Description
Openfire is a real time collaboration (RTC) server licensed under the Open Source Apache License. It uses the only widely adopted open protocol for instant messaging, XMPP (also called Jabber).

## Quick Start
```bash
# Start target environment
./lab start openfire-cve-2023-32315

# View container status
./lab status

# Open interactive shell inside target
./lab shell openfire-cve-2023-32315
```

## Verification & Exploitation
```bash
curl http://localhost:8452/
```

## Video Walkthrough
- Walkthrough: [Openfire XMPP Server Admin Console RCE](https://www.youtube.com/watch?v=ptajUIqk_Ao)
