#lang racket/base

(require racket/match)
(require racket/string)
(require "color.rkt")

(provide colorize)

(define (colorize color-symbol str)
  (string-join `[,(get-color color-symbol) ,mark-end ,str] ""
               #:before-first esc
               #:after-last (string-append esc mark-end)))

(define (get-color color-symbol)
  (match color-symbol
    ['black color-black]
    ['red color-red]
    ['green color-green]
    ['yellow color-yellow]
    ['blue color-blue]
    ['magenta color-magenta]
    ['cyan color-cyan]
    ['white color-white]))

(define esc "\033[0;")
(define mark-end "m")
