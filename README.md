# guix-config — Polaris v6

`~/dotfiles` for `don@polaris` — Tuxedo Polaris 17 — Stevensville, MI — GNU Guix System — Emacs 31.1.

One Org file builds the whole machine.

## Machine

- AMD Renoir + NVIDIA RTX 2060 Mobile — hybrid — `amdgpu` + `nvidia` — both visible
- 1920x1080@144Hz laptop + Samsung 32"@60Hz right — Mirror Off — XFCE + LightDM + X11 + LUKS
- Emacs 31.1 + gruber-darker + The Perfect Setup — Scheme 80.1% / Elisp 13.1% / Shell 6.8%
- Prompt `u@h w λ` — Menu key 135 → `Greek_lambda` — gammastep `42.015277:-86.505 5500:3500`

## Source

`config.org` is truth. It tangles:

- `config.scm` — System
- `home.scm` — Home — SSH agent `/run/user/1000/ssh-agent/socket` — GitHub `id_ed25519_github` — Brave Flatpak
- `~/.emacs.d/init.el` — 6273 bytes — symlinks `~/.config/emacs/init.el` and `~/dotfiles/init.el` → one file

Edit `config.org` → `C-c C-v t` → `sudo guix system reconfigure` + `guix home reconfigure` → `git diff` clean.

## Does

**Sees.** Dual monitors declared in System, no xrandr scripts.

**Remembers.** OrgCube v6 2026-11-05 — now 100% functional:
- `C-c o p` → `~/OrgCube/inbox.org`
- `C-c o e` → xelatex DejaVu → `PDF file produced.` clean — keeps inbox at root, moves pdf/tex/txt to `exports/`
- Fixed today: lexical-binding col0, mv bug, Xmodmap load-file → shell-command, ox-latex truncation

**Breathes.** `eye-relief.sh` gammastep — `flatpak/sync.sh` 10 apps — fixes `WEBKIT_DISABLE_DMABUF_RENDERER=1`.

**Fixes.** `00-fix-pulse-runtime.desktop` — `/run/user/1000` perms.

## Adjacent

`opendrs53now/docs` — GPL-3.0 — games that run here:

- `eigencube/` — v9 final `live.scm`
- `pong/` — v1 — eigencube v8.5.1 + raylib 5.5 + Guile — no submodules

OS here. Games next door.

## Layout

`config.org` → `config.scm` / `home.scm` / `init.el` + `channels.scm` + `my-packages/` + `orgcube/` + `Xmodmap` + `flatpak/`

69 commits — Pure Single Source — Updated 2026-11-05 — GPL-3.0
