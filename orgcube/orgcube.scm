(define-module (orgcube)
  #:use-module (ice-9 format)
  #:use-module (ice-9 popen)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-13)
  #:export (%cubes load-cube cube-scope-check eigencube-query eigencube_query yubicube-present?))

(define %cubes
  '((public . "/home/don/dotfiles/orgcube/org-memory/public.cube")
    (private . "/home/don/dotfiles/orgcube/org-memory/private.cube")))

(define (eigencube_query q s) '())

(define (yubicube-present?)
  (let* ((port (open-input-pipe "lsusb 2>/dev/null"))
         (out (let loop ((line (read-line port)) (acc ""))
                (if (eof-object? line) acc
                    (loop (read-line port) (string-append acc line "\n")))))
         (_ (close-pipe port)))
    (or (string-contains out "Yubico")
        (string-contains out "YubiKey"))))

(define (load-cube scope)
  (let ((path (assoc-ref %cubes scope)))
    (and path (file-exists? path) path)))

(define (cube-scope-check requested-scope tool-scope)
  (cond ((eq? requested-scope 'public) #t)
        ((and (eq? requested-scope 'private) (eq? tool-scope 'private))
         (if (yubicube-present?) 'needs-touch 'no-hardware))
        (else #f)))

(define* (eigencube-query query #:key (scope 'public) (k 5))
  (eigencube_query query (if (symbol? scope) (symbol->string scope) scope)))
