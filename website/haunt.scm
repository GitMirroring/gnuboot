;;; Copyright © 2015 David Thompson <davet@gnu.org>
;;; Copyright © 2016 Christopher Allan Webber <cwebber@dustycloud.org>
;;; Copyright © 2023,2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is based on haunt/builder/blog.scm,
;;; haunt/reader/commonmark.scm and tests/post.scm and from Haunt
;;; 2.6.0.
;;;
;;; Haunt is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; Haunt is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Haunt.  If not, see <http://www.gnu.org/licenses/>.

(use-modules (haunt builder assets)
             (haunt post)
             (haunt reader)
             (haunt reader commonmark)
             (haunt site)
             (modules builders gnuboot))

;; We use "C.UTF-8", because it's built in glibc, and without it we have the
;; following error with guix shell -C:
;; ERROR: In procedure substring:
;; Value out of range 0 to< 30: 33
(setlocale LC_ALL "en_US.UTF-8")

(define (string->string* str) str)
(register-metadata-parser! 'title string->string*)
(register-metadata-parser! 'x-unreviewed string->string*)

(site #:title "GNU Boot"
      #:domain "gnu.org/software/gnuboot"
      #:default-metadata
      '((author . "GNU Boot contributors")
        (date . (make-date 0 0 0 0 0 0 0 0))
        (x-unreviewed . #f))
      #:build-directory "build/haunt/site"
      #:posts-directory "pages"
      #:readers (list commonmark-reader)
      #:builders
      (list (gnuboot-website
             #:prefix "software/gnuboot")
            ;; Also include markdown files because Untitled did that and some
            ;; people may be used to it. The corresponding markdown files are
            ;; also referenced in the bottom of each HTML page.
            (static-directory "manual"
                              "software/gnuboot/manual")
            (static-directory "pages"
                              "software/gnuboot")
            (static-directory "static"
                              "software/gnuboot")
            (static-directory "hwdumps"
                              "software/gnuboot/docs/hardware/hwdumps")
            (static-directory "img"
                              "software/gnuboot/img")))
