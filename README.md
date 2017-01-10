# compose-app

A Racket `#%app` macro that changes `(a .. b .. c)` into `(lambda (v) (a (b (c v))))` for easier function composition. Integrates with `fancy-app` to change `(a .. map b _ .. c)` into `(a .. (lambda (v) (map b v) .. c)`. See the documentation for details.
