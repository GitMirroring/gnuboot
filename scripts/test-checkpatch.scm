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

(define-module (test-checkpatch)
  #:use-module (srfi srfi-64)
  #:use-module (checkpatch))

(test-begin "test-checkpatch")

;; Taken from tests/dsv.scm in guile-dsv which is GPLv3+ and which has
;; the following copyrights:
;; Copyright (C) 2014-2023 Artyom V. Poptsov <poptsov.artyom@gmail.com>
(define exit-status (test-runner-fail-count (test-runner-current)))

(test-end "test-checkpatch")

;; Taken from tests/dsv.scm in guile-dsv which is GPLv3+ and which has
;; the following copyrights:
;; Copyright (C) 2014-2023 Artyom V. Poptsov <poptsov.artyom@gmail.com>
;;
;; Without it it would return the number of failed tests. This
;; conflicts with automake as according to its info manual: "When no
;; test protocol is in use, an exit status of 0 from a test script
;; will denote a success, an exit status of 77 a skipped test, an exit
;; status of 99 a hard error, and any other exit status will denote a
;; failure."
;;
;; So right now we only do return success or failure
(exit (zero? exit-status))
