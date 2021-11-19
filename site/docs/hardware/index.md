---
title: Hardware compatibility list 
x-toc-enable: true
...

This sections relates to known hardware compatibility in libreboot.

For installation instructions, refer to [../install/](../install/).

NOTE: For T60/R60 thinkpads, make sure that it has an Intel GPU, not an ATI GPU
because coreboot lacks native video initialization for the ATI GPUs on these
machines.

(for later machines like T500, T400, ATI GPU doesn't matter, because it also
has an Intel GPU, and Libreboot uses the Intel one)

Supported hardware
==================

Libreboot supports the following systems in this release:

### Desktops (AMD, Intel, x86)

-   [Gigabyte GA-G41M-ES2L motherboard](ga-g41m-es2l.md)
-   [Intel D510MO and D410PT motherboards](d510mo.md)
-   [Intel D945GCLF](d945gclf.md)
-   [Apple iMac 5,2](imac52.md)

### Servers/workstations (AMD, x86)

-   [ASUS KCMA-D8 motherboard](kcma-d8.md)
-   [ASUS KGPE-D16 motherboard](kgpe-d16.md)
-   [ASUS KFSN4-DRE motherboard](kfsn4-dre.md)

### Laptops (ARM)

-   [ASUS Chromebook C201](c201.md) (**Libreboot 20160907 only**)

### Laptops (Intel, x86)

-   ThinkPad X60 / X60S / X60 Tablet
-   ThinkPad T60 (with Intel GPU)
-   [Lenovo ThinkPad X200 / X200S / X200 Tablet](x200.md)
-   [Lenovo ThinkPad R400](r400.md)
-   [Lenovo ThinkPad T400 / T400S](t400.md)
-   [Lenovo ThinkPad T500](t500.md)
-   [Lenovo ThinkPad W500](t500.md)
-   [Lenovo ThinkPad R500](r500.md)
-   [Apple MacBook1,1 and MacBook2,1](macbook21.md)

'Supported' means that the build scripts know how to build ROM images
for these systems, and that the systems have been tested (confirmed
working). There may be exceptions; in other words, this is a list of
'officially' supported systems.

EC update on i945 (X60, T60) and GM45 (X200, T400, T500, R400, W500, R500)
==============================================================

It is recommended that you update to the latest EC firmware version. The
[EC firmware](../../faq.md#ec-embedded-controller-firmware) is separate from
libreboot, so we don't actually provide that, but if you still have
Lenovo BIOS then you can just run the Lenovo BIOS update utility, which
will update both the BIOS and EC version. See:

-   [../install/#flashrom](../install/#flashrom)
-   <http://www.thinkwiki.org/wiki/BIOS_update_without_optical_disk>

NOTE: this can only be done when you are using Lenovo BIOS. How to
update the EC firmware while running libreboot is unknown. Libreboot
only replaces the BIOS firmware, not EC.

Updated EC firmware has several advantages e.g. better battery
handling.

How to find what EC version you have (i945/GM45)
------------------------------------------------

In GNU+Linux, you can try this:

    grep 'at EC' /proc/asound/cards

Sample output:

    ThinkPad Console Audio Control at EC reg 0x30, fw 7WHT19WW-3.6

7WHT19WW is the version in different notation, use search engine to find
out regular version - in this case it's a 1.06 for x200 tablet
