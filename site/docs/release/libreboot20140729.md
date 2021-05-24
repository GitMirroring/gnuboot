% Libreboot 20140729 release
% Leah Rowe
% 29 July 2014

Revisions for r20140729 (4th beta) (29th July 2014)
---------------------------------------------------

-   Documentation: improved (more explanations, background info) in
    docs/security/x60\_security.html (courtesy of Denis Carikli)
-   MacBook2,1 tested (confirmed)
-   macbook21: Added script 'macbook21\_firstflash' for flashing
    libreboot while Apple EFI firmware is running.
-   Documentation: macbook21: added software-based flashing instructions
    for flashing libreboot while Apple EFI firmware is running.
-   Reduced size of libreboot\_src.tar.gz:
    -   Removed .git and .gitignore from grub directory
        (libreboot\_src); not needed. Removing them reduces the size of
        the archive (by a lot). GRUB development should be upstream.
    -   Removed .git and .gitignore from bucts directory
        (libreboot\_src); not needed. Removing them reduces the size of
        the archive. bucts development should be upstream.
    -   Removed .svn from flashrom directory (libreboot\_src); not
        needed. Removing it reduces the size of the archive. flashrom
        development should be upstream.
-   Added ROMs with Qwerty (Italian) layout in GRUB
    (libreboot\*itqwerty.rom)
-   Added resources/utilities/i945gpu/intel-regs.py for debugging issues
    related to LCD panel compatibility on X60 Tablet and T60. (courtesy
    of [Michał Masłowski](http://mtjm.eu))

