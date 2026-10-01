# guix-config

Personal setup for Tuxedo Polaris running GNU Guix System. ~/dotfiles is this repo.

## What's inside

- config.scm - system config (root)
- config.org - home config literate source of truth
- home.scm - generated from config.org via org-babel-tangle (gitignored)
- channels.scm - channels
- my-packages/ - custom packages like raylib-guile
- flatpaks.txt - 9 flatpaks

## Workflow

System:
sudo guix system reconfigure config.scm

Home:
1. Edit config.org
2. M-x org-babel-tangle (makes home.scm)
3. guix home reconfigure home.scm

## Flatpaks

9 apps: WhatsApp, Telegram, Firefox, LibreWolf, Ungoogled Chromium, Evolution, LibreOffice, Zoom, Tor Browser Launcher. See flatpaks.txt. Tor needs XDG_DATA_DIRS fix in config.org.

## Security - SSH Persistence

Documented fully in config.org:

- home-ssh-agent-service-type runs ssh-agent -D -a /run/user/1000/ssh-agent/socket as shepherd service. Check: herd status ssh-agent
- SSH_AUTH_SOCK hardcoded in bash service environment-variables into ~/.profile, survives reboot. No manual export needed.
- home-openssh-service-type generates ~/.ssh/config with github.com -> ~/.ssh/id_ed25519_github

## Machine

Host: don@polaris
OS: GNU Guix System
Workflow: literate via org-babel
Updated: 2026-10-01
