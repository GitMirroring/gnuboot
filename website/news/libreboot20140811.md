% Libreboot 20140811 release
% Leah Rowe
% 11 August 2014

Corrections to r20140811 (5th beta) (11th August 2014)
------------------------------------------------------

-   Fixed typo where revision list for 5th beta was listed as March 11th
    2014, when in fact it was August 11th 2014
-   Fixed incorrect grub.cfg that was actually placed in
    resources/grub/config/x60/grub\_usqwerty.cfg which broke the default
    GRUB menu entry on X60

Revisions for r20140811 (5th beta) (11th August 2014)
-----------------------------------------------------

-   build: added 'luks', 'lvm', 'cmosdump' and 'cmostest' to the
    list of modules for grub.elf
-   Documentation: added pics showing T60 unbricking (still need to
    write a tutorial)
-   build: include cmos.layout
    (coreboot/src/mainboard/manufacturer/model/cmos.layout) files in
    libreboot\_bin
-   Documentation: added **install/x60tablet\_unbrick.html**
-   Documentation: added **install/t60\_unbrick.html**
-   Documentation: added **install/t60\_lcd\_15.html**
-   Documentation: added **install/t60\_security.html**
-   Documentation: added **install/t60\_heatsink.html**
-   Documentation: Renamed RELEASE.html to release.html
-   Documentation: removed pcmcia reference in x60\_security.html (it's
    cardbus)
-   Documentation: added preliminary information about randomized seal
    (for physical intrusion detection) in x60\_security.html and
    t60\_security.html
-   Documentation: added preliminary information about
    preventing/mitigating cold-boot attack in x60\_security.html and
    t60\_security.html
-   Documentation: added info to \#macbook21 warning about issues with
    macbook21
-   Documentation: X60/T60: added information about checking custom ROMs
    using dd to see whether or not the top 64K region is duplicated
    below top or not. Advise caution about this in the tutorial that
    deals with flashing on top of Lenovo BIOS, citing the correct dd
    commands necessary if it is confirmed that the ROM has not been
    applied with dd yet. (in the case that the user compiled their own
    ROMs from libreboot, without using the build scripts, or if they
    forgot to use dd, etc).
-   Split resources/libreboot/patch/gitdiff into separate patch files
    (getcb script updated to accomodate this change).
-   Re-added .git files to bucts
-   Fixed the oversight where macbook21\_firstflash wasn't included in
    binary archives
-   Release archives are now compressed using .tar.xz for better
    compression

