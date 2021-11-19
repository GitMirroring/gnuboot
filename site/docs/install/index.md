---
title: Installation instructions
x-toc-enable: true
...

This section relates to installing Libreboot on supported targets.

NOTE: if running `flashrom -p internal` for software based flashing, and you
get an error related to `/dev/mem` access, you should reboot with
`iomem=relaxed` kernel parameter before running flashrom, or use a kernel that
has `CONFIG_STRICT_DEVMEM` not enabled.

Libreboot flashing can be risky business. Please ensure that you have external
flashing equipment, in case anything goes wrong. The general rule of thumb with
firmware is this: if it's non-free, replace it, but if you're already running
free firmware and it works nicely for you, you do not need to update it.
However, you might want to tweak it or try out newer releases of Libreboot if
they have bug fixes for your board, and/or new security fixes.

If you're already running libre firmware on your board, you should decide for
sure whether you wish to risk it. See changelogs on
the [release announcements via the news page](/news/) and decide for yourself.

About ROM image file names
==========================

Init types and display mode
---------------------------

NOTE: On Libreboot 20210522, `libgfxinit` in the only init type provided on
the pre-compiled ROM images, but the build system does support other types
defined below.

NOTE: regardless of init type, on desktops, an external/add-on GPU can always
be used. On laptop hardware in Libreboot, libgfxinit will always be used. On
desktop/server hardware, if available, libgfxinit will also always be used by
default (but in that setup, SeaBIOS can be used if you want to use an add-on
graphics card, e.g. on KCMA-D8, KGPE-D16, GA-G41M-ES2L)

**This means that on desktop hardware such as KCMA-D8, KGPE-D16, G43T-AM3,
GA-G41M-ES2L and others, you can use either the internal GPU or an add-on
PCI-E graphics card. Simply use a ROM image that starts with SeaBIOS, and you
can use both. On desktop/server hardware, libgfxinit simply means that you
CAN use the internal graphics chip, but you don't have to; external add-on
GPUs will also still work! However, if libgfxinit is enabled, that disables
coreboot from loading/executing PCI option ROMs which means you MUST use SeaBIOS
if you wish to use the add-on cards!**

### libgfxinit

In this setup, on supported systems, coreboot's own native video initialization
code is used. This is referred to generically as libgfxinit, which is coreboot's
library in `3rdparty/libgfxinit` but not all boards with native video
initialization use libgfxinit; some of them are using coreboot's older style
of video initialization method, written purely in C.

#### corebootfb (libgfxinit)

high resolution coreboot framebuffer used on startup

#### txtmode (libgfxinit)

int10h text mode is used on startup.

### vgarom

NOTE: no configs in libreboot are currently available that use this method.

With this method, coreboot is finding, loading and executing a VGA option ROM
for your graphics hardware. This would not be done on laptops, because that
implies supplying non-free binary blobs in Libreboot, so this setup would only
ever be provided on desktop hardware where no GPU exists or where it is
desirable for you to use an external/add-on graphics card

#### vesafb (vgarom)

high resolution VESA framebuffer used on startup

#### txtmode (vgarom)

int10h text mode is used on startup

### normal

int10h text mode startup is implied here.

In this setup, coreboot is neither implementing libgfxinit / native graphics
initialization nor is it finding/loading/executing VGA option ROMs. In this
setup, SeaBIOS would most likely be used for that.

The `normal` setup is supported in the Libreboot 20210522 build system, but not
currently used. It is there for desktop hardware that will be added in the
future, where those desktop boards do not have an onboard GPU and therefore an
add-on GPU is always used..

Payload names
-------------

### grub

ROM images with just `grub` in the file name will start first with the GNU GRUB
payload. They may or may not also provide other payloads in the menu, such as
memtest86+, SeaBIOS, Tianacore and so on.

### seabios

ROM images with just `seabios` in the file name will start first with the
SeaBIOS payload. They will only contain SeaBIOS, but may also contain memtest as
an option in the boot menu.

### seabios\_withgrub

ROM images that have `seabios_withgrub` in the file name start with SeaBIOS
first, but also have GNU GRUB available in the boot menu when you press ESC.

### seabios\_grubfirst

ROM images that have `seabios_grubfirst` in the file name start with SeaBIOS,
but SeaBIOS is configured via special `bootorder` file in CBFS so as to ONLY
load GNU GRUB. This setup would be most useful on desktops, where you wish to
only have GNU GRUB available, but want to use an add-on GPU while also having
the option to use libgfxinit, if a supported GPU/framebuffer chip is present
on your board.

