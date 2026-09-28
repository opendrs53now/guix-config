(use-modules (gnu)
             (gnu services)
             (gnu system mapped-devices)
             (nongnu packages linux)
             (nongnu services nvidia)
             (nongnu system linux-initrd)
             (gnu services desktop)
             (gnu services networking)
             (gnu services cups)
             (gnu services base)
             (gnu services avahi)
             (gnu packages cups)
             (gnu packages fonts)
             (gnu system setuid))

(use-service-modules desktop xorg lightdm)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (kernel-arguments '("modprobe.blacklist=nouveau" "nouveau.modeset=0" "acpi_backlight=native"))
  (host-name "polaris")
  (name-service-switch %mdns-host-lookup-nss)
  (timezone "America/Detroit")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "us"))
  (initrd microcode-initrd)

  (mapped-devices
   (list (mapped-device
           (source (uuid "52d6551b-bff7-4dfe-bdab-2f9a44e4b557"))
           (target "cryptroot")
           (type luks-device-mapping))
         (mapped-device
           (source (uuid "344e4020-2299-4890-bedc-b4e39e3ab649"))
           (target "crypthome")
           (type luks-device-mapping))))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))))

  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "ext4")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "BA41-5E9B" 'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/crypthome")
                         (type "ext4")
                         (dependencies mapped-devices))
                       %base-file-systems))

  (setuid-programs
    (append
      (list (setuid-program
              (program (file-append (specification->package "light") "/bin/light"))))
      %setuid-programs))

  (users (cons (user-account
                 (name "don")
                 (comment "Don")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))

  ;; SYSTEM: hardware, networking, printing, base tools only
  (packages (append (list (specification->package "iwd")
                         (specification->package "gcc-toolchain")
                         (specification->package "pkg-config")
                         (specification->package "raylib")
                         (specification->package "gvfs")
                         (specification->package "git")
                         (specification->package "thunar-volman")
                         (specification->package "udisks")
                         (specification->package "htop")
                         (specification->package "man-db")
                         (specification->package "man-pages")
                         (specification->package "lm-sensors")
                         (specification->package "powertop")
                         (specification->package "pavucontrol")
                         (specification->package "bluez")
                         (specification->package "curl")
                         (specification->package "wget")
                         (specification->package "file")
                         (specification->package "alacritty")
                         (specification->package "rsync")
                         (specification->package "nvidia-driver")
                         (specification->package "nss-mdns")
                         (specification->package "cups")
                         (specification->package "brlaser")
                         (specification->package "cups-filters")
                         (specification->package "foomatic-filters")
                         (specification->package "system-config-printer")
                         (specification->package "light")
                         (specification->package "desktop-file-utils")
                         (specification->package "ghostscript"))
                   %base-packages))

  (services
    (append
      (list (service xfce-desktop-service-type)
            (service tor-service-type)
            (service cups-service-type
              (cups-configuration
                (web-interface? #t)
                (extensions (list cups-filters brlaser))))
            (simple-service 'flatpak-extra-data-dirs
                            session-environment-service-type
                            `(("XDG_DATA_DIRS" . "/home/don/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS")))
            (simple-service 'fix-backlight
                            activation-service-type
                            #~(begin
                                (system* "/run/current-system/profile/bin/light" "-S" "80")))
            (service lightdm-service-type))
      (modify-services %desktop-services
        (delete gdm-service-type)))))
