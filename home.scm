(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu packages)
             (guix gexp))

(home-environment
  (packages (specifications->packages
             (list
              ;; dev / lisp - for emacs/slime
              "emacs" "emacs-slime" "sbcl" "clisp" "mit-scheme" "guile" "racket"
              "gcc-toolchain" "clang" "make" "gdb" "binutils" "pkg-config"
              "python" "python-ipython" "fasm"
              "strace" "ltrace" "valgrind" "lsof" "psmisc" "tmux"

              ;; browser - GNU version only, rest via flatpak
              "icecat"

              ;; media - stable Guix builds
              "vlc" "mpv" "audacious" "clementine" "yt-dlp"
              "shotwell" "gwenview" "geeqie" "nomacs" "eog" "feh" "digikam"
              "snapshot" "guvcview" "avidemux"

              ;; office / docs - lightweight only
              "evince" "okular" "gnome-terminal"

              ;; graphics
              "gimp" "inkscape" "imagemagick" 

              ;; utils
              "fastfetch" "unzip" "zip" "isync" "msmtp"
              "flatpak" "moreutils" "hwinfo" "inxi" "lshw" "dmidecode"
              "gnome-calculator" "gnome-maps"
              "font-liberation")))

  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (guix-defaults? #t)
                   (environment-variables
                    `(("XDG_DATA_DIRS" . "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")))
                   (bashrc
                    (list (plain-file "my-prompt"
                         "export PS1='\\[\\e[1;32m\\]\\u@\\h \\[\\e[1;34m\\]\\w \\[\\e[0m\\]λ '")))
                   (aliases
                    '(("ll" . "ls -l")
                      ("grep" . "grep --color=auto"))))))))