Which systems are supported?
============================

[Refer to the hardware compatibility page](../hardware/)

MAC address on GM45+ICH9M hardware (ThinkPad X200/R400/T400/T500/W500)
======================================================================

The MAC address is stored in a region of the boot flashed called *GbE NVM*
which is short for *gigabit ethernet non-volatile memory*. Refer to the
following article:

[ich9utils documentation](ich9utils.md)

Libreboot puts a default MAC address in the available ROM images, but this is
a generic MAC address and it's identical on every ROM image. Technically, you
can use it but if you encounter other Libreboot users on the same ethernet
switch, using the same physical network as you, you will encounter a MAC
address conflict.

NOTE: R500 thinkpads do not have an Intel gigabit ethernet NIC, so on that
laptop you can just flash the default ROM and you do not have to worry.

There are also some Intel X4X platforms that use an ICH10 southbridge,
supported in Libreboot, but these are flashed in a *descriptorless* setup,
which means that the MAC address is irrelevant (either there will be an Intel
PHY module that is now unusable, and you use an add-on card, or it doesn't use
an Intel PHY module and the onboard NIC is usable).

Install via host CPU (internal flashing)
========================================

On all mainboards is a built-in programmer, which can read, erase and rewrite
the boot flash. However, it is not always usable by default. For example, it
may be configured to restrict write privileges by the host CPU.

In some situations, the host CPU can rewrite/erase/dump the boot flash.
This is called *internal flashing*. This means that you will run software,
namely `flashrom`, to read/erase/write the contents of the boot flash from a
running operating system on the target device.

NOTE: please also read the sections further down this page. On some systems,
external flashing is required. This means that you power the system down and
use a special tool that connects to and reprograms the boot flash.

NOTE: in some cases, external flashing is possible but special steps are
required. This depends on your mainboard. Again, please read this page
carefully.

Run flashrom on host CPU
------------------------

You can simply take any ROM image from the Libreboot project, and flash it.
Boot a GNU+Linux distribution on the target device, and install flashrom.

In some cases, this is not possible or there are other considerations. Please
read this section *carefully*.

### Flash chip size

Use this to find out:

    flashrom -p internal

In the output will be information pertaining to your boot flash.

### Howto: read/write/erase the boot flash (PLEASE CHECK LIST OF EXCEPTIONS BELOW BEFORE YOU ATTEMPT THIS!!!!)

How to read the current chip contents:

    sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force -r dump.bin

You should still make several dumps, even if you're flashing internally, to
ensure that you get the same checksums. Check each dump using `sha1sum`

How to erase and rewrite the chip contents:

    sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force -w libreboot.rom

If you are re-flashing a GM45+ICH9M laptop (e.g. ThinkPad X200/X200S/X200T,
T400, T500, R400, W500 etc - but not R500), you should run the ich9gen utility
to preserve your mac address.
Please read the ich9utils documentation:
[/docs/install/ich9utils.html](/docs/install/ich9utils.html)

NOTE: `force_I_want_a_brick` is not scary. Do not be scared! This merely disables
the safety checks in flashrom. Flashrom and coreboot change a lot, over the years,
and sometimes it's necessary to use this option. If you're scared, then just
follow the above instructions, but remove that option. So, just use `-p internal`.
If that doesn't work, next try `-p internal:boardmismatch=force`. If that doesn't
work, try `-p internal:boardmismatch=force,laptop=force_I_want_a_brick`. So long
as you *ensure* you're using the correct ROM for your machine, it will be safe
to run flashrom. These extra options just disable the safetyl checks in flashrom.
There is nothing to worry about.

If successful, it will either say `VERIFIED` or it will say that the chip
contents are identical to the requested image.

NOTE: there are exceptions where the above is not possible. Read about them in
the sections below:

### Exceptions

#### If your boot flash is currently write-protected

[You must flash it externally](spi.md)

#### ASUS Chromebook C201 (Libreboot 20160907 only)

Ignore this section. Instead, refer to the following guide:

[ASUS Chromebook C201 installation guide](c201.md)

#### Lenovo ThinkPad X200/X200S/X200T/T400/T400S/T500/W500/R400/R500 running non-free Lenovo BIOS

