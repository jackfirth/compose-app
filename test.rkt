#lang racket/base

(module+ test
  
  (module base racket/base
    (require racket/list
             racket/string
             rackunit
             "main.rkt")
    (define ((mapped f) vs) (map f vs))
    (check-equal? ((- .. length .. rest) '(a b c)) -2)
    (check-equal? ((first .. (mapped string->symbol) .. string-split)
                   "foo bar baz")
                  'foo)
    (check-equal? ((first .. mapped string->symbol .. string-split)
                   "foo bar baz")
                  'foo)
    (define ((mapped/kw #:proc f) vs) (map f vs))
    (check-equal? ((first .. mapped/kw #:proc string->symbol .. string-split)
                   "foo bar baz")
                  'foo))

  (module fancy racket/base
    (require racket/list
             racket/string
             rackunit
             "fancy-app.rkt")
    (check-equal? ((first .. map string->symbol _ .. string-split)
                   "foo bar baz")
                  'foo)
    (define (map/kw f #:vs vs) (map f vs))
    (check-equal? ((first .. map/kw string->symbol #:vs _ .. string-split)
                   "foo bar baz")
                  'foo))

  (require 'base 'fancy))

