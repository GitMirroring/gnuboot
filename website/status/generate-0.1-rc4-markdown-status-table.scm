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
contains a record from a file like resources/data/0.1-rc4.rec.  See the
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
      (car computer)
      #f))

(define (get-values computer status-recfile-path)
  "Returns a list of values to display in the status table like
(\"Tested\" \"Untested\" \"Tested\" \"Untested\").
@var{computer} should contain an alists of the data of a given computer,
similar to one of the records in resources/data/computers-0.1-rc4.rec. See the Records
section of the recutils info manual for more details on records."
  (define vendor (assoc-ref computer "vendor"))
  (define product (assoc-ref computer "product"))
  (define defaults (get-defaults computer))
  (define tests (get-computer-test-data
                 (parse-recfile status-recfile-path) vendor product))
  (define (decode val)
    (cond
     ((= val 0) "grub_high_resolution_graphics")
     ((= val 1) "grub_text_only_low_resolution")
     ((= val 2) "seabios_high_resolution_graphics")
     ((= val 3) "seabios_text_only_low_resolution")))

  ;; Here we assume that Untested is a default template in the release
  ;; recfile. If there are no images this is declared in the computer recfile
  ;; not in the release recfile. In that case the release recfile will still
  ;; have "Untested" and so we have to check if there are really images for
  ;; the computer and if there are, display "Untested" and if they are none,
  ;; report that instead. Tested images and bugs are declared in the release
  ;; recfile for now.
  ;;
  ;; It may (or not) make sense to remove all the Untested entries in the
  ;; release recfiles with something like "sed '/.*Untested$/d' -i
  ;; resources/data/0.1-rc5.rec", but in this case the code below must be
  ;; adjusted, and it might also look less intuitive for users adding new
  ;; tests, depending on how this is implemented, as the users would need to
  ;; find the right vendor, product and an example of a record with the same
  ;; tested image before being able to add an entry.
  (define (test-value num)
    (if (string=? (list-ref defaults num) "Untested")
        (gettext (assoc-ref tests (decode num)))
        (gettext (list-ref defaults num))))
  (list
   (test-value 0)
   (test-value 1)
   (test-value 2)
   (test-value 3)))

(define (release-status computers-recfile-path status-recfile-path)
  "Returns a list of rows (which itself is a list of strings) compatible with
guile-dsv's format-table function. The list it will return will look like that:
(list
  (\"Vendor, product\" \"GRUB with high resolution graphics\"
   \"GRUB with text-only low resolution\"
   \"SeaBIOS with high resolution graphics\"
   \"SeaBIOS with text-only low resolution\")
  ...
  (\"Technoethical, X200\" \"Untested\" \"Untested\" \"Untested\" \"Untested\")
  ...)."
  (define (handle-computer status-recfile-path)
    (lambda (computer1 computer2)
      (append
       (list
        (append
         (list
          (string-append
           (gettext (assoc-ref computer1 "vendor"))
           ", "
           (gettext (assoc-ref computer1 "product"))))
         (get-values computer1 status-recfile-path)))
       computer2)))
    (append
     (list (list (gettext "Vendor, product")
                 (gettext "GRUB with high resolution graphics")
                 (gettext "GRUB with text-only low resolution")
                 (gettext "SeaBIOS with high resolution graphics")
                 (gettext "SeaBIOS with text-only low resolution")))
     (fold (handle-computer status-recfile-path)
           '()
           (reverse (parse-recfile computers-recfile-path)))))

(define (main args)
  (cond
   ((eqv? (length args) 1)
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-0.1-rc4-markdown-status-table.scm" 64))
   ((string=? (list-ref args 1) "--help")
    (usage "generate-0.1-rc4-markdown-status-table.scm" 0))
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
       (list 16 12 12 12 12))
     #:string-slice string-slice*))
   (else
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-markdown-status-table.scm" 64))))
