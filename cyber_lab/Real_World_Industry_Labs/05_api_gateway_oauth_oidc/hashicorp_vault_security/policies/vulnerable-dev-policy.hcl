# Vulnerable Developer Policy: Allows editing ACL policies
# Exploitation vector: The user can modify policies under sys/policies/acl/*
# to add root/sudo privileges to their own token or rewrite other policies.

path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "secret/data/dev/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}
