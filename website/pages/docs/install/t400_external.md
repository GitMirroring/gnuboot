---
title: Flashing the ThinkPad T400 externally
x-unreviewed: true
...

Initial flashing instructions for T400.

This guide is for those who want libreboot on their ThinkPad T400 while
they still have the original Lenovo BIOS present. This guide can also be
followed (adapted) if you brick your T400, to know how to recover.

An
["HMM"](https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/43y6629_05.pdf#page=386)
(Hardware Maintenance Manual) detailing the process of [dis]assembly
is available for this model. Be careful when reassembling the laptop as
the screws on page 114 (with title "1130 Keyboard bezel") are swapped
and if you follow the HMM you will punch a hole through the bezel in the
upper right corner.

Serial port {#serial_port}
-----------

EHCI debug might not be needed. It has been reported that the docking
station for this laptop has a serial port, so it might be possible to
use that instead.

A note about CPUs
=================

[ThinkWiki](http://www.thinkwiki.org/wiki/Category:T400) has a list of
CPUs for this system. The Core 2 Duo P8400, P8600 and P8700 are believed
to work in libreboot.

T9600, T9500, T9550 and T9900 are all compatible, as reported by users.

Quad-core CPUs
--------------

Very likely to be compatible, but requires hardware modification.
Based on info from German forum post about installing Core Quad CPU on T500 found in coreboot mailing list. Currently work in progress and no guide available.

- [Coreboot mailing list post](https://mail.coreboot.org/pipermail/coreboot/2016-November/082463.html)
- [German forum post about install Core Quad on T500](https://thinkpad-forum.de/threads/199129)


A note about GPUs
=================

Some models have an Intel GPU, while others have both an ATI and an
Intel GPU; this is referred to as "switchable graphics". In the *BIOS
setup* program for lenovobios, you can specify that the system will use
one or the other (but not both).

Libreboot is known to work on systems with only the Intel GPU, using
native graphics initialization. On systems with switchable graphics, the
Intel GPU is used and the ATI GPU is disabled, so native graphics
initialization works all the same.

CPU paste required
==================

See [\#paste](#paste).

Flash chip size {#flashchips}
===============

Use this to find out:

    flashrom -p internal

MAC address {#macaddress}
===========

Refer to [mac\_address.html](../hardware/mac_address.html).

How to flash externally
=========================

Refer to [spi.html](spi.html) as a guide for external re-flashing.

The procedure
-------------

Remove *all* screws, placing them in the order that you removed them:\
![](/software/gnuboot/web/static/img/t400/0001.jpg) ![](/software/gnuboot/web/static/img/t400/0002.jpg)

Remove those three screws then remove the rear bezel:\
![](/software/gnuboot/web/static/img/t400/0003.jpg) ![](/software/gnuboot/web/static/img/t400/0004.jpg)
![](/software/gnuboot/web/static/img/t400/0005.jpg) ![](/software/gnuboot/web/static/img/t400/0006.jpg)

Remove the speakers:\
![](/software/gnuboot/web/static/img/t400/0007.jpg) ![](/software/gnuboot/web/static/img/t400/0008.jpg)
![](/software/gnuboot/web/static/img/t400/0009.jpg) ![](/software/gnuboot/web/static/img/t400/0010.jpg)
![](/software/gnuboot/web/static/img/t400/0011.jpg)

Remove the wifi:\
![](/software/gnuboot/web/static/img/t400/0012.jpg) ![](/software/gnuboot/web/static/img/t400/0013.jpg)

Remove this cable:\
![](/software/gnuboot/web/static/img/t400/0014.jpg) ![](/software/gnuboot/web/static/img/t400/0015.jpg)
![](/software/gnuboot/web/static/img/t400/0016.jpg) ![](/software/gnuboot/web/static/img/t400/0017.jpg)
![](/software/gnuboot/web/static/img/t400/0018.jpg)

Unroute those antenna wires:\
![](/software/gnuboot/web/static/img/t400/0019.jpg) ![](/software/gnuboot/web/static/img/t400/0020.jpg)
![](/software/gnuboot/web/static/img/t400/0021.jpg) ![](/software/gnuboot/web/static/img/t400/0022.jpg)
![](/software/gnuboot/web/static/img/t400/0023.jpg)

Remove the LCD assembly:\
![](/software/gnuboot/web/static/img/t400/0024.jpg) ![](/software/gnuboot/web/static/img/t400/0025.jpg)
![](/software/gnuboot/web/static/img/t400/0026.jpg) ![](/software/gnuboot/web/static/img/t400/0027.jpg)
![](/software/gnuboot/web/static/img/t400/0028.jpg) ![](/software/gnuboot/web/static/img/t400/0029.jpg)
![](/software/gnuboot/web/static/img/t400/0030.jpg) ![](/software/gnuboot/web/static/img/t400/0031.jpg)

Disconnect the NVRAM battery:\
![](/software/gnuboot/web/static/img/t400/0033.jpg)

Disconnect the fan:\
![](/software/gnuboot/web/static/img/t400/0034.jpg)

Unscrew these:\
![](/software/gnuboot/web/static/img/t400/0035.jpg) ![](/software/gnuboot/web/static/img/t400/0036.jpg)
![](/software/gnuboot/web/static/img/t400/0037.jpg) ![](/software/gnuboot/web/static/img/t400/0038.jpg)

Unscrew the heatsink, then lift it off:\
![](/software/gnuboot/web/static/img/t400/0039.jpg) ![](/software/gnuboot/web/static/img/t400/0040.jpg)

Disconnect the power jack:\
![](/software/gnuboot/web/static/img/t400/0041.jpg) ![](/software/gnuboot/web/static/img/t400/0042.jpg)

Loosen this:\
![](/software/gnuboot/web/static/img/t400/0043.jpg)

Remove this:\
![](/software/gnuboot/web/static/img/t400/0044.jpg) ![](/software/gnuboot/web/static/img/t400/0045.jpg)
![](/software/gnuboot/web/static/img/t400/0046.jpg) ![](/software/gnuboot/web/static/img/t400/0047.jpg)
![](/software/gnuboot/web/static/img/t400/0048.jpg)

Unscrew these:\
![](/software/gnuboot/web/static/img/t400/0049.jpg) ![](/software/gnuboot/web/static/img/t400/0050.jpg)

Remove this:\
![](/software/gnuboot/web/static/img/t400/0051.jpg) ![](/software/gnuboot/web/static/img/t400/0052.jpg)

Unscrew this:\
![](/software/gnuboot/web/static/img/t400/0053.jpg)

Remove the motherboard (the cage is still attached) from the right hand
side, then lift it out:\
![](/software/gnuboot/web/static/img/t400/0054.jpg) ![](/software/gnuboot/web/static/img/t400/0055.jpg)
![](/software/gnuboot/web/static/img/t400/0056.jpg)

Remove these screws, placing the screws in the same layout and marking
each screw hole (so that you know what ones to put the screws back into
later): ![](/software/gnuboot/web/static/img/t400/0057.jpg) ![](/software/gnuboot/web/static/img/t400/0058.jpg)
![](/software/gnuboot/web/static/img/t400/0059.jpg) ![](/software/gnuboot/web/static/img/t400/0060.jpg)
![](/software/gnuboot/web/static/img/t400/0061.jpg) ![](/software/gnuboot/web/static/img/t400/0062.jpg)

Separate the motherboard:\
![](/software/gnuboot/web/static/img/t400/0063.jpg) ![](/software/gnuboot/web/static/img/t400/0064.jpg)

Connect your programmer, then connect GND and 3.3V\
![](/software/gnuboot/web/static/img/t400/0065.jpg) ![](/software/gnuboot/web/static/img/t400/0066.jpg)
![](/software/gnuboot/web/static/img/t400/0067.jpg) ![](/software/gnuboot/web/static/img/t400/0069.jpg)
![](/software/gnuboot/web/static/img/t400/0070.jpg) ![](/software/gnuboot/web/static/img/t400/0071.jpg)

A dedicated 3.3V PSU was used to create this guide, but at ATX PSU is
also fine:\
![](/software/gnuboot/web/static/img/t400/0072.jpg)

Of course, make sure to turn on your PSU:\
![](/software/gnuboot/web/static/img/x200/disassembly/0013.jpg)

Now, you should be ready to install libreboot.

Refer to the external flashing instructions [here](spi.html), and when you're
done, re-assemble your laptop.

Thermal paste (IMPORTANT)
=========================

Because part of this procedure involved removing the heatsink, you will
need to apply new paste. Arctic MX-4 is ok. You will also need isopropyl
alcohol and an anti-static cloth to clean with.

When re-installing the heatsink, you must first clean off all old paste
with the alcohol/cloth. Then apply new paste. Arctic MX-4 is also much
better than the default paste used on these systems.

![](/software/gnuboot/web/static/img/t400/paste.jpg)

NOTE: the photo above is for illustration purposes only, and does not
show how to properly apply the thermal paste. Other guides online detail
the proper application procedure.

Memory
======

In DDR3 machines with Cantiga (GM45/GS45/PM45), northbridge requires sticks
that will work as PC3-8500 (faster PC3/PC3L sticks can work as PC3-8500).
Non-matching pairs may not work. Single module (meaning, one of the slots
will be empty) will currently only work in slot 0.

NOTE: according to users reports, non matching pairs (e.g. 1+2 GiB) might
work in some cases.

Make sure that the RAM you buy is the 2Rx8 configuration when buying 4GiB sticks
(In other words: maximum of 2GiB per rank, 2 ranks per card).

[This page](http://www.forum.thinkpads.com/viewtopic.php?p=760721) might
be useful for RAM compatibility info (note: coreboot raminit is
different, so this page might be BS)

The following photo shows 8GiB (2x4GiB) of RAM installed:\
![](/software/gnuboot/web/static/img/t400/memory.jpg)

Boot it!
--------

You should see something like this:

![](/software/gnuboot/web/static/img/t400/boot0.jpg) ![](/software/gnuboot/web/static/img/t400/boot1.jpg)

Now [install GNU+Linux](../gnulinux/).
