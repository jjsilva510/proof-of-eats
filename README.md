# Proof of Eats 🍽️

A Nostr-based food and restaurant check-in app.

## What is Proof of Eats?

Proof of Eats is a decentralized app built on the **Nostr protocol** that lets you:
- Check in at restaurants and food spots
- Share your dining experiences on the Nostr network
- Build a verifiable history of places you've eaten

## How It Works

- **Nostr Integration**: Uses the Nostr protocol for decentralized, censorship-resistant check-ins
- **Alby Wallet**: Integrates with Alby as a NIP-07 signer for authentication and potential Lightning payments
- **Relay Network**: Publishes check-ins to Nostr relays (Primal, Damus, nos.lol, nostr.wine, etc.)

## Tech Stack

- Static HTML/JS
- Nostr protocol (NIP-07 for signer integration)
- Alby wallet extension

## Getting Started

1. Install a Nostr client with NIP-07 support (e.g., Alby browser extension)
2. Open `index.html` in your browser
3. Connect your Alby wallet
4. Start checking in at your favorite spots!

## Development

```bash
# Clone the repo
git clone https://github.com/jjsilva510/proof-of-eats.git
cd proof-of-eats

# Open in browser
# Just open index.html directly or serve with:
python3 -m http.server 8000
```

## Resources

- [Nostr Protocol](https://nostr.com/)
- [NIP-07 (Window Signer)](https://github.com/nostr-protocol/nips/blob/master/07.md)
- [Alby Wallet](https://getalby.com/)
- [Primal](https://primal.net/)

## License

MIT

---

Built with 🤍 on Nostr
