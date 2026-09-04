(define-module (my-packages zoom)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system deb)
  #:use-module ((guix licenses) #:prefix license:))

(define-public zoom
  (package
    (name "zoom")
    (version "latest")
    (source (origin
              (method url-fetch)
              (uri "https://zoom.us/client/latest/zoom_amd64.deb")
              (sha256
               (base32
                ;; you'll need to fill this in after download
                "0..."))))
    (build-system deb-build-system)
    (arguments
     '(#:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (delete 'build)
                  (replace 'install
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let ((out (assoc-ref outputs "out")))
                        (invoke "dpkg-deb" "-x" (assoc-ref %build-inputs "source") out)
                        #t))))))
    (synopsis "Zoom video conferencing")
    (description "Zoom video conferencing client")
    (home-page "https://zoom.us")
    (license license:proprietary)))
