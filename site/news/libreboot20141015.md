% Libreboot 20141015 release
% Leah Rowe
% 15 October 2014

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
    -   It is unknown whether an X61 Tablet can have its mainboard
        replaced with an X60 Tablet motherboard.
-   **Lenovo ThinkPad T60** (Intel GPU) (there are issues; see below):
    -   See notes below for exceptions, and
        **hardware/\#supported\_t60\_list** for known working LCD panels.
    -   It is unknown whether a T61 can have its mainboard replaced with
        a T60 motherboard.
    -   See **future/\#t60\_cpu\_microcode**.
    -   T60p (and T60 variants with ATI GPU) will likely never be supported:
        **hardware/\#t60\_ati\_intel**
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See **hardware/\#macbook11**.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See **hardware/\#macbook21**.

Changes for this release (latest changes first, earliest changes last)
----------------------------------------------------------------------

-   Updated coreboot (git commit
    8ffc085e1affaabbe3dca8ac6a89346b71dfc02e), the latest at the time of
    writing.
-   Updated SeaBIOS (git commit
    67d1fbef0f630e1e823f137d1bae7fa5790bcf4e), the latest at the time of
    writing.
-   Updated Flashrom (svn revision 1850), the latest at the time of
    writing.
-   Updated GRUB (git commit 9a67e1ac8e92cd0b7521c75a734fcaf2e58523ad),
    the latest at the time of writing.
-   Cleaned up the documentation, removed unneeded files.
-   ec/lenovo/h8 (x60/x60s/x60t/t60): Enable
    wifi/bluetooth/wwan/touchpad/trackpoint by default.
-   Documentation: Updated list of T60 LCDs (Samsung LTN150XG 15" XGA
    listed as non-working).
-   builddeps-coreboot: Don't build libpayload (not needed. This was
    leftover by mistake, when trying out the TINT payload).
-   Replaced most diff files (patches) for coreboot with gerrit
    checkouts (cherry-pick).
-   Documentation: x60\_security.html and t60\_security.html: added
    links to info about the ethernet controller (Intel 82573).
-   Documentation: x60\_security.html and t60\_security.html: added
    notes about DMA and the docking station.
-   Documentation: configuring\_parabola.html: basic post-install steps
    for Parabola GNU+Linux (helpful, since libreboot development is
    being moved to Parabola at the time of writing).
-   builddeps-coreboot: use 'make crossgcc-i386' instead of 'make
    crossgcc'. Libreboot only targets x86 at the time of writing.
-   ROM images no longer include SeaBIOS. Instead, the user adds it
    afterwards. Documentation and scripts updated.
-   docs/images/encrypted\_parabola.html: Notes about linux-libre-grsec
-   Documentation: encrypted\_parabola.html: add tutorial for encrypted
    Parabola GNU+Linux installation.
-   Documentation: added more info about wifi chipsets

