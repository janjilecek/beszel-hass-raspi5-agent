# beszel-hass-raspi5-agent

Home Assistant add-on that runs a [Beszel](https://beszel.dev) monitoring agent on Raspberry Pi 5 (aarch64).

## Installation

1. Go to **Settings → Add-ons → Add-on Store → ⋮ → Repositories**
2. Add `https://github.com/janjilecek/beszel-hass-raspi5-agent`
3. Install **Beszel-Agent** from the store

## Configuration

| Option | Required | Description |
|---|---|---|
| `public_key` | Yes | SSH public key from your Beszel Hub (Add System screen) |
| `port` | No | Port the agent listens on. Default: `45876` |
| `hub_url` | No | URL of your Beszel Hub, e.g. `http://192.168.1.x:8090` |
| `token` | No | Auth token if enabled on your Hub |

## Usage

1. Start the add-on
2. In your Beszel Hub, add a new system with your HA machine's local IP and port `45876`

## Notes

- aarch64 only (Raspberry Pi 4/5)
- The binary is downloaded from the [official Beszel releases](https://github.com/henrygd/beszel/releases) and verified against the upstream checksums before installation