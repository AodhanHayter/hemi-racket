#lang racket/base

(require "../../display/colorize.rkt")

(provide install-path)
(provide hemi-dir-exists?)
(provide create-hemi-dir)

(define hemi-dir ".hemi")

(define (install-path)
  (cond
    ([getenv "HEMI_PREFIX"] (string->path (getenv "HEMI_PREFIX")))
    (else (build-path (getenv "HOME")))))

(define (hemi-dir-exists? path)
  (directory-exists? (build-path path hemi-dir)))

(define (create-hemi-dir path)
  (define full-path (build-path path hemi-dir))
  (printf (colorize 'yellow
                    (format "Creating directory for hemi...~nmkdir: ~a~n" (path->string full-path))))
  (make-directory full-path))
