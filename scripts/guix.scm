;; Copyright © 2020,2024,2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;
;; This file is part of GNU Boot.
;;
;; GNU Boot is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.
;;
;; GNU Boot is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Boot.  If not, see <http://www.gnu.org/licenses/>.
;;
;; The guix.scm files typically contain package definitions that
;; are not meant to be used as regular packages but are meant for
;; testing or developing on a given project (here GNU Boot).
;;
;; Here we want to make sure that some GNU Boot components and/or
;; packages build fine in (recent) Guix (revisions).

(define-module (gnuboot-manual)
  #:use-module (ice-9 popen)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 textual-ports)
  #:use-module (sxml ssax input-parse)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:use-module (guix transformations)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages version-control)
  #:use-module (rnrs base))

;; When running Guix through the resources/packages/ scripts,
;; '(current-filename)' returns the current filename, but in some
;; other situations it returns #f, so it's better to test for it
;; rather than fail with some cryptic message.
(assert (current-filename))

(define topdir
  (dirname (dirname (current-filename))))

(define-public gnuboot-manual
  ;; TODO: use the current source code and not something from git, but
  ;; also filter out git related information or directories like
  ;; coreboot or grub that we download.
  (package
   (name "gnuboot-manual")
   (version "0.1")
   (source
    (local-file
     topdir
     #:recursive? #t
     ;; TODO: We probably need something better to properly support
     ;; builds in tarballs. Since we use autotools we can however
     ;; leverage that to build a source tarball and build from that
     ;; as well.
     #:select?
     (lambda (file stat)
       ;; (pk topdir file)
       (and (git-predicate topdir)
	    ;; There are directories like coreboot, grub, etc in the
	    ;; top directory that are git checkouts as well.

	    (lambda (path)
	      (eq? 0 (length
		      (filter
		       ;; Only keep #t
		       (lambda (elm)
			 elm)
		       (map
			(lambda (git)
			  ((is-project? git) path))
			(list
			 "coreboot"
			 "grub"
			 "memtest86+"
			 "seabios"
			 "website/lbssg/"))))))))))
   (build-system gnu-build-system)
   (arguments
    (list
     #:configure-flags
     #~(list
        "--disable-kvm"
	;; "--enable-component=manual"
        (string-append "--prefix=" #$output))
     #:make-flags #~(list "info")
     #:tests? #f))
   (native-inputs (list autoconf-2.71
                        automake
                        bash
                        coreutils
                        diffutils
                        gcc-toolchain
                        glibc-locales
                        gawk
                        git
                        graphicsmagick
                        grep
                        guix
                        gnu-make
                        libtool
                        sed
                        tar
                        texinfo
                        texlive-bin
                        texlive-cm
                        texlive-epsf
                        texlive-kpathsea
                        texlive-latex-bin ;; guix > 1.4
                        ;; texlive-latex-base   ;; guix 1.4
                        texlive-metafont
                        texlive-texinfo  ;; guix > 1.4
                        ;; texlive-tex-texinfo ;; guix 1.4
                        which
                        ))
   (synopsis "GNU Boot manual")
   (description "The manual contains a descrpition of GNU Boot and practical
information for getting or using GNU Boot, like the list of compatible
computers, hardware, operating systems and distributions, how to
authenticate GNU Boot source code and so on.")
   (home-page "https://gnu.org/software/gnuboot")
   (license license:fdl1.3+)))

gnuboot-manual
