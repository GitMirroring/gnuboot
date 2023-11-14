;;; Copyright © 2015 David Thompson <davet@gnu.org>
;;; Copyright © 2016 Christopher Allan Webber <cwebber@dustycloud.org>
;;; Copyright © 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is based on haunt/builder/blog.scm,
;;; haunt/reader/commonmark.scm and tests/post.scm and from Haunt
;;; 2.6.0.
;;;
;;; This file is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published
;;; by the Free Software Foundation; either version 3 of the License,
;;; or (at your option) any later version.
;;;
;;; Haunt is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Haunt.  If not, see <http://www.gnu.org/licenses/>.

(define-module (website readers untitled)
  #:use-module (commonmark)
  #:use-module (haunt reader)
  #:use-module (haunt site)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-19)
  #:export (untitled-file-filter)
  #:export (untitled-reader))

;; TODO: append to default-file-filter
(define untitled-file-filter
  (make-file-filter
   (append
    (list "^\\." "^#" "~$") ;; from default-file-filter
    (list
     "^COPYING$"
     "^MANIFEST$"
     "^codec#0$"            ;; in docs/hardware/hwdumps/x200
     "^pin_hwC0D0$"         ;; in docs/hardware/hwdumps/x200
     "^robots.txt$"         ;; TODO
     "^template.original$"
     "global\\.css$"        ;; TODO
     "\\.cfg$"
     "\\.config$"
     "\\.asc$"
     "\\.include$"
     "\\.patch$"
     "\\.txt$"))))

(define %tzoffset
  (date-zone-offset (string->date "2015-09-05" "~Y~m~d")))

;; TODO: Handle the case where there is no title.
(define (parse-three-dashes-file-title port)
  (let ((next-line (read-line port)))
    (if (not (eof-object? next-line))
	(let ((line-parts (string-split next-line #\space)))
	  (if (string=? (list-ref line-parts 0) "title:")
	      ((lambda _
		 (do ((next-line (read-line port) (read-line port)))
		     ((or (eof-object? next-line) (string=? next-line "..."))))
		 (string-join (cdr line-parts) " ")))
	      (parse-three-dashes-file-title port))))))

(define (parse-percent-file-title port first-line)
  (if (not (eof-object? first-line))
      ((lambda _
	 ;; TODO: also handle author and date instead of skiping them
	 (if (not (eof-object? (read-line port)))
	     (read-line port))
	 ;; Untitled's 'build' script uses 'sed -e s-^..--' to select
	 ;; the title.
	 (substring first-line 2)))))

(define (parse-title port)
  (let* ((first-line (read-line port)))
    (if (not (eof-object? first-line))
	(cond ((string=? first-line "---")
	       (parse-three-dashes-file-title port))
	      ((string=? (substring first-line 0 1) "%")
	       (parse-percent-file-title port first-line))))))

(define (read-untitled-metadata-headers port)
  `((date . ,(make-date 0 0 0 0 0 0 1970 %tzoffset))
    (title . ,(parse-title port))))

(define untitled-reader
  (make-reader (make-file-extension-matcher "md")
               (lambda (file)
                 (call-with-input-file file
                   (lambda (port)
                     (values (read-untitled-metadata-headers port)
                             (commonmark->sxml port)))))))
