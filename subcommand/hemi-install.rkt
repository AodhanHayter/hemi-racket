#lang racket/base

(require "../display/colorize.rkt")

(provide hemi-install)

(define (hemi-install version)
  (printf (colorize 'green
            (format "Installing Node.js version ~a~n" version))))
