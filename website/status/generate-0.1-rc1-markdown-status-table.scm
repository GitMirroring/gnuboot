#!/usr/bin/env -S guile -l status/modules/dsv/table.scm -l status/common.scm -e main -s
!#
;; Copyright (C) 2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
(use-modules (dsv table)
             (guix records)
             (ice-9 i18n)
             (srfi srfi-1))

(define (usage progname exit-code)
  (display (string-append
            "Usage: "
            progname
            " [OPTIONS] [COMPUTERS-RECFILE] [RELEASE-RECFILE] [LANGUAGE]\n"
            "\n"
            "Options:\n"
            "\t--help print this help.\n"))
  (exit exit-code))

(define (get-computer-test-data computer-list vendor product)
  "Returns a record of tests for a given computer. The record is an alist that
contains a record from a file like resources/data/0.1-rc1.rec.  See the
Records section of the recutils info manual for more details on records.
@var{computer-list} should contain a list of such records. @var{vendor} and
@var{product} are strings like \"Technoethical\" \"X200\" that contain the
name of the computer vendor and product."
  (define (filter-computer v p)
    (lambda (elm)
      (if
       (and
        (string=? (assoc-ref elm "vendor") v)
        (string=? (assoc-ref elm "product") p))
       #t
       #f)))
  (define computer
    (filter (filter-computer vendor product) computer-list))
  (if computer
      computer
      #f))

(define (get-values computer status-recfile-path)
  "Returns a list of values to display in the status table like
(\"Untested\").
@var{computer} should contain an alists of the data of a given computer,
similar to one of the records in resources/data/computers-0.1-rc1.rec. See the Records
section of the recutils info manual for more details on records."
  (define vendor (assoc-ref computer "vendor"))
  (define product (assoc-ref computer "product"))
  (define tests (get-computer-test-data
                 (parse-recfile status-recfile-path) vendor product))

  ;; TODO: move to get-defaults
  (list
   (if (> (length tests) 0)
       (gettext (assoc-ref (car tests) "stability"))
       (gettext "Untested"))))

(define (release-status computers-recfile-path status-recfile-path)
  "Returns a list of rows (which itself is a list of strings) compatible with
guile-dsv's format-table function. The list it will return will look like that:
(list
  (\"Vendor\" \"Product\" \"Stability\")
  ...
  (\"Technoethical\" \"X200\" \"Untested\")
  ...)."
  (define (handle-computer status-recfile-path)
    (lambda (computer1 computer2)
      (append
       (list
        (append
         (list
           (gettext (assoc-ref computer1 "vendor"))
           (gettext (assoc-ref computer1 "product")))
         (get-values computer1 status-recfile-path)))
       computer2)))
    (append
     (list (list (gettext "Vendor")
                 (gettext "Product")
                 (gettext "Stability")))
     (fold (handle-computer status-recfile-path)
           '()
           (reverse (parse-recfile computers-recfile-path)))))

(define (main args)
  (cond
   ((eqv? (length args) 1)
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-0.1-rc1-markdown-status-table.scm" 64))
   ((string=? (list-ref args 1) "--help")
    (usage "generate-0.1-rc1-markdown-status-table.scm" 0))
   ((eqv? (length args) 4)
    (setup-translations (list-ref args 3))
    (format-table
     (release-status
      (list-ref args 1)
      (list-ref args 2))
     pandoc-markdown
     #:width 35
     #:calculate-cell-widths
     (lambda (content-width percents)
       (if (string=? (list-ref args 3) "es")
         (list 13 14 15)
         (list 13 18 12)))
     #:string-slice string-slice*))
   (else
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-markdown-status-table.scm" 64))))
