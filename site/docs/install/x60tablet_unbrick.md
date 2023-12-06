---
title: ThinkPad X60 Tablet Recovery guide
x-unreviewed: true
...

This section documents how to recover from a bad flash that prevents
your ThinkPad X60 Tablet from booting.

ROM images for this machine are well-tested in Libreboot, so bricks are rare.
The most common cause of a brick is operator error, when flashing a ROM image.
In *most* cases, the cause will be that there is no bootblock, or an invalid
one.

Brick type 1: bucts not reset. {#bucts_brick}
==============================

You still have Lenovo BIOS, or you had libreboot running and you flashed
another ROM; and you had bucts 1 set and the ROM wasn't dd'd.\* or if
Lenovo BIOS was present and libreboot wasn't flashed.

There are *2* 64KiB bootblocks possible, in the upper part of the ROM image.
By default (bucts set to 0), the top one is used. If bucts is set to 1, the
lower one (the one before the top one) is used. This bootblock is the first
code that executes, during *romstage* as per coreboot hardware initialization.

BUC is short for *Backup Control* and TS is short for *Top Swap*. This is a
special register on Intel platforms. Lenovo BIOS sets PRx registers, preventing
software re-flashing, but there is a bug in the protection, allowing everything
*except* the upper 64KiB from being flashed. By default, coreboot only puts a
bootblock in the upper region. If you flash such a ROM, while bucts is set to 1,
the system won't boot because there's not a valid bootblock; this is common if
you're re-flashing when coreboot is already installed, and you didn't set bucts
back to 0.

When you install on X60/T60 the first time, you set this bucts bit to 1, then
you re-flash a second time and set it back to 0.

In this case, unbricking is easy: reset BUC.TS to 0 by removing that
yellow cmos coin (it's a battery) and putting it back after a minute or
two:\
![](/software/gnuboot/web/img/x60t_unbrick/0008.JPG)\

\*Those dd commands should be applied to all newly compiled X60 ROM
images (the ROM images in libreboot binary archives already have this
applied!):

    dd if=coreboot.rom of=top64k.bin bs=1 skip=$[$(stat -c %s coreboot.rom) - 0x10000] count=64k
    dd if=coreboot.rom bs=1 skip=$[$(stat -c %s coreboot.rom) - 0x20000] count=64k | hexdump
    dd if=top64k.bin of=coreboot.rom bs=1 seek=$[$(stat -c %s coreboot.rom) - 0x20000] count=64k conv=notrunc

(doing this makes the ROM suitable for use when flashing a system that
still has Lenovo BIOS running, using those instructions:
<http://www.coreboot.org/Board:lenovo/x60/Installation>.

Brick type 2: bad ROM image {#recovery}
===========================================

In this instance, you might have flashed a ROM without the top bootblock copied
to the lower 64KiB section in the ROM, and you flashed the ROM for the first
time (from Lenovo BIOS), in which case there is not a valid bootblock.

In this scenario, you compiled a ROM that had an incorrect
configuration, or there is an actual bug preventing your system from
booting. Or, maybe, you set BUC.TS to 0 and shut down after first flash
while Lenovo BIOS was running. In any case, your system is bricked and
will not boot at all.

"Unbricking" means flashing a known-good (working) ROM. The problem:
you can't boot the system, making this difficult. In this situation,
external hardware (see hardware requirements above) is needed which can
flash the SPI chip (where libreboot resides).

![](/software/gnuboot/web/img/x60t_unbrick/0000.JPG)

Remove those screws:\
![](/software/gnuboot/web/img/x60t_unbrick/0001.JPG)

Remove the HDD:\
![](/software/gnuboot/web/img/x60t_unbrick/0002.JPG)

Push keyboard forward to loosen it:\
![](/software/gnuboot/web/img/x60t_unbrick/0003.JPG)

Lift:\
![](/software/gnuboot/web/img/x60t_unbrick/0004.JPG)

Remove those:\
![](/software/gnuboot/web/img/x60t_unbrick/0005.JPG)

![](/software/gnuboot/web/img/x60t_unbrick/0006.JPG)

Also remove that (marked) and unroute the antenna cables:\
![](/software/gnuboot/web/img/x60t_unbrick/0007.JPG)

For some X60T laptops, you have to unroute those too:\
![](/software/gnuboot/web/img/x60t_unbrick/0010.JPG)

Remove the LCD extend board screws. Also remove those screws (see blue
marks) and remove/unroute the cables and remove the metal plate:\
![](/software/gnuboot/web/img/x60t_unbrick/0008.JPG)

Remove that screw and then remove the board:\
![](/software/gnuboot/web/img/x60t_unbrick/0009.JPG)

This photo shows the flash location:\
![](/software/gnuboot/web/img/x60t_unbrick/0011.JPG)

This photo shows an SPI flasher used, with SOIC8 test clip:\
![](/software/gnuboot/web/img/x60/th_bbb_flashing.jpg)

Refer to the external flashing guide:

[Externally rewrite 25xx NOR flash via SPI protocol](spi.md)

NOTE: Do not use the 3.3v rail from your SPI programmer. Leave that disconnected.
For 3.3v, plug your charger into the mainboard (but do not power on the mainboard)
when the clip is connected. Before removing the clip, disconnect the charger.
This will provide adequate 3.3v DC at correct current levels. The SPI flash on an
X60 Tablet shares a common 3.3V rail with many other components on the mainboard,
which all draw a lot of current, more than most flashers can provide.

Example command:

    sudo ./flashrom -p linux_spi:dev=/dev/spidev0.0,spispeed=4096 -w libreboot.rom -V

If flashrom complains about multiple flash chips detected, just pass the `-c`
option as it suggests, and pick any of the chips it lists. `spispeed=4096` or
lower (e.g. `spispeed=512`) is recommended on this board. The flashing becomes
unstable, on this machine, when you use higher speeds.

Reverse the steps to re-assemble your system, after you've flashed the chip.