If you're running one of these, it cannot be flashed internally if you're still
running the non-free Lenovo BIOS firmware.

[You must flash it externally](spi.md)

See notes further down on this page. We have guides for specific thinkpads,
related to disassembly and reassembly so that you can access the flash.

Please also see notes about the built-in MAC address inside the boot flash, for
the onboard NIC (ethernet one); not relevant on R500, which doesn't use an
Intel NIC.

#### Intel D510MO and D410PT running non-free Intel BIOS

[You must flash it externally](spi.md)

D410PT is more or less the same board as D510MO, but we would like more info
about this board. If you have a D410PT mainboard, please contact the Libreboot
project via IRC and ping `leah` before you flash it. When you do so, please
reference this paragraph on this web page.

#### Gigabyte GA-G41M-ES2l (any firmware)

Ignore this section. Internal flashing *is* possible, but there are two chips
and you must flash both chips. Refer to the guide:\
[Gigabyte GA-G41M-ES2L installation guide](ga-g41m-es2l.html)

#### Macbook1,1 running non-free Apple EFI firmware

This laptop requires external flashing. Remove the mainboard and refer to
the [external flashing guide](spi.md); if Libreboot is already running, you
can flash internally.

MacBook2,1 can be flashed internally.

#### ASUS KFSN4-DRE?

Simply boot GNU+Linux with the default vendor firmware, and flash it internally,
but before you do: take a push pin, remove the metal pin, and superglue the
plastic part to the chip. Then remove the chip after you booting your
GNU+Linux system. Install a new chip, and flash *that*.

This board uses LPC flash in a PLCC32 socket. This coreboot page shows an
example of the push pin as a proof of concept:
<http://www.coreboot.org/Developer_Manual/Tools#Chip_removal_tools>

#### ASUS KGPE-D16 running non-free ASUS BIOS

[You must flash it externally](spi.md)

#### ASUS KCMA-D8 running non-free ASUS BIOS

[You must flash it externally](spi.md)

#### ASUS D945GCLF running non-free Intel BIOS

[You must flash it externally](spi.md)

#### ThinkPad X60/X60S/X60T/T60 with Lenovo BIOS {#flashrom_lenovobios}

**I forgot to actually add the flashrom patches in the Libreboot 20210522
release. When you see the notes below about `_sst` and `_mx`, for now just use
the `util` archive from Libreboot 20160907. That release has a utils archive
with pre-compiled flashrom binaries, including patches binaries for Macronix
and SST flash chips on these machines. Bucts is also included, pre compiled.
They are statically linked binaries, so they should work on any distro. Use
those binaries, but with the ROM images from the Libreboot 20210522 release!**

Here are a list of targets:

* ThinkPad X60/X60S/X60T: flash the X60 ROM
* ThinkPad T60 with Intel GPU: flash the T60 ROM
* ThinkPad T60 with ATI GPU: flash the Headless T60 ROM (no video init, but you
  can get a serial console on the RS232 port if you use the Advanced Dock or
  Advanced Mini Dock. Connect to it from another machine, using null modem
  cable and USB serial adapter; GNU Screen can connect to the serial console
  and you will run it at 115200 baud rate. agetty/fgetty in GNU+Linux can give
  you a serial console in your OS)

Download and build flashrom, using the instructions
on [the Git page](../../git.md), and download the `bucts` software using the
notes on that very same page.

You can replace Lenovo BIOS with Libreboot, using flashrom running on the host
CPU. However, there are some considerations.

Firstly, make sure that the yellow CMOS battery is installed, and functioning
correctly. You could check the voltage. The battery is a CR2032
coin cell and it *should* be providing a 3V signal. You should check this while
it is connected to the board, because this will give a more accurate reading
(if the battery is weak, it will have severe voltage drop when there is any
load on it, which there will be. This coincell powers the real-time clock and
CMOS memory).

Lenovo BIOS restricts write access, but there is a weakness in it. With a
specially patched flashrom binary, you can easily flash it but the top 64KiB
region of the boot flash, containing your bootblock, cannot be flashed just
yet. However, there is a register called the *Backup Control* or *BUC* register
and in that register is a status bit called *Top Swap* or *TS*.

There are *2* bootblocks possible. The *other* bootblock is below the upper
64KiB one, which can't be flashed, but the lower one can. By using bucts, you
can set the machine to boot using that lower 64KiB bootblock, which is
read-write. You do this by setting the BUC.TS register to 1, using the `bucts`
program referenced below.

