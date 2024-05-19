---
title: Modifying grub.cfg in CBFS
x-unreviewed: true
...

Before you follow this guide, it is advisable that you have the ability to
flash externally, just in case something goes wrong.

This guide assumes that you use the GNU GRUB bootloader as your default
payload. In this configuration, GNU GRUB is flashed alongside coreboot and runs
on *bare metal* as a native coreboot payload and does *not* use BIOS or UEFI
services (but it *can* load and execute SeaBIOS, in addition to any other
coreboot payload, by chainloading it).

In most circumstances, this guide will not benefit you. Libreboot's default
GRUB configuration file contains scripting logic within it that intelligently
searches for GRUB partitions installed onto a partition on your SSD, HDD or
USB drive installed on your computer. If such a file is found, libreboot's
default GRUB configuration is configured to switch automatically to that
configuration. While not perfect, the logic *does* work with most
configurations.

Therefore, you should only follow *this* guide if the automation (described
above) does not work. It goes without saying that modifying the default GRUB
configuration is risky, because a misconfiguration could create what's called
a *soft brick* where your machine is effectively useless and, in that scenario,
may or may not require external flashing equipment for restoring the machine to
a known state.

Compile flashrom and cbfstool
=============================

Libreboot does not currently distribute utilities pre-compiled. It only
provides ROM images pre-compiled, where feasible. Therefore, you have to build
the utilities from source.

As for the ROM, there are mainly three methods for obtaining a libreboot ROM
image:

1. Dump the contents of the the main *boot flash* on your system, which already
   has libreboot installed (with GNU GRUB as the default payload). Extract the
   GRUB configuration from *that* ROM image.
2. Extract it from a libreboot ROM image supplied by the libreboot project, on
   the libreboot website or mirrors of the libreboot website.
3. Build the ROM yourself, using the libreboot build system. Instructions for
   how to do this are covered in the following article:
   [How to build libreboot from source](../build/)

In either case, you will use the `cbfstool` supplied in the Libreboot build
system.
This can be found under `coreboot/*/util/cbfstool/` as source code,
where `*` can be any coreboot source code directory for a given mainboard.
The directory named `default` should suffice.

Install the build dependencies. For Ubuntu 20.04 and similar, you can run
the following command in the libreboot build system, from the root directory
of the libreboot Git repository.

    ./build dependencies trisquel-10

Then, download coreboot:

    ./download coreboot

Finally, compile the `cbutils` module:

    ./build module cbutils

Among other things, this will produce a `cbfstool` executable under any of the
subdirectories in `coreboot/` under `util/cbfstool/cbfstool

For example: `coreboot/default/util/cbfstool/cbfstool`

The `cbfstool` utility is what you shall use. It is used to manipulate CBFS
(coreboot file system) which is a file system contained within the coreboot
ROM image; as a *coreboot distribution*, libreboot inherits this technology.

You will also want to build `flashrom` which libreboot recommends for reading
from and/or writing to the boot flash. In the libreboot build system, you can
build it by running this command:

    ./build module flashrom

An executable will be available at `flashrom/flashrom` after you have done
this.

Dump the boot flash
===================

If you wish to modify your *existing* libreboot ROM, which was installed on
your computer, you can use `flashrom` to acquire it.

Simply run the following, after using libreboot's build system to compile
flashrom:

    sudo ./flashrom/flashrom -p internal -r dump.bin

If flashrom complains about multiple flash chip definitions, do what it says to
rectify your command and run it again.

You may want to use the following, instead of `-p internal`:
`-p internal:laptop=force_I_want_a_brick,boardmismatch=force`

Do not let the word *brick* fools you. This merely disables the safety checks
in flashrom, which is sometimes necessary depending on what ROM was already
flashed, versus the new ROM image.

The `internal` option assumes that internal read/write is possible; this is
when you read from and/or write to the boot flash from an operating systems
(usually GNU+Linux) that is *running on* the target system.

In other cases, you may need to connect an SPI programmer externally (with the
machine powered down) and read the contents of the boot flash.

[Learn how to externally reprogram these chips](../install/spi.html)

Extract grub.cfg
================

Libreboot images that use the GNU GRUB bootloader will have *two* configuration
files in CBFS:

* `grub.cfg`
* `grubtest.cfg`

We recommend that you modify `grubtest.cfg` first, and boot. Select the boot
menu option for loading `grubtest.cfg` and verify that your new config works
correctly. If it doesn't, keep modifying `grubtest.cfg` until it does work.
When that it done, copy the changes over to `grub.cfg

You can use the following commands to modify the contents of CBFS, where
GRUB's configuration file is concerned (dump.bin is the ROM that you dumped,
or it could refer to the libreboot ROM image that you compiled or otherwise
acquired).

Show the contents of CBFS, in your ROM:

    cbfstool dump.bin print

Extract `grub.cfg` (substitude with `grubtest.cfg` as desired):

    cbfstool dump.bin extract -n grub.cfg -f grub.cfg

You will now have a file named `grub.cfg`.

Make your desired modifications. You should then delete the old `grub.cfg`
from your ROM image.

Insert new grub.cfg
===================

Remove the old `grub.cfg` (substitute with `grubtest.cfg` as desired):

    cbfstool dump.bin remove -n grub.cfg

Add your modified `grub.cfg` (substitute with `grubtest.cfg` as desired):

    cbfstool dump.bin add -f grub.cfg -n grub.cfg -t raw

Flash the modified ROM image
============================

Your modified `dump.bin` or other modified libreboot ROM can then be re-flashed
using:

    sudo ./flashrom -p internal -w dump.bin

If a `-c` option is required, use it and specify a flash chip name. This is
only useful when `flashrom` complains about multiple flash chips being
detected.

If flashrom complains about wrong chip/board, make sure that your ROM is for
the correct system. If you're sure, you can disable the safety checks by running
this instead:

    sudo ./flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force -w dump.bin

If you need to use external flashing equipment, see the link above to the
Raspberry Pi page.
