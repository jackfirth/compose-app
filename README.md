# compose-app
Not implemented yet

A Racket `#%app` macro that changes `(a .. b .. c)` to `(lambda (v) (a (b (c v))))` for easier function composition.

Planned features:

- Provide a syntax parameter for controlling what base `#%app` macro is used
- Treat adjacent expressions specially - `(a .. b c .. d)` is equivalent to `(a .. (b c) .. d)`
- Provide another syntax parameter used in the above-mentioned implicit grouping
- Provide a `compose-app/fancy` module that uses `fancy-app` as the base app, making `(a .. b _ 1 .. c)` equivalent to `(a .. (lambda (v) (b v 1)) .. c)`
