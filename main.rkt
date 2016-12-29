#lang racket/base

(provide (rename-out [compose-app #%app])
         ..
         compose-app
         compose-app-base-app
         compose-app-base-lambda
         compose-app-group)

(require (for-syntax racket/base)
         racket/stxparam
         syntax/parse/define)

(define-syntax-parameter compose-app-base-app (make-rename-transformer #'#%app))
(define-syntax-parameter compose-app-base-lambda
  (make-rename-transformer #'lambda))

(define-syntax-parameter compose-app-group
  (make-rename-transformer #'compose-app-base-app))

(define-syntax-parameter ..
  (λ (stx)
    (raise-syntax-error 'compose-app
                        "use of .. outside compose-app application"
                        stx)))

(begin-for-syntax
  (define-syntax-class not-dots
    #:literals (..)
    (pattern (~and any (~not ..))))
  (define-splicing-syntax-class group
    (pattern only:not-dots
             #:attr func-expr #'only)
    (pattern (~seq first:not-dots rest:not-dots ...)
             #:attr func-expr #'(compose-app-group first rest ...))))

(define-syntax-parser compose-app
  #:literals (..)
  [(_ any:not-dots ...) #'(compose-app-base-app any ...)]
  [(_ first:group (~seq .. rest:group) ...+)
   #'(compose-app-base-lambda (v)
       (compose-app-apply v first.func-expr rest.func-expr ...))])

(define-syntax-parser compose-app-apply
  [(_ v:expr) #'v]
  [(_ v:expr first-func rest-funcs ...)
   #'(compose-app-base-app first-func (compose-app-apply v rest-funcs ...))])
