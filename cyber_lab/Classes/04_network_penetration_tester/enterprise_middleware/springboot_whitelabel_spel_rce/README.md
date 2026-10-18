# SpringBoot - Whitelabel-SpEL-RCE

## Overview

- **Vulnerability ID**: SPRING-WHITELABEL
- **Application**: SpringBoot
- **Port Allocation**: Port 8554
- **CLI Shortcut**: `./lab start springboot-whitelabel-spel-rce`

## Vulnerability Description

Spring Boot framework whitelabel error page SpEL expression injection remote code execution.

## Quick Start

```bash
# Start target environment
./lab start springboot-whitelabel-spel-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell springboot-whitelabel-spel-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8554/
```

## Video Walkthrough

- Walkthrough: [SpringBoot Whitelabel-SpEL-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=LIO0TZx3gHM)
