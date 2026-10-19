(add-to-load-path (string-append (getenv "HOME") "/dotfiles/my-packages"))

    (use-modules (gnu home)
                 (gnu home services)
                 (gnu home services shells)
                 (gnu home services ssh)
                 (gnu packages)
                 (gnu packages ssh)
                 (nongnu packages nvidia)
                 (guix gexp)
                 (raylib-guile))

    (define %private-dir (string-append (getenv "HOME") "/dotfiles-private"))
    (define %private-file (string-append %private-dir "/private.scm"))
    (when (file-exists? %private-dir)
      (add-to-load-path %private-dir))

    (home-environment
      (packages (append (specifications->packages
                         (list
                          "emacs" "emacs-geiser" "emacs-geiser-guile" "autoconf" "automake"
                          "emacs-company" "emacs-projectile" "emacs-paredit" "emacs-slime"
                          "sbcl" "clisp" "mit-scheme" "guile" "racket" "gparted" "m4" "bison"
                          "gcc-toolchain" "clang" "make" "gdb" "binutils" "pkg-config" "mesa-utils" 
                          "python" "python-ipython" "fasm" "sdl2" "sdl3" "raylib" "gnucash"
                          "gammastep" "vulkan-tools" "imagemagick" "mypaint" "texinfo" "gnuastro"
                          "xmodmap" "xev" "setxkbmap" "nvidia-driver" "drawpile" "screen"
                          "strace" "ltrace" "valgrind" "lsof" "psmisc" "tmux" "rawtherapee"
                          "openssh" "git" "gnupg" "gimp" "inkscape" "dia" "krita" "blender"
                          "icecat" "vlc" "mpv" "audacious" "clementine" "yt-dlp" "gnumeric"
                          "shotwell" "gwenview" "geeqie" "nomacs" "eog" "feh" "digikam" "gnucap"
                          "snapshot" "guvcview" "avidemux" "exo" "gnutls" "gnupg" "jami" "aspell"
                          "evince" "okular" "gnome-terminal" "gnome-calculator" "gnome-maps"
                          "fastfetch" "hwinfo" "inxi" "lshw" "dmidecode" "units" "maxima"
                          "unzip" "zip" "isync" "msmtp" "flatpak" "moreutils" "gnunet"
                          "font-liberation"))
                        (list raylib-guile)))
      (services
       (list
        ;; --- 1. Your AZIO right Menu key (keycode 135) -> λ + silent eye-relief + Flatpak Brave fix ---
        (service home-files-service-type
         `((".Xmodmap"
            ,(plain-file "Xmodmap" "keycode 135 = Greek_lambda U03BB\n"))
           (".config/eye-relief.sh"
            ,(plain-file "eye-relief.sh" "#!/bin/sh
  # Stevensville X11 - 42.015277:-86.505 - eye relief + λ key loader
  if [ -n \"$DISPLAY\" ]; then
    [ -f \"$HOME/.Xmodmap\" ] && xmodmap \"$HOME/.Xmodmap\" > /dev/null 2>&1
    if ! pgrep -x gammastep > /dev/null 2>&1; then
      gammastep -t 5500:3500 -l 42.015277:-86.505 -m randr > /dev/null 2>&1 &
    fi
  fi
"))
           (".local/share/xfce4/helpers/custom-WebBrowser.desktop"
            ,(plain-file "custom-WebBrowser.desktop" "[Desktop Entry]
Type=X-XFCE-Helper
  Name=Flatpak Brave
X-XFCE-Category=WebBrowser
X-XFCE-Binaries=flatpak;
X-XFCE-Commands=flatpak run com.brave.Browser
X-XFCE-CommandsWithParameter=flatpak run com.brave.Browser \"%s\"
"))
           (".config/xfce4/helpers.rc"
            ,(plain-file "helpers.rc" "[Default]
WebBrowser=custom-WebBrowser
"))))
        
        (service home-ssh-agent-service-type
                 (home-ssh-agent-configuration))
        (service home-openssh-service-type
                 (home-openssh-configuration
                  (hosts
                   (list
                    (openssh-host (name "github.com")
                                  (host-name "github.com")
                                  (user "git")
                                  (identity-file "~/.ssh/id_ed25519_github"))))))
        (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #t)
                  (environment-variables
                   `(("SSH_AUTH_SOCK" . "/run/user/1000/ssh-agent/socket")
                     ("XDG_DATA_DIRS" . "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")
                     ("GUILE_LOAD_PATH" . "$HOME/.guix-home/profile/share/guile/site/3.0:$GUILE_LOAD_PATH")
                     ("GUILE_LOAD_COMPILED_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")
                     ("GUILE_EXTENSIONS_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/extensions:$GUILE_EXTENSIONS_PATH")))
                  (bashrc
                   (list (plain-file "my-prompt"
                                     "export PS1='\\[\\e[1;32m\\]\\u@\\h \\[\\e[1;34m\\]\\w \\[\\e[0m\\]λ '")
                         (plain-file "eye-relief-loader"
                                     "# Load Xmodmap + gammastep silently (X11 randr, not wayland)\n[ -f \"$HOME/.config/eye-relief.sh\" ] && . \"$HOME/.config/eye-relief.sh\" > /dev/null 2>&1\n")))
                  (aliases
                   '(("ll" . "ls -l")
                     ("grep" . "grep --color=auto"))))))))
