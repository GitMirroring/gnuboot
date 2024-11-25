;;; Copyright © 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;; Copyright © 2024 Adrien 'neox' Bourmault <neox@gnu.org>
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

(use-modules (gcrypt pk-crypto))
(use-modules (guix pki))

(define bordeaux.guix.gnu.org
  "(public-key
     (ecc
       (curve Ed25519)
       (q #7D602902D3A2DBB83F8A0FB98602A754C5493B0B778C8D1DD4E0F41DE14DE34F#)))")


(cond ((and
	(eq? (length (program-arguments)) 2)
	(string=? (list-ref (program-arguments) 1) "force"))
       (if (authorized-key? (string->canonical-sexp bordeaux.guix.gnu.org))
	   (display "--substitute-urls=https://bordeaux.guix.gnu.org")))

      ((and
	(eq? (length (program-arguments)) 2)
	(string=? (list-ref (program-arguments) 1) "check"))
       (if (authorized-key? (string->canonical-sexp bordeaux.guix.gnu.org))
	   (display "bordeaux.guix.gnu.org is enabled\n")
	   (display "bordeaux.guix.gnu.org is disabled\n")))

      (#t ((lambda _
	     (display
	      (string-append
	       "Usage: "
	       "guix repl force-bordeaux-substitute.scm check # "
	       "check if bordeaux.guix.gnu.org is enabled or not.\n"))
	     (display
	      (string-append
	       "Usage: "
	       "guix repl force-bordeaux-substitute.scm force # "
	       "print '--substitute-urls=https://bordeaux.guix.gnu.org' "
	       "if bordeaux.guix.gnu.org is enabled.\n"))))))
