# Transit Decryption Oracle Policy:
# Grants unlimited encrypt and decrypt capabilities without HMAC/context verification

path "transit/encrypt/customer-data" {
  capabilities = ["update"]
}

path "transit/decrypt/customer-data" {
  capabilities = ["update"]
}

path "transit/keys/customer-data" {
  capabilities = ["read"]
}
