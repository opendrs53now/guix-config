#!/usr/bin/env guile
!#
(add-to-load-path "/home/don/dotfiles/orgcube")
(use-modules (ice-9 rdelim) (srfi srfi-13) (ice-9 format) (json) (orgcube))

(format (current-error-port) ";; OrgCube Guile host ready [YubiCube: ~a]~%"
        (if (yubicube-present?) "present - touch" "not detected"))

(let loop ((line (read-line)))
  (unless (eof-object? line)
    (catch #t
      (lambda ()
        (let* ((req (json-string->scm line))
               (q (assoc-ref req "query"))
               (s (or (assoc-ref req "scope") "public")))
          (when q
            (format #t "~a~%" (scm->json-string `((result . ,(string-append "EIGEN_OK:" q)) (scope . ,s)))))))
      (lambda (k . a) (format (current-error-port) ";; ERR ~a ~a~%" k a)))
    (force-output)
    (loop (read-line))))
