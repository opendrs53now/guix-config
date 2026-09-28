(use-modules (guix profiles) (gnu packages))
(specifications->manifest
  '("gcc-toolchain" "make" "coreutils" "pkg-config" "raylib" "glfw"))
