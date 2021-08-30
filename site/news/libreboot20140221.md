% Libreboot 20140221 release
% Leah Rowe
% 21 February 2014

Release 20140221 (4th release) {#release20140221}
==============================

-   21st February 2014

Officially supported
--------------------

-   ThinkPad X60
-   ThinkPad X60s

Development notes
-----------------

-   Removed SeaBIOS (redundant)
-   New GRUB version (2.02\~beta2)
    -   Fixes some USB issues
    -   Includes ISOLINUX/SYSLINUX parser
-   New grub.cfg
-   Removed useless options:
    -   options for booting sda 2/3/4
    -   seabios boot option
-   Added new menu entries:
    -   Parse ISOLINUX config (USB)
    -   Parse ISOLINUX config (CD)
    -   Added 'cat' module for use on GRUB command line.
-   "set pager=1" is set in grub.cfg, for less-like functionality

The "Parse" options read ./isolinux/isolinux.cfg on a CD or USB, and
automatically converts it to a grub config and switches to the boot menu
of that distro. This makes booting ISOs \*much\* easier than before.

