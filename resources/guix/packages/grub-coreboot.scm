;; This file is part of GNU Boot.
;;
;; This file is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or (at
;; your option) any later version.
;;
;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (grub-coreboot))

(use-modules (gnu packages bootloaders)
             (guix build-system copy)
             (guix build-system trivial)
             (guix gexp)
             ((guix licenses)
              #:prefix license:)
             (guix packages)
             (guix utils))

(define-public grub-coreboot
  (package
    (inherit grub)
    (name "grub-coreboot")
    (synopsis "GRand Unified Boot loader (Coreboot payload version)")
    (arguments
     `(,@(substitute-keyword-arguments (package-arguments grub)
           ((#:phases phases '%standard-phases)
            `(modify-phases ,phases
               (add-before 'check 'disable-broken-tests
                 (lambda _
                   (setenv "DISABLE_HARD_ERRORS" "1")
                   (setenv
                    "XFAIL_TESTS"
                    (string-join
                     ;; TODO: All the tests below use grub shell
                     ;; (tests/util/grub-shell.in), and here grub-shell uses
                     ;; QEMU and a Coreboot image to run the tests. Since we
                     ;; don't have a Coreboot package in Guix yet these tests
                     ;; are disabled. See the Guix bug #64667 for more details
                     ;; (https://debbugs.gnu.org/cgi/bugreport.cgi?bug=64667).
                     (list
                      "pata_test"
                      "ahci_test"
                      "uhci_test"
                      "ehci_test"
                      "example_grub_script_test"
                      "ohci_test"
                      "grub_script_eval"
                      "grub_script_echo1"
                      "grub_script_test"
                      "grub_script_leading_whitespace"
                      "grub_script_echo_keywords"
                      "grub_script_vars1"
                      "grub_script_for1"
                      "grub_script_while1"
                      "grub_script_if"
                      "grub_script_comments"
                      "grub_script_functions"
                      "grub_script_continue"
                      "grub_script_break"
                      "grub_script_shift"
                      "grub_script_blockarg"
                      "grub_script_return"
                      "grub_script_setparams"
                      "grub_cmd_date"
                      "grub_cmd_sleep"
                      "grub_cmd_regexp"
                      "grub_script_not"
                      "grub_cmd_echo"
                      "grub_script_expansion"
                      "grub_script_gettext"
                      "grub_script_escape_comma"
                      "help_test"
                      "grub_script_strcmp"
                      "test_sha512sum"
                      "grub_cmd_tr"
                      "test_unset"
                      "file_filter_test")
                     " "))))))
           ((#:configure-flags flags
             ''())
            `(cons* "--with-platform=coreboot"
                    ,flags)))))))

(list grub-coreboot)
