% Libreboot 20140911 release
% Leah Rowe
% 11 September 2014

6th release (pre-release, 7th beta)
===================================

-   Released 11th July 2014 (pre-release) 1st beta
-   Revised (pre-release, 2nd beta) 16th July 2014
-   Revised (pre-release, 3rd beta) 20th July 2014
-   Revised (pre-release, 4th beta) 29th July 2014
-   Revised (pre-release, 5th beta) 11th August 2014 (corrected 11th
    August 2014)
-   Revised (pre-release, 6th beta) 3rd September 2014
-   Revised (pre-release, 7th beta) 11th September 2014

Machines still supported (compared to previous release):
--------------------------------------------------------

-   **Lenovo ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard.

New systems supported in this release:
--------------------------------------

-   **Lenovo ThinkPad X60 Tablet** (1024x768 and 1400x1050) with
    digitizer support
    -   See **hardware/\#supported\_x60t\_list** for list of supported LCD
        panels
    -   It is unknown whether an X61 Tablet can have its mainboard
        replaced with an X60 Tablet motherboard.
-   **Lenovo ThinkPad T60** (Intel GPU) (there are issues; see below)
    -   See notes below for exceptions, and
        **hardware/\#supported\_t60\_list** for known working LCD panels.
    -   It is unknown whether a T61 can have its mainboard replaced with
        a T60 motherboard.
    -   T60p (and T60 variants with ATI GPU) will likely never be supported:
        **hardware/\#t60\_ati\_intel**
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See **hardware/\#macbook11**.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See **hardware/\#macbook21**.

Machines no longer supported (compared to previous release):
------------------------------------------------------------

-   **All previous systems still supported!**

Revisions for r20140911 (7th beta) (11th September 2014)
--------------------------------------------------------

-   The changes below were made in a git repository, unlike in previous
    releases. Descriptions below are copied from 'git log'.
-   Update .gitignore for new dependencies.
-   Use a submodule for i945-pwm.
-   Don't clean packages that fail or don't need cleaning.
-   Don't clean i945-pwm, it's not needed.
-   Regression fix: Parabola live ISO boot issues
-   Re-enable background images in ISOLINUX/SYSLINUX GRUB parser menus
-   Regression fix: Re-add CD-ROM (ata0) in GRUB
-   Documentation: add notes about performance penalty when using
    ecryptfs.
-   Documentation: Fixed spelling and grammatical errors.
-   Documentation: macbook21: add new system as tested
-   Documentation: macbook21: add info about improving touchpad
    sensitivity
-   Documentation: X60 Tablet: add more information about finger input
-   Documentation: release.html: Add information about recently merged
    commit in coreboot

