# Proof of Eats - Developer Onboarding

**Project:** Proof of Eats - Nostr-based restaurant review platform  
**Repo:** https://github.com/jjsilva510/proof-of-eats  
**Last Updated:** 2026-07-20

---

## Quick Start with OpenClaw

### 1. Install OpenClaw

```bash
# Install OpenClaw globally
npm install -g openclaw

# Or check current installation
openclaw --version
```

### 2. Configure API Keys

Set up your LLM API keys (OpenClaw uses these for AI assistance):

```bash
# Add to ~/.bashrc or ~/.profile
export DASHSCOPE_API_KEY="sk-your-key-here"      # Qwen models (recommended)
export OPENAI_API_KEY="sk-proj-..."               # GPT models
export ANTHROPIC_API_KEY="sk-ant-..."             # Claude models
export MOONSHOT_API_KEY="sk-..."                  # Kimi models

# Reload shell
source ~/.bashrc
```

### 3. Clone the Project

```bash
git clone https://github.com/jjsilva510/proof-of-eats.git
cd proof-of-eats
```

### 4. Start Development

```bash
# Simple HTTP server (Python 3)
python3 -m http.server 8080

# Or use Node.js
npx http-server -p 8080

# Open in browser
# http://localhost:8080
```

---

## Project Overview

**Proof of Eats** is a decentralized restaurant review platform built on Nostr protocol. Users can:

- Connect their Nostr wallet (NIP-07 browser extension)
- Browse restaurants with verified reviews
- Filter by taste, environment, and service ratings
- Submit new restaurant reviews signed with their Nostr identity
- View reviewer profiles with reputation scores

### Tech Stack

- **Frontend:** Vanilla HTML/CSS/JavaScript (no framework)
- **Protocol:** Nostr (NIP-07 for wallet signing)
- **Data:** Decentralized relays for profile/review storage
- **Styling:** Custom CSS with dark theme

### Key Files

| File | Purpose |
|------|---------|
| `index.html` | Single-page app with all UI, styles, and logic |
| `.gitignore` | Git ignores (OS files, editor configs) |
| `README.md` | Project overview |
| `ONBOARDING.md` | This file - developer setup guide |

---

## OpenClaw Workflow

### Common Tasks

**1. Ask OpenClaw to review code:**
```
openclaw chat "Review the restaurant filtering logic in index.html and suggest improvements"
```

**2. Generate new features:**
```
openclaw chat "Add a map view for restaurants using Leaflet.js"
```

**3. Debug issues:**
```
openclaw chat "The Nostr login isn't working. Check the nip07 connection code and fix it"
```

**4. Commit and push changes:**
```bash
git add .
git commit -m "Add map view feature"
git push
```

### OpenClaw Config

OpenClaw is configured at `~/.openclaw/openclaw.json`. Key settings:

- **Models:** Qwen (DashScope), OpenAI, Anthropic, Moonshot
- **Gateway:** Runs on port 18789 by default
- **Workspace:** `~/.openclaw/workspace/`

---

## Nostr Integration

### Required: NIP-07 Wallet Extension

Users need a Nostr browser extension to sign reviews:

- **Alby** (recommended): https://getalby.com
- **nos2x**: https://github.com/fiatjaf/nos2x
- **Flamingo**: https://flamingo.nu

### How It Works

1. User clicks "Connect Nostr Wallet" in the app
2. App requests `window.nostr` from browser extension
3. User approves connection in extension
4. App can now sign reviews with user's Nostr identity
5. Reviews published to configured relays

### Relay Configuration

The app uses multiple relays for redundancy:

```javascript
const DEFAULT_RELAYS = [
    'wss://relay.primal.net',
    'wss://nos.lol',
    'wss://relay.damus.io',
    'wss://nostr.wine',
    'wss://relay.snort.social'
];
```

Users can add custom relays in the Profile page.

---

## Development Tips

### Testing Nostr Features

1. Install Alby extension
2. Create a test Nostr account
3. Use test relays for development
4. Sign test reviews to verify flow

### Code Style

- Vanilla JS (no frameworks)
- Inline CSS in `<style>` tag (single-file app)
- Event-driven architecture
- Async/await for Nostr operations

### Common Issues

**Nostr not connecting:**
- Check `window.nostr` exists (extension installed?)
- Verify NIP-07 permissions granted
- Check browser console for errors

**Reviews not showing:**
- Verify relay connection
- Check NIP-01 event format
- Confirm public key is correct

---

## Deployment

### Static Hosting (Recommended)

The app is a static HTML file - deploy anywhere:

- **GitHub Pages:** Enable in repo settings
- **Netlify:** Drag & drop `index.html`
- **Vercel:** Connect GitHub repo
- **IPFS:** Pin the HTML file

### Custom Domain

1. Buy domain
2. Point DNS to hosting provider
3. Enable HTTPS (required for Nostr extension)

---

## Resources

- **Nostr Protocol:** https://nostr.com
- **NIP-07 (Wallet Extension):** https://github.com/nostr-protocol/nips/blob/master/07.md
- **NIP-01 (Basic Event Format):** https://github.com/nostr-protocol/nips/blob/master/01.md
- **OpenClaw Docs:** https://docs.openclaw.ai
- **Alby Wallet:** https://getalby.com

---

## Getting Help

1. **Check existing code** - Most logic is in `index.html`
2. **Ask OpenClaw** - Use `openclaw chat` for code help
3. **Nostr Discord** - https://discord.gg/nostr
4. **GitHub Issues** - https://github.com/jjsilva510/proof-of-eats/issues

---

**Welcome to the team! 🍽️**

Start by running the app locally, connecting your Nostr wallet, and exploring the codebase. When ready, pick a feature from the issues or suggest improvements!
