% Libreboot 20140711 release
% Leah Rowe
% 11 July 2014

Revisions for r20140711 (1st beta) (11th July 2014)
---------------------------------------------------

-   Initial release (new coreboot base, dated 1st June 2014. See
    'getcb' script for reference)
-   DEBLOBBED coreboot
-   Removed the part from memtest86+ 'make' where it tried to connect
    to some scp server while compiling. (commented out line 24 in the
    Makefile)
-   X60 now uses a single .config (for coreboot)
-   X60 now uses a single grub.cfg (for grub memdisk)
-   X60 now uses a single grub.elf (payload)
-   Added new native graphics code for X60 (replaces the old 'replay'
    code) from Vladimir Serbinenko: 5320/9 from review.coreboot.org
-   T60 is now supported, with native graphics. (5345/4 from
    review.coreboot.org, cherry-picked on top of 5320/9 checkout)
-   Added macbook2,1 support (from Mono Moosbart and Vladimir
    Serbinenko) from review.coreboot.org (see 'getcb' script to know
    how that was done)
    -   Documentation: added information linking to correct page and
        talking about which models are supported.
    -   Added resources/libreboot/config/macbook21config
    -   macbook21: Added 'build-macbook21' script and linked to it in
        'build' (ROMs included under bin/macbook21/)
    -   macbook21: Removed dd instructions from build-macbook21 script
        (macbook21 does not need bucts when flashing libreboot while
        Apple EFI firmware is running)
    -   Documentation: Added macbook21 ROMs to the list of ROMs in
        docs/\#rom
    -   Documentation: Write documentation linking to Mono Moosbart's
        macbook21 and parabola page (and include a copy)
-   Documentation: added a copy of Mono's Parabola install guide (for
    macbook21 with Apple EFI firmware) and linked in in main index.
-   Documentation: added a copy of Mono's Coreboot page (for macbook21)
    and linked it in main index.
-   T60: Copy CD option from the grub.cfg files for T60 \*serial\*.rom
    images into the grub configs for non-serial images. (T60 laptops have
    CD/DVD drive on main laptop)
-   macbook21: remove options in build-macbook21 for \*serial\*.rom
    (there is no dock or serial port available for macbook21)
-   Added patches for backlight controls on X60 and T60 with help from
    Denis Carikli (see ./resources/libreboot/patch/gitdiff and ./getcb
    and docs/i945\_backlight.md)
    -   Documentation: added docs/i945\_backlight.html showing how
        backlight controls were made to work on X60/T60
-   Documentation: Added info about getting LCD panel name based on EDID
    data.
    -   Documentation: Added a link to this from the list of supported
        T60 laptopss and LCD panels for T60 (so that the user can check
        what LCD panel they have).
-   X60/T60: Merged patches for 3D fix (from Paul Menzel) when using
    kernel 3.12 or higher (see ./resources/libreboot/patch/gitdiff and
    ./getcb)
    -   based on 5927/11 and 5932/5 from review.coreboot.org
-   Improved thinkpad\_acpi support (from coreboot ): xsensors shows
    more information.
    -   From 4650/29 in review.coreboot.org (merged in coreboot
        'master' on June 1st 2014)
-   Merged changes for digitizer (X60 Tablet) and IR (X60 and T60) based
    on 5243/17, 5242/17 and 5239/19 from review.coreboot.org
    -   (see ./resources/libreboot/patch/gitdiff and ./getcb)
-   Documentation: added information about building flashrom using
    'builddeps-flashrom' script.
-   Re-created resources/libreboot/config/x60config
-   Re-created resources/libreboot/config/t60config
-   Added 'x60tconfig' in resources/libreboot/config (because X60
    Tablet has different information about serial/model/version in
    'dmidecode')
    -   Added 'build-x60t' script
    -   Updated 'build' script to use 'build-x60t'
    -   Documentation: added to \#config section the section
        \#config\_x60t (libreboot configuration and dmidecode info)
    -   Documentation: added x60t ROMs to the list of ROMs
