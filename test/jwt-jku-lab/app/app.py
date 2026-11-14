"""
PortSwigger Web Security Academy - Lab: JWT authentication bypass via jku header injection.

VULNERABLE-BY-DESIGN JWT auth service.

Vulnerability: JWT 'jku' (JWK Set URL) header injection.
On login, the server generates its OWN RSA keypair, signs a token with RS256,
and sets the 'jku' header to its own legitimate JWKS endpoint
(http://victim-app:5000/.well-known/jwks.json).

On protected requests (/admin, /admin/delete, /my-account), the verifier blindly
fetches whatever URL is in the token's 'jku' header and uses the keys found there
to verify the signature, allowing an attacker to host their own public key on an
exploit server and forge an administrator JWT.
"""

import base64
import json
import os
import time
import uuid

import requests
from authlib.jose import JsonWebKey, jwt
from flask import (
    Flask,
    flash,
    jsonify,
    redirect,
    render_template,
    render_template_string,
    request,
    url_for,
)

app = Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY", os.urandom(32).hex())
app.config["SESSION_COOKIE_NAME"] = "flask_flash"

# --- Server's own legit signing key (used for normal logins) ---
_key = JsonWebKey.generate_key("RSA", 2048, is_private=True)
SERVER_KID = str(uuid.uuid4())
SERVER_JWK_PRIVATE = _key.as_dict(is_private=True)
SERVER_JWK_PRIVATE["kid"] = SERVER_KID
SERVER_JWK_PUBLIC = _key.as_dict(is_private=False)
SERVER_JWK_PUBLIC["kid"] = SERVER_KID

# App's own legitimate JWKS endpoint
SELF_JKU = os.environ.get("SELF_JKU", "http://victim-app:5000/.well-known/jwks.json")
FLAG = "FLAG{jku_header_injection_jwt_auth_bypass}"

# Standard Demo Users (PortSwigger Web Security Academy style)
INITIAL_USERS = {
    "wiener": {
        "username": "wiener",
        "password": "peter",
        "role": "user",
        "email": "wiener@normal-user.net",
        "apikey": "k8Z2x9PqL1mNv5Tr7JwY4sDa",
        "deleted": False,
    },
    "alice": {
        "username": "alice",
        "password": "password123",
        "role": "user",
        "email": "alice@normal-user.net",
        "apikey": "bT4wR8yU3iOp9Lk2Mv6Xc1Za",
        "deleted": False,
    },
    "carlos": {
        "username": "carlos",
        "password": "montoya",
        "role": "user",
        "email": "carlos@victim-user.net",
        "apikey": "cN3vX7mP1kL9wR4yU8iOp2Za",
        "deleted": False,
    },
}

USERS = {k: dict(v) for k, v in INITIAL_USERS.items()}

LAB_STATE = {
    "solved": False,
    "carlos_deleted": False,
}


def reset_lab_state():
    """Resets the lab to initial state (restoring users and marking unsolved)."""
    LAB_STATE["solved"] = False
    LAB_STATE["carlos_deleted"] = False
    global USERS
    USERS = {k: dict(v) for k, v in INITIAL_USERS.items()}


def _b64url_decode(segment: str) -> bytes:
    padding = "=" * (-len(segment) % 4)
    return base64.urlsafe_b64decode(segment + padding)


def get_unverified_header(token: str) -> dict:
    """Decode unverified header segment."""
    header_segment = token.split(".", 1)[0]
    return json.loads(_b64url_decode(header_segment))


def get_token_from_request() -> str | None:
    """
    Extract JWT token supporting both:
    1. Authorization: Bearer <token>
    2. Cookies ('session' or 'jwt')
    3. Query parameter (?token=...)
    """
    # 1. Authorization header
    auth = request.headers.get("Authorization", "")
    if auth.startswith("Bearer "):
        token = auth.split(" ", 1)[1].strip()
        if token:
            return token

    # 2. Cookies (session or jwt)
    for cookie_name in ("session", "jwt"):
        cookie_val = request.cookies.get(cookie_name)
        if cookie_val and cookie_val.strip():
            return cookie_val.strip()

    # 3. Query parameter (?token=...)
    token_arg = request.args.get("token")
    if token_arg and token_arg.strip():
        return token_arg.strip()

    return None


