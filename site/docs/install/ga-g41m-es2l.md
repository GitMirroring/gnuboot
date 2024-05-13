---
title: GA-G41M-ES2L flashing tutorial 
x-unreviewed: true
...

This guide is for those who want libreboot on their Intel GA-G41M-ES2L
motherboard while they still have the original BIOS present.

Flash chip size {#flashchips}
===============

Use this to find out:

    flashrom -p internal

Flashing instructions {#clip}
=====================

Refer to [spi.html](spi.html) for how to set up an SPI programmer for
external flashing. *You can only externally reprogram one of the chips
at a time, and you need to disable the chip that you're not flashing,
by connecting 3v3 to /CS of that chip, so you will actually need second test
clip or IC pin mini grabber.*

NOTE: on GA-G41M-ES2L, the flash shares a common voltage plane with the
southbridge, which draws a lot of current. This will cause under-voltage on
most SPI flashers, so do not use the 3.3V rail from your flasher. Do not
connect +3.3V to the chip. Instead, turn the board on and then turn it off by
holding the power button. With the board powered down, but plugged in, there
will be a 3.3V supply from the ATX PSU. You can then flash, but DO NOT connect
the +3.3V supply from your SPI flasher!

NOTE: You should use a resistor in series, between 1K to 10K ohms, for the 3.3v
connection to the CS pin. This is to protect from over-current.

Here is an image of the flash chip:\
![](/software/gnuboot/web/img/ga-g41m-es2l/ga-g41m-es2l.jpg)

Internal flashing is possible. Boot with the proprietary BIOS and
GNU+Linux. There are 2 flash chips (one is backup).

Flash the first chip:

    ./flashrom -p internal:dualbiosindex=0 -w libreboot.rom

Flash the second chip:

    ./flashrom -p internal:dualbiosindex=1 -w libreboot.rom

NOTE: you can still boot the system with just the main flash chip
connected, after desoldering the backup chip. This has been tested while
libreboot was already installed onto the main chip.

NOTE: If you don't flash both chips, the recovery program from the default
factory BIOS will kick in and your board will be soft bricked. Make sure that
you flash both chips!

NOTE: You need the latest flashrom. Just get it on flashrom.org from
their SVN or Git repos.

NOTE: due to a bug in the hardware, the MAC address is hardcoded in
coreboot-libre. Therefore, you must set your own MAC address in your
operating system.
