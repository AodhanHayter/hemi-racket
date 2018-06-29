#lang racket

(provide (struct-out install))

(struct install (version hemi-path) #:transparent)