def fetch_jwks(jku: str) -> dict:
    """
    Fetches JWKS with network resolution fallback for local/host environments.
    """
    try:
        resp = requests.get(jku, timeout=4)
        resp.raise_for_status()
        return resp.json()
    except (requests.exceptions.ConnectionError, requests.exceptions.Timeout) as e:
        # Fallback if testing outside docker and container names are not in /etc/hosts
        fallback_url = None
        if "victim-app:5000" in jku:
            fallback_url = jku.replace("victim-app:5000", "127.0.0.1:5000")
        elif "attacker-jwks:6000" in jku:
            fallback_url = jku.replace("attacker-jwks:6000", "127.0.0.1:6000")

        if fallback_url:
            try:
                resp = requests.get(fallback_url, timeout=4)
                resp.raise_for_status()
                return resp.json()
            except (requests.exceptions.ConnectionError, requests.exceptions.Timeout):
                pass

        # If pointing to victim's own JWKS and HTTP connection failed (e.g. during test_client),
        # return server's legitimate public key
        if any(h in jku for h in ("victim-app:5000", "127.0.0.1:5000", "localhost:5000")) and jku.endswith("/.well-known/jwks.json"):
            return {"keys": [SERVER_JWK_PUBLIC]}

        raise


def verify_token_INSECURE(token: str) -> dict:
    """
    THE VULNERABILITY:
    Verification blindly fetches whatever 'jku' URL is embedded in the token's
    header, with NO domain allow-list or certificate pinning check.
    It then uses the public key from that JWKS (matched by 'kid') to verify
    the token signature.
    """
    unverified = get_unverified_header(token)
    jku = unverified.get("jku")
    kid = unverified.get("kid")

    if not jku:
        raise ValueError("missing jku in token header")

    jwk_set = fetch_jwks(jku)

    matching = [k for k in jwk_set.get("keys", []) if k.get("kid") == kid]
    if not matching:
        matching = jwk_set.get("keys", [])
    if not matching:
        raise ValueError("no matching key found in jku response")

    key = JsonWebKey.import_key(matching[0])
    claims = jwt.decode(token, key)
    claims.validate()
    return dict(claims)


def is_admin_user(claims: dict) -> bool:
    """
    Checks if verified claims grant admin privilege.
    Supports standard PortSwigger role / sub combinations:
    - role: "admin" or "administrator"
    - sub / user: "administrator" or "admin"
    """
    if not isinstance(claims, dict):
        return False
    role = str(claims.get("role", "")).lower().strip()
    sub = str(claims.get("sub") or claims.get("user") or "").lower().strip()
    return role in ("admin", "administrator") or sub in ("admin", "administrator")


def get_user_profile(username: str, claims: dict | None = None) -> dict:
    """Builds a complete user profile dictionary for template rendering or API."""
    claims = claims or {}
    uname = username or "unknown"
    if uname in USERS:
        u = dict(USERS[uname])
        if "role" in claims:
            u["role"] = claims["role"]
        return u

    # Forged admin or custom user
    is_admin = is_admin_user(claims)
    role = claims.get("role") or ("admin" if is_admin else "user")
    return {
        "username": uname,
        "role": role,
        "email": "administrator@portswigger.net" if is_admin else f"{uname}@normal-user.net",
        "apikey": "ADMIN_MASTER_KEY_SECRET_89234" if is_admin else f"key_{uuid.uuid4().hex[:16]}",
        "deleted": False,
    }


def is_browser_request() -> bool:
    """Determines whether to render HTML or return JSON based on Accept headers."""
    accept = request.headers.get("Accept", "")
    return "text/html" in accept


@app.context_processor
def inject_globals():
    """Inject common lab state variables into all Jinja templates."""
    token = get_token_from_request()
    current_user = None
    claims = None
    if token:
        try:
            claims = verify_token_INSECURE(token)
            uname = claims.get("sub") or claims.get("user")
            current_user = get_user_profile(uname, claims)
        except Exception:
            pass

    return {
        "solved": LAB_STATE["solved"],
        "carlos_deleted": LAB_STATE["carlos_deleted"],
        "flag": FLAG if LAB_STATE["solved"] else None,
        "current_user": current_user,
        "user": current_user,
        "username": current_user["username"] if current_user else None,
        "role": current_user["role"] if current_user else None,
        "token": token,
        "jwt_token": token,
        "claims": claims,
        "exploit_server_url": os.environ.get("EXPLOIT_SERVER_URL", "http://localhost:6000"),
    }


# =====================================================================
# Routes
# =====================================================================

