# Hardened Least-Privilege Policy:
# Explicitly denies policy modification and token manipulation

# Deny all system paths by default
path "sys/*" {
  capabilities = ["deny"]
}

# Explicitly deny modifying ACL policies
path "sys/policies/acl/*" {
  capabilities = ["deny"]
}

# Explicitly deny token generation for arbitrary roles
path "auth/token/create" {
  capabilities = ["deny"]
}

# Allow scoped read-only access to specific path
path "secret/data/apps/frontend/*" {
  capabilities = ["read"]
}
