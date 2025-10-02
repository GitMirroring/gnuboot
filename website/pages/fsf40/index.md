---
title: FSF40 Hackathon
...

Introduction
============

GNU Boot participates in the [FSF40
hackathon](https://www.fsf.org/events/fsf40-hackathon).

As part of this hackathon GNU Boot has worked on defining some tasks
that you might be interested in contributing to.

If you don't know which tasks to pick, try to maximize the chance of
your work getting into GNU Boot as-is by picking tasks that are easy
for you, and that you have a chance to finish, and to polish for
inclusion into GNU Boot.

Tasks that don't require any specific hardware or software
==========================================================

Here if you know a bit Markdown or CommonMark and git, you can easily contribute
without even having to build the website.

However if you still want to do that (to test your changes), you can see
the [Building the website](#building-the-website) section below.

Make patches for tested computers
---------------------------------

The [bug tracker used by GNU
Boot](https://savannah.gnu.org/bugs/?group=gnuboot) has several report
of computers having been tested with GNU Boot.

This task would consist in making patches to add that information to
the GNU Boot website status page.

The patches should also contain a link to the bug reports like that:

```
Bug-report: https://savannah.gnu.org/bugs/?12345
```

This could be extremely useful if there are computers that weren't
tested before with GNU Boot, or if the latest version of GNU Boot was
tested.

Website: easy fixes
-------------------

The GNU Boot website is a mess:

* It still contains reference to Libreboot

* A lot of the content in the pages is outdated or wrong.

So you can simply read the website until you find sometihng that is
easy to fix.

To fix it, you can simply download GNU Boot from git, read the
documentation on [how to
contribute](contribute.html#how-to-contribute), and send a patch to
the GNU Boot mailing list.

While this is probably the easiest task in the list, it's also hard to
know in advance how useful the contributions will be: it basically
depend on what issue you found and fix.

Also note that the [Website: improve "DiffieHellman"'s patches
task](#website-improve-diffiehellmans-patches) touches the following files:

* website/pages/docs/hardware/index.md

* website/pages/docs/hardware/r400.md

* website/pages/docs/hardware/t500.md

* website/pages/docs/hardware/x200.md

So it might be easier if you don't touch these to avoid conflicting
changes in case someone else wants to work on this other task.

Website: improve "DiffieHellman"'s patches
------------------------------------------

In May 2025, there were patches ("Replace proprietary EC installation
recommendation [...]") sent by "DiffieHellman" on the gnuboot-patches
mailing list but they need to be split (more information on how to do
that can be found on the thread about this patch on the GNU Boot
mailing list).

The task here would be to do this split and send the resulting patches
to the mailing list.

The patches were extracted from the mailing list and are listed below
for convenience:

* [0001-index.patch](DiffieHellman-website/0001-index.patch)

* [0002-r400.patch](DiffieHellman-website/0002-r400.patch)

* [0003-t500.patch](DiffieHellman-website/0003-t500.patch)

* [0004-x200.patch](DiffieHellman-website/0004-x200.patch)

At the time of writing they can be applied on top of
the commit 39c70840617d2fd849284919232b0cc09384a96c ("configure.ac,
website/configure.ac: unify guix revision declaration.").

This requires to know git well enough to split patches. It would
enable us to finally merge the modifications and not to have to keep
them in mind.

Easy fixes from bug reports
---------------------------

The bug tracker has at least this bug:

* https://savannah.gnu.org/bugs/?66681

This task would consist in making patches to fix the issues being
reported.

The patches should also contain a link to the bug reports like that:

```
Bug-report: https://savannah.gnu.org/bugs/?12345
```

Having broken links isn't nice and so this should be fixed.

In this case the following patch could help, as we also need to
properly integrate the SVG source code of the logos we have in GNU
Boot:

* [0001-Add-GNU-Boot-logos-sources-and-use-them-to-generate-.patch](logos/0001-Add-GNU-Boot-logos-sources-and-use-them-to-generate-.patch)

Tasks that require to contribute to other projects
==================================================

Make sure Guix is in the next Trisquel version
----------------------------------------------

At the time of writing [the Guix package will be removed from
Debian](https://lwn.net/Articles/1035491/) very soon, so this
complicates things as it might also be dropped from PureOS and
Trisquel as well as from all other distributions based on Debian.

The reason is related to security: Guix had several security issues
([September
2025](https://guix.gnu.org/en/blog/2025/privilege-escalation-vulnerability-2025-2/),
[June
2025](https://guix.gnu.org/en/blog/2025/privilege-escalation-vulnerabilities-2025/),
[October
2024](https://guix.gnu.org/en/blog/2024/build-user-takeover-vulnerability/),
[March
2024](https://guix.gnu.org/en/blog/2024/fixed-output-derivation-sandbox-bypass-cve-2024-27297/))
that enabled an attacker that already executed code on a machine, to get root
access on this machine.

Here the task would be to backport all the required patches and try to
convince the Trisquel maintainer to keep the guix package.

This is extremely important for GNU Boot as Guix for several reasons:

* Guix is required to really trust GNU Boot. GNU Boot isn't really
  reproducible yet, so we encourage users that care about certain
  security attacks to build from source. To do that we encourage users
  to use Guix to verify the signature of the GNU Boot source code
  downloaded with git.

* Nowadays, guix is a non-optional dependency for GNU Boot and the
  plan is to convert more and more scripts to Guix packages. Having
  Guix being easy to install is important as it also enables to more
  easily contribute to GNU Boot, and maybe to download GNU Boot in a
  far future.

This would also benefit Replicant as well as its blog is being
migrated to Haunt which is only packaged in Guix.

Remove nonfree software in arm-trusted-firmware in free GNU/Linux distros
-------------------------------------------------------------------------

[Leah Rowe found a nonfree hdcp.bin in GNU
Boot](https://lists.gnu.org/archive/html/gnuboot-patches/2024-10/msg00028.html).

This issue has long been fixed in GNU Boot, but it's not fixed in
GNU/Linux distributions.

This task would consist in removing this nonfree software in Guix, and
all [free GNU/Linux
distributions](https://www.gnu.org/distros/free-distros.html), but also
to notify other distributions like Debian that have a policy against
the inclusion of nonfree software in some of their repositories.

The [Bug #66246](https://savannah.gnu.org/bugs/?66246) is an example
of how we dealt with a similar issue after finding nonfree software in
vboot.

This is also important for GNU Boot because we can't add ARM support
by shipping nonfree software.

This would also benefit Replicant as well that needs a free bootloader
and will probably use Guix and/or GNU Boot to go forward with the port
of Replicant to the Pinephone.

Investigate nonfree software in u-boot
--------------------------------------

Recent u-boot probably have nonfree software. So these would require
to investigate the following:

[The Debian Copyrights file for
u-boot](https://metadata.ftp-master.debian.org/changelogs/main/u/u-boot/u-boot_2025.01-3_copyright)
doesn't seems to list nonfree software in u-boot, however there is
clearly nonfree code.

Recent u-boot still have the
drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h which nonfree code in it
and a nonfree license. The arch/x86/dts/microcode/ directory is also
still present. See the [blobs.list](blobs.list) file from GNU Boot
source codefor more details.

In addition there is also the [GNU Boot Bug
#64904](https://savannah.gnu.org/bugs/?64904) that raises additional concerns about u-boot.

Here this task consist in investigating what happened in Debian to
make sure we are on the right track, and contacting all [free
GNU/Linux distribution](https://www.gnu.org/distros/free-distros.html)
and other distributions as well that have a policy against the
inclusion of nonfree software in some of their repositories.

It might also require to contribute to
[common-distros](https://www.gnu.org/distros/common-distros.html) in
case some nonfree distributions changed policies.

Once the investigation is done, the task would consist in fixing this
issue in [free GNU/Linux
distribution](https://www.gnu.org/distros/free-distros.html),
especially Guix as GNU Boot wants to reuse Guix to add ARM support.

This would also benefit Replicant as well that needs a free bootloader
and will probably use Guix and/or GNU Boot to go forward with the port
of Replicant to the Pinephone.

Remove nonfree software in vboot in free GNU/Linux distros
----------------------------------------------------------

We found nonfree software in vboot, and we removed it from GNU
Boot. We also contacted many distributions about the issue and even
managed to contact the upstream of this software through Coreboot.

However we're not sure if the issue is fixed in all [free GNU/Linux
distribution](https://www.gnu.org/distros/free-distros.html) or not.

This task would be to make sure of that. Note that Replicant is also
affected but nobody had the time to look into it yet for Replicant.

The [Bug #66246](https://savannah.gnu.org/bugs/?66246) has more
details on that.


Removes nonfree software in Coreboot source package in Guix
-----------------------------------------------------------

GNU Boot plans to use Guix more and more. However we found nonfree
software in the Coreboot source shipped by Guix, but due to the lack
of reviewers familiar with Coreboot our patches were never merged.

The [bug #67403](https://debbugs.gnu.org/cgi/bugreport.cgi?bug=67403)
has more details on the issue.

The task would consist in taking these patches, updating them if
needed and upstreaming them in Guix.


Test the workman keyboard patch
-------------------------------
"DiffieHellman" sent a patch for adding the workman keyboard:

[0001-Added-workman-keymap.patch](workman/0001-Added-workman-keymap.patch).

Unfortunately nobody tested it so it was never included.

The following patches can help with testing:

* [0001-build-download-Handle-unusable-dev-kvm.patch](qemu/0001-build-download-Handle-unusable-dev-kvm.patch)
* [0002-manual-Document-how-to-use-GNU-Boot-with-QEMU.patch](qemu/0002-manual-Document-how-to-use-GNU-Boot-with-QEMU.patch)

Tasks that require specific computers or flash programmers
==========================================================

Test GNU Boot
-------------

On the GNU Boot [status
page](../status.html), very few
computers are tested.

We need help for testing computers. So if you have the knowledge and
hardware to recover from non-working GNU Boot image, this is probably
the most useful contribution you can do.

This would be especially useful with computers that were never tested
before in any GNU Boot revisions.

Write an installation guide with the ChipFlasher v2
---------------------------------------------------

We don't have any good installation instructions. The only one we have
are on our website and come with a scary warning.

This guide needs to be made for one of these computers:

* Lenovo, ThinkPad R400, R500, T400, T400s, T500, W500

* Lenovo, ThinkPad X200, X200s, X200 Tablet, X301

These ThinkPad models are well supported by GNU Boot, don't have a
glossy display that [can be more dangerous for the
health](https://en.wikipedia.org/wiki/Glossy_display#Adverse_health_effects),
especially when working a lot on the computer, and it is relatively
easy to install a [free GNU/Linux
distribution](https://www.gnu.org/distros/free-distros.html) on them.

You will need to use the ChipFlasher v2 in the instructions as this
makes it much easier to install GNU Boot safely (basically not making
things worse). You will also need to care about static electricity to
not reduce the computer lifespan.

The ChipFlasher v2 will need to use the stock flashrom compatible
firmware to make things easier.

Your guide will need to be added in the manual, but if you are more
comfortable with another format like markdown and/or the website, we
could convert your work to the format used by the manual later on.

You don't need to care about improving the computer (like Changing the
WiFi card, the battery, applying thermal paste and so on) because
there is already a section meant for that in the manual, and this
could be added later on, and it's better to concentrate on having
something basic that works, rather than having unfinished work, and
this can also be done later on.

You will also instruct users to backup and restore what is on the
computer flash chip. At this point we also assume that the computer
comes with a nonfree BIOS, so you don't need to do anything special
for saving and restoring the MAC address, though users will have to
keep backups of the nonfree BIOS anyway, so the MAC address should be
in there, and could be reused for a later guide.

It would be good to either be able to take pictures or to be able to
reuse pictures under a free license with a clear copyright
situation. The pictures that we have already on the GNU Boot website
should be pretty safe to use.

You can apply these patches first in case you want to know how the
Chipflasher v2 will be added in the list of flash programmers inside
the manual:

* [0001-manual-distinguish-distros-from-the-hardware-they-su.patch](chipflasher/0001-manual-distinguish-distros-from-the-hardware-they-su.patch)

* [0002-manual-add-bootloader-s-supported-with-SeaBIOS-image.patch](chipflasher/0002-manual-add-bootloader-s-supported-with-SeaBIOS-image.patch)

* [0003-manual-Supported-operating-systems-split-in-differen.patch](chipflasher/0003-manual-Supported-operating-systems-split-in-differen.patch)

* [0004-manual-GRUB-images-add-information-about-grub.cfg-im.patch](chipflasher/0004-manual-GRUB-images-add-information-about-grub.cfg-im.patch)

* [0005-manual-GRUB-images-add-information-well-supported-pa.patch](chipflasher/0005-manual-GRUB-images-add-information-well-supported-pa.patch)

* [0006-manual-GRUB-images-add-information-about-LVM2-partit.patch](chipflasher/0006-manual-GRUB-images-add-information-about-LVM2-partit.patch)

* [0007-manual-GRUB-images-add-information-about-RAID-partit.patch](chipflasher/0007-manual-GRUB-images-add-information-about-RAID-partit.patch)

* [0008-manual-GRUB-images-warn-about-potential-removal-of-l.patch](chipflasher/0008-manual-GRUB-images-warn-about-potential-removal-of-l.patch)

* [0009-manual-move-security-in-its-own-chapter.patch](chipflasher/0009-manual-move-security-in-its-own-chapter.patch)

* [0010-manual-security-add-section-about-updating-GNU-Boot.patch](chipflasher/0010-manual-security-add-section-about-updating-GNU-Boot.patch)

* [0011-manual-security-add-information-about-installing-GNU.patch](chipflasher/0011-manual-security-add-information-about-installing-GNU.patch)

* [0012-manual-security-add-section-on-trusting-hardware.patch](chipflasher/0012-manual-security-add-section-on-trusting-hardware.patch)

* [0013-manual-security-add-instruction-to-check-images-sign.patch](chipflasher/0013-manual-security-add-instruction-to-check-images-sign.patch)

* [0014-manual-flash-programmers-add-Chipflasher-v2.patch](chipflasher/0014-manual-flash-programmers-add-Chipflasher-v2.patch)

To build the manual, see the [Building the manual](#building-the-manual)
section below.

Test the ChipFlasher v2 without a firmware
------------------------------------------

This requires to contribute to the ChipFlasher v2 directly.

The ChipFlasher v2 comes with a builtin free firmware. However the
stock firmware might need to be built from source for security reasons
and/or users might need to upgrade the ChipFlasher firmware at some
point. The firmware that is compatible with the 'connect' utility
provided by the ChipFlasher can also provide speed improvements that
are always useful.

However both these speed improvements and the loading of a different
free firmware can bring compatibility issues with some USB<->Serial
adapter.

Here the task would be to test as many USB<->Serial adapter,
especially those with a PL2303 chip. Some of these adapters produce
the following kernel log when they are connected to a computer (it can
be seen with the 'dmesg' command):

```
[  123.456789] ftdi_sio ttyUSB0: Unable to read latency timer: -32
```

So this task would be to help the ChipFlasher creator to fix these
issues and also test adapters at bigger speed.

For more background here are some patches that shows how the
ChipFlasher v2 might be integrated in the GNU Boot manual:

* [0001-manual-distinguish-distros-from-the-hardware-they-su.patch](chipflasher/0001-manual-distinguish-distros-from-the-hardware-they-su.patch)

* [0002-manual-add-bootloader-s-supported-with-SeaBIOS-image.patch](chipflasher/0002-manual-add-bootloader-s-supported-with-SeaBIOS-image.patch)

* [0003-manual-Supported-operating-systems-split-in-differen.patch](chipflasher/0003-manual-Supported-operating-systems-split-in-differen.patch)

* [0004-manual-GRUB-images-add-information-about-grub.cfg-im.patch](chipflasher/0004-manual-GRUB-images-add-information-about-grub.cfg-im.patch)

* [0005-manual-GRUB-images-add-information-well-supported-pa.patch](chipflasher/0005-manual-GRUB-images-add-information-well-supported-pa.patch)

* [0006-manual-GRUB-images-add-information-about-LVM2-partit.patch](chipflasher/0006-manual-GRUB-images-add-information-about-LVM2-partit.patch)

* [0007-manual-GRUB-images-add-information-about-RAID-partit.patch](chipflasher/0007-manual-GRUB-images-add-information-about-RAID-partit.patch)

* [0008-manual-GRUB-images-warn-about-potential-removal-of-l.patch](chipflasher/0008-manual-GRUB-images-warn-about-potential-removal-of-l.patch)

* [0009-manual-move-security-in-its-own-chapter.patch](chipflasher/0009-manual-move-security-in-its-own-chapter.patch)

* [0010-manual-security-add-section-about-updating-GNU-Boot.patch](chipflasher/0010-manual-security-add-section-about-updating-GNU-Boot.patch)

* [0011-manual-security-add-information-about-installing-GNU.patch](chipflasher/0011-manual-security-add-information-about-installing-GNU.patch)

* [0012-manual-security-add-section-on-trusting-hardware.patch](chipflasher/0012-manual-security-add-section-on-trusting-hardware.patch)

* [0013-manual-security-add-instruction-to-check-images-sign.patch](chipflasher/0013-manual-security-add-instruction-to-check-images-sign.patch)

* [0014-manual-flash-programmers-add-Chipflasher-v2.patch](chipflasher/0014-manual-flash-programmers-add-Chipflasher-v2.patch)

Dependencies
============

Some of the tasks above require to build the manual, and some may
require to build the website. Below are instructions on how to do that
with Guix.

Building the manual
-------------------

To build the manual you will need Guix in one way or another, so let's
use it to build the manual as well.

To do that first download GNU Boot and create a Guix shell with all
the required dependencies:

```
$ git clone https://git.savannah.gnu.org/git/gnuboot.git
$ cd guix
$ guix shell -C autoconf automake bash coreutils diffutils findutils gawk \
  gcc-toolchain graphicsmagick grep guix libtool m4 make sed tar \
  texinfo texlive-collection-fontsrecommended \
  texlive-collection-latexrecommended texlive-epsf \
  texlive-scheme-basic texlive-texdoc which -- bash
```

Once this is done you should be inside a Guix shell, and you can build
the manual with these commands:

```
[env]$ sed "s%#\!/usr/bin/env bash%#\!$(which bash)%" -i guix-revision.sh
[env]$ bash ./autogen.sh
[env]$ bash ./configure --disable-kvm
[env]$ make pdf
```

You can also avoid using Guix to build the manual, and it works with
Trisquel, but since GNU Boot will check for Guix presence, you will
still need either to install it.

Building the website
--------------------

To build the website, first download the GNU Boot source code and go
inside the website directory:

```
$ git clone https://git.savannah.gnu.org/git/gnuboot.git
$ cd guix/website
$ icecat http://localhost:8086/software/gnuboot/
```

Once done you can either use the following commands to build and test
the website Guix:

```
$ ./autogen.sh
$ ./configure
$ make serve
```

Or read the documentation in the README file which explains how to
build and test the website on Trisquel without Guix.