@app.route("/", methods=["GET"])
def index():
    """Storefront / Academy home page."""
    if is_browser_request() and not request.is_json:
        return render_template(
            "index.html",
            solved=LAB_STATE["solved"],
            carlos_deleted=LAB_STATE["carlos_deleted"],
            flag=FLAG if LAB_STATE["solved"] else None,
        )

    return jsonify({
        "service": "PortSwigger Web Security Academy - JWT jku header injection lab",
        "status": "online",
        "solved": LAB_STATE["solved"],
        "carlos_deleted": LAB_STATE["carlos_deleted"],
        "flag": FLAG if LAB_STATE["solved"] else None,
        "endpoints": [
            "/ (GET)",
            "/login (GET/POST)",
            "/logout (GET/POST)",
            "/my-account (GET)",
            "/admin (GET)",
            "/admin/delete?username=carlos (GET/POST)",
            "/api/lab-status (GET)",
            "/api/reset (POST)",
            "/.well-known/jwks.json (GET)",
        ],
        "hint": "To solve the lab, modify your session token with a jku header pointing to your exploit server, access /admin, and delete user carlos.",
    })


@app.route("/login", methods=["GET", "POST"])
def login():
    """Web login supporting standard demo credentials."""
    if request.method == "GET":
        token = get_token_from_request()
        if token:
            try:
                verify_token_INSECURE(token)
                return redirect(url_for("my_account"))
            except Exception:
                pass
        return render_template("login.html", error=request.args.get("error"))

    # POST
    if request.is_json:
        data = request.get_json(silent=True) or {}
        username = str(data.get("username", "")).strip()
        password = str(data.get("password", "")).strip()
    else:
        username = str(request.form.get("username", "")).strip()
        password = str(request.form.get("password", "")).strip()

    user_obj = USERS.get(username)
    if not user_obj or user_obj.get("password") != password:
        if is_browser_request() and not request.is_json:
            return render_template("login.html", error="Invalid username or password"), 401
        return jsonify({"error": "invalid credentials"}), 401

    if user_obj.get("deleted"):
        if is_browser_request() and not request.is_json:
            return render_template("login.html", error="This user account has been deleted"), 403
        return jsonify({"error": "user account has been deleted"}), 403

    # Generate RS256 token pointing to legitimate victim JKU
    header = {
        "alg": "RS256",
        "kid": SERVER_KID,
        "jku": SELF_JKU,
    }
    payload = {
        "sub": username,
        "role": user_obj.get("role", "user"),
        "iat": int(time.time()),
        "exp": int(time.time()) + 86400,
    }
    token = jwt.encode(header, payload, SERVER_JWK_PRIVATE).decode()

    # Browser redirect vs API response
    if is_browser_request() and not request.is_json:
        resp = redirect(url_for("my_account"))
    else:
        resp = jsonify({
            "status": "success",
            "token": token,
            "username": username,
            "role": user_obj.get("role", "user"),
        })

    # Set session & jwt cookies for browser convenience
    resp.set_cookie("session", token, path="/", samesite="Lax", httponly=False)
    resp.set_cookie("jwt", token, path="/", samesite="Lax", httponly=False)
    return resp


@app.route("/logout", methods=["GET", "POST"])
def logout():
    """Clears cookies and redirects to home."""
    if is_browser_request() and not request.is_json:
        resp = redirect(url_for("index"))
    else:
        resp = jsonify({"status": "logged out"})

    resp.delete_cookie("session", path="/")
    resp.delete_cookie("jwt", path="/")
    resp.delete_cookie("flask_flash", path="/")
    return resp


@app.route("/my-account", methods=["GET"])
def my_account():
    """Account profile page displaying user details and token inspector."""
    token = get_token_from_request()
    if not token:
        if is_browser_request():
            return redirect(url_for("login"))
        return jsonify({"error": "unauthorized", "message": "missing token"}), 401

    try:
        claims = verify_token_INSECURE(token)
    except Exception as e:
        if is_browser_request():
            resp = redirect(url_for("login", error=f"Invalid session token: {e}"))
            resp.delete_cookie("session", path="/")
            resp.delete_cookie("jwt", path="/")
            return resp
        return jsonify({"error": f"invalid token: {e}"}), 401

    uname = claims.get("sub") or claims.get("user")
    user_info = get_user_profile(uname, claims)
    unverified_header = get_unverified_header(token)

    if is_browser_request():
        return render_template(
            "account.html",
            user=user_info,
            username=user_info["username"],
            role=user_info["role"],
            email=user_info["email"],
            api_key=user_info["apikey"],
            token=token,
            claims=claims,
            header=unverified_header,
        )

    return jsonify({
        "user": user_info,
        "token": token,
        "claims": claims,
        "header": unverified_header,
    })


