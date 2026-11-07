#!/usr/bin/env bash
# GrubSeal deploy: app + NIP-05 -> OVH VPS. Run AFTER grubseal.com is registered
# and grey-clouded to 89.147.111.140, and after filling the placeholders in
# deploy/Caddyfile.grubseal + deploy/nostr.json (JPUBKEY_HEX_PLACEHOLDER =
# 64-char hex of the app's main pubkey; grab it from the app's Settings
# identity card or Alby).
#
# Usage:  ./deploy/deploy.sh            # push app + nostr.json, install Caddy block once
#         ./deploy/deploy.sh --check    # curl-verify live endpoints, change nothing
set -euo pipefail

VPS=root@89.147.111.140
APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REMOTE_DIR=/var/www/grubseal
CADDY_BLOCK=deploy/Caddyfile.grubseal

if [[ "${1:-}" == "--check" ]]; then
  echo "root:      $(curl -sS -o /dev/null -w '%{http_code}' https://grubseal.com/)"
  echo "nip05:     $(curl -sS -o /dev/null -w '%{http_code}' https://grubseal.com/.well-known/nostr.json)"
  echo "www:       $(curl -sS -o /dev/null -w '%{http_code}' https://www.grubseal.com/)"
  echo "jefizzle:  $(curl -sS -o /dev/null -w '%{http_code} -> %{redirect_url}' https://grubseal.com/jefizzle)"
  exit 0
fi

echo "==> staging $REMOTE_DIR"
ssh "$VPS" "mkdir -p $REMOTE_DIR/.well-known"
rsync -az --delete \
  --exclude .git --exclude deploy --exclude 'cat-*' --exclude 'search-styles.html' \
  "$APP_DIR/" "$VPS:$REMOTE_DIR/"
rsync -az "$APP_DIR/deploy/nostr.json" "$VPS:$REMOTE_DIR/.well-known/nostr.json"

echo "==> caddy block"
if ssh "$VPS" "grep -q 'grubseal.com {' /etc/caddy/Caddyfile"; then
  echo "block already present, skipping (edit /etc/caddy/Caddyfile to update)"
else
  if grep -q CLOUDFLARE_TOKEN_PLACEHOLDER "$APP_DIR/$CADDY_BLOCK"; then
    echo "!! fill CLOUDFLARE_TOKEN_PLACEHOLDER in $CADDY_BLOCK first (token is in /etc/caddy/cloudflare-token.txt on the VPS)" >&2
    exit 1
  fi
  ssh "$VPS" "cp /etc/caddy/Caddyfile /etc/caddy/Caddyfile.bak-\$(date +%s)"
  ssh "$VPS" "cat >> /etc/caddy/Caddyfile" < "$APP_DIR/$CADDY_BLOCK"
fi

echo "==> validate + reload"
ssh "$VPS" "caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy"
echo "done. verify with: ./deploy/deploy.sh --check"