Libreboot ROM images already have the upper 64KiB bootblock copied to the lower
one, so you don't have to worry about copying it yourself.

If you build flashrom using the libreboot build system, there will be three
binaries:

* `flashrom`
* `flashrom_i945_sst`
* `flashrom_i945_mx`

It's these last two binaries that you should use. Now compile bucts (just
run `make` in the bucts source directory).

Run the bucts tool:

    sudo ./bucts 1

Ensure that your CMOS battery is connected too. Now you must determine whether
you have Macronix or SST. An X60/T60 thinkpad will have either an SST or a
Macronix chip. The Macronix chip will have "MX" written on the chip. You will
use `flashrom_i945_sst` for the SST chip, and `flashrom_i945_mx` for the
Macronix chip.

Now run flashrom (for SST):

    sudo ./flashrom_i945_sst -p internal -w coreboot.rom

Or Macronix:

    sudo ./flashrom_i945_mx -p internal -w coreboot.rom

NOTE: you *can* just run both. One of them will succeed. It is perfectly
harmless to run both versions of flashrom. In fact, you should do so!

You'll see a lot of errors. This is normal. You should see something like:

    Reading old flash chip contents... done.
    Erasing and writing flash chip... spi_block_erase_20 failed during command execution at address 0x0
    Reading current flash chip contents... done. Looking for another erase function.
    spi_block_erase_52 failed during command execution at address 0x0
    Reading current flash chip contents... done. Looking for another erase function.
    Transaction error!
    spi_block_erase_d8 failed during command execution at address 0x1f0000
    Reading current flash chip contents... done. Looking for another erase function.
    spi_chip_erase_60 failed during command execution
    Reading current flash chip contents... done. Looking for another erase function.
    spi_chip_erase_c7 failed during command execution
    Looking for another erase function.
    No usable erase functions left.
    FAILED!
    Uh oh. Erase/write failed. Checking if anything has changed.
    Reading current flash chip contents... done.
    Apparently at least some data has changed.
    Your flash chip is in an unknown state.

If you see this, rejoice! It means that the flash was successful. Please do not
panic. Shut down now, and wait a few seconds, then turn back on again.

**WARNING: if flashrom complains about `/dev/mem` access, please
run `sudo ./bucts 0`. If flashrom is complaining about `/dev/mem`, it means
that you have `CONFIG_STRICT_DEVMEM` enabled in your kernel. Reboot with the
following kernel parameter added in your bootloader: `iomem=relaxed` and try
again with the above instructions. DO NOT continue until the above works, and
you see the expected flashrom output as indicated above.**

If you *did* run flashrom and it failed to flash, but you set bucts to 1 and
shut down, don't worry. Just remove the yellow coin-cell battery (it's underneath
the keyboard, connected to the mainboard), wait a minute or two, reconnect the
coin-cell and try again from scratch. In this instance, if flashrom didn't do
anything, and didn't flash anything, it means you still have Lenovo BIOS but
if bucts is set to 1, you can flush it and set it back to 0. BUC.TS is stored in
volatile memory, powered by that CR2032 coin-cell battery.

Assuming that everything went well:

Flash the ROM for a second time. For this second flashing attempt, the upper
64KiB bootblock is now read-write. Use the *unpatched* flashrom binary:

    sudo ./flashrom -p internal -w libreboot.rom

To reset bucts, do this:

    sudo ./bucts 0

ONLY set bucts back to 0 if you're sure that the upper 64KiB bootblock is
flashed. It is flashed if flashrom said VERIFIED when running the above
command.

If it said VERIFIED, shut down. If it didn't say VERIFIED, make sure bucts is
still set to 1, and consult the libreboot project on IRC for advice, and avoid
shutting down your system until you get help.

If all went well, Libreboot should now be booting and you should be able to
boot into your operating system.

If you messed up, there are external flashing instructions. See main navigation
menu on this page. These "external" instructions teach you how to flash
externally, using special equipment (requires disassembling your laptop and
removing the mainboard).

Install using external flashing equipment
=========================================

In many situations, the host CPU is restricted from rewriting/erasing/dumping
the boot flash. In this situations, you must re-flash the chip (containing the
boot firmware) externally. This is called *external flashing*.

