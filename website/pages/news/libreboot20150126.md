% Libreboot 20150126 release
% Leah Rowe
% 26 January 2015

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

Revisions for r20150126 (relative to r20150124)
-----------------------------------------------

This is a bug fix release based on r20150124. It contains a few small
changes:

-   grub.cfg: hardcode the list of partitions to search (speeds up
    booting considerably. GRUB regexp isn't very well optimized)
-   Docs (x200.html hcl): Remove incorrect information
-   Documentation (bbb\_setup.md): Fix typos
-   build-release: delete ich9fdgbe\_{4m,8m}.bin files from ich9gen
    -   These were accidentically included in the r20150124 release.
        They are generated from ich9gen so it's ok, but they don't
        need to be in the archive.
-   Documentation (grub\_cbfs.md): Looping in libreboot\_grub.cfg (Add
    notes about it if the user copied from grub.cfg in CBFS.)

