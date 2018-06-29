#lang racket

(require http/request)
(require http/head)
(require "../structs.rkt")

(provide fetch-file)

(define node-url-base "https://nodejs.org/download/release/")

(define (format-url version platform)
  (format "~av~a/node-v~a-~a.tar.gz" node-url-base version version platform))

(define (listen-for-progress in total)
  #| make sure input port isn't closed before the sync' |#
  (sync (port-progress-evt in))
  (cond
    ([port-closed? in] (printf "Download Complete ~a\n" (port-closed? in)))
    (else
      (define-values [line col pos] (port-next-location in))
      (printf "bytes read: ~a" pos)
      (listen-for-progress in total))))

(define (read-with-progress in content-length)
  (thread (lambda () (listen-for-progress in content-length)))
  (call-with-output-file "/Users/Aodhan/.hemi/test.tar.gz"
                         (lambda (out)
                           (copy-port in out))))

(define (handle-entity in headers)
  #| (display headers) |#
  (read-with-progress
    (read-entity/transfer-decoding-port in headers)
    (extract-field/number "Content-Length" headers)))

(define (fetch-file to-install)
  (call/input-request "1.1"
                      "GET"
                      (format-url (install-version to-install) "darwin-x64")
                      empty
                      handle-entity
                      #:redirects 10))
