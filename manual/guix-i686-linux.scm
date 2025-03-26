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
(use-modules (gnu) (gnu bootloader) (gnu packages linux))
(operating-system
  (host-name "guix-i686-linux")
  (kernel linux-libre-lts)
  (bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (targets '(file-system-label "Guix_image"))
               (terminal-outputs '(console))))
  (file-systems (append (list (file-system
                                (device (file-system-label "Guix_image"))
                                (mount-point "/")
                                (type "ext4")))
                        %base-file-systems)))
