# guix-config

Personal GNU Guix System setup for Tuxedo Polaris. This repo is `~/dotfiles`.

## Layout

- `config.scm` - system config
- `config.org` - home config, literate source of truth
- `home.scm` - generated from `config.org` via `org-babel-tangle` (gitignored)
- `channels.scm` - Guix channels
- `my-packages/` - custom packages (raylib-guile etc)
- `flatpak/` - decoupled, variable Flatpak system

## Workflow

**System:** `sudo guix system reconfigure config.scm`

**Home:**
1. Edit `config.org`
2. `M-x org-babel-tangle`
3. `guix home reconfigure home.scm`

**Flatpaks:** `./flatpak/sync.sh`

## Flatpak System

Designed to stay variable and not hamstring `home.scm`.

- `flatpak/flatpaks.txt` - single source of truth (10 apps). Add/remove = edit this file.
- `flatpak/sync.sh` - installs all from list, removes stale, applies fixes.
- `flatpak/fixes/*.env` - per-app environment overrides applied via `flatpak override`. e.g. `com.github.eneshecan.WhatsAppForLinux.env` contains `WEBKIT_DISABLE_DMABUF_RENDERER=1` for the gray-screen fix.
- `flatpak/fixes/apply.sh` - generalized applier, no hardcoded app IDs.
- `flatpak/snippets/` - commented recipes for future add/remove/fix tasks.

Current 10: WhatsAppForLinux, Telegram, Firefox, LibreWolf, Ungoogled Chromium, Brave, Evolution, LibreOffice, Zoom, Tor Browser Launcher.

## SSH Persistence

Documented in `config.org`:

- `home-ssh-agent-service-type` runs `ssh-agent -D -a /run/user/1000/ssh-agent/socket` as a Shepherd service (`herd status ssh-agent`)
- `SSH_AUTH_SOCK` exported via bash service into `~/.profile`, survives reboot
- `home-openssh-service-type` generates `~/.ssh/config` mapping github.com to `id_ed25519_github`

## Machine

don@polaris — GNU Guix System — literate org-babel workflow — 2026-10-14
