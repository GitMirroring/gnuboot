% Libreboot 20160818 release
% Leah Rowe
% 18 August 2016

This is in comparison to the Libreboot 20150518 release.

Installation instructions can be found at `docs/install/`. Building
instructions (for source code) can be found at `docs/git/\#build`.

Machines supported in this release:
-----------------------------------

-   **ASUS Chromebook C201**
    -   Check notes in ***docs/hardware/c201.html***
-   **Gigabyte GA-G41M-ES2L desktop motherboard**
    -   Check notes in ***docs/hardware/ga-g41m-es2l.html***
-   **Intel D510MO desktop motherboard**
    -   Check notes in ***docs/hardware/d510mo.html***
-   **Intel D945GCLF desktop motherboard**
    -   Check notes in ***docs/hardware/d945gclf.html***
-   **Apple iMac 5,2**
    -   Check notes in ***docs/hardware/imac52.html***
-   **ASUS KFSN4-DRE server board**
    -   PCB revision 1.05G is the best version (can use 6-core CPUs)
    -   Check notes in ***docs/hardware/kfsn4-dre.html***
-   **ASUS KGPE-D16 server board**
    -   Check notes in ***docs/hardware/kgpe-d16.html***
-   **ASUS KCMA-D8 desktop/workstation board**
    -   Check notes in ***docs/hardware/kcma-d8.html***
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

Changes for this release of Libreboot, relative to Libreboot version 20150518 (earliest changes are shown last and the most recent changes are shown first first)
---------------------------------------------------------------------------------------------

-   NEW BOARDS ADDED:
    -   ASUS Chromebook C201 (ARM laptop) (thanks to Paul Kocialkowski)
    -   Gigabyte GA-G41M-ES2L motherboard (desktop) (thanks to Damien
        Zammit)
    -   Intel D510MO motherboard (desktop) (thanks to Damien Zammit)
    -   ASUS KCMA-D8 motherboard (desktop) (thanks to Timothy Pearson)
    -   ASUS KFSN4-DRE motherboard (server) (thanks to Timothy Pearson)
    -   ASUS KGPE-D16 motherboard (server) (thanks to Timothy Pearson)

For details development history on these boards, refer to the git log
and documentation.

For boards previously supported, many fixes from upstream have been
merged.

Other changes (compared to libreboot 20150518), for libreboot in general
or for previously supported systems: (this is a summary. For more
detailed change list, refer to the git log)

256MiB VRAM allocated on GM45 (X200, T400, T500, R400) instead of 32MiB.
This is an improvement over both Lenovo BIOS and Libreboot 20150518,
allowing video decoding at 1080p to be smoother. (thanks Arthur Heymans)
To clarify, GM45 video performance in libreboot 20160818 is better than
on the original BIOS and the previous libreboot release.

64MiB VRAM on i945 (X60, T60, MacBook2,1) now supported in
coreboot-libre, and used by default (in the previous release, it was
8MiB allocated). Thanks to Arthur Heymans.

Higher battery life on GM45 (X200, T400, T500, R400) due to higher
cstates now being supported (thanks Arthur Heymans). C4 power states
also supported.

Higher battery life on i945 (X60, T60, MacBook2,1) due to better CPU
C-state settings. (Deep C4, Dynamic L2 shrinking, C2E).

Text mode on GM45 (X200, T400, T500, R400) now works, making it possible
to use MemTest86+ comfortably. (thanks to Nick High from coreboot)

Dual channel LVDS displays on GM45 (T400, T500) are now automatically
detected in coreboot-libre. (thanks Vladimir Serbinenko from coreboot)

Partial fix in coreboot-libre for GRUB display on GM45, for dual channel
LVDS higher resolution LCD panels (T400, T500). (thanks Arthur Heymans)

Massively improved GRUB configuration, making it easier to boot more
encrypted systems automatically, and generally a more useful menu for
booting the system (thanks go to Klemens Nanni of the autoboot project).
Libreboot now uses the grub.cfg provided by the installed GNU+Linux
distribution automatically, if present, switching to that configuration.
This is done across many partitions, where libreboot actively searches
for a configuration file (also on LVM volumes and encrypted volumes).
This should make libreboot more easy to use for non-technical users,
without having to modify the GRUB configuration used in libreboot.

Utilities archives is now source only. You will need to compile the
packages in there (build scripts included, and a script for installing
build dependencies). (binary utility archives are planned again in the
next release, when the new build system is merged)

SeaGRUB is now the default payload on all x86 boards. (SeaBIOS
configured to load a compressed GRUB payload from CBFS immediately,
without providing an interface in SeaBIOS. This way, GRUB is still used
but now BIOS services are available, so you get the best of both
worlds). Thanks go to Timothy Pearson of coreboot for this idea.

crossgcc is now downloaded and built as a separate module to
coreboot-libre, with a universal revision used to build all boards.

Individual boards now have their own coreboot revision and patches,
independently of each other board. This makes maintenance easier.

Updated all utilities, and modules (coreboot, GRUB, etc) to newer
versions, with various bugfixes and improvements upstream.

RTC century byte issue now fixed on GM45 in coreboot-libre, so the date
should now be correctly displayed when running the latest linux kernel,
instead of seeing 1970-01-01 when you boot (thanks to Alexander Couzens
from coreboot)

Build system now uses multiple CPU cores when building, speeding up
building for some people. Manually specifying how many cores are needed
is also possible, for those using the build system in a chroot
environment. (thanks go to Timothy Pearson from coreboot)

In the build system (git repository), https:// is now used when cloning
coreboot. http:// is used as a fallback for GRUB, if git:// fails.

New payload, the depthcharge bootloader (free bootloader maintained by
Google) for use on the ASUS Chromebook C201. (thanks go to Paul
Kocialkowski)

Various fixes to the ich9gen utility (e.g. flash component density is
now set correctly in the descriptor, gbe-less descriptors now supported)

