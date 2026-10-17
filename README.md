# guix-config

Personal GNU Guix System for Tuxedo Polaris. This repo is `~/dotfiles`.

Anyone who wants the details can look at the files on GitHub — `config.scm` for system, `config.org` / `home.scm` for home.

## Layout

- `config.scm` - System config, declares hardware capability
- `config.org` - Home config, literate source of truth
- `home.scm` - Tangled from `config.org` (the file you saw in the screenshot)
- `channels.scm` - Guix channels
- `my-packages/` - Custom packages (raylib-guile etc)
- `flatpak/` - Decoupled Flatpak layer

## Workflow

**System:** `sudo guix system reconfigure config.scm`

**Home:**
1. Edit `config.org`
2. `M-x org-babel-tangle`
3. `guix home reconfigure home.scm`

## Displays — Dual Monitor Upgrade [2026-10-17]

Upgraded from single panel to dual: Laptop (Primary) + Samsung 32" external. 
XFCE Display dialog shows [ Laptop 1 ] [ Samsung 32" 2 ] side-by-side, Mirror Off

**Making it so — system supports, home decides:**

System-level in `config.scm` declares the hybrid GPU capability 
so home can change layout options freely:

```scheme
(define %my-xorg
  (xorg-configuration
    (modules (cons* nvidia-driver %default-xorg-modules))
    (drivers '("amdgpu" "nvidia"))
    (extra-config
      (list
        "Section \"ServerLayout\"\n  Identifier \"layout\"\n  Option \"AllowNVIDIAGPUScreens\"\nEndSection"
        "Section \"Device\"\n  Identifier \"amdgpu\"\n  Driver \"amdgpu\"\n  BusID \"PCI:6:0:0\"\n  Option \"PrimaryGPU\" \"yes\"\nEndSection"
        "Section \"Device\"\n  Identifier \"nvidia\"\n  Driver \"nvidia\"\n  BusID \"PCI:1:0:0\"\n  Option \"AllowEmptyInitialConfiguration\" \"True\"\nEndSection"))))

(operating-system
  (kernel linux)
  (kernel-loadable-modules (list nvidia-module))
  (firmware (list linux-firmware nvidia-firmware))
  (kernel-arguments '("modprobe.blacklist=nouveau" "nouveau.modeset=0" "nvidia-drm.modeset=1" "acpi_backlight=native"))
  ;; ...
  (services (list (service xfce-desktop-service-type)
                  (service lightdm-service-type (lightdm-configuration (xorg-configuration %my-xorg))))))

This makes both cards visible (amdgpu + TU106 RTX 2060 Mobile) and gives XFCE two outputs. 
Home environment in home.scm then just uses home-files-service-type for 
.Xmodmap (AZIO λ key) and eye-relief gammastep -l 42.015277:-86.505, 
and lets XFCE store resolution/refresh/position in displays.xml:
Laptop: 1920x1080_, 16:9, 1.00, 144.00 Hz, Primary On
Samsung 32": 1920x1080_, 1.00, 60.00 Hz, extended right
No xrandr scripts. Change display options in XFCE, it survives guix home reconfigure.

Flatpak System
flatpak/flatpaks.txt - single source of truth (10 apps)
flatpak/sync.sh - installs + removes staleflatpak/fixes/_.env 
- per-app overrides e.g. WhatsAppForLinux WEBKIT_DISABLE_DMABUF_RENDERER=1flatpak/fixes/apply.sh
 
- generic applierSSH / Environment
From home.scm:
home-ssh-agent-service-type -> herd status ssh-agent socket at
 /run/user/1000/ssh-agent/sockethome-openssh-service-type -> github.com 
-> id_ed25519_githubBash SSH_AUTH_SOCK, GUILE___PATH exported for Flatpak + GuilePolaris Quirks 
— Runtime Fix [2026-10-17]
Cold boot race left /run/user/1000 without perms -> PulseAudio Failed to create secure directory 
(/run/user/1000/pulse) + Emacs CRITICAL D-Bus warnings on config.org. 
Fixed with first Autostart entry 00-fix-pulse-runtime.desktop:
sh -c "rm -rf /run/user/1000/pulse-native; mkdir -p /run/user/1000; chmod 700 /run/user/1000; pulseaudio --start; start-pulseaudio-x11"
Verified with Volume Control back to Analog Stereo Duplex + Family 17h/19h + TU106 OFF.

Machine
don@polaris — GNU Guix System — Tuxedo Polaris 17 
(AMD Radeon/Renoir + nVidia TU106) 
— Dual 1920x1080 Laptop@144Hz + Samsung 32"@60Hz 
— XFCE + LightDM 
— Stevensville X11 — 2026-10-17
