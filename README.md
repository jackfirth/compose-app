# compose-app [![Build Status](https://travis-ci.org/jackfirth/compose-app.svg?branch=master)](https://travis-ci.org/jackfirth/compose-app) [![codecov](https://codecov.io/gh/jackfirth/compose-app/branch/master/graph/badge.svg)](https://codecov.io/gh/jackfirth/compose-app)

A Racket `#%app` macro that changes `(a .. b .. c)` into `(lambda (v) (a (b (c v))))` for easier function composition. Integrates with `fancy-app` to change `(a .. map b _ .. c)` into `(a .. (lambda (v) (map b v) .. c)`. See [the documentation](http://docs.racket-lang.org/compose-app/) for details.
