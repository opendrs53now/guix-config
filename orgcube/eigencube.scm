;; ~/dotfiles/orgcube/eigencube.scm — EIGEN = own, intrinsic — Polaris v5 Ring0 3B
(define-module (orgcube eigencube)
  #:use-module (ice-9 ftw)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 string-fun)
  #:export (eigencube-query %cube-dir))

(define %cube-dir
  (or (and=> (getenv "ORGCUBE_DIR") identity)
      (string-append (getenv "HOME") "/dotfiles/orgcube")))

(define (cube-files)
  (if (file-exists? %cube-dir)
      (filter (lambda (f) (string-suffix? ".cube" f))
              (scandir %cube-dir (lambda (f) (not (string-prefix? "." f)))))
      '()))

(define (grep-cube file needle)
  (let ((path (string-append %cube-dir "/" file)))
    (call-with-input-file path
      (lambda (port)
        (let loop ((line 1) (hits '()))
          (let ((l (read-line port)))
            (if (eof-object? l) (reverse hits)
                (loop (+ line 1)
                      (if (string-contains-ci l needle)
                          (cons (list file line (string-trim l)) hits)
                          hits)))))))))

(define (eigencube-query needle)
  (if (or (not needle) (string-null? (string-trim needle)))
      '()
      (apply append
             (map (lambda (f) (grep-cube f needle))
                  (cube-files)))))
