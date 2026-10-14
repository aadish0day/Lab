#!/usr/bin/env bash
# ==============================================================================
# HashiCorp Vault Security Lab Initialization Script
# ==============================================================================
set -e

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="cyberlab_vault_root_token"

echo "[*] Waiting for Vault server to be ready..."
until curl -s "$VAULT_ADDR/v1/sys/health" > /dev/null 2>&1; do
  sleep 1
done
echo "[+] Vault is healthy and unsealed."

# 1. Enable KV v2 secrets engine at secret/ (if not already enabled)
echo "[*] Initializing KV Secrets Engine..."
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/sys/mounts/secret" \
  -d '{"type": "kv", "options": {"version": "2"}}' > /dev/null 2>&1 || true

# Seed high-value target secrets
echo "[*] Seeding production secrets..."
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/secret/data/production/database" \
  -d '{"data": {"username": "prod_db_admin", "password": "FLAG{vault_prod_db_pwned_881923}", "host": "10.0.1.55"}}' > /dev/null

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/secret/data/payments/stripe" \
  -d '{"data": {"api_key": "sk_live_FLAG{vault_stripe_super_secret_99412}", "webhook_secret": "whsec_live_90124"}}' > /dev/null

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/secret/data/dev/sandbox" \
  -d '{"data": {"env": "development", "api_url": "http://dev.internal.net"}}' > /dev/null

# 2. Upload ACL policies
echo "[*] Configuring ACL Policies..."
VULN_POLICY=$(cat <<'EOF'
path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "list"]
}
path "secret/data/dev/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "auth/token/lookup-self" {
  capabilities = ["read"]
}
EOF
)

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X PUT "$VAULT_ADDR/v1/sys/policies/acl/vulnerable-dev" \
  -d "{\"policy\": $(echo "$VULN_POLICY" | jq -Rs .)}" > /dev/null

# 3. Create low-privileged developer token
echo "[*] Issuing low-privileged developer token..."
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/auth/token/create" \
  -d '{
    "id": "cyberlab_dev_token_user01",
    "policies": ["vulnerable-dev"],
    "ttl": "72h",
    "no_parent": true
  }' > /dev/null

# 4. Enable and configure AppRole Auth Method
echo "[*] Configuring AppRole Authentication Method..."
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/sys/auth/approle" \
  -d '{"type": "approle"}' > /dev/null 2>&1 || true

APPROLE_POLICY=$(cat <<'EOF'
path "secret/data/production/*" {
  capabilities = ["read", "list"]
}
path "secret/data/payments/*" {
  capabilities = ["read"]
}
EOF
)

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X PUT "$VAULT_ADDR/v1/sys/policies/acl/approle-ci-policy" \
  -d "{\"policy\": $(echo "$APPROLE_POLICY" | jq -Rs .)}" > /dev/null

# Create ci-pipeline role
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/auth/approle/role/ci-pipeline" \
  -d '{
    "token_policies": ["approle-ci-policy"],
    "token_ttl": "24h",
    "token_max_ttl": "48h",
    "secret_id_num_uses": 0
  }' > /dev/null

# Set static custom Role ID & Secret ID for predictable lab learning
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/auth/approle/role/ci-pipeline/role-id" \
  -d '{"role_id": "ci-runner-service-account-role-id"}' > /dev/null

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/auth/approle/role/ci-pipeline/custom-secret-id" \
  -d '{"secret_id": "ci-secret-token-vault-9921"}' > /dev/null

# 5. Enable Transit Secrets Engine
echo "[*] Configuring Transit Secrets Engine (Encryption-as-a-Service)..."
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/sys/mounts/transit" \
  -d '{"type": "transit"}' > /dev/null 2>&1 || true

# Create transit encryption key
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/transit/keys/customer-data" \
  -d '{"type": "aes256-gcm96"}' > /dev/null

# Encrypt sample PII string
ENCRYPT_RESP=$(curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
  -X POST "$VAULT_ADDR/v1/transit/encrypt/customer-data" \
  -d '{"plaintext": "RkxBR3t0cmFuc2l0X2RlY3J5cHRpb25fb3JhY2xlX2V4cGxvaXRlZF83MzE5Mn0="}')
CIPHERTEXT=$(echo "$ENCRYPT_RESP" | jq -r .data.ciphertext)

# Save ciphertext sample to file for learners
echo "$CIPHERTEXT" > /vault/scripts/sample_ciphertext.txt 2>/dev/null || echo "$CIPHERTEXT" > ./scripts/sample_ciphertext.txt 2>/dev/null || true

echo "================================================================="
echo "[+] HashiCorp Vault Security Lab Initialized Successfully!"
echo "    Vault Address    : http://127.0.0.1:8200"
echo "    Root Token       : cyberlab_vault_root_token"
echo "    Low-Priv Token   : cyberlab_dev_token_user01"
echo "    AppRole Role-ID  : ci-runner-service-account-role-id"
echo "    AppRole Secret-ID: ci-secret-token-vault-9921"
echo "    Sample Ciphertext: $CIPHERTEXT"
echo "================================================================="
