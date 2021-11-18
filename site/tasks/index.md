---
title: Tasks
x-toc-enable: true
...

Help the Libreboot project
==========================

This page is very new. It's intended to serve those who ask: what can I do to
help Libreboot? You could try implementing some of the tasks listed on this page
or you could submit new tasks to this page!

Current tasks (more will be added soon)
=======================================

Move all distro FDE+/boot/ guides to distro wiki/manuals
--------------------------------------------------------

The Guix, Fedora, Parabola and Trisquel guides were outdated and therefore
deleted. The Debian guide should also be deleted, even though it's up to date.
The hyperbola one is actually a link to a guide on the Hyperbola site.

These are guides for fully encrypted GNU+Linux systems, including /boot, but
it's desirable for these to be documented instead by each distro, because then
they will more likely be properly maintained.

We constantly have to update them, on libreboot.org. It is unsustainable. Move
them to other projects and let them deal with it. Libreboot's only job is to
boot you into a payload. The rest is up to you!

This concerns GRUB payload on x86 targets. For SeaBIOS, it's fairly easy to
just push a button and the distro installer boots, or the installed distro
just boots up as normal.

Here are links to the guides that were deleted:

* <https://notabug.org/libreboot/lbwww/src/8844c201ef0d1ab856fed2aa5148b89100fffe0d/site/docs/gnulinux/guix_system.md>
* <https://notabug.org/libreboot/lbwww/src/8844c201ef0d1ab856fed2aa5148b89100fffe0d/site/docs/gnulinux/encrypted_trisquel.md>
* <https://notabug.org/libreboot/lbwww/src/8844c201ef0d1ab856fed2aa5148b89100fffe0d/site/docs/gnulinux/encrypted_parabola.md>
* <https://notabug.org/libreboot/lbwww/src/8844c201ef0d1ab856fed2aa5148b89100fffe0d/site/docs/gnulinux/configuring_parabola.md>

The Trisquel one will be almost identical to the Debian one, with perhaps a few
extra considerations taken. It's recommended to focus on Debian first, and
then adapt that to Trisquel. However, Trisquel is based on Ubuntu, so the
guide can also be adapted for the Ubuntu site. This will cover most Ubuntu and
Debian based distros.

The remaining Debian guide is here:
<https://notabug.org/libreboot/lbwww/src/8844c201ef0d1ab856fed2aa5148b89100fffe0d/site/docs/gnulinux/encrypted_debian.md>

Document other RPi GNU+Linux distros for SPI flashing
-----------------------------------------------------

See:
[../docs/install/spi.md#caution-about-rpi](../docs/install/spi.md#caution-about-rpi)

RPi's default distro, Raspbian, no longer can be trusted to be secure. TODO:
document how to use other distros, to configure the RPi for SPI flashing.

bug: crossgcc not included in src archive if not already build
--------------------------------------------------------------

fix this. in practise, i always build the roms and then run the release scripts
which means crossgcc will have been built, but this bug should still be fixed.
this is so that you can simply run the release build scripts right after
downloading the git repository

ThinkPad R60 support
--------------------

macc24 on IRC ported it. add it!

Investigate u-boot
-----------------

e.g. Pine64 ROCKPro64, which was added in coreboot 4.14
but it's also supported by uboot

Lots of ARM hardware supported in coreboot, and lots of non-coreboot hardware
out there with free firmware, but using uboot (not coreboot)

Pinebook computers look interesting:

Some of their computers look like they will be suitable for Libreboot, but they
are ARM and most of them don't have coreboot support (instead, they use uboot
exclusively).

GRUB: add BLS support
---------------------
Resources:

