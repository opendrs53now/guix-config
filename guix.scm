;; guix.scm - dev manifest for pong
(use-modules (guix profiles)
             (gnu packages))

(specifications->manifest
  (list "gcc-toolchain"
        "make"
        "coreutils"
        "pkg-config"
        "raylib"))
