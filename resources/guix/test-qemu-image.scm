;;; This file is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; This file is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

(define-module (test-qemu-image)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages virtualization)
  #:use-module (guix build utils)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)) ;; for the images

(define-public
  (make-gnuboot-image-package target-name file-target gnuboot-version hash)
  (let ((target
         (string-replace-substring
          (string-replace-substring
           (string-downcase target-name)
           " " "")
          "." ""))
        (install-dir (string-append
                      "/share/gnuboot-" gnuboot-version "/"
                      (string-downcase target-name))))
    (package
     (name (string-append "gnuboot-" target "-" gnuboot-version))
     (version gnuboot-version)
     (source
      (origin
       (method url-fetch)
       (uri
        (if (string=? gnuboot-version "0.1-rc1")
            (string-append "mirror://gnu/gnuboot/gnuboot-" version "/"
                           "gnuboot-" version "_"
                           file-target ".tar.xz")
            (string-append "mirror://gnu/gnuboot/gnuboot-" version "/"
                           "roms/gnuboot-" version "_"
                           file-target ".tar.xz")))
       (sha256 (base32 hash))))
     (build-system copy-build-system)
     (arguments
      (list
       #:install-plan #~`(("./" #$install-dir))))
     (synopsis (string-append "GNU boot images for the Thinkpad " target-name))
     (description (string-append "Release of GNU Boot images for the
 thinkpad " target-name))
     (home-page "https://www.gnu.org/software/gnuboot")
     (license (append
               ;; Coreboot
               (list license:gpl2)
               ;; SeaBIOS, taken from the Guix SeaBIOS Package
               (list license:gpl3+ license:lgpl3+
                     ;; src/fw/acpi-dsdt.dsl is lgpl2
                     license:lgpl2.1
                     ;; src/fw/lzmadecode.c and src/fw/lzmadecode.h are lgpl3+
                     ;; and cpl with a linking exception.
                     license:cpl1.0)
               ;; GRUB
               (list license:gpl3+)
               ;; Memtest86+
               (list license:gpl2))))))

(define-public gnuboot-0.1-rc3-qemu
  (make-gnuboot-image-package
   "qemu-pc" "qemu-pc_2mb" "0.1-rc3"
   "1d82f9nnfb8q7z8sk7iacbsp7r23f1d1c6pwgc2kszcqp2jgr30f"))

(define-public gnuboot-version "0.1-rc3")
(define-public gnuboot-source
  (origin
   (method url-fetch)
   (uri (string-append "mirror://gnu/gnuboot/gnuboot-"
                       gnuboot-version
                       "/gnuboot-" gnuboot-version "_src.tar.xz"))
   (sha256
    (base32
     "19p4xw32jrkmpx13xbfsk3v58zfrwfmqb77x7psrackdq7ghk21n"))))

(define-public
  (make-gnuboot-utils-package
   name
   source
   version
   synopsis
   description)
  (package
   (name name)
   (version version)
   (source source)
   (build-system gnu-build-system)
   (arguments
    (list
     #:tests? #f
     #:make-flags
     #~(list
        (string-append "CC=" #$(cc-for-target))
        (string-append "DESTDIR=" #$output)
        "INSTALL=install"
        "PREFIX=/")
     #:phases
     #~(modify-phases
        %standard-phases
        (delete 'configure)
        (add-after
         'unpack 'enter-source
         (lambda _
           (chdir (string-append "coreboot/default/util/" #$name)))))))
   (synopsis synopsis)
   (description description)
   (home-page "https://www.gnu.org/software/gnuboot")
   (license license:gpl2)))

(define-public cbfstool
  (make-gnuboot-utils-package
   "cbfstool"
   gnuboot-source
   gnuboot-version
   "Tool to manipulate Coreboot image files"
   "This package provides @command{cbfstool}, a program that can
add a wide variety of files (bootblock, stage, payload, configuration
files, etc) to Coreboot File System (CBFS) images.  It supports
original CBFS images as well as images in the newer FMAP format.  It
also supports compressing files when requested."))

(define qemu-test-grub.cfg
  (package
    (name "qemu-test-grub.cfg")
    (version "1.0")
    (source #f)
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f ;no tests
      #:phases
      #~(modify-phases %standard-phases
          (delete 'bootstrap)
          (delete 'build)
          (delete 'configure)
          (delete 'patch-shebangs)
          (delete 'patch-usr-bin-file)
          (delete 'unpack)
          (replace 'install
            (lambda _
              (mkdir-p #$output)
              (let ((port
                     (open-file (string-append #$output "/grub.cfg") "al")))
                (display "serial -u 0 -s 115200
terminal_output --append serial_com0
echo \"test ok\"
halt\n" port)
                (close-port port)))))))
    (synopsis "grub.cfg used for testing.")
    (description "This grub.cfg sets the UART output to be able to verify that
the image boots fine by capturing the UART output. It then halts the
machine: this cleanly shuts down qemu.")
    (home-page #f)
    (license license:gpl3+))) ;; Same license than GRUB.

(define qemu-test-image
  (package
    (name "qemu-test-image")
    (version "1.0")
    (source #f)
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f ;no tests
      #:phases
      #~(modify-phases %standard-phases
          (delete 'bootstrap)
          (delete 'build)
          (delete 'configure)
          (delete 'patch-shebangs)
          (delete 'patch-usr-bin-file)
          (delete 'unpack)
          (replace 'install
            (lambda _
              (mkdir-p #$output)
              (let
                  ((qemu-pc.rom
                    (string-append
                     #$gnuboot-0.1-rc3-qemu
                     "/share/gnuboot-0.1-rc3/qemu-pc/"
                     "seabios_grubfirst_qemu-pc_2mb_libgfxinit_txtmode_usqwerty.rom"))
                    (test.rom
                     (string-append #$output "/test.rom")))
                (copy-file qemu-pc.rom test.rom)
                (chmod test.rom #o644)
                (invoke
                 "cbfstool"
                 test.rom
                 "remove" "-n" "grub.cfg")
                (invoke
                 "cbfstool"
                 test.rom
                 "add"
                 "-f" (string-append #$qemu-test-grub.cfg "/grub.cfg")
                 "-n" "grub.cfg"
                 "-t" "raw")))))))
    (native-inputs (list cbfstool gnuboot-0.1-rc3-qemu qemu-test-grub.cfg))
    (synopsis "GNU Boot image used for testing.")
    (description "This GNU Boot image uses a custom grub.cfg that sets the UART
output to be able to verify that the image boots fine by capturing the
UART output. It then halts the machine: this cleanly shuts down qemu.")
    (home-page #f)
    (license
     (append
      ;; Coreboot
      (list license:gpl2)
      ;; SeaBIOS, taken from the Guix SeaBIOS Package
      (list license:gpl3+ license:lgpl3+
            ;; src/fw/acpi-dsdt.dsl is lgpl2
            license:lgpl2.1
            ;; src/fw/lzmadecode.c and src/fw/lzmadecode.h are lgpl3+
            ;; and cpl with a linking exception.
            license:cpl1.0)
      ;; GRUB
      (list license:gpl3+)
      ;; Memtest86+
      (list license:gpl2))))) ;; Has GRUB

(define qemu-test
  (package
    (name "qemu-test")
    (version "1.0")
    (source #f)
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f ;no tests
      #:modules '((guix build gnu-build-system)
                  (guix build utils)
                  (ice-9 rdelim)
                  (ice-9 popen))
      #:phases
      #~(modify-phases %standard-phases
          (delete 'bootstrap)
          (delete 'build)
          (delete 'configure)
          (delete 'patch-shebangs)
          (delete 'patch-usr-bin-file)
          (delete 'unpack)
          (replace 'install
            (lambda _
              (mkdir-p #$output)
              (if
               (invoke
                "qemu-system-x86_64"
                "-M" "pc"
                "-bios" (string-append #$qemu-test-image "/test.rom")
                "-vga" "none" "-display" "none"
                "-chardev" (string-append
                            "file,id=char0,path=" #$output "/qemu.log")
                "-serial" "chardev:char0")
               (call-with-output-file
                   (string-append #$output "/test.log")
                 (lambda (port)
                   (format
                    port
                    "[ OK ] Run QEMU GRUB image.\n")))
               (call-with-output-file
                   (string-append #$output "/test.log")
                 (lambda (port)
                   (format
                    port
                    "[ !! ] Run QEMU GRUB image.\n"))))
              (let* ((port
                      (open-file (string-append #$output "/qemu.log") "r")))
                (if
                 (string=? (read-line port) "\x1b[H\x1b[J\x1b[1;1Htest ok")
                 (call-with-output-file
                     (string-append #$output "/test.log")
                   (lambda (port)
                     (format
                      port
                      "[ OK ] test\n")))
                 (call-with-output-file
                     (string-append #$output "/test.log")
                   (lambda (port)
                     (format
                      port
                      "[ !! ] test\n"))))
                (close-input-port port))
              (delete-file (string-append #$output "/qemu.log")))))))
    (native-inputs (list qemu qemu-test-image))
    (synopsis "Test if the qemu GRUB image boots.")
    (description "")
    (home-page #f)
    (license license:gpl3+)))
(list qemu-test)
