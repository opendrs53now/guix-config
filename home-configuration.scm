;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.

(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells) 
             (gnu packages))

(home-environment
  (packages (specifications->packages (list "fastfetch"
                                            "feh"
                                            "geeqie"
                                            "nomacs"
                                            "gnome-terminal"
                                            "python"
                                            "python-ipython"
                                            "python-ipython-genutils"
                                            "gnome-calculator"
                                            "telegram-desktop"
                                            "flatpak"
                                            "fasm"
                                            "moreutils"
                                            "hwinfo"
                                            "inxi"
                                            "lshw"
                                            "dmidecode")))

  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (guix-defaults? #t)
                   (environment-variables
                    '(("XDG_DATA_DIRS" . "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")))
                   (aliases
                    '(("ll" . "ls -l")
                      ("grep" . "grep --color=auto"))))))))
