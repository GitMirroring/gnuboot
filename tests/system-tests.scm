;;; GNU Boot --- Boot software distribution
;;; Copyright © 2016, 2018-2020, 2022 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2024 Denis 'GNUtooo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file has been modified from etc/system-tests.scm from GNU
;;; Guix 1.4.0.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(use-modules (git)
             (gnu build marionette)
             (gnu packages package-management)
             (gnu packages virtualization)
             (gnu tests base)
             (gnu tests install)
             (gnu tests)
             (gnuboot packages gnuboot-releases)
             (guix gexp)
             (guix monads)
             (guix store)
             (ice-9 match))

(define* (gnuboot-qemu-command* bios-image bios-image-path images #:key (memory-size 256))
  "Return as a monadic value the command to run QEMU with a writable overlay
on top of IMAGES, a list of disk images.  The QEMU VM has access to MEMORY-SIZE
MiB of RAM."
  (mlet* %store-monad ((system (current-system)))
    (return #~(begin
                (use-modules (srfi srfi-1))
                `(,(string-append #$qemu-minimal "/bin/"
                                  #$(qemu-command system))
                  "-snapshot"           ;for the volatile, writable overlay
                  ,@(if (file-exists? "/dev/kvm")
                        '("-enable-kvm")
                        '())
                  "-bios" ,(string-append #$bios-image #$bios-image-path)
                  "-no-reboot" "-m" #$(number->string memory-size)
                  ,@(append-map (lambda (image)
                                  (list "-drive" (format #f "file=~a,if=ide,media=disk"
                                                         image)))
                                #$images))))))

(define %test-gnuboot-installed-os
  (system-test
   (name "installed-os")
   (description
    "Test basic functionality of an OS installed like one would do by hand.
This test is expensive in terms of CPU and storage usage since we need to
build (current-guix) and then store a couple of full system images.")
   (value
    (mlet* %store-monad ((images  ((@@ (gnu tests install) run-install)
                                   (@@ (gnu tests install) %minimal-os)
                                   (@@ (gnu tests install) %minimal-os-source)))
                     (command
                          (gnuboot-qemu-command*
                           gnuboot-0.1-rc3-qemu-pc-2mib
                           "/share/gnuboot-0.1-rc3/qemu-pc-2mib/seabios_withgrub_qemu-pc_2mb_libgfxinit_txtmode_usqwerty.rom"
                           images)))
      (run-basic-test (@@ (gnu tests install) %minimal-os) command
                      "gnuboot-installed-os")))))

(define (tests-for-current-guix)
    (list
     (system-test
      (inherit %test-gnuboot-installed-os)
      (value (mparameterize %store-monad ((current-guix-package (current-guix)))
               (system-test-value %test-gnuboot-installed-os))))))

(define (system-test->manifest-entry test)
  "Return a manifest entry for TEST, a system test."
  (manifest-entry
    (name (string-append "test." (system-test-name test)))
    (version "0")
    (item test)))

(define (system-test-manifest)
  "Return a manifest containing all the system tests, or all those selected by
the 'TESTS' environment variable."
  (let* ((tests  (tests-for-current-guix)))
    (format (current-error-port) "Selected ~a system tests...~%"
            (length tests))
    (manifest (map system-test->manifest-entry tests))))

(system-test-manifest)
