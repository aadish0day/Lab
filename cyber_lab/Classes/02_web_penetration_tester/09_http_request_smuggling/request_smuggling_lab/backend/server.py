#!/usr/bin/env python3
import html
import socket
import threading
import time
import urllib.parse

HOST = "0.0.0.0"
PORT = 8000

# Global state
state = {
    "mode": "CL.TE",  # 'CL.TE' or 'TE.CL'
    "comments": [
        "Welcome to the Request Smuggling Practice Lab!",
        "Try bypassing the front-end HAProxy ACL to access /admin.",
        "Smuggle a POST /comment with a large Content-Length to capture victim traffic.",
    ],
    "requests_served": 0,
    "smuggled_hits": 0,
}
state_lock = threading.Lock()


def get_dashboard_html():
    with state_lock:
        mode = state["mode"]
        reqs = state["requests_served"]
        smuggled = state["smuggled_hits"]
        comm_list = "".join(
            f"<li><code>{html.escape(c)}</code></li>" for c in state["comments"][-10:]
        )

    return f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CyberLab HTTP Request Smuggling Target</title>
    <style>
        body {{ font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 40px; background: #0d1117; color: #c9d1d9; }}
        .card {{ background: #161b22; border: 1px solid #30363d; border-radius: 8px; padding: 24px; margin-bottom: 24px; }}
        h1, h2, h3 {{ color: #58a6ff; }}
        .badge {{ background: #238636; color: white; padding: 4px 8px; border-radius: 4px; font-weight: bold; }}
        .badge-alt {{ background: #8957e5; color: white; padding: 4px 8px; border-radius: 4px; font-weight: bold; }}
        pre {{ background: #090d13; padding: 12px; border-radius: 6px; overflow-x: auto; color: #7ee787; }}
        a {{ color: #58a6ff; text-decoration: none; }}
        ul {{ line-height: 1.6; }}
    </style>
</head>
<body>
    <div class="card">
        <h1>HTTP Request Smuggling Lab</h1>
        <p>Current Backend Desync Mode: <span class="badge">{mode}</span></p>
        <p>Total Backend Requests Handled: <strong>{reqs}</strong> | Successful Admin Smuggled Hits: <strong>{smuggled}</strong></p>
        <p><a href="/mode/toggle">[Switch Mode to {"TE.CL" if mode == "CL.TE" else "CL.TE"}]</a> | <a href="/comments">[View Captured Comments]</a> | <a href="/admin">[Test Protected /admin]</a></p>
    </div>

    <div class="card">
        <h2>Target Endpoints</h2>
        <ul>
            <li><code>GET /</code> — This dashboard.</li>
            <li><code>GET /admin</code> — <strong>Protected Administrator Panel</strong> (Blocked by HAProxy frontend with 403 Forbidden; accessible only via request smuggling!).</li>
            <li><code>POST /comment</code> — Submits a comment. Smuggle an incomplete POST to capture other users' request headers!</li>
            <li><code>GET /comments</code> — View stored user comments.</li>
            <li><code>GET /mode/toggle</code> — Switch backend parser between <code>CL.TE</code> and <code>TE.CL</code>.</li>
        </ul>
    </div>

    <div class="card">
        <h2>Recent Comments / Captured Request Streams</h2>
        <ul>{comm_list}</ul>
    </div>
</body>
</html>
"""


def handle_client(conn, addr):
    buf = b""
    while True:
        try:
            data = conn.recv(4096)
            if not data:
                break
            print(f"[RAW RECV] {data!r}", flush=True)
            buf += data

            while b"\r\n\r\n" in buf:
                header_part, rest = buf.split(b"\r\n\r\n", 1)
                lines = header_part.decode("latin1", errors="replace").split("\r\n")
                if not lines or not lines[0]:
                    buf = rest
                    continue

                req_tokens = lines[0].split(" ")
                if len(req_tokens) < 2:
                    buf = rest
                    continue

                method = req_tokens[0].upper()
                path = req_tokens[1]

                headers = {}
                for line in lines[1:]:
                    if ":" in line:
                        k, v = line.split(":", 1)
                        headers[k.strip().lower()] = v.strip()

                print(
                    f"[DEBUG] method={method} path={path} headers={headers}", flush=True
                )

                with state_lock:
                    current_mode = state["mode"]

                # Desynchronization parser logic
                body = b""
                has_te = (
                    "transfer-encoding" in headers
                    and "chunked" in headers["transfer-encoding"].lower()
                )
                has_cl = "content-length" in headers

                # In CL.TE mode: Backend prioritizes Transfer-Encoding over Content-Length
                # In TE.CL mode: Backend prioritizes Content-Length over Transfer-Encoding
                use_te = False
                if current_mode == "CL.TE" and has_te:
                    use_te = True
                elif current_mode == "TE.CL" and has_cl:
                    use_te = False
                elif has_te:
                    use_te = True

                if use_te:
                    # Parse chunked body
                    chunk_buf = rest
                    body_parts = []
                    incomplete = False
                    while True:
                        if b"\r\n" not in chunk_buf:
                            incomplete = True
                            break
                        sz_str, rest_chunk = chunk_buf.split(b"\r\n", 1)
                        try:
                            sz = int(sz_str.split(b";")[0].strip(), 16)
                        except ValueError:
                            sz = 0
                        if sz == 0:
                            if b"\r\n" in rest_chunk:
                                _, buf = rest_chunk.split(b"\r\n", 1)
                            else:
                                buf = rest_chunk
                            break
                        if len(rest_chunk) < sz + 2:
                            incomplete = True
                            break
                        body_parts.append(rest_chunk[:sz])
                        chunk_buf = rest_chunk[sz + 2 :]
                    if incomplete:
                        # Wait for more data
                        break
                    body = b"".join(body_parts)
                elif has_cl:
                    try:
                        cl = int(headers["content-length"])
                    except ValueError:
                        cl = 0
                    if len(rest) < cl:
                        # Full body not received yet
                        break
                    body = rest[:cl]
                    buf = rest[cl:]
                else:
                    buf = rest
                    body = b""

                with state_lock:
                    state["requests_served"] += 1

                # Route handling
                parsed_url = urllib.parse.urlparse(path)
                req_path = parsed_url.path

                if req_path == "/":
                    resp_body = get_dashboard_html().encode("utf-8")
                    resp = (
                        b"HTTP/1.1 200 OK\r\n"
                        b"Content-Type: text/html; charset=utf-8\r\n"
                        b"Connection: keep-alive\r\n"
                        b"Content-Length: "
                        + str(len(resp_body)).encode()
                        + b"\r\n\r\n"
                        + resp_body
                    )
                elif req_path == "/admin":
                    with state_lock:
                        state["smuggled_hits"] += 1
                    admin_html = (
                        b"<!DOCTYPE html><html><body style='background:#1a0000;color:#ff5555;font-family:sans-serif;padding:30px;'>"
                        b"<h1>Access Granted: Admin Control Center</h1>"
                        b"<p>Front-end HAProxy proxy ACL restriction successfully bypassed via HTTP Request Smuggling desync!</p>"
                        b"<div style='border:2px dashed #00ff00;padding:15px;color:#00ff00;font-size:20px;font-family:monospace;'>"
                        b"FLAG{http_request_smuggling_desync_master_8108}"
                        b"</div>"
                        b"<p><a href='/' style='color:#ffffff;'>Back to Dashboard</a></p>"
                        b"</body></html>"
                    )
                    resp = (
                        b"HTTP/1.1 200 OK\r\n"
                        b"Content-Type: text/html; charset=utf-8\r\n"
                        b"Connection: keep-alive\r\n"
                        b"Content-Length: "
                        + str(len(admin_html)).encode()
                        + b"\r\n\r\n"
                        + admin_html
                    )
                elif req_path == "/mode/toggle":
                    with state_lock:
                        state["mode"] = "TE.CL" if state["mode"] == "CL.TE" else "CL.TE"
                        new_mode = state["mode"]
                    redir_body = f"<html><body>Switched mode to {new_mode}. <a href='/'>Return</a></body></html>".encode()
                    resp = (
                        b"HTTP/1.1 200 OK\r\n"
                        b"Content-Type: text/html\r\n"
                        b"Connection: keep-alive\r\n"
                        b"Content-Length: "
                        + str(len(redir_body)).encode()
                        + b"\r\n\r\n"
                        + redir_body
                    )
                elif req_path == "/comment":
                    content = body.decode("latin1", errors="replace")
                    # Parse form urlencoded or raw string
                    if "comment=" in content:
                        parsed = urllib.parse.parse_qs(content)
                        comment_val = parsed.get("comment", [content])[0]
                    else:
                        comment_val = content
                    with state_lock:
                        state["comments"].append(comment_val)
                    msg = b"Comment received! <a href='/comments'>View comments</a>"
                    resp = (
                        b"HTTP/1.1 200 OK\r\n"
                        b"Content-Type: text/html\r\n"
                        b"Connection: keep-alive\r\n"
                        b"Content-Length: " + str(len(msg)).encode() + b"\r\n\r\n" + msg
                    )
                elif req_path == "/comments":
                    with state_lock:
                        comms = "\n".join(
                            f"<div style='border-bottom:1px solid #333;padding:8px;'><pre>{html.escape(c)}</pre></div>"
                            for c in state["comments"]
                        )
                    comm_page = f"<html><body style='background:#111;color:#eee;font-family:monospace;padding:20px;'><h1>Stored Comments & Intercepted Requests</h1><p><a href='/' style='color:#58a6ff;'>Back</a></p>{comms}</body></html>".encode()
                    resp = (
                        b"HTTP/1.1 200 OK\r\n"
                        b"Content-Type: text/html\r\n"
                        b"Connection: keep-alive\r\n"
                        b"Content-Length: "
                        + str(len(comm_page)).encode()
                        + b"\r\n\r\n"
                        + comm_page
                    )
                else:
                    not_found = b"404 Not Found"
                    resp = (
                        b"HTTP/1.1 404 Not Found\r\n"
                        b"Content-Length: " + str(len(not_found)).encode() + b"\r\n"
                        b"Connection: keep-alive\r\n\r\n" + not_found
                    )

                conn.sendall(resp)
        except Exception:
            break
    conn.close()


def victim_traffic_simulator():
    """Simulates an active user/admin browsing every 12 seconds with sensitive session cookies."""
    time.sleep(5)
    while True:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect(("127.0.0.1", PORT))
            victim_req = (
                b"GET / HTTP/1.1\r\n"
                b"Host: localhost:8108\r\n"
                b"User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) VictimBrowser/1.0\r\n"
                b"Cookie: session=SUPER_SECRET_ADMIN_TOKEN_XYZ_8108; role=admin\r\n"
                b"Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.victim_admin_session\r\n"
                b"Connection: keep-alive\r\n\r\n"
            )
            s.sendall(victim_req)
            s.recv(1024)
            s.close()
        except Exception:
            pass
        time.sleep(12)


def main():
    threading.Thread(target=victim_traffic_simulator, daemon=True).start()
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen(128)
    print(f"[*] Smuggling Backend listening on {HOST}:{PORT}")

    while True:
        conn, addr = server.accept()
        threading.Thread(target=handle_client, args=(conn, addr), daemon=True).start()


if __name__ == "__main__":
    main()
