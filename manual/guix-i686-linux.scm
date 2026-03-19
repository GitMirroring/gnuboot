;;; Copyright (C) 2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
;;;
;;; This file is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version, or (at your option) under the
;;; terms of the GNU Free Documentation License, Version 1.3 or any
;;; later version published by the Free Software Foundation.
;;;
;;; This file is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; and the GNU Free Documentation License along with this file.  If
;;; not, see <https://www.gnu.org/licenses/>.

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
