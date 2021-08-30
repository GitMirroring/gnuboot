---
title: Libreboot project
...

Libreboot is
[freedom-respecting](https://www.gnu.org/philosophy/free-sw.html)
*boot firmware* that initializes the hardware (e.g. memory controller, CPU,
peripherals) in your computer and starts a bootloader for your operating
system. It replaces proprietary BIOS/UEFI firmware. Libreboot works
on [specific Intel/AMD x86 platforms](docs/hardware/), with decent
[GNU+Linux](docs/gnulinux/) and [BSD](docs/bsd/) support. Help is available
via [\#libreboot](https://web.libera.chat/#libreboot) on
[Libera](https://libera.chat/) IRC. *The latest release is Libreboot
20210522, from 22 May 2021.*

Libreboot is a [Free software](https://www.gnu.org/philosophy/free-sw.html)
project, but can be considered Open Source.
[GNU teaches
us](https://www.gnu.org/philosophy/open-source-misses-the-point.en.html)
why you should call it *free software* or *libre software*. Free software
matters. [Right to Repair](https://vid.puffyan.us/watch?v=Npd_xDuNi9k) matters.

Libreboot uses [coreboot](https://www.coreboot.org/) for
[hardware initialization](https://doc.coreboot.org/getting_started/architecture.html).
However, *coreboot* is notoriously difficult to configure by non-technical
users. There are many complicated steps, and coreboot only handles basic
hardware initialization before jumping to a
separate [payload](https://doc.coreboot.org/payloads.html) program, which
could be anything (e.g.
[Linux](https://www.fsfla.org/ikiwiki/selibre/linux-libre/),
[GRUB](https://www.gnu.org/software/grub/),
[SeaBIOS](https://www.seabios.org/SeaBIOS),
[Tianocore](https://www.tianocore.org/)).

Libreboot solves this problem. It is a *coreboot distribution*,
just like [Parabola](https://www.parabola.nu/) is a *GNU+Linux distribution*.
Libreboot has an [automated build system](docs/build/) that downloads,
patches and builds software like coreboot, GRUB and SeaBIOS to build a
complete *ROM image* for firmware installation, just like a GNU+Linux
distribution provides an ISO image for OS installation. Libreboot regularly
re-bases on the latest versions of coreboot and other upstream projects.

Libreboot has advanced features like
[encrypted /boot/](docs/gnulinux/encrypted_debian.md) and [GPG support](docs/gnulinux/grub_hardening.html).
Binary blobs from coreboot are excluded, making Libreboot *100% free
software*. It is [endorsed by the Free Software
Foundation](https://www.fsf.org/blogs/licensing/replace-your-proprietary-bios-with-libreboot). Libreboot
has [helped](https://www.gnu.org/education/how-i-fought-to-graduate-without-using-non-free-software.html)
many people, [including the FSF, the GNU
project](https://www.fsf.org/bulletin/2017/fall/six-months-of-equipment-upgrades-at-the-fsf)
and [GNU project founder, Richard Stallman](https://stallman.org/stallman-computing.html).
