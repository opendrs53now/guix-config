# guix-config

This is my personal setup for my Tuxedo Polaris laptop, running GNU Guix System. Everything I need to rebuild my system lives here.

My local `~/dotfiles` folder _is_ this repository, so what you see here is exactly what's on my machine.

*What's inside*

I keep two main configurations. `config.scm` defines the whole system, everything that needs root to change. `home.scm` defines my personal environment, my packages, services, and dotfiles.

I also track my Guix channels in `channels.scm`, my custom packages in `my-packages/`, and my Flatpaks in `flatpaks.txt`.

*How I use it*

When I want to update, I just go into `~/dotfiles` and run:

`sudo guix system reconfigure config.scm` for the system, and `guix home reconfigure home.scm` for my home.

*About Flatpaks*

I currently use 9 Flatpak apps, from WhatsApp and Telegram to Firefox, LibreWolf, Ungoogled Chromium, Evolution, LibreOffice, Zoom, and Tor Browser Launcher. They're listed in `flatpaks.txt`, which I keep in sync with what's actually installed.

The Tor Browser Launcher needs a small fix in `home.scm` so it shows up correctly in GNOME search.

*My machine*

Host: Tuxedo Polaris (don@polaris)
OS: GNU Guix System
Last checked: September 20, 2026
