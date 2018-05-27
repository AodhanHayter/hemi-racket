#lang racket/base

(require command-tree)
(require "subcommand/hemi-install.rkt")

(define hemi-commands
  `([install ,hemi-install]))

(command-tree hemi-commands (current-command-line-arguments))
