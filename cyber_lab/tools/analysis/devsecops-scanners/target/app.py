import os
import sqlite3

import yaml
from flask import Flask, jsonify, request

app = Flask(__name__)

# HARDCODED SECRETS (Target for Gitleaks & Semgrep)
AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
STRIPE_API_KEY = "sk_live_51HzT92Lkjf92834jlsdfk90234jlks"
DATABASE_URL = "postgres://admin:SuperSecretPass123!@db.internal:5432/prod"


@app.route("/")
def home():
    return jsonify(
        {
            "status": "online",
            "service": "cyberlab-vulnerable-microservice",
            "description": "DevSecOps Scanner Pipeline Target",
        }
    )


# SQL INJECTION (Target for Semgrep SAST)
@app.route("/user")
def get_user():
    user_id = request.args.get("id", "1")
    conn = sqlite3.connect(":memory:")
    cursor = conn.cursor()
    # INSECURE: Direct string concatenation in SQL query
    query = f"SELECT * FROM users WHERE id = '{user_id}'"
    try:
        cursor.execute(query)
        res = cursor.fetchall()
        return jsonify({"result": res, "query": query})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# COMMAND INJECTION (Target for Semgrep SAST)
@app.route("/ping")
def ping_host():
    host = request.args.get("host", "127.0.0.1")
    # INSECURE: os.system with untrusted user input
    cmd = f"ping -c 1 {host}"
    status = os.system(cmd)
    return jsonify({"command": cmd, "exit_status": status})


# INSECURE DESERIALIZATION (Target for Semgrep & Trivy)
@app.route("/load_config", methods=["POST"])
def load_config():
    payload = request.data
    # INSECURE: yaml.load without SafeLoader allows arbitrary object instantiation
    data = yaml.load(payload, Loader=yaml.Loader)
    return jsonify({"parsed": str(data)})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
