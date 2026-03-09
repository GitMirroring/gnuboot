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

(define-module (gnuboot packages ich9-descriptors)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages flashing-tools)
  #:use-module (guix build-system gnu)
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

(define-public gnuboot-ich9-descriptors
  (package
   (name "gnuboot-ich9-descriptors")
   (version "0")
   (source
    (local-file
     (string-append topdir "/resources/ich9-descriptors")
     #:recursive? #t
     ;; TODO: We probably need something better to properly support
     ;; builds in tarballs. Since we use autotools we can however
     ;; leverage that to build a source tarball and build from that
     ;; as well.
     #:select?
     (lambda (file stat)
       (git-predicate (string-append topdir "/resources/ich9-descriptors")))))
   (build-system gnu-build-system)
   (native-inputs
    (list
     autoconf
     automake
     bincfg
     ifdtool))
   (home-page "https://gnu.org/software/gnuboot")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:gpl3+)))

(list gnuboot-ich9-descriptors)
