#lang info
(define collection "compose-app")
(define deps '("base"
               "fancy-app"))
(define build-deps '("racket-doc"
                     ("scribble-lib" #:version "1.16")
                     "scribble-text-lib"
                     "rackunit-lib"))
(define scribblings '(("main.scrbl" () (library) "compose-app")))
(define version "0.9")
(define compile-omit-paths '("test.rkt"))
