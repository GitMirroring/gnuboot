;;; Copyright © 2024 Denis Carikli <GNUtoo@cyberdimension.org>
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

(define-module (gnuboot packages trisquel-netinst)
  #:use-module (gnu packages)
  #:use-module (gnu packages adns)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bootloaders)
  #:use-module (gnu packages cdrom)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages debian)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages mtools)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages virtualization)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (rnrs base)
  #:use-module (ice-9 safe-r5rs)
  #:use-module (srfi srfi-19)
  #:use-module (srfi srfi-26))

;; When running Guix through the resources/packages/ scripts,
;; '(current-filename)' returns the current filename, but in some
;; other situations it returns #f, so it's better to test for it
;; rather than fail with some cryptic message.
(assert (current-filename))

(define topdir
  (dirname (dirname (dirname (dirname (dirname (current-filename)))))))

(define (search-trisquel-resources-file file-name)
  "Search FILE-NAME in resources.  Return #f if not found."
  (string-append (string-append topdir "/resources/trisquel/") file-name))

(define-public 0xD24DDAC9226D5BA5E9F3BED3F5DAAAF74AD4C938
  "-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBGNQMswBEACpaLnL36fWyve4zXHKrN7AjXl+g5cafQyei4j1saTLfQatdJed
ubvcscZ3yERB+R0+8xuH2UqvR0E57ohZZaTiwcUWJ3VemxCZhwKy+Xvt1ZUNxBrh
2qAJBcP0+UCskSfWb+QQ1twNIeQ8Raj+kRPGphlNmjYxF2CFOsw9c56Lz+jNyty9
RC3Bg4l+Kcdhw23w5XBUXpHOyL6lsG317PWgEHUIQzNhXZfHL9GzwtTVQV8tVPyu
MOQIa7KDFXUEEnRN31mVLzfNHqKtTgFfP2LnSiD3LsBYsqJUtAnFGyORHgKhddRg
AKLrn1h0dEzkN+XsMaAWPrJg87ks7qXhhNz3SEI+t7dL4ozfUryRY9/8t/rXuQK+
ffRO/63i8SaHdu1Sl8MgHsNZRFOlbYGPw73TpdJ3JvfmfPNrRcTzsU1arMML8GWs
q6/QYDTWVYBYXy0kEqJQmeb3yJRvnIdVfiAdu9fyDPY8FCTUTcsxKe88u2bgrIaY
pNdoNFXojIC9JvMUM5QakMeog+ocTrZFOyhRMKfq5KEV/IDvsx6BfQzpjvK27LgX
LcdlP9HUVb9ZkKUgMGV1trqSA7kKrkDtfw+BInReTeSEnr4jsAwwiG62kDmmA4mo
dFq1MsWTAJTvpeeK+86gYliZukt6076zPrszmDJIyJWwHCLFn1jVkn1tlQARAQAB
tFpUcmlzcXVlbCBHTlUvTGludXggQXJjaGl2ZSBBdXRvbWF0aWMgU2lnbmluZyBL
ZXkgKDExL2FyYW1vKSA8dHJpc3F1ZWwtZGV2ZWxAdHJpc3F1ZWwuaW5mbz6JAk4E
EwEKADgCGwMFCwkIBwMFFQoJCAsFFgMCAQACHgECF4AWIQTSTdrJIm1bpenzvtP1
2qr3StTJOAUCY1AzAgAKCRD12qr3StTJOIxbD/44B7Kv+26TBW6BIiUlp1iDsvoX
yHk9yau41g6HjJR53KrFID4uszN9B+Cl+R0PjywfgC9OSSTKOjJq4/yQE00JpuF+
HtWieshZJs8QFKLD+mZQfRVCQweqj9HZS8AFH02LYkdsXiv4LZLaNljcHEPC3Y34
61xcg3viATgHL1ZJIPGT/vk425jQkEv9wjCjIvKsMhoE9EcqDBft9jKBC6H8LQwZ
iIYYNf28WRIW/EbutPe+0B3YOuw3PT/o/x40ySLWIJARODxBCqJ0wEC4PI7lUiLg
DGV0cUUykZz7BXKaIZIj+3wViR5zDGqIWx5TwdW2MJpDi9ove8N/3HaAc6BwQQXH
acZohOBqf/BjTKXQufVzx1sMBxB+a5zp284uICX54y/mm9tPHWcOOtl+NYj5qk4A
qn+vh433kNW622qJ8tt72kbcfaRekBnCj/A10U46TyWgZgMc7XxCc5r8slJWlhYZ
bRgbWWvkyH1s0mzbkAyNwrNa0vafcxOxO9psc7LG4mLPBqLoKKPmYY5Vgu8fdlbb
OLLFVvNhuTSX2ugkPfAp/XeWucQPJv3een1C1AWNcufhKYm1DZkYTGBeT8cbsw3T
0JnpRad+Sm2VhLcQ8PHKHUUeklVqUMjyCHo32sydo+I1MjC3QWycolljno2un9HU
TNAXG/1k2DzsqFPFjw==
=LJyh
-----END PGP PUBLIC KEY BLOCK-----")

(define trisquel-installer-public-key
  (package
    (name "trisquel-installer-public-key")
    (version "07-2024")
    (source #f)
    (build-system trivial-build-system)
    (home-page "https://trisquel.info")
    (arguments
     (list
      #:builder
      #~(begin
          (mkdir #$output)
          (mkdir (string-append #$output "/share/"))
          (mkdir (string-append #$output "/share/trisquel-installer/"))
          (call-with-output-file
              (string-append
               #$output
               "/share/trisquel-installer/"
               "0xD24DDAC9226D5BA5E9F3BED3F5DAAAF74AD4C938.asc")
            (lambda (port)
              (format
               port
               #$0xD24DDAC9226D5BA5E9F3BED3F5DAAAF74AD4C938))))))
    (synopsis "Trisquel installer signing key")
    (description #f)
    (license #f))) ;; Public keys are not copyrightable.

(define trisquel-netinst_11.0_amd64.iso.asc
  (package
    (name "trisquel-netinst-amd64-signature")
    (version "11.0")
    (source
     (origin
       (method url-fetch)
       (uri
        (string-append
         "https://cdimage.trisquel.info/trisquel-images/"
         "trisquel-netinst_11.0_amd64.iso.asc"))
    (sha256 (base32 "1b46w7wnd81yw71f18ia5wfsg1ybxbn132b8psh42p4xw2g40f4q"))))
    (build-system gnu-build-system)
    (home-page "https://trisquel.info")
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
              (mkdir-p (string-append #$output "/share/trisquel-installer/"))
              (copy-file
               #$source
               (string-append
                #$output
                "/share/trisquel-installer/"
                "trisquel-netinst_11.0_amd64.iso.asc")))))))
    (synopsis "Trisquel installer signing key")
    (description #f)
    (license #f))) ;; Signatures are not copyrightable.

;; TODO: move gpg in check
(define-public trisquel-netinst_11.0_amd64.iso
  (package
    (name "trisquel-netinst-amd64")
    (version "11.0")
    (source
     (origin
       (method url-fetch)
       (uri
        (string-append
         "https://cdimage.trisquel.info/trisquel-images/"
         "trisquel-netinst_11.0_amd64.iso"))
    (sha256 (base32 "0rn2fk91lhmgfcl267l7f6iqqky2qd8aiwkqpflmvi9dqlgf6g70"))))
    (build-system gnu-build-system)
    (native-inputs (list
                    gnupg
                    trisquel-netinst_11.0_amd64.iso.asc
                    trisquel-installer-public-key))
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
              (mkdir ".gnupg")
              (invoke
               "gpg"
               "--homedir" ".gnupg"
               "--import" (string-append
                           #$trisquel-installer-public-key
                           "/share/trisquel-installer/"
                           "0xD24DDAC9226D5BA5E9F3BED3F5DAAAF74AD4C938.asc"))
              (invoke
               "gpg"
               "--homedir" ".gnupg"
               "--verify"
               (string-append
                #$trisquel-netinst_11.0_amd64.iso.asc
                "/share/trisquel-installer/"
                "trisquel-netinst_11.0_amd64.iso.asc")
               #$source)
              (mkdir-p (string-append #$output "/share/trisquel-installer/"))
              (copy-file
               #$source
               (string-append
                #$output
                "/share/trisquel-installer/"
                "trisquel-netinst_11.0_amd64.iso")))))))
     (synopsis
      "Trisquel netinstall image")
    (description
     "Trisquel netinstall image.  It supports (mostly) automatic installation
through preseeding, though the user is expected to manually select the
right boot menu entry and to enter the URI to the preseed file
manually.")
    (home-page "https://trisquel.info")
    (license (license:fsdg-compatible
              "https://www.gnu.org/distros/free-distros.html"))))

(define-public gnuboot-trisquel-preseed.img
  (package
    (name "gnuboot-trisquel-preseed.img")
    (version "07-2024")
    (source #f)
    (home-page "https://gnu.org/software/gnuboot")
    (build-system gnu-build-system)
    (native-inputs (list
                    coreutils
                    dosfstools
                    libfaketime
                    mtools))
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (delete 'bootstrap)
          (delete 'configure)
          (delete 'patch-shebangs)
          (delete 'patch-usr-bin-file)
          (replace
           'unpack
           (lambda _
             (setenv "TZ" "UTC0")
             (copy-file
              #$(local-file (search-trisquel-resources-file "preseed.cfg"))
              "preseed.cfg")
             (invoke "touch" "-d" "@0" "preseed.cfg")
             (copy-file
              #$(local-file
                 (search-trisquel-resources-file "shutdown-after-boot.service"))
              "shutdown-after-boot.service")
             (invoke "touch" "-d" "@0" "shutdown-after-boot.service")
             (copy-file
              #$(local-file
                 (search-trisquel-resources-file "preseed.img.sha512"))
              "preseed.img.sha512")))
          (replace
           'build
           (lambda _
             (invoke "dd" "if=/dev/zero" "of=preseed.img" "count=2048")
             (invoke "mkfs.vfat"
                     "-a"
                     "--mbr=y"
                     "-n" "MEDIA"
                     "--invariant"
                     "preseed.img")
             (invoke "faketime" "@315532800" ; FAT epoch.
                     "mcopy"
                     "-i" "preseed.img"
                     "-m"
                     "preseed.cfg"
                     "::/preseed.cfg")
             (invoke  "faketime" "@315532800" ; FAT epoch.
                      "mcopy"
                      "-i" "preseed.img"
                      "-m"
                      "shutdown-after-boot.service"
                      "::/shutdown-after-boot.service")))
          (replace
           'install
           (lambda _
             (mkdir-p (string-append #$output "/share/trisquel-installer/"))
             (install-file "preseed.img" (string-append #$output "/share/trisquel-installer/"))))
          (replace
              'check
            (lambda* (#:key tests? #:allow-other-keys)
              (if tests?
                  (invoke "sha512sum" "-c" "preseed.img.sha512")))))))
    (synopsis "Preseed configuration as a FAT12 filesystem.")
    (description "FAT12 filesystem with inside a preseed.cfg file for automatic install,
as well as dependencies for the preseed.cfg, such as the files
preseed.cfg includes in the target rootfs.")
    (license license:gpl3+))) ;; License of GNU Boot.

;; TODO: make it reproducible
(define-public gnuboot-trisquel-grub.img
  (package
    (name "gnuboot-trisquel-grub.img")
    (version "07-2024")
    (source #f)
    (home-page "https://gnu.org/software/gnuboot")
    (build-system gnu-build-system)
    (native-inputs (list
                    grub
                    trisquel-netinst_11.0_amd64.iso
                    xorriso))
    (arguments
     (list
      #:tests? #f ;no tests
      #:phases
      #~(modify-phases %standard-phases
          (delete 'bootstrap)
          (delete 'configure)
          (delete 'patch-shebangs)
          (delete 'patch-usr-bin-file)
          (replace
           'unpack
           (lambda _
             (setenv "TZ" "UTC0")
             (mkdir-p "grub/boot/grub/")
             (invoke
              "xorriso"
              "-osirrox" "on"
              "-indev" (string-append
                        #$trisquel-netinst_11.0_amd64.iso
                        "/share/trisquel-installer/"
                        "trisquel-netinst_11.0_amd64.iso")
              "-extract" "/linux" "grub/boot/linux")
             (invoke "chmod" "770" "grub/boot/linux")
             (invoke "touch" "-d" "@0" "grub/boot/linux")
             (invoke
              "xorriso"
              "-osirrox" "on"
              "-indev" (string-append
                        #$trisquel-netinst_11.0_amd64.iso
                        "/share/trisquel-installer/"
                        "trisquel-netinst_11.0_amd64.iso")
              "-extract" "/initrd.gz" "grub/boot/initrd.gz")
             (invoke "chmod" "770" "grub/boot/initrd.gz")
             (invoke "touch" "-d" "@0" "grub/boot/initrd.gz")
             (copy-file
              #$(local-file (search-trisquel-resources-file "grub.cfg"))
              "grub/boot/grub/grub.cfg")
             (invoke "touch" "-d" "@0" "grub/boot/grub/grub.cfg")))
          (replace
           'build
           (lambda _
             ;; From Guix 1.4.0 in gnu/build/image.scm:
             ;; 'grub-mkrescue' calls out to mtools programs to create
             ;; 'efi.img', a FAT file system image, and mtools honors
             ;; SOURCE_DATE_EPOCH for the mtime of those files.  The
             ;; epoch for FAT is Jan. 1st 1980, not 1970, so choose
             ;; that.
             (setenv "SOURCE_DATE_EPOCH" "315532800")
             ;; TODO, replace "315532800" by the function below
             ;; (number->string
             ;;  (time-second
             ;;   (date->time-utc (make-date 0 0 0 0 1 1 1980 0))))
             (setenv "GRUB_FAT_SERIAL_NUMBER" "2e24ec82")
             (invoke "grub-mkrescue" "-o" "grub.img" "grub")))
          (replace
           'install
           (lambda _
             (mkdir-p (string-append #$output "/share/trisquel-installer/"))
             (install-file
              "grub.img"
              (string-append #$output "/share/trisquel-installer/")))))))
    (synopsis "Bootable netinstall that is meant to be used with a preseed image.")
    (description "To produce a netinstall image that works with preseed, we use
grub, a custom grub.cfg and the kernel and initramfs extracted from the trisquel
official netinstall.  This enables us to more easily understand how it works
and modify it than if we had to modify or rebuild an existing netinstall
image.")
    (license license:gpl3+))) ;; License of GRUB and GNU Boot.

(list gnuboot-trisquel-grub.img
      gnuboot-trisquel-preseed.img)
