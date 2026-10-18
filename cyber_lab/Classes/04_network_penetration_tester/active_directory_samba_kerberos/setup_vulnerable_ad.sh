#!/usr/bin/env bash
# ==============================================================================
# Setup Vulnerable Active Directory Accounts (Kerberoast & AS-REP Roasting)
# ==============================================================================

set -e

CONTAINER="cyberlab_samba_ad_dc"

echo "[*] Waiting for Samba AD DC to become ready..."
until docker exec "$CONTAINER" samba-tool domain info 127.0.0.1 >/dev/null 2>&1; do
	echo "[-] AD DC initializing... retrying in 3 seconds."
	sleep 3
done

echo "[+] Samba AD DC is ready!"

# 1. Create standard domain user
echo "[*] Creating standard domain user: bob (Password: Summer2024!)"
docker exec "$CONTAINER" samba-tool user create bob Summer2024! 2>/dev/null || echo "User bob exists"

# 2. Create Kerberoastable Service Account
echo "[*] Creating Kerberoastable user: svc_mssql (Password: DatabasePass1!)"
docker exec "$CONTAINER" samba-tool user create svc_mssql DatabasePass1! 2>/dev/null || echo "User svc_mssql exists"
echo "[*] Assigning Service Principal Name (SPN) to svc_mssql..."
docker exec "$CONTAINER" samba-tool spn add "MSSQLSvc/db01.lab.local:1433" svc_mssql 2>/dev/null || true

# 3. Create AS-REP Roastable Account (DONT_REQ_PREAUTH)
echo "[*] Creating AS-REP roastable user: svc_backup (Password: BackupSecret99!)"
docker exec "$CONTAINER" samba-tool user create svc_backup BackupSecret99! 2>/dev/null || echo "User svc_backup exists"
echo "[*] Disabling Kerberos Pre-Authentication for svc_backup (UF_DONT_REQUIRE_PREAUTH = 0x400000)..."
docker exec "$CONTAINER" samba-tool user setaccount svc_backup --dont-req-preauth 2>/dev/null ||
	docker exec "$CONTAINER" ldbedit -H /var/lib/samba/private/sam.ldb "(sAMAccountName=svc_backup)" || true

echo ""
echo "================================================================="
echo "[+] Active Directory Target Accounts Provisioned Successfully!"
echo "    - Domain: LAB.LOCAL"
echo "    - Administrator: Password123!"
echo "    - Standard User: bob / Summer2024!"
echo "    - Kerberoast Target: svc_mssql (SPN: MSSQLSvc/db01.lab.local:1433)"
echo "    - AS-REP Roast Target: svc_backup (DONT_REQ_PREAUTH enabled)"
echo "================================================================="
