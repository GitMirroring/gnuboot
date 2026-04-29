;;; Copyright © 2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is part of GNU Boot.
;;;
;;; GNU Boot is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Bootx is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Boot.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnuboot packages grub)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bootloaders)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (rnrs base)
  ;;;;;;;;;;;;;;;;;;;
  ;; Local imports ;;
  ;;;;;;;;;;;;;;;;;;;
  #:use-module (gnuboot packages build-utilities))

;; When running Guix through the resources/packages/ scripts,
;; '(current-filename)' returns the current filename, but in some
;; other situations it returns #f, so it's better to test for it
;; rather than fail with some cryptic message.
(assert (current-filename))

(define topdir
  (dirname (dirname (dirname (dirname (dirname (current-filename)))))))

;; 2018-01-31, broken?
(define-public xkeyboard-config-2.23
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.23")
    (version "2.23")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1cx9sp9blp14kj4a1f0lnpyv5clf3ayydfgqpgc3inp94w2l3yr3"))))
    (build-system gnu-build-system)
    (inputs (list gettext-minimal libx11 xkbcomp-intermediate))
    (native-inputs (list intltool pkg-config))))

;; 2018-01-31
(define-public xkeyboard-config-2.23.1
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.23.1")
    (version "2.23.1")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1wq27cs1c9y7d1d7zp5yhq29paj9smajdb68lyvm28d2zq2vqjra"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases
	 %standard-phases
	 ;; Without this, we end up with this build error in gnuboot-grub-kbd:
	 ;;     ./ckbcomp \
	 ;;     -I/gnu/store/[...]xkeyboard-config-2.23.1-2.23.1/share/X11/xkb/ \
	 ;;     us colemak > colemak.map
	 ;;     ./ckbcomp: Can not find file "rules/xorg" in any known directory
	 ;;
	 ;; And Trisquel Etiona which can build colemak fine has these
	 ;; symlinks (and also xfree86 symlinks that are not necessary
	 ;; here).
	 (add-after
	  'install 'make-symlinks
	  (lambda* (#:key outputs inputs #:allow-other-keys)
	    (chdir (string-append #$output "/share/X11/xkb/rules/"))
	    (symlink "base" "xorg")
	    (symlink "base.lst" "xorg.lst")
	    (symlink "base.xml" "xorg.xml"))))))

    (inputs (list gettext-minimal libx11 xkbcomp-intermediate))
    (native-inputs (list intltool pkg-config))))

;; 2018-06-04
(define-public xkeyboard-config-2.24
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.24")
    (version "2.24")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1my4786pd7iv5x392r9skj3qclmbd26nqzvh2fllwkkbyj08bcci"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2018-10-13
(define-public xkeyboard-config-2.25
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.25")
    (version "2.25")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1cil54k63fwrfsvxf0h5c62jq8psn19id6m4zjdbsc9rimdc5ipy"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2019-02-02
(define-public xkeyboard-config-2.26
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.26")
    (version "2.26")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "13h3381pfp4pv32189zkfsj2x0alr91xj6dqii76rl0c8v3ihdrr"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2019-05-30
(define-public xkeyboard-config-2.27
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.27")
    (version "2.27")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "07wh443lhwv1j0q6xnxnji7f7ahh7xphxj90fv02cdd6zv4aw3b9"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2019-10-19
(define-public xkeyboard-config-2.28
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.28")
    (version "2.28")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1kmxc8hdw4qpvdlzp4ag8ygl34lqhs6sn3pcz1sl0kn61xdv5bb9"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2020-01-31
(define-public xkeyboard-config-2.29
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.29")
    (version "2.29")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "00hqc8nykvy8c09b8vab64dcd0ij3n5klxjn6rl00q7hickpah8x"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2020-06-02
(define-public xkeyboard-config-2.30
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.30")
    (version "2.30")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1m4pnzlcdl6d1p7hdccpi0605zkikind00kjc5bx4gk3gd7m4nh9"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2020-10-06
(define-public xkeyboard-config-2.31
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.31")
    (version "2.31")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "18xddaxh83zm698syh50w983jg6b7b8zgv0dfaf7ha485hgihi6s"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2021-02-16
(define-public xkeyboard-config-2.32
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.32")
    (version "2.32")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1a1nq0bc51jwg8v9dh7lr2zszrkk1iy9ilnbn011kf9rp8by7vhz"))))
    (build-system gnu-build-system)
    (inputs (list libx11 xkbcomp-intermediate))
    (native-inputs (list gettext-minimal
			 intltool
			 perl
			 pkg-config
			 python))))

;; 2021-06-08
(define-public xkeyboard-config-2.33
  (package
    (inherit xkeyboard-config)
    (name "xkeyboard-config-2.33")
    (version "2.33")
    (source
     (origin
      (method url-fetch)
      (uri
       (string-append
        "mirror://xorg/individual/data/xkeyboard-config/xkeyboard-config-"
        version
        ".tar.bz2"))
      (sha256
       (base32
        "1g6kn7l0mixw50kgn7d97gwv1990c5rczr2x776q3xywss8dfzv5"))))))

(define-public gnuboot-grub-kbd
  (package
   (name "gnuboot-grub-kbd")
   (version "0.1")
   (source
    (local-file
     (string-append topdir "/resources/grub-kbd")
     #:recursive? #t
     ;; TODO: We probably need something better to properly support
     ;; builds in tarballs. Since we use autotools we can however
     ;; leverage that to build a source tarball and build from that
     ;; as well.
     #:select?
     (lambda (file stat)
       (git-predicate (string-append topdir "/resources/grub-kbd")))))
   (build-system gnu-build-system)
   (arguments
    (list
     #:tests? #t
     #:configure-flags
     #~(list
	(string-append
	 "--with-colemak-default-keymap-dir="
	 #$xkeyboard-config-2.23.1 "/share/X11/xkb/")
	(string-append
	 "--with-trqwerty-default-keymap-dir="
	 #$xkeyboard-config-2.33 "/share/X11/xkb/"))))
   (native-inputs
    (list
     autoconf
     automake
     console-setup
     grub-pc
     perl
     xkeyboard-config-2.23.1
     xkeyboard-config-2.33))
   (home-page "https://gnu.org/software/gnuboot")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:gpl3+)))

(list gnuboot-grub-kbd)
