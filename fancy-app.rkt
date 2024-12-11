#lang racket/base

(provide (rename-out [compose-app/fancy-app #%app])
         compose-app/fancy-app
         (all-from-out "main.rkt"))

(require (for-syntax racket/base)
         racket/stxparam
         syntax/parse/define
         (rename-in fancy-app [#%app fancy-app])
         (except-in "main.rkt" #%app))

(define-simple-macro (compose-app/fancy-app any ...)
  (syntax-parameterize
      ([compose-app-base-app (make-rename-transformer #'fancy-app)])
    (compose-app any ...)))
