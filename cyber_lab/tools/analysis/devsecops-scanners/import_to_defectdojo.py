#!/usr/bin/env python3
"""
DefectDojo Automated Ingestion Script
Uploads Gitleaks, Semgrep, and Trivy scan results into DefectDojo API v2.
"""

import os
import sys
import argparse
import requests

DEFAULT_DOJO_URL = os.environ.get("DEFECTDOJO_URL", "http://localhost:8098")
DEFAULT_API_KEY = os.environ.get("DEFECTDOJO_API_KEY", "")

SCANS = [
    {
        "name": "Gitleaks Secrets",
        "file": "reports/gitleaks-report.json",
        "scan_type": "Gitleaks Scan"
    },
    {
        "name": "Semgrep SAST",
        "file": "reports/semgrep-report.json",
        "scan_type": "Semgrep JSON Report"
    },
    {
        "name": "Trivy SCA & Container",
        "file": "reports/trivy-report.json",
        "scan_type": "Trivy Scan"
    }
]

def import_scan(dojo_url, api_key, engagement_id, scan_info):
    file_path = scan_info["file"]
    if not os.path.isfile(file_path):
        print(f"[-] Report file not found: {file_path}. Skipping.")
        return False

    url = f"{dojo_url.rstrip('/')}/api/v2/import-scan/"
    headers = {
        "Authorization": f"Token {api_key}"
    }
    
    data = {
        "engagement": engagement_id,
        "scan_type": scan_info["scan_type"],
        "active": "true",
        "verified": "false",
        "minimum_severity": "Low",
        "auto_create_context": "true"
    }

    print(f"[*] Ingesting {scan_info['name']} ({scan_info['scan_type']}) from {file_path}...")
    try:
        with open(file_path, "rb") as f:
            files = {"file": f}
            response = requests.post(url, headers=headers, data=data, files=files, timeout=30)
            
        if response.status_code in [200, 201]:
            print(f"[+] Successfully uploaded {scan_info['name']}! Test ID: {response.json().get('test')}")
            return True
        else:
            print(f"[-] Failed to upload {scan_info['name']}: {response.status_code} - {response.text}")
            return False
    except Exception as e:
        print(f"[-] Error connecting to DefectDojo at {url}: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description="Ingest DevSecOps scan reports into DefectDojo")
    parser.add_argument("--url", default=DEFAULT_DOJO_URL, help="DefectDojo URL (default: http://localhost:8098)")
    parser.add_argument("--key", default=DEFAULT_API_KEY, help="DefectDojo API v2 Key")
    parser.add_argument("--engagement", default=1, type=int, help="Target Engagement ID in DefectDojo (default: 1)")
    args = parser.parse_args()

    if not args.key:
        print("[-] DefectDojo API key is required.")
        print("    1. Log in to DefectDojo at http://localhost:8098 (or start via `./lab start threat-intel`)")
        print("    2. Navigate to User Profile -> API v2 Key")
        print("    3. Run: python3 import_to_defectdojo.py --key <YOUR_API_KEY> [--engagement 1]")
        sys.exit(1)

    print(f"[*] DefectDojo Target: {args.url}")
    print(f"[*] Target Engagement ID: {args.engagement}")
    print("=" * 60)

    success_count = 0
    for scan in SCANS:
        if import_scan(args.url, args.key, args.engagement, scan):
            success_count += 1

    print("=" * 60)
    print(f"[+] Ingestion complete. {success_count}/{len(SCANS)} scan reports processed.")

if __name__ == "__main__":
    main()