DO NOT buy CH341A! Read the above link, which explains why you shouldn't use it.
CH341A will damage your flash chip, and other components on your mainboard.

How to use external flashing equipment
--------------------------------------

Refer to the following article:\
[Externally rewrite 25xx NOR flash via SPI protocol](spi.md)

ASUS KFSN4-DRE
--------------

The KFSN4-DRE has an LPC chip.  Most people have been flashing these
internally, hot-swapping the chip out after boot, preserving the original chip,
and using flashrom on a new chip as described above.

TODO: Document PLCC32 (LPC) flashing.
The [FlexyICE](https://www.coreboot.org/FlexyICE) has been used to flash these
chips, but it is hard to find now.  A custom flasher may be made such as
[flashrom serprog stm32](https://github.com/wosk/stm32-vserprog-lpc) or
[teensy flasher](https://www.flashrom.org/Teensy_3.1_SPI_%2B_LPC/FWH_Flasher)

TARGET: Apple Macbook2,1, Macbook1,1 and iMac5,2 (i945 platform)
----------------------------------------------------------------

iMac5,2 is essentially the same board as Macbook2,1, and it is compatible with
Libreboot.

Refer to the following article:\
[Macbook2,1 and MacBook1,1 installation guide](../hardware/macbook21.md)

iMac5,2 isn't documented but you can find the flash chip on that board quite
easily. See the generic flashing guide:\
[Externally rewrite 25xx NOR flash via SPI protocol](spi.md)

TARGET: Gigabyte GA-G41M-ES2L mainboard
---------------------------------------

Refer to the following article:\
[Gigabyte GA-G41M-ES2L](ga-g41m-es2l.md)

TARGET: Intel D510MO and D410PT mainboards
------------------------------------------

Refer to the following article:\
[Intel D510MO and D410PT boards](d510mo.md)

TARGET: Intel D945GCLF mainboard
--------------------------------

Refer to the following article:\
[Intel D945GCLF](d945gclf.md)

TARGET: ASUS KGPE-D16 mainboard
-------------------------------

Refer to the following article:\
[ASUS KGPE-D16](kgpe-d16.md)

TARGET: ASUS KCMA-D8 mainboard
------------------------------

Refer to the following article:\
[ASUS KCMA-D8](../hardware/kcma-d8.md)

TARGET: ASUS Chromebook C201 laptop
----------------------------

Refer to the following article:\
[ASUS Chromebook C201](c201.md)

TARGET: Lenovo ThinkPad X60 laptop
----------------------------------

Refer to the following article:\
[ThinkPad X60](x60_unbrick.md)

TARGET: Lenovo ThinkPad X60 Tablet laptop
-----------------------------------------

Refer to the following article:\
[ThinkPad X60 Tablet](x60tablet_unbrick.md)

TARGET: Lenovo ThinkPad T60 laptop
----------------------------------

Refer to the following article:\
[ThinkPad T60](t60_unbrick.md)

TARGET: Lenovo ThinkPad X200 laptop
-----------------------------------

Refer to the following article:\
[ThinkPad X200](x200_external.md)

TARGET: Lenovo ThinkPad X200S or X200 Tablet laptop
---------------------------------------------------

Software-wise, identical to regular X200 but SMD rework skills are required.
You must de-solder the default flash chip, and replace it with another one.

Refer to the following article:\
[25xx NOR flashing guide](spi.md)

That guide, linked above, has instructions for how to deal with these machines.

TARGET: Lenovo ThinkPad T400 laptop
-----------------------------------

Refer to the following article:\
[ThinkPad T400](t400_external.md)

TARGET: Lenovo ThinkPad T400S laptop
------------------------------------

Software-wise, identical to regular T400 but SMD rework skills are required.
You must de-solder the default flash chip, and replace it with another one.

Refer to the following article:\
[25xx NOR flashing guide](spi.md)

TARGET: Lenovo ThinkPad R400 laptop
-----------------------------------

Refer to the following article:\
[ThinkPad R400](r400_external.md)

TARGET: Lenovo ThinkPad T500 or W500 laptop
-------------------------------------------

These two laptops have identical mainboard, except for a few minor changes.

Refer to the following article:\
[ThinkPad T500/W500](t500_external.md)

TARGET: Lenovo ThinkPad R500 laptop
-----------------------------------

Refer to the following laptop:\
[ThinkPad R500](../hardware/r500.md)
