# Insecure Deserialization Lab

## Overview
Practice exploiting object deserialization flaws and environment parser injections (PortSwigger Web Security Academy topic 17).

- **Default Port / Access**: `http://localhost:8095`
- **Shortcut**: `./lab start deserialization`

---

## Practice Exercises
1. **PHP Object Injection**: Test PHP `unserialize()` gadget chains using `PHPGGC`.
2. **Python Pickle Deserialization**: Craft malicious `__reduce__` payloads executing arbitrary system calls.
3. **Java Deserialization (ysoserial)**: Generating CommonsCollections / Spring payload payloads against serialized stream headers (`rO0AB...`).

---

## YouTube Walkthroughs & Solving Guides
- [eshanshb - Modifying Serialized Objects (PortSwigger Labs)](https://www.youtube.com/watch?v=ew-fnre3bl0)
- [eshanshb - Modifying Serialized Data Types (PortSwigger Labs)](https://www.youtube.com/watch?v=j082gL5o5yQ)
