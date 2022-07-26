(define-public clipmenu
  (let ((commit "bcbe7b144598db4a103f14e8408c4b7327d6d5e1")
        (revision "1"))
    (package
      (name "clipmenu")
      (version (string-append "6.0.1-"
                              revision "." (string-take commit 7)))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cdown/clipmenu")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0053j4i14lz5m2bzc5sch5id5ilr1bl196mp8fp0q8x74w3vavs9"))))
      (build-system gnu-build-system)
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (delete 'configure)
           (delete 'build)
           (replace 'install
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let* ((out  (assoc-ref outputs "out"))
                      (bin  (string-append out "/bin"))
                      (doc  (string-append %output "/share/doc/"
                                           ,name "-" ,version)))
                 (install-file "clipdel" bin)
                 (install-file "clipmenu" bin)
                 (install-file "clipmenud" bin)
                 (install-file "README.md" doc)
                 #t)))
           (add-after 'install 'wrap-script
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let* ((out               (assoc-ref outputs "out"))
                      (clipnotify        (assoc-ref inputs "clipnotify"))
                      (coreutils-minimal (assoc-ref inputs "coreutils-minimal"))
                      (gawk              (assoc-ref inputs "gawk"))
                      (util-linux        (assoc-ref inputs "util-linux"))
                      (xdotool           (assoc-ref inputs "xdotool"))
                      (xsel              (assoc-ref inputs "xsel")))
                 (for-each
                  (lambda (prog)
                    (wrap-script (string-append out "/bin/" prog)
                      `("PATH" ":" prefix
                        ,(map (lambda (dir)
                                (string-append dir "/bin"))
                              (list clipnotify coreutils-minimal
                                    gawk util-linux xdotool xsel)))))
                  '("clipmenu" "clipmenud" "clipdel")))
               #t))
           (replace 'check
             (lambda* (#:key inputs outputs #:allow-other-keys)
               ;; substitute a shebang appearing inside a string (the test
               ;; file writes this string to a temporary file):
               (substitute* "tests/test-clipmenu"
                 (("#!/usr/bin/env bash")
                  (string-append "#!" (which "bash"))))
               (invoke "tests/test-clipmenu")
               #t)))))
      (inputs
       `(("clipnotify" ,clipnotify)
         ("coreutils-minimal" ,coreutils-minimal)
         ("gawk" ,gawk)
         ("guile" ,guile-3.0) ; for wrap-script
         ("util-linux" ,util-linux)
         ("xdotool" ,xdotool)
         ("xsel" ,xsel)))
      (home-page "https://github.com/cdown/clipmenu")
      (synopsis "Simple clipboard manager using dmenu or rofi and xsel")
      (description "Start @command{clipmenud}, then run @command{clipmenu} to
select something to put on the clipboard.

When @command{clipmenud} detects changes to the clipboard contents, it writes
them out to the cache directory.  @command{clipmenu} reads the cache directory
to find all available clips and launches @command{dmenu} (or @command{rofi},
depending on the value of @code{CM_LAUNCHER}) to let the user select a clip.
After selection, the clip is put onto the PRIMARY and CLIPBOARD X selections.")
      (license license:public-domain))))
