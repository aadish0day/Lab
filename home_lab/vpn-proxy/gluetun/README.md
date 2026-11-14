# ProtonVPN gateway (Gluetun)

WireGuard connection to ProtonVPN inside a container, exposing a stealth HTTP
proxy on `127.0.0.1:8888`. Host apps route through the proxy; no VPN interface
or kill-switch rules are ever created on the host (which is what keeps
`protonvpn-cli` broken on this machine).

## Setup

1. Generate a WireGuard config at <https://account.proton.me/u/0/vpn/WireGuard>
   (free tier works; the private key is valid for all Proton servers).
2. Copy the `PrivateKey=` value into a local `.env`:

   ```sh
   cd gluetun
   cp .env.example .env   # then edit WIREGUARD_PRIVATE_KEY
   ```

3. Start:

   ```sh
   docker compose up -d
   ```

4. Verify the exit node (should show a Proton IP, not yours):

   ```sh
   curl -s -x http://127.0.0.1:8888 https://ipinfo.io/json
   ```

## Usage

`vpn-download.sh` auto-detects the proxy: if `127.0.0.1:8888` responds, all
yt-dlp traffic goes through it and the ProtonVPN CLI is never touched.

- Forced proxy: `vpn-download -x http://127.0.0.1:8888 -d -f links.txt`
- Force the old CLI path instead: `vpn-download -P -d -f links.txt`

## Tearing down

```sh
docker compose down
```
