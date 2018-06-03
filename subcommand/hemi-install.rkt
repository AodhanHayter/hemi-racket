#lang racket/base

(require racket/cmdline)
(require "../display/colorize.rkt")
(require "../util/path/path.rkt")

(provide hemi-install)

(define default-prefix "/usr/local")
(struct install (version hemi-path))

(define (hemi-install version)
  (printf (colorize 'cyan
            (format "Installing node.js version ~a~n" version)))
  (define to-install (install version (install-path)))
  (printf (colorize 'yellow
            (format "Attempting install at ~a~a~n" (path->string (install-hemi-path to-install)) "/.hemi")))
  (installer to-install))


(define (installer to-install)
  (cond
    ([hemi-dir-exists? (install-hemi-path to-install)] (displayln "Download not implemented yet"))
    (else (create-hemi-dir (install-hemi-path to-install)))))
