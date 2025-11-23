;;; GNU Boot --- Boot software distribution
;;; Copyright © 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is part of GNU Boot.
;;;
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
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnuboot packages i945-thinkpads-install-utilities)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages libftdi)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages pciutils)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils))

(define-public coreboot-version "4.22")

(define-public coreboot-source
  (origin
    (method git-fetch)
    (uri (git-reference
          (url "https://github.com/coreboot/coreboot")
          (commit coreboot-version)))
    (file-name (git-file-name "coreboot" coreboot-version))
    (sha256
     (base32
      "125qw98f8zfhq0d5rpawxsjghqxwmg6yha1r1dqmwbxd7i12bj8f"))
    (snippet
     #~(begin
         (use-modules (guix build utils))
         (for-each
          delete-file
          (list
           ;; The data.1.bin and data.4.bin were found thanks
           ;; to the Canoeboot nuke.list that is in
           ;; config/coreboot/default/nuke.list. Both files
           ;; are ELF files and they do contain code
           ;; (verified with strings).
           "tests/data/lib/lzma-test/data.1.bin"
           "tests/data/lib/lzma-test/data.4.bin"
           ;; This contains an array named init_script_rev_a with a
           ;; lot of hexadecimal values. It is unclear if it is code
           ;; or data but the array name suggest it is code.
           "src/vendorcode/cavium/bdk/libbdk-hal/if/bdk-if-phy-vetesse-8514.c"
           ;; This one is in
           ;; resources/coreboot/fam15h_rdimm/blobs.list and it
           ;; contains a firmware whose source code is missing.
           "src/vendorcode/cavium/bdk/libbdk-hal/if/bdk-if-phy-vetesse.c"))))))

(define-public bucts
  (package
    (name "bucts")
    (version coreboot-version)
    (source coreboot-source)
    (inputs (list pciutils))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f ;no tests
      #:make-flags #~(list (string-append "CC="
                                          #$(cc-for-target))
                           (string-append "DESTDIR="
                                          #$output) "INSTALL=install"
                           "PREFIX=/")
      #:phases #~(modify-phases %standard-phases
                   (delete 'configure) ;no configure script
                   (add-after 'unpack 'enter-source
                     (lambda _
                       (chdir "util/bucts")))
                   (add-after 'enter-source 'fixup-version
                     (lambda _
                       (substitute* "Makefile"
                         (("^VERSION:=*")
                          #$(string-append "VERSION:=" version)))))
                   ;; no install target
                   (replace 'install
                     (lambda _
                       (let ((bin (string-append #$output "/bin"))
                             (doc (string-append #$output "/share/doc/bucts/"))
                             (licenses (string-append #$output
                                        "/share/licenses/bucts/")))
                         (install-file "bucts" bin)
                         (install-file "readme.md" doc)
                         (install-file "../../COPYING" licenses)))))))
    (home-page "https://coreboot.org")
    (synopsis "Tool to manipulate swap boot firmware bootblocks on the Intel
 I945 chipsets")
    (description
     "This package provides @command{bucts}.  That command can flip a
 bit in the BUC.TS register of the Intel I945 chipsets and show the
register status.  When the bit is set, it swaps the bootblock
location.  Because the bootblock region is often set read-only by the
default BIOS, this enables to bypass that restriction and is used as
part of a procedure to replace the nonfree BIOS with free software on
various computers (Lenovo X60, X60s, X60T, T60, probably more).")
    (license license:gpl2)))

(define-public flashrom-bucts
  (package
    (name "flashrom-bucts")
    (version "1.2")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://download.flashrom.org/releases/flashrom-v"
                    version ".tar.bz2"))
              (sha256
               (base32
                "0ax4kqnh7kd3z120ypgp73qy1knz47l6qxsqzrfkd97mh5cdky71"))
              (patches (search-patches "flashrom-1.2.patch"))))
    (build-system gnu-build-system)
    (inputs (list dmidecode pciutils))
    (native-inputs (list pkg-config))
    (arguments
     (list
      #:make-flags
      #~(list "CC=gcc"
              (string-append "PREFIX=" #$output)
              (string-append "VERSION=" #$version " with patch for bucts")
              "CONFIG_NOTHING=yes"
              "CONFIG_INTERNAL=yes"
              "CONFIG_DEFAULT_PROGRAMMER=PROGRAMMER_INTERNAL")
      #:tests? #f                      ; no 'check' target
      #:phases
      #~(modify-phases
         %standard-phases
         (delete 'configure)            ; no configure script
         (add-before
          'build 'patch-exec-paths
          (lambda*
           (#:key inputs #:allow-other-keys)
           (substitute*
            "dmi.c"
            (("\"dmidecode\"")
             (format #f "~S"
                     (search-input-file inputs "/sbin/dmidecode"))))))
         (add-before
          'build 'patch-type-error
          (lambda _
            ;; See https://github.com/flashrom/flashrom/pull/133
            (substitute*
             "libflashrom.c"
             (("supported_boards\\[i\\].working = binfo\\[i\\].working")
              "supported_boards[i].working = (enum flashrom_test_state)binfo[i].working")
             (("supported_chipsets\\[i\\].status = chipset\\[i\\].status")
              "supported_chipsets[i].status = (enum flashrom_test_state)chipset[i].status"))))
         (add-after
          'patch-type-error 'rename-flashrom
          (lambda _
            (substitute*
             "Makefile"
             (("PROGRAM = flashrom")
              "PROGRAM = flashrom-bucts")
             (("\\$\\(PROGRAM\\)\\.8\\.tmpl")
              "flashrom.8.tmpl")))))))
    (home-page "https://flashrom.org/")
    (synopsis "Identify, read, write, erase, and verify ROM/flash chips on I945
Thinkpads with the stock BIOS and the bucts utility.")
    (description
     "It is possible to install GNU Boot on I945 Thinkpads without opening
the computer even if the nonfree bios sets the bootblock region (the
last 64K of the flash chip) read-only.  To bypass that read-only
restriction we use an utility (bucts) that tells the hardware to swap
the primary bootblock with the secondary one for the next boot.
After that we need a patched version of flashrom (provided by this
package) to rewrite all the flash chip but the last 64K. Then after
rebooting we have to disable that swap and reflash again.")
    (license license:gpl2)))

(list bucts
      flashrom-bucts)
