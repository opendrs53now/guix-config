(define-module (raylib-guile)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages game-development))

;; Polaris: 5.5 hashed alongside 6.0
(define-public raylib-5.5
  (package
    (inherit raylib)
    (name "raylib")
    (version "5.5")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/raysan5/raylib/archive/refs/tags/"
                                  version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13i5brgr6rkmxhmcr90f0mbh99r1784f0vd7i6vy1if5bg7qxadf")))) ;; <- YOUR HASH HERE line 28
    (arguments
     (list #:tests? #f
           #:configure-flags #~(list "-DBUILD_EXAMPLES=OFF" "-DBUILD_SHARED_LIBS=ON")))))

(define-public raylib-guile
  (package
    (name "raylib-guile")
    (version "0.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/petelliott/raylib-guile")
                    (commit "master")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "114v2rcwqyczqw80hzm6ij8iqfr93x43kj8qkq8gk7w49wcq8c5c"))))
    (build-system gnu-build-system)
    (arguments
     (list #:tests? #f
           #:phases
           #~(modify-phases %standard-phases
               (delete 'configure)
               (add-before 'build 'copy-xml
                 (lambda* (#:key inputs #:allow-other-keys)
                   (copy-file (assoc-ref inputs "raylib-xml")
                              "raylib_api.xml")))
               (replace 'install
                 (lambda* (#:key outputs #:allow-other-keys)
                   (let* ((out (assoc-ref outputs "out"))
                          (extdir (string-append out "/lib/guile/3.0/extensions"))
                          (sitedir (string-append out "/share/guile/site/3.0")))
                     (mkdir-p extdir)
                     (mkdir-p sitedir)
                     (install-file "libraylib-guile.so" extdir)
                     (for-each (lambda (f)
                                 (install-file f sitedir))
                               (find-files "." "\\.scm$"))))))
           #:make-flags
           #~(list (string-append "GUILE_SITE_DIR=" #$output
                                  "/share/guile/site/3.0"))))
    (native-inputs (list pkg-config))
    (inputs
     `(("guile" ,guile-3.0)
       ("raylib" ,raylib-5.5)
       ("raylib-xml"
        ,(origin
           (method url-fetch)
           (uri "https://raw.githubusercontent.com/raysan5/raylib/5.5/parser/output/raylib_api.xml")
           (file-name "raylib_api.xml")
           (sha256
            (base32
             "14mvhgn7k2n4pbnl8ccgs82606y3rj86kr3nrq0dkln9qgg1gn4b"))))))
    (synopsis "Guile bindings for raylib (pinned to 5.5)")
    (description "Pinned to raylib-5.5")
    (home-page "https://github.com/petelliott/raylib-guile")
    (license license:gpl3+)))
