% Libreboot 20140622 release
% Leah Rowe
% 22 June 2014

Release 20140622 (5th release)
==============================

-   7th March 2014
-   revised 22nd June 2014

Officially supported
--------------------

-   ThinkPad X60
-   ThinkPad X60s

Revision (22nd June 2014 - extra)
---------------------------------

-   Documentation: added X60 Unbricking tutorial
-   Documentation: added info about enabling or disabling wifi
-   Documentation: added info about enabling or disabling trackpoint

Revision (22nd June 2014 - extra)
---------------------------------

-   Documentation: Improved the instructions for using flashrom
-   Documentation: Improved the instructions for using cbfstool (to
    change the default GRUB menu)
-   Documentation: Numerous small fixes.

Revision notes (22nd June 2014)
-------------------------------

-   updated GRUB (git 4b8b9135f1676924a8458da528d264bbc7bbb301, 20th
    April 2014)
-   Made "DeJavu Sans Mono" the default font in GRUB (fixes border
    corruption).
-   re-added background image in GRUB (meditating GNU)
-   added 6 more images:
    -   coreboot\_ukqwerty.rom (UK Qwerty keyboard layout in GRUB)
    -   coreboot\_serial\_ukqwerty.rom (UK Qwerty keyboard layout in
        GRUB)
    -   coreboot\_dvorak.rom (US Dvorak keyboard layout in GRUB)
    -   coreboot\_serial\_dvorak.rom (US Dvorak keyboard layout in GRUB)
    -   coreboot\_ukdvorak.rom (UK Dvorak keyboard layout in GRUB)
    -   coreboot\_serial\_ukdvorak.rom (UK Dvorak keyboard layout in
        GRUB)
    -   (coreboot.rom and coreboot\_serial.rom have US Qwerty keyboard
        layout in GRUB, as usual)
-   improved the documentation:
    -   removed FLASH\_INSTRUCTION and README.powertop and merged them
        with README
    -   removed obsolete info from README and tidied it up
    -   deleted README (replaced with docs/)
-   tidied up the menu entries in GRUB
-   tidied up the root directory of X60\_source/, sorted more files into
    subdirectories
-   improved the commenting inside the 'build' script (should make
    modifying it easier)
-   Renamed X60\_binary.tar.gz and X60\_source.tar.gz to
    libreboot\_bin.tar.gz and libreboot\_src.tar.gz, respectively.
-   Replaced "GNU GRUB version" with "FREE AS IN FREEDOM" on GNU
    GRUB start screen.
-   Added sha512.txt files in libreboot\_src and libreboot\_bin. (inside
    the archives)
-   Added libreboot\_bin.tar.gz.sha512.txt and
    libreboot\_src.tar.gz.sha512.txt files (outside of the archives)

