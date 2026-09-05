# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics.

## Proof of Eats — dev environment (Jeffrey's machine)

### Browsers / profiles
- **Brave** (deb, `/opt/brave.com/brave`) is the main browser. Profile map:
  - `Profile 1` = **Safefleet** (work)
  - `Profile 2` = **jeeef** (personal/"chill" — Jeffrey wants Proof of Eats opened here)
- To open the app in jeeef, NOT Safefleet:
  ```bash
  brave-browser-stable --profile-directory="Profile 2" http://localhost:8123
  ```
  (plain `xdg-open` hands off to the default profile — wrong one)
- Profiles live at `~/.config/BraveSoftware/Brave-Browser/`; names readable from `Local State` → `profile.info_cache`.
- Firefox exists as a snap (snap-confined, useless for headless testing here).

### Display / launching GUI apps from exec
Exec has no DISPLAY. To open windows on Jeffrey's desktop (GNOME Wayland), set:
```bash
export XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-0 \
       DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
setsid xdg-open <url> &   # or setsid brave-browser-stable ... &
```

### Obsidian vaults
- **Main vault:** `~/Documents/Obsidian Vault/` (technical/projects — Nostr, freedomlab, etc.)
- `~/Documents/Personal Obsidian Vault/` = personal (interview prep etc.)
- Proof of Eats notes live in `~/Documents/Obsidian Vault/Proof of Eats/`:
  - `Proof of Eats.md` (goal/purpose — user-edited, source of product truth)
  - `Proof of Eats — Progress.md` (done/todo)
  - `Proof of Eats — Lessons Learned.md`
- Obsidian itself runs as a snap (`~/snap/obsidian`).

### Dev server
- Port **8080 is taken** by some other workspace server — Proof of Eats dev server runs on **8123**:
  ```bash
  cd ~/.openclaw/workspace/proof-of-eat && python3 -m http.server 8123
  ```
  PID kept in `/tmp/poe-server.pid`; kill with `kill $(cat /tmp/poe-server.pid)`.

### Headless browser testing
- No working headless browser in this sandbox (snap Firefox can't write screenshots; `chrome-headless-shell` missing). Reliable substitutes:
  - Extract inline `<script>` → `node --check` for syntax
  - Node wiring audit: every `onclick` handler defined, every `getElementById` id exists, no duplicate ids
  - Test relay/network paths in Node ≥22 (global `WebSocket`); load the nostr-tools CDN bundle via `vm.runInThisContext` (it's a plain IIFE, not real UMD)

### Nostr CDN dependency (current)
- `https://cdn.jsdelivr.net/npm/nostr-tools@2.1.0/lib/nostr.bundle.js` → sets `window.NostrTools`
  (`generateSecretKey`, `getPublicKey`, `finalizeEvent`, `SimplePool`, `nip19`)
- Needed for in-app identity creation + signing; known debt for offline/IPFS deploys.
