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

(define-public (usage progname exit-code)
  (display (string-append
            "Usage: "
            progname
            " [OPTIONS] [UPSTREAM-VERSIONS-RECFILE] [LANGUAGE]\n"
            "\n"
            "Options:\n"
            "\t--help print this help.\n"))
  (exit exit-code))

(define-public (parse-recfile recfile-path)
  "Returns a list of records. Each record is an alist that contains a
record from resources/data/upstream-versions.rec. See the Records section of the
recutils info manual for more details on records."
  (define port (open-input-file recfile-path))
  (define entries (list))
  (define (parse-file port)
    (define entry (recutils->alist port))
    (if (eq? 0 (length entry))
        entries
        ((lambda _
           (set! entries (append entries (list entry)))
           (parse-file port)))))
  (parse-file port))

(define-public (parse-status-recfile recfile-path)
  "Returns a list of release status records. Each record is an alist that
contains a record the given @var{recfile-path} which should be the path
of a file that contains such records (like a file in
resources/data/*.rec). See the Records section of the
recutils info manual for more details on records."
  (define port (open-input-file upstream-versions-recfile-path))
  (define entries (list))
  (define (parse-file port)
    (define entry (recutils->alist port))
    (if (eq? 0 (length entry))
        entries
        ((lambda _
           (set! entries (append entries (list entry)))
           (parse-file port)))))
  (parse-file port))

(define-public (list-values elm1 elm2)
  (append (list (cdr elm1)) elm2))

(define-public (list-list-values elm1 elm2)
  (append
   elm2
   (list (fold list-values '() (reverse elm1)))))

(define (get-defaults computer)
  "Returns a list of default values.
@var{computer} should contain an alists of the data of a given computer,
similar to one of the records in resources/data/computers-*.rec. See the Records
section of the recutils info manual for more details on records."
  (define (data-equals? key value)
    (string=?
     (assoc-ref computer key) value))

  (define gnuboot_grub
    (data-equals? "gnuboot_grub" "Yes"))
  (define gnuboot_seabios
    (data-equals? "gnuboot_seabios" "Yes"))
  (define gnuboot_high_resolution_graphics
    (data-equals? "gnuboot_high_resolution_graphics" "Yes"))
  (define gnuboot_text_only_low_resolution
    (data-equals? "gnuboot_text_only_low_resolution" "Yes"))

  (list
   (if (and gnuboot_grub gnuboot_high_resolution_graphics)
       "Untested"
       "Missing images")
   (if (and gnuboot_grub gnuboot_text_only_low_resolution)
       "Untested"
       "Missing images")
   (if (and gnuboot_seabios gnuboot_high_resolution_graphics)
       "Untested"
       "Missing images")
   (if (and gnuboot_seabios gnuboot_text_only_low_resolution)
       "Untested"
       "Missing images")))

;; guile-dsv's format-table table function supports several formats (like Org
;; Mode or Markdown but it doesn't have the format specific to Pandoc
;; Markdown.
(define-public pandoc-markdown
  '((name                . "pandoc-markdown")
    (description         . "Pandoc Markdown table.")
    (border-top          . "-")
    (border-top-left     . "+")
    (border-top-right    . "+")
    (border-top-joint    . "+")
    (border-left         . "|")
    (border-left-joint   . "+")
    (border-right        . "|")
    (border-right-joint  . "+")
    (row-separator       . "-")
    (row-joint           . "+")
    (column-separator    . "|")
    (border-bottom       . "-")
    (border-bottom-left  . "+")
    (border-bottom-right . "+")
    (border-bottom-joint . "+")
    ;; Header style.
    (header-top              . "-")
    (header-top-left         . "+")
    (header-top-right        . "+")
    (header-top-joint        . "+")
    (header-left             . "|")
    (header-right            . "|")
    (header-bottom           . "=")
    (header-bottom-left      . "|")
    (header-bottom-right     . "|")
    (header-bottom-joint     . "+")
    (header-column-separator . "|")))

;; The string-slice* function is based on string-slice from guile-dsv v0.7.2
;; which has the following copyright:
;;     Copyright (C) 2021-2023 Artyom V. Poptsov <poptsov.artyom@gmail.com>
;; It is also under the GPLv3 or later.
;;
;; I modified it to be able to produce the exact same line breaks than in
;; website/pages/status*.md.
;;
;; string-slice* is passed to format-table which uses it to break lines of
;; fields.
;;
;; For a field that has "+--------------+" above and below, the width is 12
;; for the field. The "Missing images" string length is 14 which is above
;; 12. So the string-slice function will run to split it.
;;
;; With "Missing images", the string-slice function provided by guile-dsv will
;; return ("Missing imag" "es") and so we will see "Missing imag" on the first
;; line and "es" on the second line. This is not what we want.
;;
;; So to look like the original table, we first identify if there is a coma
;; (',') between vendor and products (like "Technoetical, D16 with ECC RAM")
;; and we break line at this coma. We only break at the first coma, otherwise
;; we would have an issue with "Apple, MacBook 2,1".
;;
;; The next thing we do is to break on the last space that fits into the
;; width. For instance if we have "Asus, KCMA-D8 with non-ecc RAM" that must
;; fit in 16 characters lines, we don't want
;; ("Asus," KCMA-D8 with non" "-ecc RAM").
;; So we break it like that instead ("Asus," "KCMA-D8 with" "non-ecc RAM").
;;
;; But if we want to fit that into 12 characters lines instead, "KCMA-D8 with"
;; is 12 characters, so the algorithm above would produce
;; ("Asus," "KCMA-D8" "with" "non-ecc RAM"), so if the next character is a
;; space, we break on it instead of breaking on the previous space to finally
;; produce ("Asus," "KCMA-D8 with" "non-ecc RAM").
(define-public (string-slice* s width)
  "Slice a string S into parts of WIDTH length.  Return the list of strings."
  (if (or (zero? width) (= 0 (string-length s)))
      (list s)
      (let ((slen (string-length s)))
        (let loop ((idx    0)
                   (result '()))
          (let ((skip (string-skip (substring s idx) #\ )))
            (if (> skip 0)
                (set! idx (+ idx 1))))

          (if (>= (+ idx width) slen)
              (reverse (cons
                        (string-append
                         (string-copy s idx slen)
                         (string-join
                          (make-list (- (+ idx width) slen) " ") ""))
                        result))
              (let ((first-coma (string-index s #\, idx (+ idx width)))
		    (last-coma (string-rindex s #\, idx (+ idx width)))
                    (last-space (string-index-right s #\  idx (+ idx width))))
                (cond
                 ((and first-coma (< idx first-coma) (<= (+ first-coma 1) slen)
		       (<= (+ last-coma 1) slen))
                  (loop (+ last-coma 1)
                        (cons
			 (string-copy
			  s idx
			  (+ last-coma 1))
			 result)))
		 ((and first-coma (< idx first-coma) (<= (+ first-coma 1) slen))
                  (loop (+ first-coma 1)
                        (cons (string-copy s idx (+ first-coma 1)) result)))

                 ((and (> slen (+ idx width))
                       (eqv? #\  (string-ref s (+ idx width))))

                  (loop (+ idx width)
                        (cons (string-copy s idx (+ idx width)) result)))

                 (last-space
                  (loop (+ last-space 1)
                        (cons (string-copy s idx (+ last-space 1)) result)))

                 (else
                  (loop (+ idx width)
                        (cons (string-copy s idx (+ idx width)) result))))))))))

;; TODO: handle errors
(define-public (setup-translations language)
  ""
  (cond ((string=? language "es")
         (setlocale LC_ALL "es_ES.UTF-8")
         (bindtextdomain
          "gnuboot-generate-markdown-status-table"
          "status/locale")
         (textdomain "gnuboot-generate-markdown-status-table"))))
