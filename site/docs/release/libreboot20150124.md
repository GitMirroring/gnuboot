% Libreboot 20150124 release
% Leah Rowe
% 24 January 2015

Machines supported in this release:
===================================

-   **Lenovo ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard. An X60 Tablet motherboard will
        also fit inside an X60/X60s.
-   **Lenovo ThinkPad X60 Tablet** (1024x768 and 1400x1050) with
    digitizer support
    -   See **hardware/\#supported\_x60t\_list** for list of supported LCD
        panels
    -   It is unknown whether an X61 Tablet can have it's mainboard
        replaced with an X60 Tablet motherboard.
-   **Lenovo ThinkPad T60** (Intel GPU) (there are
    issuesinstall/x200\_external.html; see below):
    -   See notes below for exceptions, and
        **hardware/\#supported\_t60\_list** for known working LCD panels.
    -   It is unknown whether a T61 can have it's mainboard replaced
        with a T60 motherboard.
    -   See **future/\#t60\_cpu\_microcode**.
    -   T60p (and T60 laptops with ATI GPU) will likely never be
        supported: **hardware/\#t60\_ati\_intel**
-   **Lenovo ThinkPad X200**
    -   X200S and X200 Tablet are also supported, conditionally; see
        **hardware/x200.html\#x200s**
    -   **ME/AMT**: libreboot removes this, permanently.
        **hardware/gm45\_remove\_me.html**
-   **Lenovo ThinkPad R400** (r20150208 and later, only)
    -   **ME/AMT**: libreboot removes this, permanently.
        **hardware/gm45\_remove\_me.html**
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See **hardware/\#macbook11**.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See **hardware/\#macbook21**.

Changes for this release (latest changes first, earliest changes last)
----------------------------------------------------------------------

-   grub.cfg: Added (ahci1) to list of devices for ISOLINUX parser
    (CD/DVD) (this is needed for the X200 docking station).
-   grub.cfg: ISOLINUX parsing is now done on all USB partitions.
-   grub.cfg: Automatically switched to /boot/grub/libreboot\_grub.cfg
    on a partition, if it exists.
-   libreboot\_bin: added static ARM binaries for flashrom, cbfstool,
    ich9gen and ich9deblob (tested on beaglebone black).
-   Flashrom: removed redundant Macronix flashchip definitions (for X200
    owners).
-   Flashrom: added whitelist for ThinkPad X200.
-   X200: fixed uneven backlight (at low levels)
-   ich9macchange (new script, uses ich9gen): for changing the default
    MAC address on X200 ROM images.
-   ich9gen: added capability to change the default MAC address (and
    update the checksum)
-   ich9deblob: added new utility ich9gen: this can generate a
    descriptor+gbe image without a factory.rom dump present.
-   Modified ich9deblob to use a struct for Gbe, documenting everything.
-   Massively updated the ich9deblob utility: re-factored everything
    completely.
-   Enabled cstates 1 and 2 on macbook21. This reduces idle heat / power
    consumption.
-   buildrom-withgrub: disabled creation of \*txtmode\*.rom for X200
    (only framebuffer graphics work)
-   Updated SeaBIOS (again)
-   docs/install/\#flashrom\_x200: improve instructions
-   Updated flashrom (again) - patches updated
-   Updated GRUB (again)
-   Updated coreboot (again)
-   build-release: not all files were copied to libreboot\_src. fix
    that.
-   build-release: include cbmem (statically compiled) in libreboot\_bin
-   Documentation (X200): added software-based flashing instructions
-   Documentation: remove all references to the bus pirate (replaced
    with BBB flashing tutorials)
-   **New board:** ThinkPad X200S and X200 Tablet support added to
    libreboot
-   build: automatically find board names (configs) to build for
-   **New board:** ThinkPad X200 support added to libreboot
-   coreboot-libre config (all boards): enable USB dongle log output
    (for BeagleBone Black)
