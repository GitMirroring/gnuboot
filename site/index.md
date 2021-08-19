---
title: Libreboot project
x-toc-enable: true
...

Free your BIOS today! GNU GPL style
===================================

Libreboot is
[freedom-respecting](https://www.gnu.org/philosophy/free-sw.html)
*boot firmware* that initializes the hardware (e.g.
memory controller, CPU, peripherals) in your computer so that software can run.
Libreboot then starts a bootloader to load your operating system. It replaces the
proprietary BIOS/UEFI firmware typically found on a computer. Libreboot is
compatible with [specific computer models that use the Intel/AMD x86
architecture](docs/hardware/). Libreboot works well with GNU+Linux and BSD
operating systems. User support is available
at [\#libreboot](https://kiwiirc.com/nextclient/irc.libera.chat:6697/#libreboot)
on the *[Libera](https://libera.chat/)* IRC network.

![](https://av.libreboot.org/logo/logo.svg){.imgright}

Libreboot is a *Free Software* project, but can be considered Open Source.
[The GNU website](https://www.gnu.org/philosophy/open-source-misses-the-point.en.html)
teaches why you should call it Free Software instead; alternatively, you may
call it libre software.

Libreboot uses [coreboot](https://www.coreboot.org/) for hardware initialization.
However, *coreboot* is notoriously difficult to compile and install for most
non-technical users. There are many complicated configuration steps required,
and coreboot by itself is useless; coreboot only handles basic hardware
initialization, and then jumps to a separate *payload* program. The payload
program can be anything, for example a Linux kernel, bootloader (such as
GNU GRUB), UEFI implementation (such as Tianocore) or BIOS implementation
(such as SeaBIOS). While not quite as complicated as building a GNU+Linux
distribution from scratch, it may aswell be as far as most non-technical users
are concerned.

Libreboot solves this problem in a novel way:
Libreboot is a *coreboot distribution* much like Debian is a *GNU+Linux
distribution*. Libreboot provides an *automated build system* that downloads,
patches (where necessary) and compiles coreboot, GNU GRUB, various payloads and
all other software components needed to build a complete, working *ROM image*
that you can install to replace your current BIOS/UEFI firmware, much like a
GNU+Linux distribution (e.g. Debian) provides an ISO image that you can use to
replace your current operating system (e.g. Windows).

Information about who works on Libreboot, and who runs the project, can be
found on the [who.md](who.md) page.

Why use Libreboot?
==================

[![](https://retrofreedom.com/glugluglug/wp-content/uploads/2018/04/0001-300x225.jpg){.imgright}](https://minifree.org/glugluglug/wp-content/uploads/2018/04/0001.jpg)

[Free software](https://www.gnu.org/philosophy/free-sw.html) is important for
the same reason that education is important.
All children and adults alike should be entitled to a good education.
Knowledge begs to be free! In the context of computing, this means that the
source code should be fully available to study, and use in whatever way you
see fit. In the context of computer hardware, this means that
[Right to Repair](https://vid.puffyan.us/watch?v=Npd_xDuNi9k)
should be universal, with full access to documents such as the schematics and
boardview files.

**[The four freedoms are paramount!](https://www.gnu.org/philosophy/free-sw.html)**

You have rights. The right to privacy, freedom of thought, freedom
of speech and the right to read. In the context of computing, that means anyone
can use [free software](https://www.gnu.org/philosophy/free-sw.html). Simply
speaking, free software is software that is under the direct sovereignty of the
user and, more importantly, the collective that is the *community*. Libreboot
is dedicated to the Free Software community, with the aim of making free software
at a *low level* more accessible to non-technical people.

Many people use [proprietary](https://www.gnu.org/philosophy/proprietary.html)
boot firmware, even if they use GNU+Linux. Non-free boot firmware often
[contains](faq.md#intel) [backdoors](faq.md#amd), can be slow and have severe
bugs. Development and support can be abandoned at any time. By contrast,
Libreboot is a free software project, where anyone can contribute or inspect
its code.

Libreboot is faster, more secure and more reliable than most non-free
firmware. Libreboot provides many advanced features, like encrypted
/boot/, GPG signature checking before booting a Linux kernel and more!
Libreboot gives *you* control over *your* computing.

Project goals
-------------

[![](https://av.vimuser.org/EoSFxYyXEAAjOEz-300x400.jpeg){.imgleft}](https://av.vimuser.org/EoSFxYyXEAAjOEz.jpeg)

-   *Recommend and distribute only free software*. Coreboot
    distributes certain pieces of proprietary software which is needed
    on some systems. Examples can include things like CPU microcode
    updates, memory initialization blobs and so on. The coreboot project
    sometimes recommends adding more blobs which it does not distribute,
    such as the Video BIOS or Intel's *Management Engine*. However, a
    lot of dedicated and talented individuals in coreboot work hard to
    replace these blobs whenever possible.
-   *Support as much hardware as possible!* Libreboot supports less
    hardware than coreboot, because most systems from coreboot still
    require certain proprietary software to work properly. Libreboot is
    an attempt to support as much hardware as possible, without any
    proprietary software.
-   *Make coreboot easy to use*. Coreboot is notoriously difficult
    to install, due to an overall lack of user-focused documentation
    and support. Most people will simply give up before attempting to
    install coreboot.

Libreboot attempts to bridge this divide by providing a build system
automating much of the coreboot image creation and customization.
Secondly, the project produces documentation aimed at non-technical users.
Thirdly, the project attempts to provide excellent user support via mailing
lists and IRC.

Libreboot already comes with a payload (GRUB), flashrom and other
needed parts. Everything is fully integrated, in a way where most of
the complicated steps that are otherwise required, are instead done
for the user in advance.

You can download ROM images for your libreboot system and install
them without having to build anything from source. If, however, you are
interested in building your own image, the build system makes it relatively
easy to do so.

Not a coreboot fork!
--------------------

[![](https://av.vimuser.org/homepage.jpg){.imgright}](https://av.vimuser.org/homepage.jpg)

Libreboot is not a fork of coreboot. Every so often, the project
re-bases on the latest version of coreboot, with the number of custom
patches in use minimized. Tested, *stable* (static) releases are then provided
in Libreboot, based on specific coreboot revisions.

Coreboot is not entirely free software. It has binary blobs in it for some
platforms. What Libreboot does is download several revisions of coreboot, for
different boards, and *de-blob* those coreboot revisions. This is done using
the *linux-libre* deblob scripts, to find binary blobs in coreboot.

All new coreboot development should be done in coreboot (upstream), not
libreboot! Libreboot is about deblobbing and packaging coreboot in a
user-friendly way, where most work is already done for the user.

For example, if you wanted to add a new board to libreboot, you should
add it to coreboot first. Libreboot will automatically receive your code
at a later date, when it updates itself.

The deblobbed coreboot tree used in libreboot is referred to as
*coreboot-libre*, to distinguish it as a component of *libreboot*.
