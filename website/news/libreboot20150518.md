% Libreboot 20150518 release
% Leah Rowe
% 18 May 2015

Installation instructions can be found at ***docs/install/***. Building
instructions (for source code) can be found at ***docs/git/\#build***.

Machines supported in this release:
-----------------------------------

-   **ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard. An X60 Tablet motherboard will
        also fit inside an X60/X60s.
-   **ThinkPad X60 Tablet** (1024x768 and 1400x1050) with digitizer
    support
    -   See ***docs/hardware/\#supported\_x60t\_list*** for list of supported
        LCD panels
    -   It is unknown whether an X61 Tablet can have it's mainboard
        replaced with an X60 Tablet motherboard.
-   **ThinkPad T60** (Intel GPU) (there are issues; see below):
    -   See notes below for exceptions, and
        ***docs/hardware/\#supported\_t60\_list*** for known working LCD
        panels.
    -   It is unknown whether a T61 can have it's mainboard replaced
        with a T60 motherboard.
    -   See ***docs/future/\#t60\_cpu\_microcode***.
    -   T60p (and T60 laptops with ATI GPU) will likely never be
        supported: ***docs/hardware/\#t60\_ati\_intel***
-   **ThinkPad X200**
    -   X200S and X200 Tablet are also supported, conditionally; see
        ***docs/hardware/x200.html\#x200s***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad R400**
    -   See ***docs/hardware/r400.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad T400**
    -   See ***docs/hardware/t400.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad T500**
    -   See ***docs/hardware/t500.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See ***docs/hardware/\#macbook11***.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See ***docs/hardware/\#macbook21***.

Changes for this release, relative to r20150208 (earliest changes last, recent changes first)
---------------------------------------------------------------------------------------------

-   Add a whitelist entry to board\_enable.c in flashrom, for the
    ThinkPad R400, T400 and T500
-   Updated flashrom (to SVN revision 1889)
    -   X200 whitelist patch removed (merged upstream)
    -   X200 whitelist modified to include X200S and X200 Tablet
-   libreboot\_util: don't include cmos layout files (not needed
    anymore)
-   **coreboot-libre: backport patches for X200 Tablet digitizer
    support**
-   build/release/archives: create SHA512 sum manifest file of the
    release archives
-   build/release/archives: separate crossgcc into a new archive
-   disabled generation of txtmode ROM images for now (they will be back
    again in the next release)
-   coreboot-libre: delete unused code (reduce size of src archive)
-   Flashing guides: make them more friendly to colourblind people
-   docs/gnulinux/encrypted\_\*.html: Remove mention of password
    length - it was arbitrary and pointless.
-   docs/maintain/: Finish the guide
-   scripts/download/coreboot: use diffs included in libreboot, not
    external gerrit cherry-picks - review.coreboot.org (gerrit) being
    down no longer kills libreboot (backup mirrors of the master
    repository exist)
-   docs/install/bbb\_setup.html: Add info about wp/hold and pinouts
-   docs/: improve the description of libreboot
-   docs/hardware/gm45\_remove\_me.html: notes about the demefactory utility
-   docs/install/bbb\_setup.html: EHCI debug: recommend linux-libre
-   docs/install/bbb\_setup.html: EHCI Debug logging setup guide
-   docs/hardware/t500.html: Add screen compatibility report (TODO: fix
    incompatible screens)
-   Update coreboot(again) + merge GM45 hybrid GPU patches - means that
    T400/T500 with the ATI+Intel hybrid GPU setup will work (ATI
    disabled, Intel permanently enabled). power\_on\_after\_fail nvram
    option added to all GM45 boards, defaulting to No, so that plugging
    it AC doesn't boot up the system against the users will. Net20DC is
    now the default debug dongle on all boards (compatible with BBB).
-   demefactory (new utility): create GM45 factory.rom without the ME
-   ich9deblob: re-factor descriptor.c functions
-   docs/hardware/t500.html: add hardware logs
-   docs/gnulinux/encrypted\_\*.html: No password for default entry
-   docs/git/: Add more details about BUC.TS
-   grub.cfg: Also scan for grub2/grub.cfg, not just grub/grub.cfg
-   docs/maintain/ (new section. WIP!): Maintaining libreboot
-   docs/gnulinux/grub\_boot\_installer.html: Fix hazardous instruction
-   docs/tasks.html: Better categorization between intel/amd/arm
-   docs/install/bbb\_setup.html: notes about SPI flashing stability
-   docs/install/bbb\_setup.html: more names for the 0.1" cables
-   docs/install/\*\_external.html: add disclaimer about thermal paste
-   docs/install/bbb\_setup.html: Fix broken links
-   docs/install/bbb\_setup.html: preliminary notes about EHCI debug
-   docs/hardware/gm45\_remove\_me.html: Link to websites talking about the
    ME
-   docs/install/{t400,t500,r400}\_external.html: Notes about CPU
    compatibility
-   Delete the ich9macchange script. It's useless, and confuses people
-   docs/hardware/gm45\_remove\_me.html: prioritize ich9gen executable path
-   docs/hardware/gm45\_remove\_me.html: prioritize changing mac address
-   docs/hardware/gm45\_remove\_me.html: less confusing notes about ich9gen
-   build/dependencies/parabola: Add dependencies for x86\_64
-   scripts/dependencies/paraboladependencies: build dependencies
    (32-bit Parabola)
-   **New board**: ThinkPad T500
-   Add diffs for descriptor/gbe differences between T500 and X200
-   coreboot-libre: provide better blob categorization
-   docs/hardware/gm45\_remove\_me.html: add notes about flash write protect
-   **New board**: ThinkPad T400
-   GRUB: add partial vesamenu.c32 support (fixes tails ISOLINUX menu)
-   Update GRUB (to revision fa07d919d1ff868b18d8a42276d094b63a58e299)
-   Update coreboot (to revision
    83b05eb0a85d7b7ac0837cece67afabbdb46ea65)
    -   Intel CPU microcode (most of it) no longer deleted, because it
        was deleted upstream (moved to a 3rd party repository).
    -   MacBook2,1 cstate patch is no longer cherry picked (merged
        upstream)
    -   Patch to disable use of timestamps in coreboot no longer
        included (merged upstream)
-   coreboot-libre: don't list vortex86ex kbd firmware as microcode
    (list it separately)
-   coreboot-libre: don't rm \*/early\_setup\_ss.h (these are not
    blobs)
