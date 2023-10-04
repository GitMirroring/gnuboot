% Libreboot 20140720 release
% Leah Rowe
% 20 July 2014

Revisions for r20140720 (3rd beta) (20th July 2014)
---------------------------------------------------

-   Fixed typo that existed in 2nd beta where the release date of the
    2nd beta was listed as being in year 2016, when in actual fact it
    was 2014.
-   Documentation: added (preliminary) details about (rare) buggy CPUs
    on the ThinkPad T60 that were found to fail (instability, kernel
    panics, etc) without the microcode updates.
-   Documentation: added docs/hardware/x60\_heatsink.html for showing
    how to change the heatsink on the Thinkpad X60
-   Added ROM images for Azerty (French) keyboard layout in GRUB
    (courtesy of Olivier Mondoloni)
-   Tidied up some scripts:
    -   ~~Re-factored those scripts (made easier to read/maintain):
        build-x60, build-x60t, build-t60, build-macbook21~~
    -   ~~Reduced the number of grub configs to 2 (or 1, for macbook21),
        the build scripts now generate the other configs at build
        time.~~
    -   Deleted build-x60, build-x60t, build-t60, build-macbook21 and
        replaced with intelligent (generic) buildrom-withgrub script
    -   Updated build to use buildrom-withgrub script for building the
        ROM images.
    -   coreboot.rom and coreboot\_serial.rom renamed to
        coreboot\_usqwerty.rom and coreboot\_serial\_usqwerty.rom
    -   coreboot\_dvorak and coreboot\_serial\_dvorak.rom renamed to
        coreboot\_usdvorak.rom and coreboot\_serial\_usdvorak.rom
    -   Renamed coreboot\*rom to libreboot\*rom
    -   Made flash, lenovobios\_firstflash and lenovobios\_secondflash
        scripts fail if the specified file does not exist.
    -   Updated all relevant parts of the documentation to reflect the
        above.
-   Replaced background.png with background.jpg. added gnulove.jpg.
    (resources/grub/background/)
-   Updated buildrom-withgrub to use background.jpg instead of
    background.png
-   Updated buildrom-withgrub to use gnulove.jpg aswell
-   Updated resources/grub/config/macbook21/grub\*cfg to use gnulove.jpg
    background.
-   Updated resources/grub/config/{x60,t60,x60t}/grub\*cfg to use
    background.jpg background.
-   Documentation: updated docs/\#grub\_custom\_keyboard to be more
    generally useful.
-   nvramtool:
    -   Updated builddeps-coreboot script to build it
    -   Updated build script to include it in libreboot\_bin
-   Documentation: added docs/security/x60\_security.html (security
    hardening for X60)

