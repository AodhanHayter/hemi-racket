#lang racket/base

(require racket/cmdline)
(require "../display/colorize.rkt")
(require "../util/path/path.rkt")
(require "../util/http/http.rkt")
(require "../util/structs.rkt")

(provide hemi-install)

(define default-prefix "/usr/local")

(define (hemi-install version)
  (define to-install (install version (install-path)))
  (printf (colorize 'cyan
            (format "Installing node.js version ~a~n" (install-version to-install))))
  (printf (colorize 'yellow
            (format "Attempting install at ~a~a~n" (path->string (install-hemi-path to-install)) "/.hemi")))
  (installer to-install))


(define (installer to-install)
  (cond
    ([hemi-dir-exists? (install-hemi-path to-install)]
     (fetch-file to-install))
    (else
      (create-hemi-dir (install-hemi-path to-install)))))
