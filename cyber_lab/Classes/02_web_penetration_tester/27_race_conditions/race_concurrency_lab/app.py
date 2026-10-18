import time

from flask import Flask, jsonify

app = Flask(__name__)

balance = 50
coupons_used = 0


@app.route("/")
def index():
    return f"""<!DOCTYPE html>
<html>
<head><title>Race Condition Challenge - Limit Overrun</title></head>
<body style="font-family: sans-serif; max-width: 650px; margin: 40px auto; line-height: 1.6;">
    <h2>PortSwigger Race Condition Challenge (Limit Overrun)</h2>
    <p>Account Balance: <b>${balance}</b></p>
    <p>Coupons Redeemed: <b>{coupons_used}/1</b></p>
    <p>Discount Code: <code>DISCOUNT2026</code> ($100 reward, 1-use only!)</p>
    <hr>
    <button onclick="fetch('/redeem', {{method:'POST'}}).then(r=>r.json()).then(d=>alert(JSON.stringify(d)))">Redeem Coupon</button>
    <button onclick="fetch('/reset', {{method:'POST'}}).then(()=>location.reload())">Reset</button>
</body>
</html>
"""


@app.route("/redeem", methods=["POST"])
def redeem():
    global balance, coupons_used
    if coupons_used >= 1:
        return jsonify({"error": "Coupon already used"}), 400
    # Vulnerable race window (sleep simulates database / validation delay)
    time.sleep(0.3)
    coupons_used += 1
    balance += 100
    flag = (
        "FLAG{TURBO_INTRUDER_RACE_PWNED}"
        if coupons_used > 1
        else "Normal single redemption"
    )
    return jsonify({"balance": balance, "redeemed": coupons_used, "message": flag})


@app.route("/reset", methods=["POST"])
def reset():
    global balance, coupons_used
    balance = 50
    coupons_used = 0
    return jsonify({"status": "reset", "balance": balance, "redeemed": coupons_used})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, threaded=True)
