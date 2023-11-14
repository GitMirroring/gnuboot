;;; Copyright © 2015 David Thompson <davet@gnu.org>
;;; Copyright © 2016 Christopher Allan Webber <cwebber@dustycloud.org>
;;; Copyright © 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
             (haunt site)
             (website builders gnuboot)
             (website readers untitled))

(site #:title "GNU Boot"
      #:domain "gnu.org/software/gnuboot"
      #:default-metadata
      '((author . "GNU Boot contributors"))
      #:file-filter untitled-file-filter
      #:posts-directory "pages"
      #:readers (list untitled-reader)
      #:builders (list (gnuboot-website
			#:prefix "software/gnuboot/web")
                       (static-directory "software/gnuboot/web/static")))
