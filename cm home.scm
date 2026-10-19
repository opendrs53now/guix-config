[1mdiff --git a/home.scm b/home.scm[m
[1mindex f323292..5abd98c 100644[m
[1m--- a/home.scm[m
[1m+++ b/home.scm[m
[36m@@ -1,82 +1,94 @@[m
 (add-to-load-path (string-append (getenv "HOME") "/dotfiles/my-packages"))[m
 [m
[31m-  (use-modules (gnu home)[m
[31m-               (gnu home services)[m
[31m-               (gnu home services shells)[m
[31m-               (gnu home services ssh)[m
[31m-               (gnu packages)[m
[31m-               (gnu packages ssh)[m
[31m-               (nongnu packages nvidia)[m
[31m-               (guix gexp)[m
[31m-               (raylib-guile))[m
[32m+[m[32m    (use-modules (gnu home)[m
[32m+[m[32m                 (gnu home services)[m
[32m+[m[32m                 (gnu home services shells)[m
[32m+[m[32m                 (gnu home services ssh)[m
[32m+[m[32m                 (gnu packages)[m
[32m+[m[32m                 (gnu packages ssh)[m
[32m+[m[32m                 (nongnu packages nvidia)[m
[32m+[m[32m                 (guix gexp)[m
[32m+[m[32m                 (raylib-guile))[m
 [m
[31m-  (define %private-dir (string-append (getenv "HOME") "/dotfiles-private"))[m
[31m-  (define %private-file (string-append %private-dir "/private.scm"))[m
[31m-  (when (file-exists? %private-dir)[m
[31m-    (add-to-load-path %private-dir))[m
[32m+[m[32m    (define %private-dir (string-append (getenv "HOME") "/dotfiles-private"))[m
[32m+[m[32m    (define %private-file (string-append %private-dir "/private.scm"))[m
[32m+[m[32m    (when (file-exists? %private-dir)[m
[32m+[m[32m      (add-to-load-path %private-dir))[m
 [m
[31m-  (home-environment[m
[31m-    (packages (append (specifications->packages[m
[31m-                       (list[m
[31m-                        "emacs" "emacs-geiser" "emacs-geiser-guile" [m
[31m-                        "emacs-company" "emacs-projectile" "emacs-paredit" "emacs-slime"[m
[31m-                        "sbcl" "clisp" "mit-scheme" "guile" "racket"[m
[31m-                        "gcc-toolchain" "clang" "make" "gdb" "binutils" "pkg-config" "mesa-utils" "nvidia-driver"[m
[31m-                        "python" "python-ipython" "fasm" "sdl2" "sdl3" "raylib"[m
[31m-                        "gammastep" "vulkan-tools"[m
[31m-                        "xmodmap" "xev" "setxkbmap"[m
[31m-                        "strace" "ltrace" "valgrind" "lsof" "psmisc" "tmux"[m
[31m-                        "openssh" "git" "gnupg"[m
[31m-                        "icecat" "vlc" "mpv" "audacious" "clementine" "yt-dlp"[m
[31m-                        "shotwell" "gwenview" "geeqie" "nomacs" "eog" "feh" "digikam"[m
[31m-                        "snapshot" "guvcview" "avidemux" "gimp" "inkscape" "imagemagick"[m
[31m-                        "evince" "okular" "gnome-terminal" "gnome-calculator" "gnome-maps"[m
[31m-                        "fastfetch" "hwinfo" "inxi" "lshw" "dmidecode"[m
[31m-                        "unzip" "zip" "isync" "msmtp" "flatpak" "moreutils"[m
[31m-                        "font-liberation"))[m
[31m-                      (list raylib-guile)))[m
[31m-    (services[m
[31m-     (list[m
[31m-      ;; --- 1. Your AZIO right Menu key (keycode 135) -> λ + silent eye-relief ---[m
[31m-      (service home-files-service-type[m
[31m-       `((".Xmodmap"[m
[31m-          ,(plain-file "Xmodmap" "keycode 135 = Greek_lambda U03BB\n"))[m
[31m-         (".config/eye-relief.sh"[m
[31m-          ,(plain-file "eye-relief.sh" "#!/bin/sh[m
[31m-# Stevensville X11 - 42.015277:-86.505 - eye relief + λ key loader[m
[31m-# Silent, runs only once - fixes top 2 lines bug on new tabs[m
[31m-if [ -n \"$DISPLAY\" ]; then[m
[31m-  [ -f \"$HOME/.Xmodmap\" ] && xmodmap \"$HOME/.Xmodmap\" > /dev/null 2>&1[m
[31m-  if ! pgrep -x gammastep > /dev/null 2>&1; then[m
[31m-    gammastep -t 5500:3500 -l 42.015277:-86.505 -m randr > /dev/null 2>&1 &[m
[32m+[m[32m    (home-environment[m
[32m+[m[32m      (packages (append (specifications->packages[m
[32m+[m[32m                         (list[m
[32m+[m[32m                          "emacs" "emacs-geiser" "emacs-geiser-guile" "autoconf" "automake"[m
[32m+[m[32m                          "emacs-company" "emacs-projectile" "emacs-paredit" "emacs-slime"[m
[32m+[m[32m                          "sbcl" "clisp" "mit-scheme" "guile" "racket" "gparted" "m4" "bison"[m
[32m+[m[32m                          "gcc-toolchain" "clang" "make" "gdb" "binutils" "pkg-config" "mesa-utils"[m[41m [m
[32m+[m[32m                          "python" "python-ipython" "fasm" "sdl2" "sdl3" "raylib" "gnucash"[m
[32m+[m[32m                          "gammastep" "vulkan-tools" "imagemagick" "mypaint" "texinfo" "gnuastro"[m
[32m+[m[32m                          "xmodmap" "xev" "setxkbmap" "nvidia-driver" "drawpile" "screen"[m
[32m+[m[32m                          "strace" "ltrace" "valgrind" "lsof" "psmisc" "tmux" "rawtherapee"[m
[32m+[m[32m                          "openssh" "git" "gnupg" "gimp" "inkscape" "dia" "krita" "blender"[m
[32m+[m[32m                          "icecat" "vlc" "mpv" "audacious" "clementine" "yt-dlp" "gnumeric"[m
[32m+[m[32m                          "shotwell" "gwenview" "geeqie" "nomacs" "eog" "feh" "digikam" "gnucap"[m
[32m+[m[32m                          "snapshot" "guvcview" "avidemux" "exo" "gnutls" "gnupg" "jami" "aspell"[m
[32m+[m[32m                          "evince" "okular" "gnome-terminal" "gnome-calculator" "gnome-maps"[m
[32m+[m[32m                          "fastfetch" "hwinfo" "inxi" "lshw" "dmidecode" "units" "maxima"[m
[32m+[m[32m                          "unzip" "zip" "isync" "msmtp" "flatpak" "moreutils" "gnunet"[m
[32m+[m[32m                          "font-liberation"))[m
[32m+[m[32m                        (list raylib-guile)))[m
[32m+[m[32m      (services[m
[32m+[m[32m       (list[m
[32m+[m[32m        ;; --- 1. Your AZIO right Menu key (keycode 135) -> λ + silent eye-relief + Flatpak Brave fix ---[m
[32m+[m[32m        (service home-files-service-type[m
[32m+[m[32m         `((".Xmodmap"[m
[32m+[m[32m            ,(plain-file "Xmodmap" "keycode 135 = Greek_lambda U03BB\n"))[m
[32m+[m[32m           (".config/eye-relief.sh"[m
[32m+[m[32m            ,(plain-file "eye-relief.sh" "#!/bin/sh[m
[32m+[m[32m  # Stevensville X11 - 42.015277:-86.505 - eye relief + λ key loader[m
[32m+[m[32m  if [ -n \"$DISPLAY\" ]; then[m
[32m+[m[32m    [ -f \"$HOME/.Xmodmap\" ] && xmodmap \"$HOME/.Xmodmap\" > /dev/null 2>&1[m
[32m+[m[32m    if ! pgrep -x gammastep > /dev/null 2>&1; then[m
[32m+[m[32m      gammastep -t 5500:3500 -l 42.015277:-86.505 -m randr > /dev/null 2>&1 &[m
[32m+[m[32m    fi[m
   fi[m
[31m-fi[m
[32m+[m[32m"))[m
[32m+[m[32m           (".local/share/xfce4/helpers/custom-WebBrowser.desktop"[m
[32m+[m[32m            ,(plain-file "custom-WebBrowser.desktop" "[Desktop Entry][m
[32m+[m[32mType=X-XFCE-Helper[m
[32m+[m[32m  Name=Flatpak Brave[m
[32m+[m[32mX-XFCE-Category=WebBrowser[m
[32m+[m[32mX-XFCE-Binaries=flatpak;[m
[32m+[m[32mX-XFCE-Commands=flatpak run com.brave.Browser[m
[32m+[m[32mX-XFCE-CommandsWithParameter=flatpak run com.brave.Browser \"%s\"[m
[32m+[m[32m"))[m
[32m+[m[32m           (".config/xfce4/helpers.rc"[m
[32m+[m[32m            ,(plain-file "helpers.rc" "[Default][m
[32m+[m[32mWebBrowser=custom-WebBrowser[m
 "))))[m
[31m-[m
[31m-      (service home-ssh-agent-service-type[m
[31m-               (home-ssh-agent-configuration))[m
[31m-      (service home-openssh-service-type[m
[31m-               (home-openssh-configuration[m
[31m-                (hosts[m
[31m-                 (list[m
[31m-                  (openssh-host (name "github.com")[m
[31m-                                (host-name "github.com")[m
[31m-                                (user "git")[m
[31m-                                (identity-file "~/.ssh/id_ed25519_github"))))))[m
[31m-      (service home-bash-service-type[m
[31m-               (home-bash-configuration[m
[31m-                (guix-defaults? #t)[m
[31m-                (environment-variables[m
[31m-                 `(("SSH_AUTH_SOCK" . "/run/user/1000/ssh-agent/socket")[m
[31m-                   ("XDG_DATA_DIRS" . "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")[m
[31m-                   ("GUILE_LOAD_PATH" . "$HOME/.guix-home/profile/share/guile/site/3.0:$GUILE_LOAD_PATH")[m
[31m-                   ("GUILE_LOAD_COMPILED_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")[m
[31m-                   ("GUILE_EXTENSIONS_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/extensions:$GUILE_EXTENSIONS_PATH")))[m
[31m-                (bashrc[m
[31m-                 (list (plain-file "my-prompt"[m
[31m-                                   "export PS1='\\[\\e[1;32m\\]\\u@\\h \\[\\e[1;34m\\]\\w \\[\\e[0m\\]λ '")[m
[31m-                       (plain-file "eye-relief-loader"[m
[31m-                                   "# Load Xmodmap + gammastep silently (X11 randr, not wayland)\n[ -f \"$HOME/.config/eye-relief.sh\" ] && . \"$HOME/.config/eye-relief.sh\" > /dev/null 2>&1\n")))[m
[31m-                (aliases[m
[31m-                 '(("ll" . "ls -l")[m
[31m-                   ("grep" . "grep --color=auto"))))))))[m
[32m+[m[41m        [m
[32m+[m[32m        (service home-ssh-agent-service-type[m
[32m+[m[32m                 (home-ssh-agent-configuration))[m
[32m+[m[32m        (service home-openssh-service-type[m
[32m+[m[32m                 (home-openssh-configuration[m
[32m+[m[32m                  (hosts[m
[32m+[m[32m                   (list[m
[32m+[m[32m                    (openssh-host (name "github.com")[m
[32m+[m[32m                                  (host-name "github.com")[m
[32m+[m[32m                                  (user "git")[m
[32m+[m[32m                                  (identity-file "~/.ssh/id_ed25519_github"))))))[m
[32m+[m[32m        (service home-bash-service-type[m
[32m+[m[32m                 (home-bash-configuration[m
[32m+[m[32m                  (guix-defaults? #t)[m
[32m+[m[32m                  (environment-variables[m
[32m+[m[32m                   `(("SSH_AUTH_SOCK" . "/run/user/1000/ssh-agent/socket")[m
[32m+[m[32m                     ("XDG_DATA_DIRS" . "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")[m
[32m+[m[32m                     ("GUILE_LOAD_PATH" . "$HOME/.guix-home/profile/share/guile/site/3.0:$GUILE_LOAD_PATH")[m
[32m+[m[32m                     ("GUILE_LOAD_COMPILED_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")[m
[32m+[m[32m                     ("GUILE_EXTENSIONS_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/extensions:$GUILE_EXTENSIONS_PATH")))[m
[32m+[m[32m                  (bashrc[m
[32m+[m[32m                   (list (plain-file "my-prompt"[m
[32m+[m[32m                                     "export PS1='\\[\\e[1;32m\\]\\u@\\h \\[\\e[1;34m\\]\\w \\[\\e[0m\\]λ '")[m
[32m+[m[32m                         (plain-file "eye-relief-loader"[m
[32m+[m[32m                                     "# Load Xmodmap + gammastep silently (X11 randr, not wayland)\n[ -f \"$HOME/.config/eye-relief.sh\" ] && . \"$HOME/.config/eye-relief.sh\" > /dev/null 2>&1\n")))[m
[32m+[m[32m                  (aliases[m
[32m+[m[32m                   '(("ll" . "ls -l")[m
[32m+[m[32m                     ("grep" . "grep --color=auto"))))))))[m