-   Tidied up the 'builddeps' script (easier to read)
-   Tidied up the 'cleandeps' script (easier to read)
-   Annotated the 'buildall' script
-   Added 'getcb' script for getting coreboot revision used from git,
    and patching it.
-   Added 'getgrub' script for getting the GRUB revision used from
    git, and patching it.
-   Added 'getmt86' script for getting the memtest86+ version used,
    and patching it.
-   Added 'getbucts' script for getting the bucts version used.
-   Added 'getflashrom' script for getting the flashrom version used,
    and patching it
-   Added 'getall' script which runs all of the other 'get' scripts.
-   Add instructions to the 'build' script to prepare
    libreboot\_meta.tar.gz
    -   New archive: libreboot\_meta.tar.gz - minimal archive, using the
        'get' scripts to download all the dependencies (coreboot,
        memtest, grub and so on).
-   Documentation: added information about where 'build' script
    prepares the libreboot\_meta.tar.gz archive.
-   Documentation: added information about how to use the 'get'
    scripts in libreboot\_meta.tar.gz (to generate
    libreboot\_src.tar.gz)
    -   Documentation: mention that meta doesn't create libreboot\_src/
        directory, but that libreboot\_meta itself becomes the same.
    -   Documentation: advise to rename libreboot\_meta to
        libreboot\_src after running 'getall'.
-   Annotated the 'builddeb' script, to say what each set of
    dependencies are for.
-   Separated bucts/flashrom builddeb sections into separate scripts:
    builddeb-flashrom, builddeb-bucts.
-   Documentation: Updated relevant parts based on the above.
-   Added instructions to 'build' script for including builddeb-bucts
    and builddeb-flashrom in libreboot\_bin
