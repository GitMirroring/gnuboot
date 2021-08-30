% Libreboot 20140903 release
% Leah Rowe
% 3 September 2014

Revisions for r20140903 (6th beta) (3rd September 2014)
-------------------------------------------------------

-   Added modified builddeb\* scripts for Parabola GNU+Linux-libre:
    buildpac, buildpac-flashrom, buildpac-bucts (courtesy of Noah
    Vesely)
-   Documentation: updated all relevant areas to mention use of
    buildpac\* scripts for Parabola users.
-   Documentation: added information showing how to enable or disable
    bluetooth on the X60
-   MacBook1,1 tested! See **hardware/\#macbook11**
-   Documentation: fixed typo in \#get\_edid\_panelname (get-edit
    changed to get-edid)
-   Documentation: added images/x60\_lcd\_change/ (pics only for now)
-   Added gcry\_serpent and gcry\_whirlpool to the GRUB module list in
    the 'build' script (for luks users)
-   **Libreboot is now based on a new coreboot version from August 23rd,
    2014:\
    Merged commits (relates to boards that were already supported in
    libreboot):**
    -   <http://review.coreboot.org/#/c/6697/>
    -   <http://review.coreboot.org/#/c/6698/> (merged already)
    -   <http://review.coreboot.org/#/c/6699/> (merged already)
    -   <http://review.coreboot.org/#/c/6696/> (merged already)
    -   <http://review.coreboot.org/#/c/6695/> (merged already)
    -   **<http://review.coreboot.org/#/c/5927/> (merged already)**
    -   <http://review.coreboot.org/#/c/6717/> (merged already)
    -   <http://review.coreboot.org/#/c/6718/> (merged already)
    -   <http://review.coreboot.org/#/c/6723/> (merged already)
        (text-mode patch, might enable memtest. macbook21)
    -   <http://review.coreboot.org/#/c/6732/> (MERGED) (remove useless
        ps/2 keyboard delay from macbook21. already merged)
-   These were also merged in coreboot (relates to boards that libreboot
    already supported):
    -   <http://review.coreboot.org/#/c/5320/> (merged)
    -   <http://review.coreboot.org/#/c/5321/> (merged)
    -   <http://review.coreboot.org/#/c/5323/> (merged)
    -   <http://review.coreboot.org/#/c/6693/> (merged)
    -   <http://review.coreboot.org/#/c/6694/> (merged)
    -   <http://review.coreboot.org/#/c/5324/> (merged)
-   Documentation: removed the section about tft\_brightness on X60 (new
    code makes it obsolete)
-   Removed all patches from resources/libreboot/patch/ and added new
    patch: 0000\_t60\_textmode.git.diff
-   Updated getcb script and DEBLOB script.
-   Updated configuration files under resources/libreboot/config/ to
    accomodate new coreboot version.
-   Removed grub\_serial\*.cfg and libreboot\_serial\*.rom, all
    configs/rom files are now unified (containing same configuration as
    serial rom files from before).
    -   Documentation: updated \#rom to reflect the above.
-   Updated GRUB to new version from August 14th, 2014.
-   Unified all grub configurations for all systems to a single grub.cfg
    under resources/grub/config/
-   Updated flashrom to new version from August 20th, 2014
-   Added getseabios and builddeps-seabios (builddeps and getall were
    also updated)
    -   Added instructions to 'buildrom-withgrub' to include
        bios.bin.elf and vgaroms/vgabios.bin from SeaBIOS inside the
        ROM.
-   Added seabios (and sgavgabios) to grub as payload option in menu
-   Disabled serial output in Memtest86+ (no longer needed) to speed up
    tests.
    -   MemTest86+ now works properly, it can output on the laptop
        screen (no serial port needed anymore).
