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

(define (upstream-versions upstream-versions-recfile-path)
  "Returns a list of rows (which itself is a list of strings) compatible with
guile-dsv's format-table function. The list it will return will look like that:
(list
  (\"GRUB\" \"/fallback/payload\" \"Unknown\" \"GRUB images\")
  ...
  (\"ich9gen\" \"Intel flash descriptor\" \"Yes: verified by checksum\" \"GM45 ThinkPads\")
  ...)."
  (define (handle-entry upstream-versions-recfile-path)
    (lambda (entry1 entry2)
      (append
       (list
         (list
           (gettext (assoc-ref entry1 "provenance"))
           (gettext (assoc-ref entry1 "path_inside_the_image"))
           (gettext (assoc-ref entry1 "reproducible"))
           (gettext (assoc-ref entry1 "usage"))))
       entry2)))
    (append
     (list (list (gettext "Provenance")
                 (gettext "Path inside the image")
                 (gettext "Reproducible")
                 (gettext "Usage")))
     (fold (handle-entry upstream-versions-recfile-path)
           '()
           (reverse (parse-recfile upstream-versions-recfile-path)))))

(define (main args)
  (cond
   ((eqv? (length args) 1)
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-reproducible-builds-status.scm" 64))
   ((string=? (list-ref args 1) "--help")
    (usage "generate-reproducible-builds-status.scm" 0))
   ((eqv? (length args) 3)
    (setup-translations (list-ref args 2))
    (format-table
     (upstream-versions
      (list-ref args 1))
     pandoc-markdown
     #:width 80
     #:calculate-cell-widths
     (lambda (content-width percents)
       (list 16 26 12 11))
     #:string-slice string-slice*))
   (else
    ;; 64 is EX_USAGE in sysexits.h
    (usage "generate-reproducible-builds-status.scm" 64))))