-   Updated flashrom checkout (r1822 2014-06-16) from SVN
    (http://flashrom.org/Downloads).
    -   Updated flashing instructions in docs/ for new commands needed
        (Macronix chip on X60/T60)
    -   For X60/T60 (flashrom): Patched
        flashchips.c\_lenovobios\_macronix and
        flashchips.c\_lenovobios\_sst executables for SST/macronix
        (included in resources/flashrom/patch)
    -   Updated builddeps to build flashrom\_lenovobios\_sst and
        flashrom\_lenovobios\_macronix, for X60/T60 users with Lenovo
        BIOS
    -   moved the flashrom build instructions from 'builddeps' and put
        them in 'builddeps-flashrom', excecuting that from
        'builddeps'.
    -   Added builddeps-flashrom to libreboot\_bin.tar.gz
-   flashrom: added patched flashchips.c to resources/flashrom/patch
    (automatically use correct macronix chip on libreboot, without using
    '-c' switch)
    -   removed 'MX25L1605' and 'MX25L1605A/MX25L1606E' entries in
        flashchips.c for the patched version of flashchips.c
    -   added instructions to 'builddeps-flashrom' to automatically
        use this modified flashchips.c in the default build
-   Added builddeb to libreboot\_bin.tar.gz
-   Moved 'bucts' build instructions from builddeps to builddeps-bucts
    -   builddeps now runs 'builddeps-bucts' instead
    -   Added 'builddeps-bucts' to libreboot\_bin.tar.gz
    -   Documentation: Added information about using 'builddep-bucts'
        to build the BUC.TS utility.
-   Added 'lenovobios\_firstflash' and 'lenovobios\_secondflash'
    scripts
    -   Added instructions to 'build' script for including those files
        in libreboot\_bin
    -   Documentation: Add tutorial for flashing while Lenovo BIOS is
        running (on X60/T60)
-   Added 'flash' script (make sure to run builddeps-flashrom first)
    which (while libreboot is already running) can use flashrom to flash
    a ROM
    -   eg: "sudo ./flash bin/x60/coreboot\_serial\_ukdvorak.rom"
        equivalent to "sudo ./flashrom/flashrom -p internal -w
        bin/x60/coreboot\_uk\_dvorak.rom"
    -   updated 'build' script to include the 'flash' script in
        libreboot\_bin.tar.gz
-   Documentation: replaced default flashrom tutorial to recommend the
    'flash' script instead.
-   Re-add cbfstool source code back into libreboot\_bin.tar.gz, as
    cbfstool\_standalone
    -   Patched that version to work (able to be built and used) without
        requiring the entire coreboot source code.
    -   Created patched version of the relevant source files and added
        it into resources/cbfstool/patch
        -   see coreboot/util/cbfstool/rmodule.c and then the patched
            version in resources/cbfstool/patch/rmodule.c
        -   see coreboot/src/include/rmodule-defs.h and the rule in
            'build' for including this in
            ../libreboot\_bin/cbfstool\_standalone
    -   Added instructions to 'build' script for applying this patch
        to the cbfstool\_standalone source in libreboot\_bin
    -   Added instructions to 'build' script for then re-compiling
        cbfstool\_standalone in libreboot\_bin after applying the patch
    -   Added a 'builddeps-cbfstool' script (in src, but only used in
        bin and put in bin by 'build') that compiles
        cbfstool\_standalone in libreboot\_bin (make), moves the
        cbfstool and rmodtool binaries into libreboot\_bin/ and then
        does 'make clean' in libreboot\_bin/cbfstool\_standalone
    -   Updated the 'build' script to put 'builddeps-cbfstool' in
        libreboot\_bin
    -   Updated the 'build' script in the cbfstool (standalone) part
        to accomodate the above.
    -   Documentation: added notes about cbfstool (standalone) in
        libreboot\_bin
-   Documentation: made docs/gnulinux/grub\_cbfs.html slightly easier to
    follow.
-   Annotate the 'build\*' scripts with 'echo' commands, to help the
    user understand what it actually happening during the build process.
-   Documentation: added information about how 'dmidecode' data was
    put in the coreboot configs
    -   Documentation: In fact, document how the 'config' files in
        resources/libreboot/config/ were created
-   Documentation: Added information about which ThinkPad T60 laptops are
    supported, and which are not.
-   Documentation: added information about LCD inverters (for upgrading
    the LCD panel on a T60 14.1' XGA or 15.1' XGA)
    -   it's FRU P/N 41W1478 (on T60 14.1") so this was added to the
        docs.
    -   it's P/N 42T0078 FRU 42T0079 or P/N 41W1338 (on T60 15.1") so
        this was added to the docs.
-   Documentation: added information about names of LCD panels for T60
    to the relevant parts of the documentation.
-   Documentation: added information (with pictures) about the
    differences between T60 with Intel GPU and T60 with ATI GPU.
-   Documentation: added pictures of keyboard layouts (US/UK
    Qwerty/Dvorak) to the ROM list, to let the user compare with their
    own keyboard.
-   Move the coreboot build instructions in 'builddeps' into
    'builddeps-coreboot' and link it in 'builddeps'
    -   Link to 'builddeps-coreboot' in final stage of 'getcb'
-   Move GRUB build instructions from 'builddeps' into
    'builddeps-grub', link from 'builddeps'
    -   Link to 'builddeps-grub' in final stage of 'getgrub'
-   Move MemTest86+ build instructions from 'builddeps' into
    'builddeps-memtest86', link from 'builddeps'
    -   Link to 'builddeps-memtest86' in final stage of 'getmt86'
-   made 'build' script put resources/ directory in libreboot\_bin, to
    make builddeps-flashrom work in libreboot\_bin
-   Removed instructions for building source code in the 'get' script
    (they don't really belong there)
-   Added libfuse-dev and liblzma-dev to the list of GRUB dependencies
    in 'builddeb' script.
-   Converted the 'RELEASE' file to 'docs/RELEASE.html'
-   Added those dependencies to builddeb script (for GRUB part): gawk
    libdevmapper-dev libtool libfreetype6-dev
-   Added to build script the instruction at the end to create a
    sha512sum.txt with a file manifest plus checksums.
-   Deleted the RELEASE and BACKPORT files (no longer needed)
-   Documentation: added information about X60/T60 dock (ultrabase x6
    and advanced mini dock) to relevant sections.
    -   Added to docs/\#serial

