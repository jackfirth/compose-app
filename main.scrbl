#lang scribble/manual

@(require (for-label (except-in compose-app #%app)
                     (except-in compose-app/fancy-app #%app)
                     (except-in fancy-app #%app)
                     racket/base)
          fancy-app
          scribble/example
          scribble/text)

@(define (make-compose-app-eval)
   (make-base-eval #:lang 'racket/base
                   (list 'require 'compose-app 'racket/list 'racket/string)))

@(define-syntax-rule (compose-app-examples example ...)
   (examples #:eval (make-compose-app-eval) example ...))

@(define (make-compose-app-fancy-eval)
   (make-base-eval #:lang 'racket/base
                   (list 'require
                         'compose-app/fancy-app
                         'racket/list
                         'racket/string)))

@(define-syntax-rule (compose-app-fancy-examples example ...)
   (examples #:eval (make-compose-app-fancy-eval) example ...))

@(define (source-code-link url-str)
   (begin/text "Source code for this library is avaible at "
               (url url-str)))

@title{Function Composition Syntax}
@author[@author+email["Jack Firth" "jackhfirth@gmail.com"]]

This library provides an alternative @racket[#%app] syntax that interprets
double dots as (unary) function composition. The syntax is lightweight and
extensible through syntax parameters, allowing alternative base forms of
@racket[#%app] to be substituted. Included with this package is integration with
the @racket[fancy-app] module, to make composition of anonymous functions as
painless as possible.

@source-code-link{https://github.com/jackfirth/compose-app}

@section{API Reference}
@defmodule[compose-app]

@defform[#:literals (..)
         (compose-app func-expr dotted-func-expr ...)
         #:grammar
         [(func-expr single-expr (code:line many-expr ...))
          (dotted-func-expr (code:line .. func-expr))]]{
 Expands into a function composition of each @racket[func-expr], with function
 application for the expanded composition defined in terms of
 @racket[compose-app-base-app]. If a @racket[func-expr] is a @racket[single-expr],
 the expression is used directly, but in the @racket[many-expr] case the
 expression used for that function is
 @racket[(compose-app-group many-expr ...)]. The @racketmodname[compose-app]
 module additionally provides @racket[compose-app] as @racket[#%app]. If no uses
 of @racket[..] are found, an expansion to a normal function application (still
 in terms of @racket[compose-app]) is used.
 @(compose-app-examples
   ((add1 .. string->number .. first) '("15" "2" "96"))
   (define ((mapped f) vs) (map f vs))
   ((rest .. (mapped string->symbol) .. string-split) "foo bar baz")
   ((rest .. mapped string->symbol .. string-split) "foo bar baz"))
 
 The composition produced by @racket[compose-app] is a single-argument function
 defined in terms of @racket[compose-app-base-lambda], which defaults to
 @racket[lambda] from @racketmodname[racket/base].}

@defform[#:id .. ..]{
 A syntactic element used by @racket[compose-app]. Usage anywhere else is a
 syntax error.}

@defform[#:id compose-app-group compose-app-group]{
 A syntax parameter that defines how @racket[compose-app] treats multiple
 expressions in the same function segment. Defaults to
 @racket[compose-app-base-app].}

@defform[#:id compose-app-base-app compose-app-base-app]{
 A syntax parameter that defines what function application syntax
 @racket[compose-app] expands to. Defaults to @racket[#%app] from
 @racketmodname[racket/base]. Changing this allows @racket[compose-app] to be
 used with other libraries providing modified versions of @racket[#%app].}

@defform[#:id compose-app-base-lambda compose-app-base-lambda]{
 A syntax parameter that defines what anonymous function syntax
 @racket[compose-app] expands to. Defaults to @racket[lambda] from
 @racketmodname[racket/base]. This parameter should always be a macro
 that accepts expressions like @racket[lambda] does, but it will only
 ever be used to produce single-argument functions. Changing this
 allows @racket[compose-app] with other definitions of anonymous
 function semantics.}

@section{Integration with fancy-app}
@defmodule[compose-app/fancy-app]

@defform[#:id compose-app/fancy-app compose-app/fancy-app]{
 Like @racket[compose-app], but with @racket[compose-app-base-app] set to
 @racket[#%app] from fancy-app.
 @(compose-app-fancy-examples
   ((map string->number _ .. rest .. string-split) "1 10 100"))}
