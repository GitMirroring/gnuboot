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
            " [OPTIONS] [COREBOOT-UPSTREAM-STATUS-RECFILE] [LANGUAGE]\n"
            "\n"
            "Options:\n"
            "\t--help print this help.\n"))
  (exit exit-code))

(define (coreboot-upstream-status status-recfile-path)
  "Returns a list of rows (which itself is a list of strings) compatible with
guile-dsv's format-table function. The list it will return will look like that:
(list
  (\"Vendor\" \"Product\" \"Coreboot status\" \"Coreboot GPU driver\")
  ...
  (\"Lenovo\" \"ThinkPad X200\" \"Maintained\" \"new GPU driver\")
  ...)."
  (define (handle-computer status-recfile-path)
    (lambda (computer1 computer2)
      (append
       (list
         (list
           (gettext (assoc-ref computer1 "vendor"))
           (gettext (assoc-ref computer1 "product"))
           (gettext (assoc-ref computer1 "coreboot_status"))
           (if (assoc-ref computer1 "coreboot_gpu_driver")
               (gettext (assoc-ref computer1 "coreboot_gpu_driver"))
               "")))
       computer2)))
    (append
     (list (list (gettext "Vendor")
                 (gettext "Product")
                 (gettext "Coreboot status")
                 (gettext "Coreboot GPU driver")))
     (fold (handle-computer status-recfile-path)
           '()
           (reverse (parse-recfile status-recfile-path)))))

(define (main args)
  (cond
   ((eqv? (length args) 1)
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-coreboot-upstream-status.scm" 64))
   ((string=? (list-ref args 1) "--help")
    (usage "generate-coreboot-upstream-status.scm" 0))
   ((eqv? (length args) 3)
    (setup-translations (list-ref args 2))
    (if
     (string=? (list-ref args 2) "es")
     (format-table
      (coreboot-upstream-status
       (list-ref args 1))
      pandoc-markdown
      #:width 80
      #:calculate-cell-widths
      (lambda (content-width percents)
        (list 8 14 24 20))
      #:string-slice string-slice*)
     (format-table
      (coreboot-upstream-status
       (list-ref args 1))
      pandoc-markdown
      #:width 80
      #:calculate-cell-widths
      (lambda (content-width percents)
        (list 8 15 25 19))
      #:string-slice string-slice*)))
   (else
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-coreboot-upstream-status.scm" 64))))
