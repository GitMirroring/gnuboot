---
title: Libreboot project
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

Libreboot is a [free software](https://www.gnu.org/philosophy/free-sw.html)
project, but can be considered Open Source.
[GNU teaches
us](https://www.gnu.org/philosophy/open-source-misses-the-point.en.html)
why you should call it *free software* or *libre software*. Free software
matters. [Right to repair](https://vid.puffyan.us/watch?v=Npd_xDuNi9k) matters.

Libreboot uses [coreboot](https://www.coreboot.org/) for
[hardware initialization](https://doc.coreboot.org/getting_started/architecture.html).
However, *coreboot* is notoriously difficult to configure and compile for
non-technical users. coreboot only handles basic hardware initialization before
jumping to a separate [payload](https://doc.coreboot.org/payloads.html) program
(e.g. [GRUB](https://www.gnu.org/software/grub/),
[Tianocore](https://www.tianocore.org/)), which the user must also configure.

Libreboot solves this problem. It is a *coreboot distribution* with
an [automated build system](docs/build/) that configures and builds
complete *ROM images* for easy installation, with regular releases and
user-friendly documentation.

Libreboot has advanced features like
[encrypted /boot/](docs/gnulinux/encrypted_debian.md) and [GPG support](docs/gnulinux/grub_hardening.html).
Binary blobs from coreboot are excluded, making Libreboot *100% free
software*. It is [endorsed by the Free Software
Foundation](https://www.fsf.org/blogs/licensing/replace-your-proprietary-bios-with-libreboot). Libreboot
has [helped](https://www.gnu.org/education/how-i-fought-to-graduate-without-using-non-free-software.html)
many people, [including the FSF, the GNU
project](https://www.fsf.org/bulletin/2017/fall/six-months-of-equipment-upgrades-at-the-fsf)
and [GNU project founder, Richard Stallman](https://stallman.org/stallman-computing.html).
