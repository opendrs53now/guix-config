# guix-config - Tuxedo Polaris - don@polaris

My fully reproducible GNU Guix System. Private backup of the nvme0n1.

## What is in here
- `config.scm` = The OS itself - kernel, nvidia, xfce, lightdm, printers, tor, file-systems. Needs sudo.
- `home.scm` = My user dotfiles & apps - bash, user packages. No sudo.
- `channels.scm` = Where Guix pulls packages from + nonguix for nvidia.

## How to rebuild from scratch

On a fresh Guix install:

```bash
# 1. Clone this repo
git clone https://github.com/opendrs53now/guix-config.git ~/guix-config
cd ~/guix-config

# 2. Pull exact same channels (important for nvidia)
guix pull -C channels.scm
# Then log out / log in or: hash guix

# 3. Rebuild the whole system (the house)
sudo guix system reconfigure config.scm

# 4. Rebuild my home (the furniture)
guix home reconfigure home.scm

# 5. Reboot
sudo reboot
