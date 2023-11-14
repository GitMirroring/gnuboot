GNU Boot
========

This software is part of the GNU Project.

To load an operating system, computers need to be able to access storage
devices (like an HDD or SSD) where the operating system is installed.
They need RAM to work to load part of the operating system in RAM. Users
also expect the display and keyboard to work before the operating system
is loaded.

But on most computers, software is needed to initialize the RAM, the storage
devices, the graphic card, to load the operating system, and give some
information to the operating system on what hardware it is running on.

Because of that computers usually require boot software that is bundled in the
computer. It is usually found on a very small storage chip that is inside the
mainboard. That software is specific to a given computer.

Unfortunately that software is usually nonfree and GNU boot aims to replace
that with 100% free software.

Like with other type of software, the fact that is nonfree has real impacts.
For instance this software often continues to run once the operating system
is loaded and as it loads the operating system it can also modify it.
So having a nonfree boot software make it impossible for users to really
trust their computers. Another common issue is that some BIOS/UEFI add
restrictions to prevent users from replacing the WiFi card for instance.
There are many more issues but listing them all here would make this
description too long.

To replace nonfree boot software, GNU boot reuses various software projects
(like Coreboot, U-boot, GRUB, SeaBIOS, etc), configure and build them to
produce an image that can be installed to replace the nonfree boot software
for specific computers.

Users can also do all that without GNU Boot but that tend to be complicated.
Having a free software project that does all that enable people to collaborate
on making sure that computers boot fine regardless of the upstream project
status, for instance by making binary releases and collaborating to test them.

In addition GNU boot also comes with extensive documentation to make it as easy
as possible to install GNU Boot and to empower users to modify the way their
computer boot.

Since not all the project it reuses are 100% free software it also removes all
the nonfree software found in them along the way and will also make the scripts
and/or data that does that reusable for distributions or users that want to
build their own free boot software without reusing the GNU Boot configuration
or build system.

Not a coreboot fork!
--------------------

GNU Boot is not a fork of coreboot, but more a boot firmware distribution
including a modified version of coreboot, and other software like SeaBIOS,
GRUB or u-boot.

Coreboot is not entirely free software as it includes binary blobs in it for
some platforms. What GNU Boot does is download several revisions of coreboot,
for different boards, and *de-blob* those coreboot revisions. This is done
using the *linux-libre* deblob scripts, to find binary blobs in coreboot.

All new coreboot development should be done in coreboot (upstream), not
GNU Boot. For example, if you wanted to add a new board to GNU Boot, you
should add it to coreboot first. GNU Boot would then receive your code at
a later date, when it updates itself.

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
