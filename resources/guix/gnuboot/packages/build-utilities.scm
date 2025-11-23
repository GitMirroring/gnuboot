;;; Copyright © 2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is part of GNU Boot.
;;;
;;; GNU Boot is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Bootx is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Boot.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnuboot packages build-utilities)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix packages))

(define-public ich9utils
  (package
    (name "ich9utils")
    (version "0") ; There is only 1 commit so far.
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://notabug.org/libreboot/ich9utils.git")
              (commit "53749b0c6f7c5778bdd1ec2b91cd230626752579")))
       (file-name (git-file-name "coreboot" version))
       (sha256
	(base32
	 "1sjzpc1gar0ry42h7h6jfgbcivs7840fqk4crrmw6l2236yi0wsn"))))
    (arguments
     (list
      #:tests? #f ; no tests
      #:phases
      #~(modify-phases %standard-phases
          (delete 'configure) ; there is only a Makefile
          (replace 'install
             (lambda* (#:key inputs #:allow-other-keys)
               (let ((bin (string-append #$output "/bin/")))
                 (install-file "demefactory" bin)
                 (install-file "ich9deblob" bin)
                 (install-file "ich9gen" bin)
                 (install-file "ich9show" bin)))))))
    (build-system gnu-build-system)
    (home-page "https://notabug.org/libreboot/ich9utils.git")
    (synopsis "Various tools that deal with the ICH9 Intel Flash Descriptor (IFD)")
    (description
     "The ich9utils package contains various utilities:
@itemize
@item demefactory: Disable ME firmware on GM45 boot flash, but leave
the ME region intact and enable read-write on all regions.
@item ich9deblob: Disable and remove the ME firmware from ICH9M / GM45 boot flash.
@item ich9gen: Generate deblobbed IFD and GBE 12KiB file.
@item ich9show: Show the ICH9 region read/write status.
@end itemize")
    (license license:gpl3+)))

(list ich9utils)
