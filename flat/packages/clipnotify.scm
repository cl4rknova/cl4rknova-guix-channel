(define-module (gnu packages xdisorg)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system python)
  #:use-module (guix build-system scons)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages)
  #:use-module (ice-9 match))


(define-public clipnotify
  (package
    (name "clipnotify")
    (version "1.0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/cdown/clipnotify")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1v3ydm5ljy8z1savmdxrjyx7a5bm5013rzw80frp3qbbjaci0wbg"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (replace 'install
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((out  (assoc-ref outputs "out"))
                    (bin  (string-append out "/bin"))
                    (doc  (string-append %output "/share/doc/" ,name "-" ,version)))
               (install-file "clipnotify" bin)
               (install-file "README.md" doc)
               #t))))
       #:make-flags
       (list ,(string-append "CC=" (cc-for-target)))
       #:tests? #f))                    ; no test suite
    (inputs
     `(("libx11" ,libx11)
       ("libXfixes" ,libxfixes)))
    (home-page "https://github.com/cdown/clipnotify")
    (synopsis "Notify on new X clipboard events")
    (description "@command{clipnotify} is a simple program that, using the
XFIXES extension to X11, waits until a new selection is available and then
exits.

It was primarily designed for clipmenu, to avoid polling for new selections.

@command{clipnotify} doesn't try to print anything about the contents of the
selection, it just exits when it changes.  This is intentional -- X11's
selection API is verging on the insane, and there are plenty of others who
have already lost their sanity to bring us xclip/xsel/etc.  Use one of those
tools to complement clipnotify.")
    (license license:public-domain)))
clipnotify