* [The systemd's Boot Loader Specification](https://systemd.io/BOOT_LOADER_SPECIFICATION)
* [The freedesktop.org's Boot Loader Specification](https://www.freedesktop.org/wiki/MatthewGarrett/BootLoaderSpec/)
* [systemd-boot](https://www.freedesktop.org/software/systemd/man/systemd-boot.html) - uefi app

Create a board-status repo, like coreboot
-----------------------------------------

See: <https://review.coreboot.org/plugins/gitiles/board-status/>

For testing boards in Libreboot (and osboot-libre), it would be nice to have
reports like on coreboot board-status entries.

This is especially important *now*, because lots of boards are being added to
both Libreboot and osboot-libre. It will *especially* be important for
osboot-libre, after the Libreboot release, because osboot-libre will start to
focus on being a rolling release, bleeding edge coreboot distro, while
Libreboot focuses on stable release. *board-status* entries like these will be
invaluable to both projects.

TODO: i945: test framebuffer(non-i915) init during S3 resume
------------------------------------------------------------

See notes here: <https://doc.coreboot.org/releases/coreboot-4.8.1-relnotes.html>

video init is skipped on i945 now, during S3 resume, to save time, and the i915
linux kernel driver can handle that, but other drivers should be tested. e.g.
generic corebootfb driver, drivers in various BSD systems, etc

61a3c8a005 payloads/tianocore: Add Kconfig to set boot timeout
--------------------------------------------------------------

this is from the coreboot git log. looks interesting. investigate

Document the following boards
-----------------------------

These boards are added, but not documented yet

### Acer G43T-AM3

See: [flashrom_read_me_disable.log.txt](flashrom_read_me_disable.log.txt)\
This is from Michael Büchler, whom I emailed, asking for info about this board.
This is the person who ported the board to coreboot.

Michael states the following:\
````
I'm also attaching a flashrom read log. The filename suggests that I
had the ME disable pin set.. so this was with the "-p internal"
flasher, but the SPI_ROM1 header also works. The pinout is 1:1 the same
as the EEPROM.

This reminds me that I wanted to create a page for this board on the
coreboot documentation. There you would have found this info. I should
do it soon.
````

ME disable pin? Probably setting GPIO33 or something. I've replied to Michael,
encouraging that person to document this board on the coreboot website.

indeed, next to the southbridge is a jumper and the silk screen says "ME disable"
so I'm guessing this is actually just GPIO33 being grounded. so it's not simply
disabling the ME, but the intel flash descriptor (which also disables NVM, not
just the ME)

Here are some photos:
TODO: add photos that michael sent me. i'm waiting for michael to confirm what
license. for now see these photos that i pulled from a search engine:

* <ttps://pc-1.ru/pic/big/1186411.jpg>
* <https://i5.walmartimages.com/asr/7ded9e88-73e6-4bc4-9b2a-ff22313c7172_2.9abea30734ddf03fc15b7188cb3e92cd.jpeg>

For flashing instructions:

* Refer to <https://av.libreboot.org/g43t-am3/soic8.jpg> - a proper photo is
  not available under a free license, or could not be found, so this diagram
  was made
* NOTE: It might not be possible to do ISP flashing. Several other X4X desktop
  mainboards are problematic.
* FOR EXAMPLE: <https://doc.coreboot.org/mainboard/intel/dg43gt.html>
* That's another X4X board, and it recommends to de-solder the flash
* It might be that this board, linked above, can be flashed ISP-style, but
  the person who wrote that page was using a 3.3V rail from a flasher like RPi
  or whatever, and maybe the flash chip shares a common rail with the southbridge
  or something else that draws a lot of current
* On GA-G41M-ES2L, it's possible to power on the board, then turn it off but
  leave it plugged in, and a 3.3V rail from the ATX PSU will be active, powering
  the chip and providing more than enough current. In that situation, you connect
  your SPI flasher without using your SPI flasher's 3.3V rail. That may also be
  the case on this board, and the one linked dabove.

I couldn't find exact schematics/boardviews, but I did find this:

* <http://download.ecs.com.cn/dlfileecs/manual/mb/eng/p4/G43T_MV10/G43T-M_V20.pdf>

2MiB flash chip according to:\
<https://review.coreboot.org/plugins/gitiles/board-status/+/refs/heads/master/acer/g43t-am3/4.12-4089-gb7e591e2da/2020-11-17T18_20_46Z/config.txt> and
<https://review.coreboot.org/plugins/gitiles/board-status/+/refs/heads/master/acer/g43t-am3/4.12-3211-gfb623a02c5/2020-10-11T11_24_19Z/config.txt>

NOTE: i think this is ICH10. Kconfig mentions IFD. flash it descriptorless
based on intel/dg43gt port using "motherboard porting guide"

coreboot ba49d859eeaeced032403b2da6a5f34ea2a93a94 added it. The following is
from that coreboot revision, in the commit log:

* Same board as Aspire M5800 (same vendor BIOS image)
* Similar mainboards by Acer: G41T-AM, G43T-AM, G43T-AM4, Q45T-AM, to name a few.
* ECS has some models that are obiously based on the same design, e.g. G43T-WM and G43T-M.

Working (ignore the note about Windows. Libreboot project doesn't care about
that. This is just copied from the coreboot git log):

* CPUs from Pentium Dual-Core E2160 to Core 2 Quad Q9550 at FSB1333
* Native raminit
* All four DIMM slots at 1066 MHz (tested 2x2GB + 2x4GB)
* PS/2 mouse
* PS/2 keyboard (needs CONFIG\_SEABIOS\_PS2\_TIMEOUT, tested: 500)
* USB ports (8 internal, 4 external)
* All six SATA ports
* Intel GbE
* Both PCI ports with various cards (Ethernet, audio, USB, VGA)
* Integrated graphics (libgfxinit)
* HDMI and VGA ports
* boot with PCIe graphics and SeaBIOS
* boot with PCI VGA and SeaBIOS
* Both PCIe ports
* Flashing with flashrom
* Rear audio output
* SeaBIOS 1.14.0 to boot slackware64
* SeaBIOS 1.14.0 to boot Windows 10 (needs VGA BIOS)
* Temperature readings (including PECI)
* Super I/O EC automatic fan control
* S3 suspend/resume
* Poweroff

Not working:

* Resource issues with the VGA BIOS of a PCI rv100-based card
* Super I/O voltage reading conversions

Untested:

* The other audio jacks or the front panel header
* On-board Firewire
* EHCI debug
* VBT (was extracted and added, but don't know how to test)
* Super I/O GPIOs

Generate ICH10 descriptor/nvm
-----------------------------

Coreboot has a few Intel X4X boards with ICH10 southbridge. These can be booted
descriptorless, but in some cases those boards will use an Intel gigabit NIC,
which means that the NIC will be useless in a descriptorless setup.

Basically `ich9utils` but for ich10. However, it's preferable to generate it
using bincfg. Intel provides some limited information about ICH10 descriptors
in public datasheets. The rest can be guessed at like it was for ICH9M in
libreboot.

Re-do desktop boards
--------------------

Right now, the configs make no sense. VGA ROM setup (for external GPU) also
runs libgfxinit, and vice versa, on KCMA-D8 / KGPE-D16, and in many
configs, both coreboot and seabios run pci roms. There needs to be consistency
here.

I think there should be separation:

* libgfxinit. coreboot doesn't load pci roms. seabios loads them
* vgarom-only setup, where coreboot runs pci roms. seabios doesn't load them

Add the following boards
------------------------

NOTE: some of these might not be suitable for Libreboot. Each one will be
checked, before adding it to Libreboot.

TODO: also check under "variants" for each board, and add more to this list if
any are found. These lists are generated by greping Kconfig files but sometimes
multiple boards are specified in a single Kconfig file. For example, macbook21
Kconfig also specifies imac52 and macbook11 without any code changes.

### lenovo/g505s

Last I checked, video init was a problem on this laptop. (binary blob, but
there was some work to implement free video initialization)

It might still be worth looking into

### Intel x4x platform

NOTE: some use ICH7 southbridge.

NOTE: others use ICH10, and some of *those* have Intel ME + descriptor. others
have descriptorless setup (no Intel ME). *all* of them can boot descriptorless,
so it's possible to nuke the Intel ME on all of them (ICH7 ones never have ME
to begin with)

NOTE: this is the same platform used by Gigabyte GA-G41M-ES2L which Libreboot
already supports. that one uses an ICH7 southbridge

#### Dell Optiplex 760

vitali64 on IRC is porting this to coreboot, and has it almost fully working

#### asrock/g41c-gs

Variants:

* g41c-gs-r2
* g41m-gs
* g41m-s3
* g41m-vs3-r2

#### asus/p5qc

Variants:

* p5q\_pro
* p5ql\_pro
* p5q

#### asus/p5ql-em

No variants specified in Kconfig

#### asus/p5qpl-am

Variants:

* p5g41t-m\_lx

#### foxconn/g41s-k

Variants:

* g41m

#### intel/dg41wv

No variants specified in Kconfig

#### intel/dg43gt

No variants specified in Kconfig

#### lenovo/thinkcentre\_a58

No variants specified in Kconfig

### Intel Pineview platform

NOTE: same platform as Intel D510MO / D410PT

* foxconn/d41s

### GM45 / ICH9M

#### lenovo/x301 (thinkpad x200 variant)

ThinkPad X200 variant. Use standand ICH9M descriptor+nvm image

### Intel i945

same platform as X60/T60 thinkpads. some of these are desktops, so there will
be some differences. it's unlikely that Intel ME will be an issue on any of
them.

#### asus/p5gc-mx

No variants specified by Kconfig

#### getac/p470

No variants specified by Kconfig

#### gigabyte/ga-945gcm-s2l

Variants:

* ga-945gcm-s2c

#### ibase/mb899

No variants specified by Kconfig

#### kontron/986lcd-m

No variants specified by Kconfig

#### roda/rk886ex

No variants specified by Kconfig

### AMD Fam10h / Fam15h

These boards are not a priority at the moment, but they will be added at some
point (*after* the post-2016 release). These were all deleted from coreboot in
version 4.11 (they are fam10h/15h boards). On this TODO page is an entry
asking whether to fork coreboot 4.11 and maintain it, backporting newer features
from coreboot, making it work with newer GCC toolchains, and so on.

NOTE: some of these are a *big* if, but many of them will work nicely without
binary blobs when booting. NOTE: use of a VGA option ROM is implied, and
Libreboot won't provide these, but the user could install an add-on graphics
card and coreboot/seabios would just run whatever is on the card. There is no
problem with Libreboot running those, because they could be free or non-free,
we just don't know.

In practise, most of these probably don't have native video initialization in
coreboot for the onboard GPU (if present), because it's probably an AMD/ATI
one and libgfxinit doesn't have good support for those (it mostly has
excellent support for Intel video chipsets).

This doesn't mean Libreboot can't support them. It just means that we will have
to provide ROM images that don't use libgfxinit. Instead, the ROMs provided
will always run VGA option ROMs present on the GPU. Here we mean add-on video
cards, which means there's no way for the Libreboot project to predict what
hardware will be used. It means that any GPU could be used. It probably implies
use of SeaBIOS, but coreboot itself is able to run those VGA ROMs which enables
other payloads (such as GNU GRUB) to be used reliably (with text mode startup).

Where external VGA ROMs are concerned, Libreboot prefers for coreboot to run
them, and for SeaBIOS to run run them, OR, for SeaBIOS to run it but be the
main payload.

In cases where coreboot runs the VGA ROM, it can also run other PCI ROMs, and
SeaBIOS doesn't need to do anything (and in fact shouldn't do anything).

On boards that *do* have libgfxinit support, coreboot isn't running any PCI
ROMs, which means no PCI ROMs for GRUB, which means you should use the SeaBIOS
payload, either as the main payload or chainloaded from GRUB.

Also: it's still possible to use a serial console. You could use any of these
boards in a headless server setup, with no graphics card.

Also: there are USB VGA adapters available. Driver support in the Linux kernel
is flaky for a lot of them, but you might be able to get some sort of desktop
usage out of these boards, if you used one of them (there would be no display
during early boot, but you would see something when booting your kernel). With
llvmpipe driver you could actually get good use out of these. They are usually
a simple framebuffer chip inside.

#### advansus/a785e-i

No variants specified by Kconfig

#### amd/bimini\_fam10

No variants specified by Kconfig

#### amd/mahogany\_fam10

No variants specified by Kconfig

#### amd/serengeti\_cheetah\_fam10

No variants specified by Kconfig

#### amd/tilapia\_fam10

No variants specified by Kconfig

#### asus/m4a785-m

No variants specified by Kconfig

#### asus/m4a785t-m

No variants specified by Kconfig

#### asus/m4a78-em

No variants specified by Kconfig

#### asus/m5a88-v

No variants specified by Kconfig

#### avalue/eax-785e

No variants specified by Kconfig

#### gigabyte/ma785gm

No variants specified by Kconfig

#### gigabyte/ma785gmt

No variants specified by Kconfig

#### gigabyte/ma78gm

No variants specified by Kconfig

#### hp/dl165\_g6\_fam10

No variants specified by Kconfig

#### iei/kino-780am2-fam10

No variants specified by Kconfig

#### jetway/pa78vm5

No variants specified by Kconfig

#### msi/ms9652\_fam10

No variants specified by Kconfig

#### supermicro/h8dmr\_fam10

No variants specified by Kconfig

#### supermicro/h8qme\_fam10

No variants specified by Kconfig

#### supermicro/h8scm\_fam10

No variants specified by Kconfig

#### tyan/s2912\_fam10

No variants specified by Kconfig

### gm45

#### thinkpad w700

<http://www.thinkwiki.org/wiki/Category:W700>

might be fun to work on. probably doesn't require much modification in
coreboot, if any. buy one and port it to coreboot

There are photos on this page:

<http://web.archive.org/web/20210510205738/https://notabug.org/libreboot/libreboot/issues/573>

Linuxboot payload
-----------------

Linuxboot is a busybox+linux system available here:\
<https://www.linuxboot.org/>

It goes in bootflash. It provides a bootloader program called u-root, which
uses kexec to boot other kernels. It also provides some UEFI features, and it
can parse GNU GRUB configuration files. It requires a large amount of flashing
space (at least 12MiB, but it might be possible to squeeze it into 8MiB).

The problem is: it is using the upstream Linux kernel. TODO: fork Linuxboot and
make the fork use linux-libre. Check other packages too. With this, a fully
libre (by FSF standards) busybox+linux distro can be made, based on Linuxboot.

Linuxboot-libre is the working name for this new project. It will absolutely
knock the wind out of GRUB and anything else, on setups where it's possible to
use this payload.

Other payloads will still be retained, of course.

Fork coreboot 4.11 and maintain, for fam10h/15h boards
------------------------------------------------------

Nowadays, coreboot removes boards. For example, KCMA-D8 and KGPE-D16 (and others
were removed) from coreboot because they don't support relocatable ramstage,
`C_ENVIRONMENTAL_BOOTBLOCK`, postcar and a few other features are required now
in coreboot ports.

For libreboot purposes, it's mostly AMD Fam10/15h boards that were removed.
These were maintained based on AMD's AGESA codebase, which was never properly
integrated. It was just bolted on to coreboot, without honouring coreboot's
native coding style and maintaining it was very difficult. The person maintaining
fam10h/15h boards (in particular KCMA-D8 and KGPE-D16) had stopped doing work
on those boards at that point.

Libreboot currently does not fork coreboot, and it never has. Rather, it has
been a downstream distribution of coreboot, de-blobbing it and patching it
when necessary. This was sustainable before, because more or less just one
revision could be used.

There are mainly 2 choices:

* Re-add deleted boards to coreboot
* Fork older coreboot revisions with those other boards, and keep backporting
  newer features from later coreboot revisions
  (for instance, coreboot now has the ability to clear all DRAM on every bootup
  but this configuration option is unavailable on KCMA-D8 and KGPE-D16 mainboards)

In practise, since this mostly affects fam10h/fam15h boards, it's probably
*easier* to do the latter; fork older coreboot revision (version 4.11 in this
case) and start backporting newer features; the current code works well, and
only minor fixes will be needed here and there over time (e.g. patch it up to
work on newer GCC versions when building).

Forking the *entire* coreboot project and maintaining it for more than just a
few boards isn't really practical. It is best to cooperate with upstream, but
in this case we are talking only about boards that were deleted.

It's always possible to bring the code on those deleted boards up to date again
in the future, for re-entry into the coreboot master repository.

Test SeaBIOS option: etc/usb-time-sigatt
----------------------------------------

default is 500ms. setting it higher like 1000s might make USB drives work in
SeaBIOS on KFSN4-DRE. see notes
on <https://www.seabios.org/Runtime_config#Option_ROMs>

SST+macronix patches for flashrom on X60/T60
------------------------------------------------------

These binaries are referenced in the documentation currently not actually
available and the build system (lbmk) does not produce them.

Warnings about option ROMs
--------------------------

They're bad because they're non-free. They violate the four freedoms.
Libreboot enables automatic loading of PCI option ROMs in some setups, simply
for the purpose of technical correctness, because there's no rule that says an
option ROM must be non-free. It's possible that an option ROM might actually be
free software.

Banning option ROMs in Libreboot desktops would be like banning all software
from executing in an operating system, just because those programs might be
non-free.

Instead, the *correct* solution ethically is to just tell people not to use
non-free software, and for the *libreboot project* to never directly recommend,
distribute or document non-free software.

Use coreboot's memtest86+ fork
------------------------------

The current version used does build, but it doesn't run, or it glitches out.
That version of memtest is designed to be run on a normal BIOS system, so it
might actually work with the SeaBIOS payload, but we want to use a memtest
version that is guaranteed to work on bare metal, which is more common on
Libreboot systems.

Gemini site for libreboot
-------------------------

Gemini is a popular alternative to the web. See:
<https://gemini.circumlunar.space/>

I've noticed a lot of projects starting to offer this, in addition to a regular
website.

pandox2gem i'm told is a good tool that could integrate with the current static
site generator, which uses pandoc (the pages are written in markdown)

Tor site for libreboot
----------------------

hidden onion service

host it separately from the main site, on a different server. that way, there
is another website just in case

2nd HTTP site
-------------

Have different DNS records for ns2. specifically, different IPv4+6 for the site.
When the main ns1 is down, the new website will kick in. (ns1 and ns2 are both
currently hosted on the same network as the website)

i2p site
--------

I probably won't, but someone is welcome to do this and libreboot.org will
link to it

Fix GRUB bugs
-------------

Many of these bugs only happen in bare metal, and only on devices supported by
libreboot. See:

<http://web.archive.org/web/20210510213902/https://notabug.org/libreboot/libreboot/issues/561>

Security patch: spectre MSR fixes for Fam15h boards
---------------------------------------------------

See: <http://web.archive.org/web/20210510214458/https://notabug.org/libreboot/libreboot/issues/440>

Document teensy SPI flasher
---------------------------

The following page has information, which can be assimilated:
<https://trmm.net/SPI_flash/>

Also see:
<https://www.flashrom.org/Teensy_3.1_SPI_%2B_LPC/FWH_Flasher>

Also see this interesting firmware here:
<https://github.com/urjaman/frser-teensyflash>\
NOTE: i've made a local git clone of this

TODO: document use of schottky diode for VCC on SPI flash (ISP)
---------------------------------------------------------------

this type of diode has minimal voltage drop. most flashes run close to their
specified 3.3v, sometimes a bit higher, but the tolerated range is between 2.7
and 3.6v

notes about use of a diode is already specified in the external flashing guide
but those notes should be improved

* x200 (after cutting solder bridge - R405 - between flash chip and ICH9M)
* x200s/x200t/w700 - 25xx flash Vcc is hardwired :( (to be confirmed on production board)
* t400/t400s/t500/x301 - 25xx flash Vcc is hardwired, as everything else on UCI/lenovo boards

Document alternative external flashing method for X200S/X200T
-------------------------------------------------------------

GNUtoo wrote this interested guide:
<https://framagit.org/GNUtoo/coreboot-scripts/-/tree/master/flash-wson8>

It still requires external flashing, but no soldering.

TODO: what about bucts? the bootblock is protected by PR4, but is it possible
to use BUCTS and init from another bootblock?

NOTE TO SELF: a local git clone has been made of the above

Handle SATA power in ultrabay on gm45 thinkpads
-----------------------------------------------

See:
<http://web.archive.org/web/20201022210929/https://notabug.org/libreboot/libreboot/issues/484>

document serial/lpt/pcie bus enable/disable on GA-G41M-ES2L
-----------------------------------------------------------

See:
<http://web.archive.org/web/20210510214317/https://notabug.org/libreboot/libreboot/issues/469>

This might be why graphics cards and add-on network cards didn't work on mine,
last time i tested it. it's a config option that must be enabled in coreboot?

Document quad-core mods on GM45 thinkpads
-----------------------------------------

NOTE: MAX\_CPUS=4 is now the default, in coreboot, for these machines.

There's a mod for T500 thinkpads, but it will
work on any gm45 thinkpad supported in libreboot.
Just have to study the schematics and boardview,
then adapt the info available online for T500.

NOTE: max CPUs has to be set in coreboot

Document a *clean* way to do it. The current guides online have you drilling
holes in the CPU socket! That's why they won't be linked here.

Some notes are already written here. expand upon them:
<http://web.archive.org/web/20210307234010/https://notabug.org/libreboot/libreboot/issues/340>
