# Openssl - CVE-2014-0160

## Overview
- **Vulnerability ID**: CVE-2014-0160
- **Application**: Openssl
- **Port Allocation**: Port 8454
- **CLI Shortcut**: `./lab start openssl-cve-2014-0160`

## Vulnerability Description
The Heartbleed Bug is a serious vulnerability in the popular OpenSSL cryptographic software library. This weakness allows stealing the information protected, under normal conditions, by the SSL/TLS encryption used to secure the Internet. SSL/TLS provides communication security and privacy over the Internet for applications such as web, email, instant messaging (IM) and some virtual private network

## Quick Start
```bash
# Start target environment
./lab start openssl-cve-2014-0160

# View container status
./lab status

# Open interactive shell inside target
./lab shell openssl-cve-2014-0160
```

## Verification & Exploitation
```bash
curl http://localhost:8454/
```

## Video Walkthrough
- Walkthrough: [OpenSSL Cryptographic Vulnerability Demo](https://www.youtube.com/watch?v=MiaEWNruYdI)
