import os
import subprocess
import sys

from flask import Flask, jsonify, render_template_string, request

app = Flask(__name__)

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insecure Deserialization Lab (Python & PHP)</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #0f172a; color: #e2e8f0; margin: 0; padding: 20px; }
        .container { max-width: 1000px; margin: 0 auto; }
        h1, h2, h3 { color: #38bdf8; }
        .card { background: #1e293b; border: 1px solid #334155; border-radius: 8px; padding: 20px; margin-bottom: 24px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        .code-box { background: #090d16; border: 1px solid #1e293b; border-radius: 6px; padding: 12px; font-family: monospace; font-size: 13px; color: #a5f3fc; overflow-x: auto; white-space: pre-wrap; }
        textarea, input[type="text"] { width: 100%; box-sizing: border-box; background: #0f172a; border: 1px solid #475569; color: #f8fafc; padding: 10px; border-radius: 6px; font-family: monospace; font-size: 14px; margin: 8px 0; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px 18px; border-radius: 6px; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        button:hover { background: #1d4ed8; }
        .secondary-btn { background: #475569; margin-right: 8px; font-size: 12px; padding: 6px 12px; }
        .secondary-btn:hover { background: #64748b; }
        .output-box { background: #020617; border: 1px solid #22c55e; border-radius: 6px; padding: 14px; font-family: monospace; font-size: 13px; color: #4ade80; white-space: pre-wrap; margin-top: 12px; max-height: 300px; overflow-y: auto; }
        .badge { display: inline-block; padding: 3px 8px; border-radius: 9999px; font-size: 11px; font-weight: 700; text-transform: uppercase; margin-bottom: 8px; }
        .badge-py { background: #0284c7; color: white; }
        .badge-php { background: #7c3aed; color: white; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        @media (max-width: 768px) { .grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔓 Insecure Deserialization Lab</h1>
        <p>Target Environment: Port 8095 &bull; Topic 17: Object Deserialization & Parser Injection</p>
        
        <div class="card">
            <h3>🎯 Lab Objective</h3>
            <p>Exploit insecure object deserialization in both Python (<code>pickle.loads</code>) and PHP (<code>unserialize</code>) to achieve privilege escalation and Remote Code Execution (RCE). A secret flag is stored at <code>/flag.txt</code>.</p>
        </div>

        <div class="grid">
            <!-- Python Pickle Section -->
            <div class="card">
                <span class="badge badge-py">Python 3 Pickle</span>
                <h2>1. Python Pickle Deserialization</h2>
                <p>Endpoint: <code>POST /pickle</code> or Cookie: <code>session=&lt;base64&gt;</code></p>
                <div class="code-box"># Target Server Deserialization Logic:
import pickle, base64
obj = pickle.loads(base64.b64decode(payload))
# Vulnerable to __reduce__ RCE execution!</div>
                
                <form method="POST" action="/pickle">
                    <label>Base64 Pickle Payload:</label>
                    <textarea name="data" id="pickle_data" rows="4" placeholder="Enter base64-encoded pickle payload..."></textarea>
                    <div>
                        <button type="button" class="secondary-btn" onclick="setPickleGuest()">Guest User</button>
                        <button type="button" class="secondary-btn" onclick="setPickleAdmin()">Admin Bypass</button>
                        <button type="button" class="secondary-btn" onclick="setPickleRCE()">RCE (id)</button>
                        <button type="submit">Submit to /pickle</button>
                    </div>
                </form>

                {% if pickle_result %}
                <div class="output-box">{{ pickle_result }}</div>
                {% endif %}
            </div>

            <!-- PHP Object Injection Section -->
            <div class="card">
                <span class="badge badge-php">PHP 8.x Unserialize</span>
                <h2>2. PHP Object Injection</h2>
                <p>Endpoint: <code>POST /php</code> or Cookie: <code>php_session=&lt;payload&gt;</code></p>
                <div class="code-box">// Target Server Gadgets:
class UserProfile { public $username; public $role; }
class CommandExec { public $command; public function __destruct() { passthru($this->command); } }
class FileViewer { public $filepath; public function __wakeup() { readfile($this->filepath); } }</div>

                <form method="POST" action="/php">
                    <label>PHP Serialized Payload (Raw or Base64):</label>
                    <textarea name="data" id="php_data" rows="4" placeholder="Enter PHP serialized string (e.g. O:11:...)..."></textarea>
                    <div>
                        <button type="button" class="secondary-btn" onclick="setPhpGuest()">Guest User</button>
                        <button type="button" class="secondary-btn" onclick="setPhpAdmin()">Admin Bypass</button>
                        <button type="button" class="secondary-btn" onclick="setPhpRCE()">RCE Gadget</button>
                        <button type="submit">Submit to /php</button>
                    </div>
                </form>

                {% if php_result %}
                <div class="output-box">{{ php_result }}</div>
                {% endif %}
            </div>
        </div>
    </div>

    <script>
        // Preset sample payloads
        function setPickleGuest() {
            // Pickled {"username": "guest", "role": "user"}
            document.getElementById('pickle_data').value = "gASVNQAAAAAAAAB9lCiMCG1lc3NhZ2WUdYwIdXNlcm5hbWWUjAVndWVzdJRoAowEcm9sZZSMBHVzZXJ1cy4=";
        }
        function setPickleAdmin() {
            // Pickled {"username": "admin", "role": "admin"}
            document.getElementById('pickle_data').value = "gASVNQAAAAAAAAB9lCiMCG1lc3NhZ2WUdYwIdXNlcm5hbWWUjAVhZG1pbpRoAowEcm9sZZSMBWFkbWludXMu";
        }
        function setPickleRCE() {
            // Base64 pickle executing 'id' via os.system
            document.getElementById('pickle_data').value = "gASVIQAAAAAAAACMBXBvc2l4lIwGc3lzdGVtlJOUjAJpZJSFlFKULg==";
        }

        function setPhpGuest() {
            document.getElementById('php_data').value = 'O:11:"UserProfile":2:{s:8:"username";s:5:"guest";s:4:"role";s:4:"user";}';
        }
        function setPhpAdmin() {
            document.getElementById('php_data').value = 'O:11:"UserProfile":2:{s:8:"username";s:5:"admin";s:4:"role";s:5:"admin";}';
        }
        function setPhpRCE() {
            document.getElementById('php_data').value = 'O:11:"CommandExec":1:{s:7:"command";s:18:"cat /flag.txt; id;";}';
        }
    </script>
</body>
</html>
"""


def execute_pickle(raw_payload_b64):
    """Safely invokes pickle deserialization in a subprocess to isolate and capture stdout."""
    script = f'''
import pickle, base64, sys

payload = """{raw_payload_b64.strip()}"""
try:
    raw = base64.b64decode(payload)
except Exception as e:
    print(f"[-] Base64 decoding failed: {{e}}")
    sys.exit(1)

print("[*] Deserializing Python pickle stream...")
try:
    obj = pickle.loads(raw)
    print(f"[+] Successfully deserialized object of type: {{type(obj)}}")
    
    # Check for dict or object role privilege escalation
    role = None
    username = None
    if isinstance(obj, dict):
        role = obj.get("role")
        username = obj.get("username", "user")
    elif hasattr(obj, "role"):
        role = getattr(obj, "role")
        username = getattr(obj, "username", "user")
        
    if role == "admin":
        print(f"[+] Welcome Administrator ({{username}})! Privilege Escalation Successful!")
        print("[+] Flag: FLAG{PYTHON_PICKLE_DESERIALIZATION_ADMIN_ROLE_BYPASS}")
    elif role:
        print(f"[+] Authenticated as {{username}} (Role: {{role}}).")
    else:
        print(f"[+] Loaded object representation: {{repr(obj)}}")
except Exception as e:
    print(f"[-] Deserialization exception: {{e}}")
'''
    try:
        proc = subprocess.run(
            [sys.executable, "-c", script], capture_output=True, text=True, timeout=10
        )
        output = proc.stdout
        if proc.stderr:
            output += "\n[STDERR]\n" + proc.stderr
        return output.strip()
    except subprocess.TimeoutExpired:
        return "[-] Execution timed out after 10 seconds."
    except Exception as e:
        return f"[-] Process error: {e!s}"


def execute_php(raw_payload):
    """Executes PHP deserialization helper script."""
    php_script_path = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "deser.php"
    )
    try:
        proc = subprocess.run(
            ["php", php_script_path, raw_payload],
            capture_output=True,
            text=True,
            timeout=10,
        )
        output = proc.stdout
        if proc.stderr:
            output += "\n[STDERR]\n" + proc.stderr
        return output.strip()
    except subprocess.TimeoutExpired:
        return "[-] Execution timed out after 10 seconds."
    except Exception as e:
        return f"[-] PHP execution error: {e!s}"


@app.route("/", methods=["GET"])
def index():
    # Also support cookie-based testing
    pickle_res = None
    php_res = None
    if "session" in request.cookies:
        pickle_res = execute_pickle(request.cookies.get("session"))
    if "php_session" in request.cookies:
        php_res = execute_php(request.cookies.get("php_session"))

    return render_template_string(
        HTML_TEMPLATE, pickle_result=pickle_res, php_result=php_res
    )


@app.route("/pickle", methods=["GET", "POST"])
def pickle_endpoint():
    data = request.values.get("data") or request.cookies.get("session")
    if not data and request.is_json:
        data = request.json.get("data")
    if not data:
        return jsonify({"error": "Missing 'data' parameter or 'session' cookie."}), 400

    result = execute_pickle(data)
    if request.is_json or request.headers.get("Accept") == "application/json":
        return jsonify({"status": "completed", "output": result})
    return render_template_string(HTML_TEMPLATE, pickle_result=result, php_result=None)


@app.route("/php", methods=["GET", "POST"])
def php_endpoint():
    data = request.values.get("data") or request.cookies.get("php_session")
    if not data and request.is_json:
        data = request.json.get("data")
    if not data:
        return jsonify(
            {"error": "Missing 'data' parameter or 'php_session' cookie."}
        ), 400

    result = execute_php(data)
    if request.is_json or request.headers.get("Accept") == "application/json":
        return jsonify({"status": "completed", "output": result})
    return render_template_string(HTML_TEMPLATE, pickle_result=None, php_result=result)


@app.route("/health", methods=["GET"])
def health():
    return jsonify(
        {"status": "healthy", "service": "insecure_deserialization_lab", "port": 8095}
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8095)