-   coreboot-libre: add GPLv3 license to the findblobs script
-   coreboot-libreboot: don't rm raminit\_tables (nahelem/sandybridge)
    (they are not blobs)
-   coreboot-libre: don't delete the .spd.hex files (they are not
    blobs)
-   build/release/archives: don't put rmodtool in libreboot\_util
-   docs/install/x200\_external.html: recommend installing GNU+Linux at
    the end
-   docs/install/x200\_external.html: add more photos, improve
    instructions
-   build/clean/grub: use distclean instead of clean
-   grub-assemble: Add the *bsd* and *part\_bsd* modules
-   build/roms/withgrub: Only run ich9gen if gm45/gs45 images exist
-   docs/git/: Add notes about building for specific boards
-   build/roms/withgrub: Allow building for a custom range of boards
-   grub-assemble: Disable verbose output
-   Add documentation on how to unlock root encrypted fs with key in
    initramfs in Parabola Linux
-   docs/gnulinux/grub\_cbfs.html: Improve structure (easier to use)
-   grub.cfg: Disable the beep on startup
-   docs/install/bbb\_setup.html: Make the guide easier to use
-   docs/gnulinux/grub\_cbfs.html: Remove redundant instructions
-   docs/install/x200\_external.html: Mark pins in the images
-   docs/install/bbb\_setup.html: Replace 3.3V PSU photo with ATX PSU
-   docs/hardware/x200.html: Add dumps from 4-MiB X200 with Lenovo BIOS 3.22
-   docs/hardware/x200.html: Add dumps from 4-MiB X200 with Lenovo BIOS 3.18
-   grub.cfg: add syslinux\_configfile menuentry for ahci0
-   grub.cfg: Add more paths for syslinux\_configfile
-   docs/future.html: T60: Add EDID dump from LG-Philips LP150E05-A2K1
-   docs/install/bbb\_setup.html: Further clarify which clip is needed
-   bash scripts: Make script output more user-friendly in general
-   bash scripts: Only enable verbose output if DEBUG= is used
-   build: Support multiple extra options - now possible to build
    multiple images for arbitrary boards (configs), but without building
    the entire collection.
-   Deleted the signing archive key - the finger print and ID is given
    instead, so that the user can download it from a key server
-   scripts/helpers/build/release: Move docs to separate archive -
    reduces the size of the other archives considerably
-   Move DEBLOB to resources/utilities/coreboot-libre/deblob
-   scripts/helpers/build/release: Delete DEBLOB from libreboot\_src/ -
    not needed in libreboot\_src (release archive) because it contains a
    coreboot revision that has already been deblobbed.
-   flash (script): Use *build* instead of *DEBLOB* to know if in src
-   docs/install/r400\_external.html: Show images, don't link.
-   docs/install/x200\_external.html: Show images, don't link.
-   docs/install/bbb\_setup.html: Show images, instead of linking
-   Documentation: optimize all images (reduce file sizes)
-   Remove download links from the release page (and the archive page) -
    release archives are hosted differently following this release,
    which means that the old methods are no longer viable.
-   Moved ich9macchange to resources/scripts/misc/ich9macchange
-   ich9macchange: assume that the script is being run from \_util (act
    only on one ROM image, defined by a user-provided path)
-   Move grub-background to resources/scripts/misc/grub-background
-   grub-background: assume that it is being run from libreboot\_util
-   grub-background: change only one ROM image, specified by path
-   build (release archives): Add the commitid file to release/
-   build-release: Move the release archives to release/
-   Merge all build scripts into a single generic script, with helpers
    in resources/scripts/helpers/build/
-   Replace *getall* with *download*, which takes as input an argument
    specifying which program the user wants to download.
-   Moved the get scripts to resources/scripts/helpers/download/
-   build-release: Remove the powertop entries
-   Documentation: general improvements to the flashing instructions
-   Merged all flashing scripts into a single script
-   Updated GRUB
-   bucts: Make it build without git
-   Moved dejavu-fonts-ttf-2.34/AUTHORS to resources/grub/font/
-   Deleted GRUB Invaders from libreboot
-   Deleted SeaBIOS from libreboot
-   build-release: optimize use of tar (reduced file sizes)
-   grub.cfg: add another SYSLINUX config location
    (/syslinux/syslinux.cfg)
-   build-release: remove the bin/ directory from libreboot\_util
-   cleandeps: delete the bin/ directory
-   buildrom-withgrub: create the bin directory if it does not exist
-   coreboot-libre: don't use git for version timestamp
-   i945-pwm: add clean command to Makefile
-   i945-pwm: add -lz to Makefile
-   docs/install/x200\_external: Mention GPIO33 non-descriptor mode
-   docs/hardware/: Remove redundant links
-   ich9macchange: Add R400
-   build-release: Separate ROM images into individual archives
-   build-release: rename libreboot\_bin to libreboot\_util
-   **New board:** ThinkPad R400 support added to libreboot.
-   bbb\_setup.html: tell user to use libreboot's own flashrom

