#!/usr/bin/env -S guile -e main -s
!#
;; Copyright (C) 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

(define (startswith str value)
  (if (> (string-length str) (string-length value))
      (string=? (substring str 0 (string-length value)) value)      #f))

(define (read-file path func)
  (define results #f)
  (let ((port (open-input-file path)))
    (set! results (func path port))
    (close-port port)
    results))

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
               "git" "ls-tree" commit "--" path))
             (str (read-line port)))
          str))))

(define (patch-modified-file? parse-results file-path)
  (not (nil?
        (filter
         (lambda (modified-file-path)
           (string=? modified-file-path file-path))
         (assq-ref parse-results 'modified-files)))))

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
;;                         ;;;;;;;;;;;;;;;;;;;;;;;;;                          ;;
;;                         ;; Patch parsing logic ;;                          ;;
;;                         ;;;;;;;;;;;;;;;;;;;;;;;;;                          ;;
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
    (lambda (path _ results) results)
    (lambda (path line _ results) #t)
    (lambda (path line _ results) results)
    (lambda (path _ results) results))

   (make-rule
    "Count lines"
    (lambda (path _ results) (acons 'line 0 results))
    (lambda (path line _ results) #t)
    (lambda (path line _ results)
      (acons 'line (+ 1 (assq-ref results 'line)) results))
    (lambda (path _ results) results))

   (make-rule
    "Find diff start"
    (lambda (path _ results) results)
    (lambda (path line _ results)
      (startswith line "diff --git "))
    (lambda (path line _ results)
      (acons 'diff-start
             (assq-ref results
                       'line) results))
    (lambda (path _ results)
      results))

   (make-rule
    "Retrieve Signed-off-by"
    (lambda (path _ results) (acons 'signed-off-by '() results))
    (lambda (path line _ results) (startswith line "Signed-off-by: "))
    (lambda (path line _ results)
      (let ((signed-off-by
             (string-join (cdr (string-split line #\ )) " ")))
        (acons 'signed-off-by
               (append (assq-ref results 'signed-off-by) (list signed-off-by))
               results)))
    (lambda (path _ results) results))

   ;; TODO: Raise an exception if there is no lines with From:, and
   ;; when handling it, complain that the file is not a valid git
   ;; patch.
   (make-rule
    "Find commit author"
    (lambda (path _ results) results)
    (lambda (path line _ results) (startswith line "From: "))
    (lambda (path line _ results)
      (let ((commit-author (string-join (cdr (string-split line #\ )) " ")))
        (acons
         'commit-author
         commit-author
         results)))
    (lambda (path _ results) results))

   (make-rule
    "Find commit hash"
    (lambda (path _ results) results)
    (lambda (path line _ results)
      ;; Example:
      ;; From 0df4fe5fadfb7f51c1c34dad10ca9e6e04c3fa18 Mon Sep 17 00:00:00 2001
      (and (not (startswith line "From: "))
           (startswith line "From ")
           ;; We only want to match the first result, otherwise a 'From [...]
           ;; within the commit message will match.
           (not (assq-ref results 'commit-hash))))
    (lambda (path line _ results)
      (let ((commit-hash (list-ref (string-split line #\ ) 1)))
        (acons 'commit-hash commit-hash results)))
    (lambda (path _ results) results))

   ;; TODO: Raise an exception if there is no lines with Date:, and
   ;; when handling it, complain that the file is not a valid git
   ;; patch.
   (make-rule
    "Find commit date"
    (lambda (path _ results) results)
    (lambda (path line _ results) (startswith line "Date: "))
    (lambda (path line _ results)
      (acons 'commit-date
             (string->date
              (string-join (cdr (string-split line #\ )) " ")
              "~a, ~d ~b ~Y ~H:~M:~S ~z")
             results))
    (lambda (path _ results) results))

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
    (lambda (path _ results) results)
    (lambda (path line _ results) (startswith line "Subject: "))
    (lambda (path line _ results)
      (let ((commit-subject (string-join (cdr (string-split line #\ )) " ")))
        (acons
         'commit-subject-line
         (assq-ref results 'line)
         (acons
          'commit-subject
          commit-subject
          results))))
    (lambda (path _ results) results))

   (make-rule
    "Find commit subject and message separator"
    (lambda (path _ results) results)
    (lambda (path line _ results)
      ;; TODO: Raise an exception if the line after the commit subject
      ;; line is not empty, and when handling it, complain that the
      ;; file is not a valid git patch.
      (and
       (not (assq-ref results 'commit-message-end-line))
       (assq-ref results 'commit-subject)
       (string=? line "")
       (eq? (+ 1 (assq-ref results 'commit-subject-line))
            (assq-ref results 'line))))
    (lambda (path line _ results)
      (acons
          'commit-subject-message-separator-line
          (assq-ref results 'line)
          results))
    (lambda (path _ results) results))

   ;; TODO: Raise an exception if there is more than two lines with
   ;; ---, and when handling it, complain that the file is not a valid
   ;; git patch.
   (make-rule
    "Find changelog end"
    (lambda (path _ results) results)
    (lambda (path line _ results)
      (and
       (assq-ref results 'commit-message-end-line)
       (string=? line "---")))
    (lambda (path line _ results)
      (acons 'changelog-end-line (assq-ref results 'line) results))
    (lambda (path _ results) results))

   ;; TODO: Raise an exception if there is no line with ---, and when
   ;; handling it, complain that the file is not a valid git patch.
   (make-rule
    "Find commit message end"
    (lambda (path _ results) results)
    (lambda (path line _ results)
      ;; This matches the first "---" but there could be more as shown
      ;; in the example below:
      ;;     ---
      ;;     ChangeLog: [...]
      ;;     ---
      ;; So until found we are in the commit message, but after it is found
      ;; we could also be in the ChangeLog.
      (and (string=? line "---")
           (not (assq-ref results 'commit-message-end-line))))
    (lambda (path line _ results)
          (acons 'commit-message-end-line (assq-ref results 'line) results))
    (lambda (path _ results) results))

   (make-rule
    "Find the end of the commit"
    (lambda (path _ results) results)
    (lambda (path line _ results) #f)
    (lambda (path line _ results) results)
    (lambda (path _ results)
      (acons 'commit-end-line
             (if (assq-ref results 'changelog-end-line)
                 (assq-ref results 'changelog-end-line)
                 (assq-ref results 'commit-message-end-line))
             results)))

   (make-rule
    "Find commit message"
    (lambda (path _ results) results)
    (lambda (path line _ results)
      (and
       (not (assq-ref results 'commit-message-end-line))
       (assq-ref results 'commit-subject-message-separator-line)
       (> (assq-ref results 'line)
          (assq-ref results 'commit-subject-message-separator-line))))
    (lambda (path line _ results)
      (let ((commit-message
             (if (not (assq-ref results 'commit-message))
                 (list)
                 (append (assq-ref results 'commit-message) (list line)))))
        (acons
         'commit-message
         commit-message
         results)))
    (lambda (path _ results) results))

   (make-rule
    "Find added files"
    (lambda (path _ results)
      (acons 'added-files
             '() results))
    (lambda (path line _ results)
      (and (startswith line " create mode ")))
    (lambda (path line _ results)
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
    (lambda (path _ results)
      results))

   (make-rule
    "Find deleted files"
    (lambda (path _ results)
      (acons 'deleted-files
             '() results))
    (lambda (path line _ results)
      (and (startswith line " delete mode ")))
    (lambda (path line _ results)
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
    (lambda (path _ results)
      results))

   (make-rule
    "Find modified files and track current file diff"
    (lambda (path _ results)
      (acons 'current-diff-file #f
             (acons 'modified-files '() results)))
    (lambda (path line _ results)
      (startswith line "diff --git a/"))
    (lambda (path line _ results)
      (define line-parts
        (string-split line #\space))
      (define current-diff-file
        #f)
      (define modified-file
        '())
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
      (acons 'modified-files
             (append (assq-ref results 'modified-files) modified-file)
             (acons 'current-diff-file current-diff-file
                    results)))
    (lambda (path _ results)
      results))

   (make-rule
    "Track diff"
    (lambda (path _ results) results)
    (lambda (path line _ results) #t)
    (lambda (path line _ results)
      (define diff-start
        0)
      (define diff-end
        0)
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
    (lambda (path _ results) results))

   (make-rule
    "Check for copyrights inside the patch"
    (lambda (path _ results)
      (acons 'diff-path-added-proper-copyright
             '() results))
    (lambda (path line _ results)
      (and (startswith line "+")
           (assq-ref results
                     'current-diff-file)
           (> (assq-ref results
                        'diff-start) 0)))
    (lambda (path line _ results)
      (let ((diff-start (assq-ref results
                                  'diff-start))
            (diff-end (assq-ref results
                                'diff-end))
            (current-diff-file (assq-ref results
                                         'current-diff-file))
            (commit-author (assq-ref results
                                     'commit-author))
            (commit-year (date-year (assq-ref results
                                              'commit-date))))
        ;; Example: Copyright (C) 2024 Some Name <mail@domain.org>
        (if
         (string-match
          (string-append
           "Copyright[ ]\\(C\\)[ ]" ;"Copyright (C) "
           ".*" ;We can have multiple years
           (number->string commit-year 10) ;Year
           ".*" ;We can have multiple years
           " " ;We have at least 1 space before the author line
           commit-author) line)
         (acons 'diff-path-added-proper-copyright
                (append (assq-ref results
                                  'diff-path-added-proper-copyright)
                        (list current-diff-file)) results)
         results)))
    (lambda (path _ results) results))

   ;; We can also use rules for debugging the code, here are two
   ;; examples below.

   ;; (make-rule
   ;;  "Debug: print lines."
   ;;  (lambda (path _ results) results)
   ;;  (lambda (path line _ results) #t)
   ;;  (lambda (path line _ results)
   ;;    (display "Count lines: line #")
   ;;    (display (+ 1 (assq-ref results 'line)))
   ;;    (display (string-append ": " line "\n"))
   ;;    results)
   ;;  (lambda (path _ results) results))

   ;; (make-rule
   ;;  "Debug: print results."
   ;;  (lambda (path _ results) results)
   ;;  (lambda (path line _ results) #f)
   ;;  (lambda (path line _ results) results)
   ;;  (lambda (path _ results)
   ;;    (pk results)
   ;;    results))
   ))

(define (set-defaults rules path parse-results results)
  (for-each
   (lambda (rule)
     (set! results ((rule-default rule) path parse-results results)))
   rules)
  results)

(define (run-line-match-rules port rules path parse-results results)
  (define line (read-line port))
  (if (eof-object? line)
      results
      ((lambda _
         (for-each
          (lambda (rule)
            (if ((rule-line-match rule) path line parse-results results)
                (set! results ((rule-line rule) path line parse-results results))))
          rules)
         (run-line-match-rules port rules path parse-results results)))))

(define (run-end-rules path rules other-results results)
  (for-each
   (lambda (rule)
     (set! results ((rule-end rule) path other-results results)))
   rules)
  results)

(define (run-parse-rules rules path)
  (read-file
   path
   (lambda (path port)
     (let* ((defaults (set-defaults rules path #f '()))
            (results (run-line-match-rules port rules path #f defaults)))
     (run-end-rules path rules #f results)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                             ;;;;;;;;;;;;;;;;;;                             ;;
;;                             ;; Patch checks ;;                             ;;
;;                             ;;;;;;;;;;;;;;;;;;                             ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (run-check-rules parse-results rules path)
  (read-file
   path
   (lambda (path port)
     (let* ((defaults (set-defaults rules path parse-results '()))
            (check-results
             (run-line-match-rules port rules path parse-results defaults)))
     (run-end-rules path rules parse-results check-results)))))

(define patch-check-rules
  (list

   ;; Here's an example of a check rule below. Since it runs each time it is
   ;; also tested. TODO: A a proper unit testing environment needs to
   ;; be added and then this could be moved to only run inside that
   ;; separate testing environment.
   (make-rule
    "Example empty rule"
    (lambda (path parse-results check-results) check-results)
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results) check-results))

   (make-rule
    "Check if the patch commit hash is in git"
    (lambda (path parse-results check-results)
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
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results) check-results))

   (make-rule
    "Count lines"
    (lambda (path parse-results check-results) (acons 'line 0 check-results))
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results)
      (acons 'line (+ 1 (assq-ref check-results 'line)) check-results))
    (lambda (path parse-results check-results) check-results))

   (make-rule
    "Track current file diff"
    (lambda (path parse-results check-results)
      (acons 'current-diff-file #f check-results))
    (lambda (path line parse-results check-results)
      (startswith line "diff --git a/"))
    (lambda (path line parse-results check-results)
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
    (lambda (path _ check-results) check-results))

   ;; Workarround for the bug #66268
   ;; [1]https://debbugs.gnu.org/cgi/bugreport.cgi?bug=66268
   (make-rule
    "Enforce commit size < 4KB"
    (lambda (path parse-results check-results)
      (acons 'commit-size 0 check-results))
    (lambda (path line parse-results check-results)
      (< (assq-ref check-results 'line)
         (assq-ref parse-results 'commit-end-line)))
    (lambda (path line parse-results check-results)
      (acons 'commit-size
             (+
              1 ;; for the \n
              (string-length line)
              (assq-ref check-results 'commit-size))
             check-results))
    (lambda (path parse-results check-results)
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
    (lambda (path parse-results check-results) check-results)
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results)
      (let ((author (assq-ref parse-results 'commit-author)))
        (if (not (any (lambda (elm)
                        (string=? author elm))
                      (assq-ref parse-results 'signed-off-by)))
            ((lambda _
               (display
                (string-append "ERROR: Missing Signed-off-by: " author "\n\n"))
               (acons
                'errors
                (+ 1 (assq-ref check-results 'errors)) check-results)))
            check-results))))

   (make-rule
    "Warn about missing translations"
    (lambda (path parse-results check-results) check-results)
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results)
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
    "Check @node alignement in the manual"
    (lambda (path parse-results check-results)
      (acons 'current-node #f check-results))
    (lambda (path line parse-results check-results)
      (and
       (assq-ref check-results 'current-diff-file)
       (string=?
       (assq-ref check-results 'current-diff-file)
       "manual/gnuboot.texi")))
    (lambda (path line parse-results check-results)
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

    (lambda (path parse-results check-results)
      check-results))

   (make-rule
    "Don't forget to review resources/wrapper/guix when bumping Guix revision"
    (lambda (path parse-results check-results)
      (acons 'guix-revision-modified #f check-results))
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results)
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
    (lambda (path parse-results check-results)
      (define warnings (assq-ref check-results 'warnings))
      (if
       (and
        (assq-ref check-results 'guix-revision-modified)
        (not (patch-modified-file? parse-results "resources/wrapper/guix")))
        ((lambda _
           (set! warnings (+ 1 warnings))
           (display
            (string-append
             "WARNING: guix-revision.sh was updated but not resources/wrapper/guix.\n"
             "         Make sure to review resources/wrapper/guix when updating "
             "the Guix revision.\n\n")))))
      (acons
       'warnings
       warnings check-results)))

   (make-rule
    "Track total errors and warnings"
    (lambda (path parse-results check-results)
      (acons 'warnings 0 (acons 'errors 0 check-results)))
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results)
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

(define (test-patch path)
  (let* ((parse-results (run-parse-rules patch-parse-rules path))
         (check-results (run-check-rules parse-results patch-check-rules path)))
    parse-results))

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
    (lambda (path _ results) results)
    (lambda (path line _ results) #t)
    (lambda (path line _ results) results)
    (lambda (path _ results) results))

   (make-rule
    "Count lines"
    (lambda (path _ results) (acons 'line 0 results))
    (lambda (path line _ results) #t)
    (lambda (path line _ results)
      (acons 'line (+ 1 (assq-ref results 'line)) results))
    (lambda (path _ results) results))

   (make-rule
    "Parse tables"
    (lambda (path _ results) (acons 'tables (list) results))
    (lambda (path line _ results)
      (string-match "\\.md$" path))
    (lambda (path line _ results)
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
            (acons 'tables (list (make-table-data line-nr #f columns)) results)))

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
    (lambda (path _ results)
;;      (pk (assq-ref results 'tables))
      results))

   ;; We can also use rules for debugging the code, here are two
   ;; examples below.

   ;; (make-rule
   ;;  "Debug: print lines."
   ;;  (lambda (path _ results) results)
   ;;  (lambda (path line _ results) #t)
   ;;  (lambda (path line _ results)
   ;;    (display "Count lines: line #")
   ;;    (display (+ 1 (assq-ref results 'line)))
   ;;    (display (string-append ": " line "\n"))
   ;;    results)
   ;;  (lambda (path _ results) results))

   ;; (make-rule
   ;;  "Debug: print results."
   ;;  (lambda (path _ results) results)
   ;;  (lambda (path line _ results) #f)
   ;;  (lambda (path line _ results) results)
   ;;  (lambda (path _ results)
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
    (lambda (path parse-results check-results) check-results)
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results) check-results))

   (make-rule
    "Count lines"
    (lambda (path parse-results check-results) (acons 'line 0 check-results))
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results)
      (acons 'line (+ 1 (assq-ref check-results 'line)) check-results))
    (lambda (path parse-results check-results) check-results))

   (make-rule
    "Check @node alignement in the manual"
    (lambda (path parse-results check-results)
      (acons 'current-node #f check-results))
    (lambda (path line parse-results check-results)
      (string-match "\\.texi$" path))
    (lambda (path line parse-results check-results)
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

    (lambda (path parse-results check-results)
      check-results))

   (make-rule
    "Check tables"
    (lambda (path parse-results check-results) check-results)
    (lambda (path line parse-results check-results)
      (let* ((line-nr (assq-ref check-results 'line))
             (tables (assq-ref parse-results 'tables))
             (in-table?
              (> (length (filter
                          (lambda (elm)
                            (and (<= (table-data-start elm) line-nr)
                                 (>= (table-data-end elm) line-nr)))
                          tables)) 0)))
        in-table?))
    (lambda (path line parse-results check-results)
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
              (display "Error: different column length detected:\n")
              (display-column-lengths 1 current-table-column-length)
              (display-column-lengths line-nr current-line-column-length)
              (display-line 1 first-line)
              (display-line line-nr line)
              (display "\n")

              (acons 'errors (+ 1 errors) check-results))
            check-results)))
    (lambda (path parse-results check-results)
      check-results))

   (make-rule
    "Track total errors and warnings"
    (lambda (path parse-results check-results)
      (acons 'warnings 0 (acons 'errors 0 check-results)))
    (lambda (path line parse-results check-results) #t)
    (lambda (path line parse-results check-results) check-results)
    (lambda (path parse-results check-results)
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

(define (test-file path)
  (let* ((parse-results (run-parse-rules file-parse-rules path))
         (check-results (run-check-rules parse-results file-check-rules path)))
    parse-results))

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
            "\t--help print this help.\n"
            "\t-f     don't treat FILE as a patch, but as regular source file instead.\n"))
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
   ((string=? (list-ref args 1) "-f")
    (map (lambda (path)
           (if (> (length args) 3)
               (print-file-name path))
           (test-file path))
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
             (display "see the '-f' argument in 'checkpatch.scm --help' for how to check files.\n")

             (exit 64))) ;; 64 is EX_USAGE in sysexits.h
          (map (lambda (path)
                 (if (> (length args) 2) (print-file-name path))
                 (test-patch path))
               (cdr args)))))))
