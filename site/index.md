---
title: Free your BIOS today!
...

Libreboot is
[freedom-respecting](https://www.gnu.org/philosophy/free-sw.html) *boot
firmware* that initializes the hardware (e.g. memory controller, CPU,
peripherals) on [specific Intel/AMD x86 computers](docs/hardware/) and starts
a bootloader for your operating system. [GNU+Linux](docs/gnulinux/)
and [BSD](docs/bsd/) are well-supported. It replaces proprietary BIOS/UEFI
firmware. Help is available
via [\#libreboot](https://web.libera.chat/#libreboot)
on [Libera](https://libera.chat/) IRC.

The latest version is [Libreboot 20211122](news/libreboot20211122.md), released
on 22 November 2021.

Join us now and flash the firmware!
-----------------------------------

You have rights. The right to privacy, freedom of thought, freedom of speech
and the right to read. [Free
software](https://www.gnu.org/philosophy/free-sw.html) gives you these rights.
Your freedom matters.
[Right to repair](https://vid.puffyan.us/watch?v=Npd_xDuNi9k) matters.
Many people use [proprietary](https://www.gnu.org/proprietary/proprietary.html)
boot firmware, even if they use [GNU+Linux](https://www.gnu.org/distros/).
Non-free firmware often [contains](faq.html#intel) [backdoors](faq.html#amd),
and can be buggy. Libreboot was founded in in December 2013, with the express
purpose of making Free Software accessible for non-technical users at the
firmware level. Libreboot can be called Open Source, [but you should call it
Free
Software](https://www.gnu.org/philosophy/open-source-misses-the-point.en.html).

Libreboot uses [coreboot](https://www.coreboot.org/) for [hardware
initialization](https://doc.coreboot.org/getting_started/architecture.html).
Coreboot is notoriously difficult to install for most non-technical users; it
handles only basic initialization and jumps to a separate
[payload](https://doc.coreboot.org/payloads.html) program (e.g.
[GRUB](https://www.gnu.org/software/grub/),
[Tianocore](https://www.tianocore.org/)), which must also be configured.
*Libreboot solves this problem*; it is a *coreboot distribution* with
an [automated build system](docs/build/) that builds complete *ROM images*, for
more robust installation. Documentation is provided.

How does Libreboot differ from regular coreboot?
------------------------------------------------

Contrary to popular opinion, Libreboot's primary purpose is not to provide a
de-blobbed coreboot setup; it is merely one of Libreboot's policies, and an
important one, but it is nonetheless a minor aspect of Libreboot.

In the same way that Trisquel is a GNU+Linux distribution, Libreboot is
a *coreboot distribution*. If you want to build a ROM image from scratch, you
otherwise have to perform expert-level configuration of coreboot, GRUB and
whatever other software you need, to prepare the ROM image. With *Libreboot*,
you can literally download from Git or a source archive, and run `make`, and it
will build entire ROM images. Libreboot's automated build system, named `lbmk`
(Libreboot MaKe), builds these ROM images automatically, without any user input
or intervention required. Configuration has already been performed in advance.

If you were to build regular coreboot, without using Libreboot's automated
build system, it would require a lot more intervention and decent technical
knowledge to produce a working configuration.

Reguar binary releases of Libreboot provide these
ROM images pre-compiled, and you can simply install them, with no special
knowledge or skill except the ability to
follow [simplified instructions, written for non-technical
users](docs/install/).

How to help
-----------

Check the [tasks](tasks/) page and pick a task to work on. You can also check
bugs listed on the [bug tracker](https://notabug.org/libreboot/lbmk/issues).

If you spot a bug and have a fix, [here are instructions for how to send
patches](git.md), and you can also report it. Also, this entire website is
written in Markdown and hosted in a [separate
repository](https://notabug.org/libreboot/lbwww) where you can send patches.

Libreboot development discussion and user support are all done on the IRC
channel. More information is on the [contact page](contact.md).
