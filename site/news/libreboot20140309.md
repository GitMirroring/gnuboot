% Libreboot 20140309 release
% Leah Rowe
% 9 March 2014

Revision notes (9th March 2014):
--------------------------------

-   recreated coreboot config from scratch
-   GRUB loads even faster now (less than 2 seconds).
-   Total boot time reduced by further \~5 seconds.
-   Added crypto and cryptodisk modules to GRUB
-   cbfstool now included in the binary archives

Development notes
-----------------

-   Binary archive now have 2 images:
    -   With serial output enabled and memtest86+ included (debug level
        8 in coreboot)
    -   With serial output disabled and memtest86+ excluded (faster boot
        speeds) (debugging disabled)
-   Reduced impact on battery life:
    -   'processor.max\_cstate=2' instead of 'idle=halt' for booting
        default kernel
-   coreboot.rom (faster boot speeds, debugging disabled):
    -   Disabled coreboot serial output (Console-> in "make
        menuconfig")
    -   Set coreboot debug level to 0 instead of 8 (Console-> in
        "make menuconfig")
    -   Changed GRUB timeout to 1 second instead of 2 (in grub.cfg
    -   Removed background image in GRUB.
    -   Removed memtest86+ payload (since it relies on serial output)
-   coreboot\_serial.rom (slower boot speeds, debugging enabled):
    -   Boot time still reduced, but only by \~2 seconds
    -   has the memtest86+ payload included in the ROM
    -   has serial port enabled. How this is achieved (from
        X60\_source): Turn on debugging level to 8, and enable serial
        output
-   (in Console-> in coreboot "make menuconfig")
-   (and build with grub\_serial.cfg and grub\_memdisk\_serial.cfg)

