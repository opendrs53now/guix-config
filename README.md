# guix-config — Polaris v5

Personal GNU Guix System for Tuxedo Polaris. This repo is `~/dotfiles`. **Pure Single Source.**

One Org file → whole machine.

## Layout - Polaris v5 - Pure Single Source

- `config.org` - **Single Source of Truth** - tangles 3 files:
    - `config.scm` - System OS - Pure System - X11 + Nvidia + XFCE + LUKS
    - `home.scm` - Home - Pure Home - Stevensville X11 + λ key + gammastep
    - `~/.emacs.d/init.el` - Emacs 31.1 + gruber-darker + The Perfect Setup
- `channels.scm` - Guix channels (guix + nonguix)
- `my-packages/` - Custom packages (raylib-guile etc)
- `flatpak/` - Decoupled Flatpak layer

## Workflow - v5

1. Edit `config.org` (only file you edit)
2. `C-x C-s` save
3. `C-c C-v t` tangle → 3 files
4. System: `sudo guix system reconfigure config.scm`
5. Home: `guix home reconfigure home.scm`

Verify: `git diff` should show NO diff for `config.scm` / `home.scm` after tangle — only `config.org`.

## Displays — Dual Monitor [2026-10-17 → v5 2026-10-19]

Laptop 1920x1080@144Hz Primary + Samsung 32" 1920x1080@60Hz extended right, Mirror Off

System in `config.scm` declares hybrid GPU capability:

```scheme
(define %my-xorg
  (xorg-configuration
    (modules (cons* nvidia-driver %default-xorg-modules))
    (drivers '("amdgpu" "nvidia"))
    (extra-config (list "Section \"ServerLayout\" ..." "Section \"Device\" ..."))))
Both cards visible (amdgpu Renoir + TU106 RTX 2060 Mobile). XFCE stores layout in `displays.xml`. No xrandr scripts.

Home in `home.scm` handles:
- `.Xmodmap` - AZIO right Menu (keycode 135) → λ
- `eye-relief.sh` - `gammastep -l 42.015277:-86.505 -t 5500:3500 -m randr`
- Flatpak Brave as default browser via `custom-WebBrowser.desktop`

## Flatpak

`flatpak/flatpaks.txt` - single source (10 apps)
`flatpak/sync.sh` - install + remove stale
`flatpak/fixes/_.env` - per-app overrides (WhatsAppForLinux WEBKIT_DISABLE_DMABUF_RENDERER=1)
`flatpak/fixes/apply.sh` - generic applier

## SSH / Environment

From `home.scm`:
- `home-ssh-agent-service-type` → `/run/user/1000/ssh-agent/socket`
- `home-openssh-service-type` → github.com → `id_ed25519_github`
- Bash exports `SSH_AUTH_SOCK`, `XDG_DATA_DIRS` for Flatpak, `GUILE___PATH`

## Polaris Quirks - Runtime Fix [2026-10-17]

Cold boot race left `/run/user/1000` without perms → PulseAudio Failed to create secure directory + Emacs D-Bus warnings.
Fixed with Autostart `00-fix-pulse-runtime.desktop`:
`sh -c "rm -rf /run/user/1000/pulse-native; mkdir -p /run/user/1000; chmod 700 /run/user/1000; pulseaudio --start; start-pulseaudio-x11"`

## Machine

don@polaris — GNU Guix System — Tuxedo Polaris 17 (AMD Radeon/Renoir + nVidia TU106) — Dual 1920x1080 Laptop@144Hz + Samsung 32"@60Hz — XFCE + LightDM + X11 — Polaris v5 Pure Single Source — 2026-10-19

Then:

```bash
git add README.md
git commit -m "docs: README Polaris v5 - single source is config.org -> system+home+emacs"
git push
Want me to keep your old Displays code block fully verbatim or is this shorter v5 version good?