@app.route("/admin", methods=["GET"])
def admin():
    """Admin panel: requires role: admin or sub: administrator."""
    token = get_token_from_request()
    if not token:
        if is_browser_request():
            return render_template(
                "error.html",
                status_code=401,
                title="Unauthorized",
                message="Admin interface only available if logged in as an administrator",
            ), 401
        return jsonify({"error": "Admin interface only available if logged in as an administrator"}), 401

    try:
        claims = verify_token_INSECURE(token)
    except Exception as e:
        if is_browser_request():
            return render_template(
                "error.html",
                status_code=401,
                title="Unauthorized",
                message=f"Invalid token: {e}",
            ), 401
        return jsonify({"error": f"invalid token: {e}"}), 401

    if not is_admin_user(claims):
        if is_browser_request():
            return render_template(
                "error.html",
                status_code=403,
                title="Unauthorized",
                message="Admin interface only available if logged in as an administrator",
            ), 403
        return jsonify({
            "error": "Admin interface only available if logged in as an administrator",
            "your_role": claims.get("role"),
            "your_sub": claims.get("sub"),
        }), 403

    admin_username = claims.get("sub") or claims.get("user") or "administrator"
    users_list = list(USERS.values())

    if is_browser_request():
        return render_template(
            "admin.html",
            user=admin_username,
            username=admin_username,
            role="admin",
            users=users_list,
            solved=LAB_STATE["solved"],
            carlos_deleted=LAB_STATE["carlos_deleted"],
            flag=FLAG if LAB_STATE["solved"] else None,
            token=token,
            claims=claims,
        )

    return jsonify({
        "message": f"Welcome admin panel, {admin_username}! You forged your way in via jku injection.",
        "solved": LAB_STATE["solved"],
        "carlos_deleted": LAB_STATE["carlos_deleted"],
        "flag": FLAG if LAB_STATE["solved"] else None,
        "users": users_list,
        "claims": claims,
    })


@app.route("/admin/delete", methods=["GET", "POST"])
def admin_delete():
    """Endpoint to delete a user (deleting carlos solves the lab)."""
    token = get_token_from_request()
    if not token:
        if is_browser_request():
            return render_template(
                "error.html",
                status_code=401,
                title="Unauthorized",
                message="Admin interface only available if logged in as an administrator",
            ), 401
        return jsonify({"error": "Admin interface only available if logged in as an administrator"}), 401

    try:
        claims = verify_token_INSECURE(token)
    except Exception as e:
        if is_browser_request():
            return render_template(
                "error.html",
                status_code=401,
                title="Unauthorized",
                message=f"Invalid token: {e}",
            ), 401
        return jsonify({"error": f"invalid token: {e}"}), 401

    if not is_admin_user(claims):
        if is_browser_request():
            return render_template(
                "error.html",
                status_code=403,
                title="Unauthorized",
                message="Admin interface only available if logged in as an administrator",
            ), 403
        return jsonify({
            "error": "Admin interface only available if logged in as an administrator",
            "your_role": claims.get("role"),
        }), 403

    target = (
        request.args.get("username")
        or (request.form.get("username") if request.form else None)
        or ((request.get_json(silent=True) or {}).get("username"))
    )

    if not target:
        if is_browser_request():
            flash("Missing target username to delete", "error")
            return redirect(url_for("admin"))
        return jsonify({"error": "missing username parameter"}), 400

    target = target.strip()
    if target in USERS:
        USERS[target]["deleted"] = True

    if target.lower() == "carlos":
        LAB_STATE["carlos_deleted"] = True
        LAB_STATE["solved"] = True

    if is_browser_request() and not request.is_json:
        flash(f"User {target} deleted successfully", "success")
        return redirect(url_for("admin"))

    return jsonify({
        "success": True,
        "message": f"User {target} deleted successfully",
        "solved": LAB_STATE["solved"],
        "carlos_deleted": LAB_STATE["carlos_deleted"],
        "flag": FLAG,
    })


@app.route("/api/lab-status", methods=["GET"])
def lab_status():
    """Live lab status endpoint for client polling."""
    return jsonify({
        "solved": LAB_STATE["solved"],
        "carlos_deleted": LAB_STATE["carlos_deleted"],
        "flag": FLAG if LAB_STATE["solved"] else None,
    })


@app.route("/api/reset", methods=["POST"])
def api_reset():
    """Resets the lab state."""
    reset_lab_state()
    return jsonify({
        "status": "reset",
        "solved": False,
        "carlos_deleted": False,
    })


@app.route("/.well-known/jwks.json", methods=["GET"])
def jwks():
    """The victim app's legitimate JWKS."""
    resp = jsonify({"keys": [SERVER_JWK_PUBLIC]})
    resp.headers["Access-Control-Allow-Origin"] = "*"
    return resp


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
