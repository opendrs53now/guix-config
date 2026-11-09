;; ob-orgcube.scm — Babel executor
(use-modules (orgcube eigencube) (ice-9 string-fun))
(define (org-babel-execute:orgcube body params)
  (let* ((query (string-trim-both body)) (hits (eigencube-query query)))
    (if (null? hits)
        (format #f "EIGEN OK — 0 hits — cube-dir: %s — query: '%s'" %cube-dir query)
        (string-join (map (lambda (r) (format #f "%a:%a: %a" (car r) (cadr r) (caddr r))) hits) "\n"))))
