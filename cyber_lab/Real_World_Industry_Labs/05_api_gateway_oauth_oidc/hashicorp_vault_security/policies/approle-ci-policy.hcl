# Insecure AppRole Policy: Allows read access to production credentials
# and lacks CIDR restrictions or token short-lived TTLs

path "secret/data/production/*" {
  capabilities = ["read", "list"]
}

path "secret/data/payments/*" {
  capabilities = ["read"]
}
