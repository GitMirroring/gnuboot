GNU Boot
========

GNU Boot is a GNU project and a
[freedom-respecting](https://www.gnu.org/philosophy/free-sw.html)
*boot firmware* that initializes the hardware (e.g.
memory controller, CPU, peripherals) in your computer so that software can run.
GNU Boot then starts a bootloader to load your operating system. It replaces the
proprietary BIOS/UEFI firmware typically found on a computer. GNU Boot is
compatible with specific computer models that use the Intel/AMD x86
architecture. GNU Boot works well with GNU+Linux and BSD
operating systems.

GNU Boot uses [coreboot](https://www.coreboot.org/) for hardware initialization.
However, *coreboot* is notoriously difficult to compile and install for most
non-technical users. There are many complicated configuration steps required,
and coreboot by itself is useless; coreboot only handles basic hardware
initialization, and then jumps to a separate *payload* program. The payload
program can be anything, for example a Linux kernel, bootloader (such as
GNU GRUB), UEFI implementation (such as Tianocore) or BIOS implementation
(such as SeaBIOS). While not quite as complicated as building a GNU+Linux
distribution from scratch, it may aswell be as far as most non-technical users
are concerned.

GNU Boot solves this problem :
GNU Boot is a *coreboot distribution* much like Debian is a *GNU+Linux
distribution*. GNU Boot provides an *automated build system* that downloads,
patches (where necessary) and compiles coreboot, GNU GRUB, various payloads and
all other software components needed to build a complete, working *ROM image*
that you can install to replace your current BIOS/UEFI firmware, much like a
GNU+Linux distribution (e.g. Debian) provides an ISO image that you can use to
replace your current operating system (e.g. Windows).


Not a coreboot fork!
--------------------

GNU Boot is not a fork of coreboot. Every so often, the project
re-bases on the latest version of coreboot, with the number of custom
patches in use minimized. Tested, *stable* (static) releases are then provided
in GNU Boot, based on specific coreboot revisions.

Coreboot is not entirely free software. It has binary blobs in it for some
platforms. What GNU Boot does is download several revisions of coreboot, for
different boards, and *de-blob* those coreboot revisions. This is done using
the *linux-libre* deblob scripts, to find binary blobs in coreboot.

All new coreboot development should be done in coreboot (upstream), not
GNU Boot ! GNU Boot is about deblobbing and packaging coreboot in a
user-friendly way, where most work is already done for the user.

For example, if you wanted to add a new board to GNU Boot, you should
add it to coreboot first. GNU Boot will automatically receive your code
at a later date, when it updates itself.

The deblobbed coreboot tree used in GNU Boot is referred to as
*coreboot-libre*, to distinguish it as a component of *GNU Boot*.


How this project came to exist
------------------------------

We believe computer users deserve to control all the software they run. This
belief is the key principle of the Free Software Movement, and was the motive
for developing the GNU operating system and starting the Free Software
Foundation. We believe computer user freedom is a crucial human rights.

Unfortunately, such a muddle happened last year with a boot program that was
free software and was called Libreboot: the development team added nonfree code
to it, but continued to refer to it misleadingly as “Libreboot”.

Libreboot was first released in 2013. It has been widely recommended in the free
software community for the last nine years. In November 2022, “Libreboot” began
to include non-libre code. We have made repeated efforts to continue
collaboration with those developers to help their version of Libreboot remain
libre, but that was not successful.

Now we’ve stepped forward to stand up for freedom, ours and that of the wider
community, by maintaining our own version – a genuinely libre boot
distribution: GNU Boot.


LICENSE FOR THIS README:
GNU Free Documentation License 1.3 as published by the Free Software Foundation,
with no invariant sections, no front cover texts and no back cover texts. If
you wish it, you may use a later version of the GNU Free Documentation License
as published by the Free Software Foundation.

Copy of the GNU Free Documentation License v1.3 here:
<https://www.gnu.org/licenses/fdl-1.3.en.html>

Info about Free Software Foundation:
<https://www.fsf.org/>
