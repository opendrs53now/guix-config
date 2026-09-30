;; Add your custom package directory to Guile's load path so (raylib-guile) can be found
(add-to-load-path (string-append (getenv "HOME") "/dotfiles/my-packages"))

;; Import Guix Home modules - core home, services, shell/ssh services, package utils
(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu home services ssh)
             (gnu packages)
             (gnu packages ssh)
             (guix gexp)          ;; needed for plain-file to create bashrc files
             (raylib-guile))      ;; your custom package from my-packages/

;; home-environment is the declarative definition of your entire $HOME, like /etc/config.scm but for dotfiles
(home-environment
 ;; packages field - list of packages to install into ~/.guix-home/profile
 (packages (append (specifications->packages
                    (list
                     ;; Lisp/Scheme dev stack
                     "emacs" "emacs-slime" "sbcl" "clisp" "mit-scheme" "guile" "racket"
                     ;; C/C++ toolchain + build tools
                     "gcc-toolchain" "clang" "make" "gdb" "binutils" "pkg-config"
                     ;; Python + low-level asm + graphics libs you use with raylib
                     "python" "python-ipython" "fasm" "sdl2" "sdl3" "raylib"
                     ;; Debugging / system inspection
                     "strace" "ltrace" "valgrind" "lsof" "psmisc" "tmux"
                     ;; Core dev tools - ssh, git, gpg are required for GitHub mirror auth
                     "openssh" "git" "gnupg"
                     ;; Browser
                     "icecat"
                     ;; Video/audio playback + download
                     "vlc" "mpv" "audacious" "clementine" "yt-dlp"
                     ;; Image viewers
                     "shotwell" "gwenview" "geeqie" "nomacs" "eog" "feh" "digikam"
                     ;; Camera / video capture
                     "snapshot" "guvcview" "avidemux"
                     ;; Docs + terminal
                     "evince" "okular" "gnome-terminal"
                     ;; Graphics editing
                     "gimp" "inkscape" "imagemagick"
                     ;; CLI utils
                     "fastfetch" "unzip" "zip" "isync" "msmtp"
                     ;; Flatpak + sysinfo tools
                     "flatpak" "moreutils" "hwinfo" "inxi" "lshw" "dmidecode"
                     ;; GNOME extras
                     "gnome-calculator" "gnome-maps"
                     ;; Fonts
                     "font-liberation"))
                   ;; Append your custom Scheme package (raylib-guile) not in guix repo
                   (list raylib-guile)))

 ;; services field - shepherd daemons and dotfile generators
 (services
  (list
   ;; SSH-AGENT SERVICE - creates shepherd service 'ssh-agent'
   ;; This runs: ssh-agent -D -a /run/user/1000/ssh-agent/socket
   ;; It is enabled + respawned, so survives reboot. This is why 'herd status ssh-agent' showed running.
   (service home-ssh-agent-service-type
            (home-ssh-agent-configuration))

   ;; OPENSSH SERVICE - generates ~/.ssh/config as symlink to /gnu/store
   (service home-openssh-service-type
            (home-openssh-configuration
             (hosts
              (list
               ;; Host block for GitHub mirror - tells ssh to use this key for github.com
               (openssh-host (name "github.com")
                             (host-name "github.com")
                             (user "git") ;; git@github.com
                             (identity-file "~/.ssh/id_ed25519_github"))))))

   ;; BASH SERVICE - generates ~/.bashrc, ~/.bash_profile, ~/.profile as symlinks
   (service home-bash-service-type
            (home-bash-configuration
             ;; guix-defaults? keeps Guix's default PATH/profile loading
             (guix-defaults? #t)
             ;; environment-variables become 'export' lines in ~/.profile
             (environment-variables
              `(;; PERSISTENCE FIX - hardcodes socket path into every new shell
                ;; Without this, manual 'export SSH_AUTH_SOCK=...' dies on terminal close/reboot
                ;; With this, Guix Home writes it to ~/.profile, so it's set on login forever
                ("SSH_AUTH_SOCK" . "/run/user/1000/ssh-agent/socket")
                ;; Fix for flatpak apps to show in menus
                ("XDG_DATA_DIRS" . "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")
                ;; Guile load paths for your custom raylib-guile libs
                ("GUILE_LOAD_PATH" . "$HOME/.guix-home/profile/share/guile/site/3.0:$GUILE_LOAD_PATH")
                ("GUILE_LOAD_COMPILED_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")
                ("GUILE_EXTENSIONS_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/extensions:$GUILE_EXTENSIONS_PATH")))
             ;; bashrc - custom prompt 'user@host ~/path λ ' in green/blue
             ;; PLUS XFCE FIX for ssh-agent
             (bashrc
              (list (plain-file "my-prompt"
                                "export PS1='\\[\\e[1;32m\\]\\u@\\h \\[\\e[1;34m\\]\\w \\[\\e[0m\\]λ '")
                    ;; force-ssh-agent - XFCE FIX - overwrites XFCE's random ~/.ssh/agent/s.xxx socket
                    ;; XFCE's xfce4-session starts its own ssh-agent before .profile, so we must re-export here at END of bashrc
                    ;; bashrc is sourced after XFCE session env in every interactive terminal, so this wins
                    (plain-file "force-ssh-agent"
                                "export SSH_AUTH_SOCK=/run/user/1000/ssh-agent/socket\n")))
             ;; shell aliases
             (aliases
              '(("ll" . "ls -l")
                ("grep" . "grep --color=auto"))))))))
