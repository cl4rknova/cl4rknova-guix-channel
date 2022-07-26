(use-modules (gnu packages base))    ;for 'hello'

(define clipnotify-1.0.22
  (package
    (inherit clipnotify)
    (version "1.0.2")
    (source (origin
              (method url-fetch)
              ;(uri (string-append "mirror://gnu/hello/hello-" version
              ;                    ".tar.gz"))
              (sha256
               (base32
                "0lappv4slgb5spyqbh6yl5r013zv72yqg2pcl30mginf3wdqd8k9"))))))
