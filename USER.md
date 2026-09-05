# USER.md - About Your Human

- **Name:** Jeffrey
- **What to call them:** Jeffrey
- **Timezone:** America/New_York (EDT)
- **Notes:**
  - Runs Ubuntu 24.04 (GNOME Wayland) — "jeffrey-System-Product-Name"
  - Uses **Brave** with two profiles: **Safefleet** (Profile 1, work) and **jeeef** (Profile 2, personal — "chill"). Wants Proof of Eats opened in jeeef.
  - **Obsidian** user; main vault at `~/Documents/Obsidian Vault/`; keeps project notes there and edits them himself — treat his note edits as product requirements.
  - Building **Proof of Eats**: Nostr food check-in app (Dianping-style, English only). Wants a light/simple UI, no-login identity creation, relay + key management in Settings, Yelp-style data/filters.
  - Interested in Nostr infra (NOSTR VPN experiments), freedomlab cellular PTT stuff.
  - Rewards working demos & quick iteration; says "good job" when things visibly work. Direct, technical communication preferred.

## Context

Proof of Eats work happens in `~/.openclaw/workspace/proof-of-eat/` (single-file `index.html`). Latest decisions (Sep 2026):
- Identity: in-app keypair (embedded) OR Alby NIP-07; profile (kind-0) editable from the app
- Reviews publish as kind 1985 + TASTE/ENVIRON/SERVICE tags to configured relays
- Demo data kept for offline browsing; real Yelp seed data offered by Jeffrey (pending)