-   cleandeps: actually clean grubinvaders
-   .gitignore: add powertop directory
-   cleandeps: clean i945-pwm utility
-   scripts (all): fix typos
-   Documentation: general cleanup.
-   builddeps-flashrom: reduce build commands to a single for loop
-   scripts (all): replace unnecessary rm -Rf with rm -f
-   docs/release.html: add lenovo g505s to the list of candidates
-   .gitignore: add libreboot\_bin.tar.xz and libreboot\_src.tar.xz
-   libreboot\_bin.tar.xz: Include utils as statically linked binaries
    -   This means that the user does not have to install build
        dependency or build from source anymore.
-   deps-parabola (removed) Remove Parabola dependencies script. Will
    re-add later (properly tested)
-   grub.cfg: Add more path checks to isolinux parser (more ISOs should
    work now)
-   Update SeaBIOS
-   x60flashfrom5 (new), for X60 users upgrading from 5th/early release
-   Update flashrom
-   Update GRUB
-   Updated coreboot-libre
    -   i945: permanently set tft\_brightness to 0xff (fixes bug on X60
        where turning up brightness at max would make it loop back to
        low brightness)
-   getcb: Revert X60/T60 to legacy backlight controls
    -   The ACPI brightness patches were abandoned and obsolete.
-   grub.cfg: Only load initrd.img if it exists. Add rw to linux line
    (for ProteanOS)
-   build: Only generate the GRUB configurations once (re-use on all
    images)
-   Only build 2 GRUB payload executables, re-use on all boards.
-   resources/utilities/grub-assemble/gen.txtmode.sh: Use GNU BASH\
    resources/utilities/grub-assemble/gen.vesafb.sh: Use GNU BASH
-   scripts (error handling): Replace exit with exit 1 (make debugging
    easier)
-   Move most files in CBFS to GRUB memdisk, except grub.cfg and
    grubtest.cfg
-   docs/release.html Add DMP vortex86ex to list of candidates.
-   docs/release.html Add ThinkPad X201 to list of candidates.
-   New links added to docs/security/x60\_security and
    docs/security/t60\_security
-   lenovobios\_secondflash: Warn if BUCTS is not present. (not a
    dealbreaker. Can just pull out nvram battery/coin).
-   lenovobios\_firstflash: Fail if BUCTS fails. (anti-bricking
    precaution)
-   Removed obnoxious warnings from flashing scripts, improved
    documentation instead.
-   scripts (all): add proper error checking (fail fast, fail early. Do
    not continue if there are errors)
-   buildrom-withgrub: rename image to boardname\_layout\_romtype.rom
-   buildrom-withgrub: don't move cbfstool, execute directly
-   resources/utilities/grub-assemble: add French Dvorak (BEPO) keyboard
    layout.
-   Documentation: add docs/hardware/x60\_keyboard.html (show how to
    replace keyboard on X60/X60T)
-   Documentation: major cleanup (better structure, easier to find
    things)
-   docs/release.html: Remove Acer CB5 from list of future candidates.
    -   Too many issues. Chromebooks are crippled (soldered
        RAM/storage/wifi) and have too many usability issues for the
        libreboot project.
-   docs/gnulinux/grub\_cbfs.html Major cleanup. Usability improvements.
-   flash (flashrom script): remove boardmismatch=force
    -   This was put there before for users upgrading from libreboot r5
        to r6, but also allows the user to flash the wrong image. For
        example, the user could flash a T60 image on an X60, thus
        bricking the system. It's almost certain that most people have
        upgraded by now, so remove this potentially dangerous option.
-   Documentation: update compatibility list for X60T LCD panels.
-   docs/release.html: add note about X60 Tablet board in X60/X60s
-   docs/howtos/grub\_boot\_installer.html: small corrections
-   docs/howtos/grub\_boot\_installer.html: improved readability, fixed
    html errors
-   Documentation (macbook21 related): clean up

