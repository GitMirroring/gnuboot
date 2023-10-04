% Libreboot 20150208 release
% Leah Rowe
% 8 February 2015

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

Revisions for r20150208 (relative to r20150126)
-----------------------------------------------

This is a maintenance release (polishing) based on r20150126. Users who
installed r20150126 don't really need to update to this release.

-   buildrom-withgrub: use gnulove.jpg background on 16:10 laptops
    (MacBook2,1 and X200)
-   build-release: include grub-background script in libreboot\_bin
-   grub-background (new): lets user change GRUB background image
-   grub-assemble: Add link to original utility.
-   buildrom-withgrub: Put background.jpg in CBFS, not GRUB memdisk
-   grub-assemble: merge scripts into a single script gen.sh
-   Documentation: implement theme, drastically improve readability
-   docs/hardware/: update list of compatible T60 LCD panels
-   docs/: more clarification of libreboot's stated purpose.
-   build-release: include the commitid file in the release archives
-   docs/: Further emphasize the GNU+Linux requirement.
-   lenovobios\_firstflash: fix BASH errors
-   lenovobios\_secondflash: fix BASH errors
-   docs/install/x200\_external.html: Tell user to switch MAC address.
-   docs/git/: Add to the list of x86\_64 compatible hosts.
-   docs/install/: Remove old (obsolete) information.
-   docs/git/: Say that the build dependencies are for src (and not
    nedeed for libreboot\_bin)
-   build: re-factor the descriptor/gbe generating loop for GM45/ICH9M
-   X60, X60S and X60 Tablet now the same ROM images.
-   Add QEMU (q35/ich9) support to libreboot.
-   Add QEMU (i440fx/piix4) support to libreboot
-   docs/: Re-write the description of what libreboot is.
-   docs/release.html: Add notes about how to use GPG.
-   build-release: delete the commitid file from release archives
-   build-release: create file named commitid after build-release

