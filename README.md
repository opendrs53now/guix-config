# guix-config - Tuxedo Polaris - don@polaris
My fully reproducible GNU Guix System. Backup of Polaris NVMe.

## What is in here
- config.scm = The OS itself - kernel, nvidia, xfce, lightdm, printers, tor, file-systems. Needs sudo guix system reconfigure
- home-configuration.scm = My user dotfiles & apps - bash, packages, flatpak Zoom 7.1.5 fix. No sudo.
- channels.scm = Where Guix pulls packages from + nonguix for nvidia/non-free.
- my-packages/zoom.scm = Custom Zoom 7.1.5 package that works with flatpak workaround.

## How to rebuild from scratch
1. git clone https://github.com/opendrs53now/guix-config.git ~/.config/guix
2. cd ~/.config/guix
3. guix pull -C channels.scm && hash guix
4. sudo guix system reconfigure config.scm
5. guix home reconfigure home-configuration.scm

## Managed by Guix on Polaris - Tuxedo Polaris 15 Gen6