-   Added getgrubinvaders, builddeps-grubinvaders scripts. Added these
    to getall and builddeps.
    -   Added [GRUB Invaders](http://www.coreboot.org/GRUB_invaders)
        menu entry in resources/grub/config/grub.cfg
-   Added rules to builddeps-coreboot to build libpayload with
    TinyCurses. (added appropriate instructions to cleandeps script).
-   Commented out lines in resources/grub/config/grub.cfg for loading
    font/background (not useful anymore, now that GRUB is in text-mode).
-   Commented out lines in buildrom-withgrub that included
    backgrounds/fonts (not useful anymore, now that GRUB is in
    text-mode).
-   Added resources/utilities/i945-pwm/ (from
    git://git.mtjm.eu/i945-pwm), for debugging acpi brightness on i945
    systems.
    -   Added instructions for it in builddeps, builddeps-i945pwm,
        builddeb and cleandeps
-   'build' script: removed the parts that generated sha512sum
    manifests (not needed, since release tarballs are GPG-signed)
-   'build' script: removed the parts that generated libreboot\_meta
    directory (not needed anymore, since \_meta will be hosted in git)
    -   Updated \#build\_meta (and other parts of documentation) to
        accomodate this change.
-   Documentation: simplified (refactored) the notes in \#rom
-   'build' script: removed the parts that generated libreboot\_bin
    and added them to a new script: 'build-release'
    -   Documentation: \#build updated to reflect the above.
-   ~~Added all gcry\_\* modules to grub (luks/cryptomount):
    gcry\_arcfour gcry\_camellia gcry\_crc gcry\_dsa gcry\_md4
    gcry\_rfc2268 gcry\_rmd160 gcry\_seed gcry\_sha1 gcry\_sha512
    gcry\_twofish gcry\_blowfish gcry\_cast5 gcry\_des gcry\_idea
    gcry\_md5 gcry\_rijndael gcry\_rsa gcry\_serpent gcry\_sha256
    gcry\_tiger gcry\_whirlpool~~
-   Added GNUtoo's list of GRUB modules (includes all of the gcry\_\*
    modules above), cryptomount should be working now.
-   Removed builddeb-bucts and builddeb-flashrom, merged them with
    builddeb ( updated accordingly)
-   Removed buildpac-bucts and buildpac-flashrom, merged them with
    buildpac ( updated accordingly)
-   Renamed buildpac to deps-parabola ( updated accordingly)
-   Documentation: removed all parts talking about build dependencies,
    replaced them with links to \#build\_dependencies
-   Documentation: emphasized more strongly on the documentation, the
    need to re-build bucts and/or flashrom before flashing a ROM image.
-   build-release: flashrom, nvramtool, cbfstool and bucts are no longer
    provided pre-compiled in binary archives, and are now in source form
    only. (to maximize distro compatibility).
-   'build' script: replaced grub.elf assembly instructons, it is now
    handled by a utility added under resources/utilities/grub-assemble
-   Moved resources/grub/keymap to
    resources/utilities/grub-assemble/keymap, and updated that utility
    to use it
-   Documentation: removed useless links to pictures of keyboard layouts
    and unmodified layouts.
-   Removed all unused fonts from dejavu-fonts-ttf-2.34/ directory
-   'buildrom-withgrub' script: updated it to create 2 sets of ROMs
    for each system: one with text-mode, one with coreboot framebuffer.
-   Documentation: updated \#rom to reflect the above
-   Deleted unused README and COPYING file from main directory
-   Removed some rm -Rf .git\* instructions from the get\* scripts and
    moved them to build-release script
-   Split up default grub.cfg into 6 parts:
    extra/{common.cfg,txtmode.cfg,vesafb.cfg} and
    menuentries/{common.cfg,txtmode.cfg,vesafb.cfg}
    -   buildrom-withgrub script uses these to generate the correct
        grub.cfg for each type of configuration.
-   grub\_memdisk.cfg (used inside grub.elf) now only loads grub.cfg
    from cbfs. It no longer enables serial output or sets prefix.
    (menuentries/common.cfg does instead)
-   resources/grub/config/extra/common.cfg, added:
    -   insmod instructions to load those modules: nativedisk, ehci,
        ohci, uhci, usb, usbserial\_pl2303, usbserial\_ftdi,
        usbserial\_usbdebug
    -   set prefix=(memdisk)/boot/grub
    -   For native graphics (recommended by coreboot wiki):\
        gfxpayload=keep\
        terminal\_output \--append gfxterm
    -   Play a beep on startup:\
        play 480 440 1
-   Documentation: updated gnulinux/grub\_cbfs.html to make it safer
    (and easier) to follow.
