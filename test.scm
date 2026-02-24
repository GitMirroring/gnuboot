#!/usr/bin/env -S guile -e main -s
!#
;; Copyright (C) 2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(use-modules (ice-9 popen))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules ((rnrs base) #:select (assert)))
(use-modules (srfi srfi-1))
(use-modules (srfi srfi-9))
(use-modules (srfi srfi-19))

(define lines
  (list
   "# Copyright (C) 2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>"
   "# Copyright (C) 2013-2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>"
   "# Copyright (C) 2013-2015 2017-2019 2021-2023 2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>"
   "# Copyright (C) 2023,2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>"
   "# Copyright (C) 2023 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>"
   "# Copyright (C) 2013,2015,2023-2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>"
   ))

(define (copyright-line? line)
  (define copyright-regex
    "Copyright \\(C\\) [0-9]{4}*")
  (if
   (string-match copyright-regex line)
   #t
   #f))

(define (find-dates line)
  (define (extract-single-date match)
    (if match
	(list
	 (string->number
	  (match:substring
	   (string-match "[0-9]{4}" (match:substring match)))))
	'()))

  (define (extract-date-range match)
    (if match
	(let* ((range
 		(match:substring
		 (string-match "[0-9]{4}-[0-9]{4}" (match:substring match))))
	       (range-elements (string-split range #\-))
	       (start (string->number (car range-elements)))
	       (end (string->number (cadr range-elements))))
	  ;; TODO: error if start >= end
	  (iota (+ (- end start) 1) start))
	'()))

  (define (_find-dates line results)
    (let* ((date-range (string-match "[0-9]{4}-[0-9]{4}[ ,]" line))
	   (single-date (string-match "[0-9]{4}[ ,]" line))
	   (date-match-data
	    (cond
	     ((and date-range single-date
		   (< (match:start date-range)
		      (match:start single-date)))
	      (cons
	       (extract-date-range date-range)
	       (substring line (match:end date-range))))
	     ((and date-range single-date
		   (< (match:start single-date)
		      (match:start date-range)))
	      (cons
	       (extract-single-date single-date)
	       (substring line (match:end single-date))))
	     (date-range
	      (cons
	       (extract-date-range date-range)
	       (substring line (match:end date-range))))
	     (single-date
	      (cons
	       (extract-single-date single-date)
	       (substring line (match:end single-date))))
	     (else #f))))
      (if date-match-data
	  (_find-dates
	   (cdr date-match-data)
	   (append results (car date-match-data)))
	  results)))
  (_find-dates line '()))

(for-each
 (lambda (line)
   (if (copyright-line? line)
       (let ((dates-name-mail
	      (regexp-substitute
	       #f
	       (string-match " Copyright \\(C\\) " line) 'post)))
	 (pk 'end (find-dates dates-name-mail) line))))
 lines)
