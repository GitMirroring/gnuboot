#!/usr/bin/env -S guile -e main -s
!#
;; Copyright (C) 2024-2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

(define (append-results results kv-list)
  (fold (lambda (cur prev)
          (acons (car cur) (cdr cur) prev))
        results
        kv-list))

(define (startswith str value)
  (if (>= (string-length str) (string-length value))
      (string=? (substring str 0 (string-length value)) value)
      #f))

(define (endswith str value)
  (if (>= (string-length str) (string-length value))
      (string=?
       (substring str
                  (- (string-length str) (string-length value))
                  (string-length str))
       value)
      #f))

(define (read-file path func)
  (define results #f)
  (let ((port (open-input-file path)))
    (set! results (func path port))
    (close-port port)
    results))

(define (get-git-commit-hash revision)
  (let* ((command (string-join
                   (list
                    "git"
                    "--no-pager"
                    "show"
                    "--no-patch"
                    "--pretty=%H"
                    revision) " "))
         (port (open-input-pipe command))
         (line (read-line port))
         (file-hash line))
    (close-pipe port)
    file-hash))

(define (get-git-file-hash commit-hash path)
  (let* ((command
          (string-join
           (list "git" "--no-pager" "ls-tree" commit-hash "--" path) " "))
         (port (open-input-pipe command))
         (line (read-line port))
         (split-line
          (string-split
           line
           (lambda (c) (or (eqv? c #\ ) (eqv? c #\tab)))))
         (file-hash (list-ref split-line 2)))
    (close-pipe port)
    file-hash))

(define (read-file-from-commit commit-hash)
  "Run FUNC on the content of PATH at git COMMIT-HASH"
  (lambda (path func)
    (define results #f)
    (let* ((file-hash (get-git-file-hash commit-hash path))
           (command (string-join (list "git" "--no-pager" "show" file-hash) " "))
           (port (open-input-pipe command)))
      (set! results (func path port))
      (close-port port)
      results)))

(define (print-file-name path)
  (define dashes
    (string-append
     (string-join (make-list (string-length path) "-") "")
     "\n"))
  (display dashes)
  (display (string-append path "\n"))
  (display dashes))

(define (file-exists-at-commit? commit path)
  (not (eof-object?
        (let*
            ((port
              (open-pipe*
               OPEN_READ
               "git" "--no-pager" "ls-tree" commit "--" path))
             (str (read-line port)))
          str))))

(define (patch-modified-file? parse-results file-path)
  (not (nil?
        (filter
         (lambda (modified-file-path)
           (string=? modified-file-path file-path))
         (assq-ref parse-results 'modified-files)))))

(define (extract-author-and-email line)
  "Extract author and email in an 'Author <email>' line. This will
preserve spaces and return a list containing the author string and
email string (without the '<' and '>')."
  (let* ((email-end (string-rindex line #\>))
         (email-start
          (if (and (string-rindex line #\<)
                   (> (string-length line)
                      (+ 1 (string-rindex line #\<))))
              (+ 1 (string-rindex line #\<))
              #f))
         (email-start
          (if (and email-start email-end
                   (> email-end email-start))
              email-start
              #f))
         (email-end
          (if (and email-start email-end
                   (> email-end email-start))
              email-end
              #f))
         (email
          (if (and email-start email-end)
              (substring line email-start email-end)
              #f))
         (author
          (if email
              ;; At email-start -1 we have the '<' and at email-start -2 we
              ;; have a space between the author and the email.
              (if (and email-start (> email-start 2))
                  (substring line 0 (- email-start 2))
                  #f)
              line))
         (author
          (if (or (not author) (string=? author ""))
              #f
              author)))
    (cons author email)))

;; Automatic tests for extract-author-and-email.
(assert
 (equal?
  (extract-author-and-email "Jason Self")
  (cons "Jason Self" #f)))

(assert
 (equal?
  (extract-author-and-email "<info@minifree.org>")
  (cons #f "info@minifree.org")))

(assert
 (equal?
  (extract-author-and-email "")
  (cons #f #f)))

(define (scheme-file? path)
  "Returns #t if it's a scheme file, returns #f otherwise."
  (or
   (endswith path ".scm")
   (string=? (basename path) ".guix-authorizations")
   (string=? path "resources/distros/guix/bordeaux.guix.gnu.org.pub")))

(define (xml-file? path)
  "Returns #t if it's an XML file, returns #f otherwise."
  (or
   (endswith path ".xml")
   (endswith path ".svg")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                     ;;
;;                   ;; Copyright header parsing logic ;;                     ;;
;;                   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                     ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (file-should-have-copyrights? path)
  (cond
   ;; Both files are generated and their source have proper
   ;; copyright information. The generated files lack copyright
   ;; information as they are included as-is, as commands to
   ;; type, in the manual.
   ((or (string=? path "manual/build-guix-i686-linux.sh")
        (string=? path "manual/build-guix-x86_64-linux.sh"))
    #f)

   ;; Not copyrightable. Trademarks should apply though.
   ((string=? path "projectname")
    #f)

   ;; No way to add comments yet in Coreboot blobs.list yet. TODO: Add
   ;; the ability to add comments inside.
   ((and (startswith path "resources/coreboot/")
         (string=? (basename path) "blobs.list"))
    #f)

   ;; We probably can't encode copyright information in these anyway.
   ((and (startswith path "resources/grub/keymap/")
         (endswith (basename path) ".gkb"))
    #f)

   ;; We probably don't want comments in them as they are generated by
   ;; Kconfig.
   ((or (and (startswith path "resources/coreboot/")
             (string=? (basename path) "corebootfb"))
        (and (startswith path "resources/coreboot/")
             (string=? (basename path) "corebootfb.debug"))
        (and (startswith path "resources/coreboot/")
             (string=? (basename path) "txtmode"))
        (and (startswith path "resources/coreboot/")
             (string=? (basename path) "txtmode.debug"))
        (string=? (dirname path) "resources/seabios/config"))
    #f)

   ;; Checksums are not copyrightable. So here we assume that
   ;; the files won't contain comments. So far all the checksum
   ;; file extensions below come from tools that end in 'sum',
   ;; like 'md5sum' and that are part of the GNU coreutils.
   ((or (endswith path ".b2sum")
        (endswith path ".cksum")
        (endswith path ".md5")
        (endswith path ".sha1")
        (endswith path ".sha224")
        (endswith path ".sha256")
        (endswith path ".sha384")
        (endswith path ".sha512")
        (endswith path ".sum"))
    #f)

   ;; TODO: tests/checkpatch doesn't support yet comments in these
   ;; files.
   ((and
     (string=? (dirname path) "tests")
     (endswith (basename path) ".ref"))
    #f)

   ;; TODO: for now we don't check pictures, but in the longer run we
   ;; could probably add the copyright inside each picture (like with
   ;; EXIF, or similar), if the format used supports that.
   ((or (endswith path ".JPG")
        (endswith path ".PNG")
        (endswith path ".gif")
        (endswith path ".jpeg")
        (endswith path ".jpg")
        (endswith path ".png"))
    #f)

   ;; If we add HTML comments in these files, it would automatically
   ;; be included in all other HTML files which could results in the
   ;; wrong copyright information in the resulting HTML file.
   ((or (string=? path "website/pages/footer.include.tmpl")
        (string=? path "website/pages/template.include"))
    #f)

   ;; File included in the generated site map HTML file.
   ((string=? path "website/pages/sitemap.include")
    #f)

   ;; So far we don't need to check any texinfo files for missing
   ;; copyright headers as the copyright are properly declared inside
   ;; the manual/gnuboot.texi file. TODO: still implement parsing of
   ;; .texi files to detect missing years in copyright headers.
   ((endswith path ".texi") #f)

   ;; I've no idea if we can add comment in these files or not but the
   ;; copyright should go in resources/debian/copyright anyway.
   ((or (string=? path "resources/debian/changelog")
        (string=? path "resources/debian/control")
        (string=? path "resources/debian/rules")
        (string=? path "resources/debian/source/format"))
    #f)

   ;; Avoid checking licenses. TODO: try to identify and whitelist
   ;; license files somehow to make sure there is no extra text in
   ;; them, and if there is to whitelist them once their copyrights
   ;; have been checked and/or added.
   ((or (string=? (basename path) "COPYING")
        (string=? (basename path) "LICENSE"))
    #f)

   ;; We don't want copyrights information inside these files.
   ((or (endswith path ".log")
        (string=? path "website/hwdumps/x200/codec#0")
        (string=? path "website/hwdumps/x200/pin_hwC0D0"))
    #f)

   ;; TODO: for now we don't check text file, but in the longer run
   ;; we could probably find a way to add copyright inside each them
   ;; in a way that is parsable.
   ((or (endswith path ".log")
        (endswith path ".md")
        (endswith path ".txt")
        (string=? (basename path) "README")
        (string=? (basename path) "README.debug"))
    #f)

   (else #t)))

(define (copyright-line? line)
  (define copyright-regex
    "Copyright (©|\\(C\\)|\\(c\\)) [0-9]{4}*")
  (if
   (string-match copyright-regex line)
   #t
   #f))

(define* (copyright-header?
          path line-nr line data
          #:key (ignore-empty-lines #f))
  "Returns #t if the LINE is part of the file header. If an empty line
is found, it will return the IGNORE_EMPTY_LINES value. The DATA
argument should be a hash table of size 1 * number of paths that is
passed accross multiple calls of copyright-header?."
  (cond
   ((scheme-file? path)
    (cond ((eq? line-nr 1)
             (hashq-set! data (string->symbol path) line)
           (or (startswith line "#!/usr/bin/env -S guile ")
               (startswith line ";")
               (if ignore-empty-lines
                   (string=? line "")
                   #f)))
          ((and (eq? line-nr 2)
                (assq-ref data path)
                (startswith (hashq-ref data (string->symbol path)) ";"))
           (or (startswith line ";")
               (if ignore-empty-lines
                   (string=? line "")
                   #f)))
          ((and (eq? line-nr 2)
                (startswith (hashq-ref data (string->symbol path))
                            "#!/usr/bin/env -S guile "))
           (or (string=? line "!#")
               (if ignore-empty-lines
                   (string=? line "")
                   #f)))
          (else (or (startswith line ";")
                    (if ignore-empty-lines
                        (string=? line "")
                        #f)))))
   ((endswith path ".css")
    (cond ((eq? line-nr 1)
           (hashq-set! data (string->symbol path) line)
           (string=? line "/*"))
          ((eq? line-nr 2)
           (let ((prev (hashq-ref data (string->symbol path))))
             (hashq-set! data (string->symbol path) line)
             (and
              (string=? prev "/*")
              (or (string=? line " *")
                  (startswith line " * ")))))
          ((or (string=? (hashq-ref data (string->symbol path)) " *")
               (startswith (hashq-ref data (string->symbol path)) " * "))
           (hashq-set! data (string->symbol path) line)
           (or (string=? line " *")
               (startswith line " * ")
               (string=? line " */")))
          (else
           #f)))
   ((xml-file? path)
    (define (intermediate-start-line? line)
      (or (startswith line (make-string 5 #\ ))
          (string=? line "")))
    (cond
     ;; First line found
     ((string=? line "<!--")
      (hashq-set! data (string->symbol path) line)
      #t)
     ;; Second line found
     ((and (hashq-ref data (string->symbol path))
           (string=? (hashq-ref data (string->symbol path)) "<!--"))
      (hashq-set! data (string->symbol path) line)
      (intermediate-start-line? line))
     ;; Last line found
     ((and
       (hashq-ref data (string->symbol path))
       (intermediate-start-line? (hashq-ref data (string->symbol path)))
       (string=? line "  -->"))
      (hashq-set! data (string->symbol path) line)
      #t)
     ;; Intermediate line found
     ((and
       (hashq-ref data (string->symbol path))
       (intermediate-start-line? (hashq-ref data (string->symbol path)))
       (not (string=? line "  -->")))
      (hashq-set! data (string->symbol path) line)
      #t)
     ;; There are usually other lines before the copyright header like
     ;; <?xml [...]>. We want to skip these to be able to later on
     ;; find the real starting line. Note that we also don't handle
     ;; single line comments <!-- [...] --> on purpose as they are too
     ;; short to contain proper copyright information, so these will
     ;; be skipped too.
     ((eq? (hashq-ref data (string->symbol path)) #f)
      'skip)
     ;; After the final -->. This requires to have the copyright
     ;; information in the first multi-line comment. It is possible to
     ;; implement some sort of 'EAGAIN if nothing is found but the
     ;; copyright information is usually in the first multi-line
     ;; comment so we want to require that for consistency, so there
     ;; is no point in doing such implementation.
     (else
      #f)))
   ;; Simple path-based rules
   (else
    (let ((comment
           (cond
            ;;;;;;;;;;;;;;;;;;;;;
            ;; File extensions ;;
            ;;;;;;;;;;;;;;;;;;;;;
            ((endswith path ".ac") "#")
            ((endswith path ".am") "#")
            ((endswith path ".dot") "#")
            ((endswith path ".gitignore") "#")
            ((endswith path ".py") "#")
            ((endswith path ".service") "#")
            ((endswith path ".sh") "#")
            ((endswith path ".sh.in") "#")
            ;;;;;;;;;;;
            ;; Paths ;;
            ;;;;;;;;;;;
            ((endswith path "/modify/configs") "#")
            ((endswith path "/update/configs") "#")
            ((startswith path "resources/dependencies/") "#")
            ((startswith path "resources/packages/u-boot-libre/") "#")
            ((string=? (basename path) "board.cfg") "#")
            ((string=? (basename path) "boot") "#")
            ((string=? (basename path) "build") "#")
            ((string=? (basename path) "clean") "#")
            ((string=? (basename path) "distclean") "#")
            ((string=? (basename path) "download") "#")
            ((string=? (basename path) "grub.cfg") "#")
            ((string=? (basename path) "modify") "#")
            ((string=? (basename path) "module") "#")
            ((string=? (basename path) "payload") "#")
            ((string=? (basename path) "preseed.cfg") "#")
            ((string=? (basename path) "release") "#")
            ((string=? (basename path) "test") "#")
            ((string=? (basename path) "update") "#")
            ((string=? path "resources/debian/rules") "#")
            ((string=? path "resources/grub/config/grub_memdisk.cfg") "#")
            ((string=? path "resources/grub/modules.list") "#")
            ((string=? path "resources/packages/dependencies/install") "#")
            ((string=? path "resources/scripts/misc/versioncheck") "#")
            ((string=? path "resources/wrapper/git") "#")
            ((string=? path "resources/wrapper/gitconfig") "#")
            ((string=? path "resources/wrapper/guix") "#")
            ((string=? path "tests/checkpatch") "#")
            ((string=? path "tests/lint") "#")
            ((string=? path "tests/targets") "#")
            ((string=? path "tests/u-boot-libre") "#")
            ((string=? path "website/lighttpd.conf.tmpl") "#")
            ((string=? path "website/site.cfg.tmpl") "#")
            ((string=? path "website/symlinks/symlinks.txt") "#")
            ;;;;;;;;;;
            ;; Else ;;
            ;;;;;;;;;;
            (else #f))))
      (if comment
          (or (startswith line comment)
              (if ignore-empty-lines
                  (string=? line "")
                  #f))
          #f)))))

;; TODO: should we use (guix records) instead of srfi-9 records? It
;; would bring sanitizer to make sure for instance the copyright years
;; are valid integers and represent a valid year. In practice this
;; means that we could add many checks directly in the record. The
;; downside is that it would also require to have Guix installed as a
;; dependency, and the GNU Boot website is for now supposed to be
;; built without Guix, not only to make it easy to package, but also
;; to not require new contributors to have to wait for a guix pull
;; that now runs twice.
(define-record-type <copyright-notice>
  (make-copyright-notice author email years patch file-path line)
  copyright-notice?
  ;; Author and/or copyright-notice owner name
  (author copyright-notice-author set-copyright-notice-author!)
  ;; Author and/or copyright-notice owner email
  (email  copyright-notice-email  set-copyright-notice-email!)
  ;; List of copyright-notice years
  (years  copyright-notice-years  set-copyright-notice-years!)
  ;; For debugging
  (patch   copyright-notice-patch   set-copyright-notice-patch!)
  (file-path   copyright-notice-file-path   set-copyright-notice-file-path!)
  (line   copyright-notice-line   set-copyright-notice-line!))

(define (append-copyright-notice-years old new)
  (assert (or (string? (copyright-notice-author old))
              (eq? (copyright-notice-author old) #f)))
  (assert (or (string? (copyright-notice-email old))
              (eq? (copyright-notice-email old) #f)))
  (assert (equal? (copyright-notice-author old)
                  (copyright-notice-author new)))
  (assert (equal? (copyright-notice-email old)
                  (copyright-notice-email new)))
  (assert (equal? (copyright-notice-patch old)
                  (copyright-notice-patch new)))
  (assert (equal? (copyright-notice-file-path old)
                  (copyright-notice-file-path new)))
  (make-copyright-notice
   (copyright-notice-author old)
   (copyright-notice-email  old)
   (append (copyright-notice-years old) (copyright-notice-years new))
   (copyright-notice-patch old)
   (copyright-notice-file-path old)
   (copyright-notice-line old)))

(define (parse-copyright-line patch file-path line)
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

  (define (extract-dates line results)
    "Extract dates from LINE and return a list containing a
copyright-notice record and the (unparsed) rest of the line."
    (let* ((date-range (string-match "[0-9]{4}-[0-9]{4}[ ,]" line))
           (single-date (string-match "[0-9]{4}[ ,]" line))
           (date-match-data
            (cond
             ((and date-range single-date
                   (< (match:start date-range)
                      (match:start single-date)))
              (cons
               (make-copyright-notice
                #f
                #f
                (extract-date-range date-range)
                patch file-path line)
               (substring line (match:end date-range))))
             ((and date-range single-date
                   (< (match:start single-date)
                      (match:start date-range)))
              (cons
               (make-copyright-notice
                #f
                #f
                (extract-single-date single-date)
                patch file-path line)
               (substring line (match:end single-date))))
             (date-range
              (cons
               (make-copyright-notice
                #f
                #f
                (extract-date-range date-range)
                patch file-path line)
               (substring line (match:end date-range))))
             (single-date
              (cons
               (make-copyright-notice
                #f
                #f
                (extract-single-date single-date)
                patch file-path line)
               (substring line (match:end single-date))))
             (else
              #f))))

      (if date-match-data
          (extract-dates
           (cdr date-match-data)
           (if (not results)
               (car date-match-data)
               (append-copyright-notice-years
                results
                (car date-match-data))))
          (list results line))))

  (let* ((results (extract-dates line #f))
         (notice (car results))
         ;; TODO: transform in cons to be able to do cdr
         (line (cadr results))
         (author-and-email (extract-author-and-email line))
         (author (car author-and-email))
         (email  (cdr author-and-email)))
      (set-copyright-notice-author! notice author)
      (set-copyright-notice-email!  notice email)
    notice))

      (define (author-email-year-in-copyright-notice? notice author email year)
        "Returns #t if the given author and email match the one in the NOTICE
and if the year is included in the list of years in the
notice. Returns #f otherwise."
        (and (if (and author (copyright-notice-author notice))
                 (string=? author (copyright-notice-author notice))
                 ;; Handle cases when author is #f
                 (eq? author (copyright-notice-author notice)))
             (if (and email (copyright-notice-email notice))
                 (string=? email (copyright-notice-email notice))
                 ;; Handle cases when email is #f
                 (eq? email (copyright-notice-email notice)))
             (any
              (lambda (elm) (eq? year elm)) (copyright-notice-years notice))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;                         ;;
;;                        ;; Texinfo parsing logic ;;                         ;;
;;                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;                         ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (handle-texinfo-node-type prefix type check-results)
  (define warnings (assq-ref check-results 'warnings))
  (define* (node-name line prefix type)
    (define match
      (if (string=? prefix "")
          (string-match (string-append "@" type " +") line)
          (string-match (string-append "\\" prefix "@" type " +") line)))
    (regexp-substitute
     #f
     match
     'post))

  (define current-node-name
    (substring
     (assq-ref check-results 'current-node)
     (string-length prefix)
     (string-length (assq-ref check-results 'current-node))))

  (lambda (line parse-results check-results)
    (if
     (and
      (string=?
       (node-name line prefix type)
       (node-name
        (string-append prefix current-node-name)
        prefix
        "node"))
      (not
       (= (string-length
           (substring line (string-length prefix) (string-length line)))
          (string-length
           current-node-name))))
     ((lambda _
        (display
         (string-append
          "WARNING: " (node-name line prefix type)
          " " type " and node are not aligned.\n\n"))
        (+ 1 warnings)))
     warnings)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                   ;;
;;                  ;; Rules definition and applications ;;                   ;;
;;                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                   ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-record-type <rule>
  (make-rule name default line-match line end)
  rule?
  (name       rule-name)       ;; Name of the rule
  (default    rule-default)    ;; Runs once at the beginning, inconditionally
  (line-match rule-line-match) ;; Runs each line, returns true/false
  (line       rule-line)       ;; Runs if rule-line-match is true
  (end        rule-end))       ;; Runs once at the end, inconditionally

(define (set-defaults context rules path parse-results results)
  (for-each
   (lambda (rule)
     (set! results ((rule-default rule) context path parse-results results)))
   rules)
  results)

(define (run-line-match-rules context port rules path parse-results results)
  (define line (read-line port))
  (if (eof-object? line)
      results
      ((lambda _
         (for-each
          (lambda (rule)
            (if ((rule-line-match rule) context path line parse-results results)
                (set! results
                      ((rule-line rule)
                       context path line parse-results results))))
          rules)
         (run-line-match-rules
          context port rules path parse-results results)))))

(define (run-end-rules context path rules other-results results)
  (for-each
   (lambda (rule)
     (set! results ((rule-end rule) context path other-results results)))
   rules)
  results)

(define (run-parse-rules read-func context rules path)
  (read-func
   path
   (lambda (path port)
     (let* ((defaults (set-defaults context rules path #f '()))
            (results (run-line-match-rules
                      context port rules path #f defaults)))
     (run-end-rules context path rules #f results)))))

(define (run-check-rules read-func context parse-results rules path)
  (read-func
   path
   (lambda (path port)
     (let* ((defaults (set-defaults context rules path parse-results '()))
            (check-results
             (run-line-match-rules
              context port rules path parse-results defaults)))
     (run-end-rules context path rules parse-results check-results)))))

(define (test-patch read-func parse-context check-context path)
  (let* ((parse-results
          (run-parse-rules
           read-func
           parse-context
           patch-parse-rules path))
         (check-results
          (run-check-rules
           read-func
           check-context
           parse-results patch-check-rules path)))
    check-results))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                         ;;;;;;;;;;;;;;;;;;;;;;;;;                          ;;
;;                         ;; Patch parsing logic ;;                          ;;
;;                         ;;;;;;;;;;;;;;;;;;;;;;;;;                          ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define patch-parse-rules
  (list
   ;; Here's an example of a parse rule below. Since it runs each time it is
   ;; also tested. TODO: A a proper unit testing environment needs to
   ;; be added and then this could be moved to only run inside that
   ;; separate testing environment.
   (make-rule
    "Example empty rule"
    (lambda (context path _ results) results)
    (lambda (context path line _ results) #t)
    (lambda (context path line _ results) results)
    (lambda (context path _ results) results))

   (make-rule
    "Count lines"
    (lambda (context path _ results)
      (acons 'line 0 results))
    (lambda (context path line _ results) #t)
    (lambda (context path line _ results)
      (acons 'line (+ 1 (assq-ref results 'line)) results))
    (lambda (context path _ results) results))

   (make-rule
    "Find diff start"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (startswith line "diff --git "))
    (lambda (context path line _ results)
      (acons 'diff-start (assq-ref results 'line) results))
    (lambda (context path _ results) results))

   (make-rule
    "Retrieve Signed-off-by"
    (lambda (context path _ results)
      (acons 'signed-off-by '() results))
    (lambda (context path line _ results)
      (startswith line "Signed-off-by: "))
    (lambda (context path line _ results)
      (let ((signed-off-by
             (string-join (cdr (string-split line #\ )) " ")))
        (acons 'signed-off-by
               (append (assq-ref results 'signed-off-by) (list signed-off-by))
               results)))
    (lambda (context path _ results) results))

   ;; TODO: Raise an exception if there is no lines with From:, and
   ;; when handling it, complain that the file is not a valid git
   ;; patch.
   (make-rule
    "Find commit author and email"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (startswith line "From: "))
    (lambda (context path line _ results)
      (let* ((commit-author-and-email
              (extract-author-and-email
               (string-join (cdr (string-split line #\ )) " "))))
        (append-results
         results
         (list
          (cons 'commit-author (car commit-author-and-email))
          (cons 'commit-email  (cdr commit-author-and-email))))))
    (lambda (context path _ results) results))

   (make-rule
    "Find commit hash"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      ;; Example:
      ;; From 0df4fe5fadfb7f51c1c34dad10ca9e6e04c3fa18 Mon Sep 17 00:00:00 2001
      (and (not (startswith line "From: "))
           (startswith line "From ")
           ;; We only want to match the first result, otherwise a 'From [...]
           ;; within the commit message will match.
           (not (assq-ref results 'commit-hash))))
    (lambda (context path line _ results)
      (let ((commit-hash (list-ref (string-split line #\ ) 1)))
        (acons 'commit-hash commit-hash results)))
    (lambda (context path _ results) results))

   ;; TODO: Raise an exception if there is no lines with Date:, and
   ;; when handling it, complain that the file is not a valid git
   ;; patch.
   (make-rule
    "Find commit date"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (startswith line "Date: "))
    (lambda (context path line _ results)
      (acons 'commit-date
             (string->date
              (string-join (cdr (string-split line #\ )) " ")
              "~a, ~d ~b ~Y ~H:~M:~S ~z")
             results))
    (lambda (context path _ results) results))

   ;; TODO:
   ;; - In general we might want to have the commit summary instead of
   ;;   the subject, but for now we will use the mail subject instead
   ;;   as we don't use the summary yet and properly parsing the
   ;;   subject would require to reimplement the cleanup_subject
   ;;   function from mailinfo.c in git source code.
   ;; - Raise an exception if there is no lines with From:, and when
   ;;   handling it, complain that the file is not a valid git patch.
   (make-rule
    "Find patch subject"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (startswith line "Subject: "))
    (lambda (context path line _ results)
      (let ((commit-subject (string-join (cdr (string-split line #\ )) " ")))
        (append-results
         results
         (list
          (cons 'commit-subject-line (assq-ref results 'line))
          (cons 'commit-subject      commit-subject)))))
    (lambda (context path _ results) results))

   (make-rule
    "Find commit subject and message separator"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      ;; TODO: Raise an exception if the line after the commit subject
      ;; line is not empty, and when handling it, complain that the
      ;; file is not a valid git patch.
      (and
       (not (assq-ref results 'commit-message-end-line))
       (assq-ref results 'commit-subject)
       (string=? line "")
       (eq? (+ 1 (assq-ref results 'commit-subject-line))
            (assq-ref results 'line))))
    (lambda (context path line _ results)
      (acons 'commit-subject-message-separator-line
             (assq-ref results 'line)
             results))
    (lambda (context path _ results) results))

   ;; TODO: Raise an exception if there is more than two lines with
   ;; ---, and when handling it, complain that the file is not a valid
   ;; git patch.
   (make-rule
    "Find changelog end"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (and
       (assq-ref results 'commit-message-end-line)
       (string=? line "---")))
    (lambda (context path line _ results)
      (acons 'changelog-end-line (assq-ref results 'line) results))
    (lambda (context path _ results) results))

   ;; TODO: Raise an exception if there is no line with ---, and when
   ;; handling it, complain that the file is not a valid git patch.
   (make-rule
    "Find commit message end"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      ;; This matches the first "---" but there could be more as shown
      ;; in the example below:
      ;;     ---
      ;;     ChangeLog: [...]
      ;;     ---
      ;; So until found we are in the commit message, but after it is found
      ;; we could also be in the ChangeLog.
      (and (string=? line "---")
           (not (assq-ref results 'commit-message-end-line))))
    (lambda (context path line _ results)
          (acons 'commit-message-end-line (assq-ref results 'line) results))
    (lambda (context path _ results) results))

   (make-rule
    "Find the end of the commit"
    (lambda (context path _ results) results)
    (lambda (context path line _ results) #f)
    (lambda (context path line _ results) results)
    (lambda (context path _ results)
      (acons 'commit-end-line
             (if (assq-ref results 'changelog-end-line)
                 (assq-ref results 'changelog-end-line)
                 (assq-ref results 'commit-message-end-line))
             results)))

   (make-rule
    "Find commit message"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (and
       (not (assq-ref results 'commit-message-end-line))
       (assq-ref results 'commit-subject-message-separator-line)
       (> (assq-ref results 'line)
          (assq-ref results 'commit-subject-message-separator-line))))
    (lambda (context path line _ results)
      (let ((commit-message
             (if (not (assq-ref results 'commit-message))
                 (list)
                 (append (assq-ref results 'commit-message) (list line)))))
        (acons 'commit-message commit-message results)))
    (lambda (context path _ results) results))

   (make-rule
    "Find added files"
    (lambda (context path _ results)
      (acons 'added-files '() results))
    (lambda (context path line _ results)
      (and (startswith line " create mode ")))
    (lambda (context path line _ results)
      (define line-parts
        (string-split line #\space))
      (define added-file
        '())
      (if (> (length line-parts) 3)
          (set! added-file
                (list (list-ref line-parts 4))))
      (acons 'added-files
             (append (assq-ref results 'added-files) added-file)
             results))
    (lambda (context path _ results) results))

   (make-rule
    "Find deleted files"
    (lambda (context path _ results)
      (acons 'deleted-files '() results))
    (lambda (context path line _ results)
      (and (startswith line " delete mode ")))
    (lambda (context path line _ results)
      (define line-parts
        (string-split line #\space))
      (define deleted-file
        '())
      (if (> (length line-parts) 3)
          (set! deleted-file
                (list (list-ref line-parts 4))))
      (acons 'deleted-files
             (append (assq-ref results 'deleted-files) deleted-file)
             results))
    (lambda (context path _ results) results))

   (make-rule
    "Find modified files and track current file diff"
    (lambda (context path _ results)
        (append-results
         results
         (list
          (cons 'current-diff-file #f)
          (cons 'modified-files '()))))
    (lambda (context path line _ results)
      (startswith line "diff --git a/"))
    (lambda (context path line _ results)
      (define line-parts (string-split line #\space))
      (define current-diff-file #f)
      (define modified-file     '())
      (if (> (length line-parts) 3)
          ;; Example: b/www/x60t_unbrick/0009.JPG
          (let* ((part3 (list-ref line-parts 3))
                 ;; remove the b/
                 (path (substring part3 2
                                  (string-length part3))))
            (set! current-diff-file path)
            (if (not (or (any (lambda (added-file-path)
                                (string=? added-file-path path))
                              (assq-ref results 'added-files))
                         (any (lambda (deleted-file-path)
                                (string=? deleted-file-path
                                          path))
                              (assq-ref results 'deleted-files))))
                (set! modified-file
                      (list path)))))
        (append-results
         results
         (list
          (cons 'modified-files
                (append (assq-ref results 'modified-files) modified-file))
          (cons 'current-diff-file current-diff-file))))
    (lambda (context path _ results) results))

   (make-rule
    "Track diff"
    (lambda (context path _ results) results)
    (lambda (context path line _ results) #t)
    (lambda (context path line _ results)
      (define diff-start 0)
      (define diff-end   0)
      (if (and (assq-ref results
                         'current-diff-file)
               (startswith line "@@"))
          (set! diff-start
                (assq-ref results
                          'line)))
      (if (startswith line "diff --git a/")
          (set! diff-end
                (assq-ref results
                          'line)))
      (if (and (not (eq? diff-start 0))
               (not (eq? diff-end 0)))
          (acons 'diff-end diff-end
                 (acons 'diff-start diff-start results))
          (if (not (eq? diff-start 0))
              (acons 'diff-start diff-start results)
              (acons 'diff-end diff-end results))))
    (lambda (context path _ results) results))

   ;; We can also use rules for debugging the code, here are two
   ;; examples below.

   ;; (make-rule
   ;;  "Debug: print lines."
   ;;  (lambda (context path _ results) results)
   ;;  (lambda (context path line _ results) #t)
   ;;  (lambda (context path line _ results)
   ;;    (display "Count lines: line #")
   ;;    (display (+ 1 (assq-ref results 'line)))
   ;;    (display (string-append ": " line "\n"))
   ;;    results)
   ;;  (lambda (context path _ results) results))

   ;; (make-rule
   ;;  "Debug: print results."
   ;;  (lambda (context path _ results) results)
   ;;  (lambda (context path line _ results) #f)
   ;;  (lambda (context path line _ results) results)
   ;;  (lambda (context path _ results)
   ;;    (pk results)
   ;;    results))
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                             ;;;;;;;;;;;;;;;;;;                             ;;
;;                             ;; Patch checks ;;                             ;;
;;                             ;;;;;;;;;;;;;;;;;;                             ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define patch-check-rules
  (list

   ;; Here's an example of a check rule below. Since it runs each time it is
   ;; also tested. TODO: A a proper unit testing environment needs to
   ;; be added and then this could be moved to only run inside that
   ;; separate testing environment.
   (make-rule
    "Example empty rule"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check if the patch commit hash is in git"
    (lambda (context path parse-results check-results)
      (define commit-hash (assq-ref parse-results 'commit-hash))
      (define void-port (%make-void-port OPEN_WRITE))
      (define (return value) (close void-port) value)
      (define (commit-hash-in-git? hash)
        ;; The documentation (man 7 gitrevisions) shows that the
        ;; format is not very strict, so we can't ever pass a revision
        ;; to a shell. So (1) we check everything, and (2) we use
        ;; functions that run programs without using a shell. Note
        ;; that it's still possible to bypass the check by using a
        ;; maliciously crafted revision like 'HEAD', however here we
        ;; rely on the good faith of contributors and they are even
        ;; encouraged to run checkpatch.scm themselves.
        (cond
         ((not (= EXIT_SUCCESS
                 (with-output-to-port
                     void-port
                   (lambda _
                     (system* "git"
                              "--no-pager"
                              "rev-parse"
                              "-q"
                              "--verify"
                              hash)))))
          (return #f))
         ;; Then we check if the hash is in the current git repository.
         ((= EXIT_SUCCESS
            (with-output-to-port
                   void-port
              (lambda _
                (system* "git"
                         "--no-pager"
                         "rev-list"
                         "--quiet"
                         "-1"
                         hash))))
          (return #t))
         (else (return #f))))

      (cond ((not commit-hash)
             (display "Error: the patch has no commit hash.\n")
             (exit 69)) ;; 69 is EX_UNAVAILABLE in sysexits.h
            ((not (commit-hash-in-git? commit-hash))
             (display
              (string-append
               "Error: the patch commit hash (" commit-hash ") is not\n"
               "       in git. To fix it, you need to import the patche(s) "
               "with the following\n"
               "       command:\n"
               "       git am " path "\n"
               "       However if this patch depends on other patches, "
               "you will also need to\n"
               "       import them before with git am as well.\n"))
             (exit 69)) ;; 69 is EX_UNAVAILABLE in sysexits.h
            (else check-results)))
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Count lines"
    (lambda (context path parse-results check-results)
      (acons 'line 0 check-results))
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results)
      (acons 'line (+ 1 (assq-ref check-results 'line)) check-results))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Track current file diff"
    (lambda (context path parse-results check-results)
      (acons 'current-diff-file #f check-results))
    (lambda (context path line parse-results check-results)
      (startswith line "diff --git a/"))
    (lambda (context path line parse-results check-results)
      (define line-parts (string-split line #\space))
      (define current-diff-file #f)
      (if (> (length line-parts) 3)
          ;; Example: b/www/x60t_unbrick/0009.JPG
          (let* ((part3 (list-ref line-parts 3))
                 ;; remove the b/
                 (path (substring part3 2
                                  (string-length part3))))
            (set! current-diff-file path)))
      (acons 'current-diff-file current-diff-file check-results))
    (lambda (context path _ check-results) check-results))

   ;; Workarround for the bug #66268
   ;; [1]https://debbugs.gnu.org/cgi/bugreport.cgi?bug=66268
   (make-rule
    "Enforce commit size < 4KB"
    (lambda (context path parse-results check-results)
      (acons 'commit-size 0 check-results))
    (lambda (context path line parse-results check-results)
      (< (assq-ref check-results 'line)
         (assq-ref parse-results 'commit-end-line)))
    (lambda (context path line parse-results check-results)
      (acons 'commit-size
             (+
              1 ;; for the \n
              (string-length line)
              (assq-ref check-results 'commit-size))
             check-results))
    (lambda (context path parse-results check-results)
      ;; We're not sure of the exact size limit so let's use 2500
      ;; instead of 4096, since we're not counting signatures etc
      (let ((limit 2500)
            (commit-size (assq-ref check-results 'commit-size)))
        (if (>= commit-size limit)
            ((lambda _
               (display
                (string-append
                 "ERROR: Commit size is " (number->string commit-size) " B"
                 " which is over the " (number->string limit) " B limit\n\n"))
               (acons
                'errors
                (+ 1 (assq-ref check-results 'errors)) check-results)))
            check-results))))

   (make-rule
    "Check for Signed-off-by"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results)
      (let* ((author (assq-ref parse-results 'commit-author))
             (email (assq-ref parse-results 'commit-email))
             (author-and-email (string-append author " <" email ">")))
        (if (not (any (lambda (elm)
                        (string=? author-and-email elm))
                      (assq-ref parse-results 'signed-off-by)))
            ((lambda _
               (display
                (string-append
                 "ERROR: Missing Signed-off-by: " author-and-email "\n\n"))
               (acons
                'errors
                (+ 1 (assq-ref check-results 'errors)) check-results)))
            check-results))))

   (make-rule
    "Warn about missing translations"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))

      (define (english-page? path)
        (and
         (not (string-match "^website/pages/.*\\.es\\.md$" path))
         (string-match "^website/pages/.*\\.md$" path)))

      (define (english-page->spanish-page path)
        (regexp-substitute #f (string-match "\\.md$" path) 'pre ".es.md"))

      (define (spanish-needs-update? page-path)
        (cond ((not (english-page? page-path)) #f)
              ;; We cannot expects contributors to ever update Spanish
              ;; pages if they do not exit.
              ((not (file-exists-at-commit?
                     (assq-ref parse-results 'commit-hash)
                     (english-page->spanish-page page-path)))
               #f)
              ;; This checks if the patch updates the corresponding
              ;; Spanish file. If it doesn't the file needs update
              ;; and a warning is added.
              ((not
                (= 1 (length
                      (filter
                       (lambda (modified-file-path)
                         (string=?
                          modified-file-path
                          (english-page->spanish-page page-path)))
                       (assq-ref parse-results 'modified-files)))))
               #t)
              (else #f)))
      (for-each
       (lambda (current-page)
         (if (spanish-needs-update? current-page)
             ((lambda _
                (set! warnings (+ 1 warnings))
                (display
                 (string-append
                  "WARNING: " current-page " was updated but not "
                  (english-page->spanish-page current-page)
                     ".\n\n"))))))
       (assq-ref parse-results 'modified-files))

      (acons
       'warnings
       warnings check-results)))

   (make-rule
    "Check for colon in @node"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results)
      (startswith line "+@node "))
    (lambda (context path line parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))

      (define (node-name line)
        (regexp-substitute
         #f
         (string-match "\\+@node +" line) 'post))

      (define (node-has-colon line)
        (not (string=?
              (string-filter (lambda (c) (eq? c #\:)) (node-name line))
              "")))

      (if (node-has-colon line)
          (let ((warnings (assq-ref check-results 'warnings)))
            (display
             (string-append
              "WARNING: node \"" (node-name line) "\" has a colun (':').\n\n"))
            (acons 'warnings (+ warnings 1) check-results))
          check-results))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check for comma in @node"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results)
      (startswith line "+@node "))
    (lambda (context path line parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))

      (define (node-name line)
        (regexp-substitute
         #f
         (string-match "\\+@node +" line) 'post))

      (define (node-has-comma line)
        (or
         (not (string=?
               (string-filter (lambda (c) (eq? c #\,)) (node-name line))
               ""))
         (string-match "@comma\\{\\}" (node-name line))))

      (if (node-has-comma line)
          (let ((warnings (assq-ref check-results 'warnings)))
            (display
             (string-append
              "WARNING: node \"" (node-name line) "\" has a comma (',').\n\n"))
            (acons 'warnings (+ warnings 1) check-results))
          check-results))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check @node alignement in the manual"
    (lambda (context path parse-results check-results)
      (acons 'current-node #f check-results))
    (lambda (context path line parse-results check-results)
      (and
       (assq-ref check-results 'current-diff-file)
       (string=?
       (assq-ref check-results 'current-diff-file)
       "manual/gnuboot.texi")))
    (lambda (context path line parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))

      ;; We have at least 3 cases we want to detect:
      ;; - a @chapter/@*section was changed and node was not
      ;; - a @chapter/@*section was not changed and node was
      ;; - both were changed
      ;; So we store the @node reguardless of if it was changed or
      ;; not, and then we also look at @chapter/@*section reguardless
      ;; of the change of both node or @chapter/@*section.
      ;; To avoid trigering when none changed, we store the full line
      ;; with @node, including the begining "+" or " ", to then be
      ;; able to know that node didn't change in the @chapter/@*section.

      (cond
       ((or (startswith line "+@node ") (startswith line " @node "))
        (acons
         'current-node
         line
         check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line " @chapter ")
             (startswith (assq-ref check-results 'current-node) " @node "))
               check-results)

       ((and (assq-ref check-results 'current-node)
             (or (startswith line "+@chapter ")
                 (startswith line " @chapter ")))
        (acons 'warnings
               ((handle-texinfo-node-type
                 (substring line 0 1) ;; "+" or " "
                 "chapter"
                 check-results)
                line parse-results check-results)
               check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line " @section ")
             (startswith (assq-ref check-results 'current-node) " @node "))
               check-results)

       ((and (assq-ref check-results 'current-node)
             (or (startswith line "+@section ")
                 (startswith line " @section ")))
        (acons 'warnings
               ((handle-texinfo-node-type
                 (substring line 0 1) ;; "+" or " "
                 "section"
                 check-results)
                line parse-results check-results)
               check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line " @subsection ")
             (startswith (assq-ref check-results 'current-node) " @node "))
               check-results)

       ((and (assq-ref check-results 'current-node)
             (or (startswith line "+@subsection ")
                 (startswith line " @subsection ")))
        (acons 'warnings
               ((handle-texinfo-node-type
                 (substring line 0 1) ;; "+" or " "
                 "subsection"
                 check-results)
                line parse-results check-results)
               check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line " @subsubsection ")
             (startswith (assq-ref check-results 'current-node) " @node "))
               check-results)

       ((and (assq-ref check-results 'current-node)
             (or (startswith line "+@subsubsection ")
                 (startswith line " @subsubsection ")))
        (acons 'warnings
               ((handle-texinfo-node-type
                 (substring line 0 1) ;; "+" or " "
                 "subsubsection"
                 check-results)
                line parse-results check-results)
               check-results))

       (else check-results)))

    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Don't forget to review resources/wrapper/guix when bumping Guix revision"
    (lambda (context path parse-results check-results)
      (acons 'guix-revision-modified #f check-results))
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results)
      (if (and
           (string? (assq-ref check-results 'current-diff-file))
           (string=? (assq-ref check-results 'current-diff-file)
                     "guix-revision.sh"))
          (if (or
               (startswith line "+GUIX_REVISION=\"")
               (startswith line "-GUIX_REVISION=\""))
              (acons 'guix-revision-modified #t check-results)
              check-results)
          check-results))
    (lambda (context path parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))
      (if
       (and
        (assq-ref check-results 'guix-revision-modified)
        (not (patch-modified-file? parse-results "resources/wrapper/guix")))
        ((lambda _
           (set! warnings (+ 1 warnings))
           (display
            (string-append
             "WARNING: "
             "guix-revision.sh was updated but not resources/wrapper/guix.\n"
             "         "
             "Make sure to review resources/wrapper/guix when updating "
             "the Guix revision.\n\n")))))
      (acons
       'warnings
       warnings check-results)))

   (make-rule
    "Check for tabs being added in scheme files"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results)
      (and (assq-ref check-results 'current-diff-file)
           (scheme-file? (assq-ref check-results 'current-diff-file))
           ;; This file adds tabs for automatic testing of
           ;; checkpatch.scm.
           (not
            (string=? "tests/scm-file-with-tabs.scm"
                      (assq-ref check-results 'current-diff-file)))
           (startswith line "+")
           (string-match "\t" line)))
    (lambda (context path line parse-results check-results)
      (let ((errors (assq-ref check-results 'errors))
            (line-nr (assq-ref check-results 'line)))
        (display
         (string-append
          "ERROR: "
          "Tab found in file " path" at line " (number->string line-nr) ": "
          line
          "\n"))
        (acons 'errors (+ 1 errors) check-results)))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check if the author copyright wasn't updated"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path patch-parse-results patch-check-results)
      (define commit-hash (assq-ref patch-parse-results 'commit-hash))
      (define commit-author (assq-ref patch-parse-results 'commit-author))
      (define commit-email (assq-ref patch-parse-results 'commit-email))
      (define commit-date (assq-ref patch-parse-results 'commit-date))
      (assert (not (eq? commit-hash #f)))
      (assert (not (eq? commit-author #f)))
      (assert (not (eq? commit-email #f)))
      (assert (not (eq? commit-date #f)))
      (define commit-year (date-year commit-date))
      (assert (not (eq? commit-year #f)))
      (define warnings (assq-ref patch-check-results 'warnings))
      (define has-copyright-note
        (if (assq-ref patch-parse-results 'has-copyright-note)
            (assq-ref patch-parse-results 'has-copyright-note)
            #f))

      (for-each
       (lambda (modified-file)
         (define file-parse-results
           (run-parse-rules
            (read-file-from-commit (assq-ref patch-parse-results 'commit-hash))
            (list (cons 'runtime 'parse-patch))
            file-parse-rules
            modified-file))

         (if (and
              (file-should-have-copyrights? modified-file)
              (not (if (assq-ref file-parse-results 'copyright-lines)
                       (any
                        (lambda (notice)
                          (author-email-year-in-copyright-notice?
                           notice
                           commit-author commit-email commit-year))
                        (assq-ref file-parse-results 'copyright-lines))
                       #f)))
             ((lambda _
                (display
                 (string-append
                  "WARNING: "
                  "unless the patch is only adding missing copyrights[1], the "
                  (number->string commit-year)
                  " copyright for \""
                  commit-author
                  "\" (" commit-email ") is missing in "
                  modified-file ".\n"))
                (set! has-copyright-note #t)
                (set! warnings (+ 1 warnings))))))
       (assq-ref patch-parse-results 'modified-files))
      (append-results
       patch-check-results
       (list
        (cons 'has-copyright-note has-copyright-note)
        (cons 'warnings warnings)))))

   (make-rule
    "Print note at the end"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results)
      (if
       (assq-ref check-results 'has-copyright-note)
       (display
        (string-append
         "\nNotes:\n------\n[1] "
         "checkpatch.scm gives false positives with patches that add missing "
         "copyright when the commit year is newer than the years of the "
         "missing copyrights being added.\n")))
      check-results))

   (make-rule
    "Track total errors and warnings"
    (lambda (context path parse-results check-results)
      (acons 'warnings 0 (acons 'errors 0 check-results)))
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results)
      (let* ((nr-lines (number->string (assq-ref parse-results 'line) 10))
             (errors (assq-ref check-results 'errors))
             (warnings (assq-ref check-results 'warnings))
             (error-text
              (string-append (number->string errors 10)
                             (if (> errors 1) " errors, " " error, ")))
             (warning-text
              (string-append (number->string warnings 10)
                             (if (> warnings 1) " warnings, " " warning, "))))
        (display
         (string-append
          "total: " error-text warning-text nr-lines " lines checked\n\n"))
        (if (or (> errors 0) (> warnings 0))
            ((lambda _
               (display
                (string-append path " has style problems, please review.\n"))
               (display
                (string-append
                 "NOTE: If any of the errors are false positives, "
                 "please report them to the GNU Boot maintainers.\n"))))
            (display
             (string-append
              path
              " has no obvious style problems "
              "and is ready for submission.\n"))))
      check-results))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                           ;;;;;;;;;;;;;;;;;;;;;;                           ;;
;;                           ;; File parse logic ;;                           ;;
;;                           ;;;;;;;;;;;;;;;;;;;;;;                           ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-record-type <table-data>
  (make-table-data start end columns)
  table-data?
  (start   table-data-start)
  (end     table-data-end)
  (columns table-data-columns))

(define*
  (get-table-columns-length
   line
   #:key (separator #\+))
  "Get the table column length of the given line. By default it operates on
lines like '+---+---+' to get the columns lengths. By passing a separator
character argument, it can also works on different tables or line formats."
  (let* ((columns
          (filter
           (lambda (elm) (not (string=? "" elm)))
           (string-split line separator)))
         (column-length
          (fold
           (lambda (elm1 elm2)
             (append (list (string-length elm1)) elm2))
           '()
           columns)))
    column-length))

(define file-parse-rules
  (list
   ;; Here's an example of a parse rule below. Since it runs each time it is
   ;; also tested. TODO: A a proper unit testing environment needs to
   ;; be added and then this could be moved to only run inside that
   ;; separate testing environment.
   (make-rule
    "Example empty rule"
    (lambda (context path _ results) results)
    (lambda (context path line _ results) #t)
    (lambda (context path line _ results) results)
    (lambda (context path _ results) results))

   (make-rule
    "Count lines"
    (lambda (context path _ results)
      (acons 'line 0 results))
    (lambda (context path line _ results) #t)
    (lambda (context path line _ results)
      (acons 'line (+ 1 (assq-ref results 'line)) results))
    (lambda (context path _ results) results))

   (make-rule
    "Parse copyright header"
    (lambda (context path _ results)
        (append-results
         results
         (list
          (cons 'copyright-header?-data (make-hash-table 1))
          (cons 'copyright-header-end-line 0)
          (cons 'copyright-header-done #f))))
    (lambda (context path line _ results)
      (not (assq-ref results 'copyright-header-done)))
    (lambda (context path line _ results)
      (define header?
        (copyright-header? path (assq-ref results 'line) line
                           (assq-ref results 'copyright-header?-data)
                           #:ignore-empty-lines #t))
      (cond
       ((eq? header? 'skip)
        results)
       ((eq? header? #t)
        (acons 'copyright-header-end-line (assq-ref results 'line) results))
       ((eq? header? #f)
        (acons 'copyright-header-done #t results))))
    (lambda (context path _ results) results))

   (make-rule
    "Identify copyright lines in the copyright header"
    (lambda (context path _ results) results)
    (lambda (context path line _ results)
      (and
       (not (assq-ref results 'copyright-header-done))
       (copyright-line? line)))
    (lambda (context path line _ results)
      (define previous-copyright-lines
        (or
         (assq-ref results 'copyright-lines)
         '()))
      (acons 'copyright-lines
             (append previous-copyright-lines
                     (list (parse-copyright-line #f path line)))
             results))
    (lambda (context path _ results) results))

   (make-rule
    "Parse tables"
    (lambda (context path _ results)
      (acons 'tables (list) results))
    (lambda (context path line _ results)
      (string-match "\\.md$" path))
    (lambda (context path line _ results)
      (let* ((line-nr (assq-ref results 'line))
             (tables (assq-ref results 'tables))
             (tables? (> (length tables) 0))
             (separation-line (string-match "^\\+((-+\\+)+)$" line))
             (row-line (string-match "^\\|.*\\|$" line))
             (previous-line-in-table
              (lambda (results)
                (cond
                 ((and tables? (not (table-data-end (car tables))))
                  (eq? (+ 1 (table-data-start (car tables))) line-nr))
                 ((and tables? (table-data-end (car tables)))
                  (eq? (+ 1 (table-data-end (car tables))) line-nr))
                 (else #f)))))
        (cond
         ((and separation-line (not tables?))
          (let ((columns (get-table-columns-length line)))
            (acons 'tables
                   (list (make-table-data line-nr #f columns))
                   results)))

         ((and separation-line (previous-line-in-table results))
          (let ((start (table-data-start (car tables)))
                (columns (table-data-columns (car tables))))
            (list-set! tables 0 (make-table-data start line-nr columns))
          (acons 'tables tables results)))

         ((and separation-line (not (previous-line-in-table results)))
          (let ((columns (get-table-columns-length line)))
            (acons
             'tables
             (append (list (make-table-data line-nr #f columns)) tables)
             results)))

         ((and row-line (previous-line-in-table results))
          (let ((start (table-data-start (car tables)))
                (columns (table-data-columns (car tables))))
            (list-set!
             tables 0
             (make-table-data start line-nr columns))
            (acons 'tables tables results)))

         (else results))))
    (lambda (context path _ results)
;;      (pk (assq-ref results 'tables))
      results))

   ;; We can also use rules for debugging the code, here are two
   ;; examples below.

   ;; (make-rule
   ;;  "Debug: print lines."
   ;;  (lambda (context path _ results) results)
   ;;  (lambda (context path line _ results) #t)
   ;;  (lambda (context path line _ results)
   ;;    (display "Count lines: line #")
   ;;    (display (+ 1 (assq-ref results 'line)))
   ;;    (display (string-append ": " line "\n"))
   ;;    results)
   ;;  (lambda (context path _ results) results))

   ;; (make-rule
   ;;  "Debug: print results."
   ;;  (lambda (context path _ results) results)
   ;;  (lambda (context path line _ results) #f)
   ;;  (lambda (context path line _ results) results)
   ;;  (lambda (context path _ results)
   ;;    (pk results)
   ;;    results))
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                             ;;;;;;;;;;;;;;;;;                              ;;
;;                             ;; File checks ;;                              ;;
;;                             ;;;;;;;;;;;;;;;;;                              ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define file-check-rules
  (list
   ;; Here's an example of a check rule below. Since it runs each time it is
   ;; also tested. TODO: A a proper unit testing environment needs to
   ;; be added and then this could be moved to only run inside that
   ;; separate testing environment.
   (make-rule
    "Example empty rule"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Count lines"
    (lambda (context path parse-results check-results)
      (acons 'line 0 check-results))
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results)
      (acons 'line (+ 1 (assq-ref check-results 'line)) check-results))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check @node alignement in the manual"
    (lambda (context path parse-results check-results)
      (acons 'current-node #f check-results))
    (lambda (context path line parse-results check-results)
      (string-match "\\.texi$" path))
    (lambda (context path line parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))
      (cond
       ((startswith line "@node ")
        (acons
         'current-node
         line
         check-results))
       ((and (assq-ref check-results 'current-node)
             (startswith line "@chapter "))
        (acons 'warnings
               ((handle-texinfo-node-type
                 ""
                 "chapter"
                 check-results)
                line parse-results check-results)
               check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line "@section ")
             (startswith (assq-ref check-results 'current-node) "@node "))
        check-results)

       ((and (assq-ref check-results 'current-node)
             (startswith line "@section "))
        (acons 'warnings
               ((handle-texinfo-node-type
                 ""
                 "section"
                 check-results)
                line parse-results check-results)
               check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line "subsection ")
             (startswith (assq-ref check-results 'current-node) "node "))
        check-results)

       ((and (assq-ref check-results 'current-node)
             (startswith line "subsection "))
        (acons 'warnings
               ((handle-texinfo-node-type
                 ""
                 "subsection"
                 check-results)
                line parse-results check-results)
               check-results))

       ;; Skip when nothing changed. Note that (assq-ref check-results
       ;; 'current-node) is sometime false. So we cannot assume it is
       ;; a string unless we check if it is not false before.
       ((and (assq-ref check-results 'current-node)
             (startswith line "@subsubsection ")
             (startswith (assq-ref check-results 'current-node) "@node "))
        check-results)

       ((and (assq-ref check-results 'current-node)
             (startswith line "@subsubsection "))
        (acons 'warnings
               ((handle-texinfo-node-type
                 ""
                 "subsubsection"
                 check-results)
                line parse-results check-results)
               check-results))

       (else check-results)))

    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check for tabs in scheme files"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results)
      (and (scheme-file? path)
           (string-match "\t" line)))
    (lambda (context path line parse-results check-results)
      (let ((errors (assq-ref check-results 'errors))
            (line-nr (assq-ref check-results 'line)))
        (display
         (string-append
          "ERROR: "
          "Tab found in file " path" at line " (number->string line-nr) ": "
          line
          "\n"))
        (acons 'errors (+ 1 errors) check-results)))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check tables"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results)
      (let* ((line-nr (assq-ref check-results 'line))
             (tables (assq-ref parse-results 'tables))
             (in-table?
              (> (length (filter
                          (lambda (elm)
                            (and (<= (table-data-start elm) line-nr)
                                 (>= (table-data-end elm) line-nr)))
                          tables)) 0)))
        in-table?))
    (lambda (context path line parse-results check-results)
      (let* ((line-nr (assq-ref check-results 'line))
             (tables (assq-ref parse-results 'tables))
             (current-table
              (car (filter
                    (lambda (elm)
                      (and (<= (table-data-start elm) line-nr)
                           (>= (table-data-end elm) line-nr)))
                    tables)))
             (current-table-column-length
              (table-data-columns current-table))
             (current-line-column-length
              (cond ((startswith line "+")
                     (get-table-columns-length line))
                    ((startswith line "|")
                     (get-table-columns-length line #:separator #\|))
                    (else
                     (assert #f))))
             (first-line
              (string-append
               (fold (lambda (elm1 elm2)
                       (assert (> elm1 0))
                       (string-append
                        elm2
                        (fold string-append "" (make-list elm1 "-"))
                        "+"))
                     "+"
                     current-table-column-length))))
        (if (not (equal? current-table-column-length
                         current-line-column-length))
            (let*
                ((len (string-length (number->string line-nr)))
                 (padding-left (if (> len 1)
                                   ""
                                   (fold string-append "" (make-list len " "))))
                 (errors (assq-ref check-results 'errors))
                 (display-line
                  (lambda (line-nr line)
                    (display
                     (string-append
                      "       line" padding-left (number->string line-nr) ": "
                      line "\n"))))

                 (display-column-lengths
                  (lambda (line-nr column-lengths)
                    (display
                     (string-append
                      "       line" padding-left (number->string line-nr)
                      ": column lengths: (list "
                      (string-join (map number->string column-lengths) " ")
                      ")\n")))))
              (display "ERROR: different column length detected:\n")
              (display-column-lengths 1 current-table-column-length)
              (display-column-lengths line-nr current-line-column-length)
              (display-line 1 first-line)
              (display-line line-nr line)
              (display "\n")

              (acons 'errors (+ 1 errors) check-results))
            check-results)))
    (lambda (context path parse-results check-results) check-results))

   (make-rule
    "Check if the file has some copyrights in it"
    (lambda (context path parse-results check-results) check-results)
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results)
      (define file-has-copyright?
        (if (endswith path ".patch")
            ;; Git patches usually have the same information than
            ;; regular copyright headers, and it is standardized so we
            ;; require git patches for now. Debian patch tagging
            ;; guidelines is also standarized so if people want to
            ;; bring in non-git patches, implementing Debian's patch
            ;; tagging guidelines would enable to import non-git
            ;; patches.
            (let* ((parse-results
                    (run-parse-rules
                     read-file
                     (list (cons 'runtime 'parse-file))
                     patch-parse-rules path))
                   (author?
                    (not (eq? (assq-ref parse-results 'commit-author) #f)))
                   (email?
                    (not (eq? (assq-ref parse-results 'commit-email) #f)))
                   (date?
                    (not (eq? (assq-ref parse-results 'commit-date) #f))))
              (and author?
                   email?
                   date?))
            (or
             (not (eq? #f (assq-ref parse-results 'copyright-lines)))
             (not (file-should-have-copyrights? path)))))
      (if (not file-has-copyright?)
          (let ((errors (assq-ref check-results 'errors)))
            (display
             (string-append "ERROR: missing copyrights in " path "\n"))
            (acons 'errors (+ 1 errors) check-results))
          check-results)))

   (make-rule
    "Track total errors and warnings"
    (lambda (context path parse-results check-results)
        (append-results
         check-results
         (list
          (cons 'warnings 0)
          (cons 'errors 0))))
    (lambda (context path line parse-results check-results) #t)
    (lambda (context path line parse-results check-results) check-results)
    (lambda (context path parse-results check-results)
      (let* ((nr-lines (number->string (assq-ref parse-results 'line) 10))
             (errors (assq-ref check-results 'errors))
             (warnings (assq-ref check-results 'warnings))
             (error-text
              (string-append (number->string errors 10)
                             (if (> errors 1) " errors, " " error, ")))
             (warning-text
              (string-append (number->string warnings 10)
                             (if (> warnings 1) " warnings, " " warning, "))))
        (display
         (string-append
          "total: " error-text warning-text nr-lines " lines checked\n\n"))
        (if (or (> errors 0) (> warnings 0))
            ((lambda _
               (display
                (string-append path " has style problems, please review.\n"))
               (display
                (string-append
                 "NOTE: If any of the errors are false positives, "
                 "please report them to the GNU Boot maintainers.\n"))))
            (display
             (string-append
              path
              " has no obvious style problems "
              "and is ready for submission.\n"))))
      check-results))))

(define (test-file read-func path)
  (let* ((parse-results (run-parse-rules
                         read-func
                         (list (cons 'runtime 'parse-file))
                         file-parse-rules path))
         (check-results (run-check-rules
                         read-func
                         (list (cons 'runtime 'check-file))
                         parse-results file-check-rules path)))
    check-results))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                     ;;
;;                     ;; Command line parsing handlig ;;                     ;;
;;                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                     ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; error if not in git tree and in topdir.
(define (in-tree-topdir?)
  (string=?
   (canonicalize-path (getcwd))
   (dirname (dirname (current-filename)))))

(define (in-git-dir?)
  (file-exists? ".git/config"))

(define (usage progname exit-code)
  (display (string-append
            "Usage: "
            progname
            " [OPTIONS] [FILE [FILE ...]]\n"
            "\n"
            "Options:\n"
            "\t--help         print this help.\n"
            "\t-c REVISION    "
            "Requires -f. Uses the given file from the given git REVISION.\n"
            "\t-f             "
            "don't treat FILE as a patch, but as regular source file instead"
            ".\n"))
  (exit exit-code))

(define (main args)
  (cond
   ((eq? (length args) 1)
    (usage "checkpatch.pl" 64)) ;; 64 is EX_USAGE in sysexits.h
   ((string=? (list-ref args 1) "--help")
    (usage "checkpatch.pl" 0))
   ((or (not (in-tree-topdir?))
        (not (in-git-dir?)))
    ((lambda _
       (display
        (string-append
         "Error: please run checkpatch.scm in the git top directory.\n"))
       (exit 69)))) ;; 69 is EX_UNAVAILABLE in sysexits.h
   ((or (and (> (length args) 4)
             (string=? (list-ref args 1) "-c")
             (string=? (list-ref args 3) "-f"))
        (and (> (length args) 4)
             (string=? (list-ref args 1) "-f")
             (string=? (list-ref args 2) "-c")))
    (let ((rev (if (string=? (list-ref args 1) "-c")
                   (list-ref args 2)
                   (list-ref args 3))))
      (map (lambda (path)
             (if (> (length args) 5)
                 (print-file-name path))
             (test-file (read-file-from-commit (get-git-commit-hash rev)) path))
           (cddddr args))))
   ((string=? (list-ref args 1) "-f")
    (map (lambda (path)
           (if (> (length args) 3)
               (print-file-name path))
           (test-file read-file path))
         (cddr args)))
   (else
    (let ((not-patch-files
           (filter (lambda (arg)
                     (not (string-match "\\.patch$" arg)))
                   (cdr args))))
      (if (> (length not-patch-files) 0)
          ((lambda _
             (if (> (length not-patch-files) 1)
                 (display "ERROR: Some files doesn't end in .patch:\n")
                 (display "ERROR: The following file doesn't end in .patch:\n"))
             (for-each
              (lambda (arg)
                (display
                 (string-append "- " arg "\n")))
              not-patch-files)
             (display
              (string-append
               "see the '-f' argument in 'checkpatch.scm --help' "
               "for how to check files.\n"))

             (exit 64))) ;; 64 is EX_USAGE in sysexits.h
          (map (lambda (path)
                 (if (> (length args) 2) (print-file-name path))
                 (test-patch
                  read-file
                  (list (cons 'runtime 'parse-patch))
                  (list (cons 'runtime 'check-patch))
                  path))
               (cdr args)))))))
