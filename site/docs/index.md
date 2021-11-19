---
title: Documentation
...

Always check [libreboot.org](https://libreboot.org/) for the latest updates to
Libreboot. News, including release announcements, can be found in
the [main news section](../news/).

[Answers to Frequently Asked Questions about Libreboot](../faq.md).

Installing libreboot
====================

-   [What systems can I use libreboot on?](hardware/)
-   [How to install libreboot](install/)

Documentation related to operating systems
============================

-   [GNU+Linux Guides](gnulinux/)
-   [How to install BSD on a libreboot system](bsd/)

Information for developers
==========================

-   [How to compile the libreboot source code](build/)
-   [Depthcharge payload](depthcharge/) (**Libreboot 20160907 only**)
-   [GRUB payload](grub/)

Other information
=================

-   [Miscellaneous](misc/)
-   [List of codenames](misc/codenames.md)

How do I know what version I'm running? {#version}
========================================

If you are at least 127 commits after release 20150518 (commit message
*build/roms/helper: add version information to CBFS*) (or you have any
*upstream* stable release of libreboot after 20150518), then you can
press C at the GRUB console, and use this command to find out what
version of libreboot you have:

    cat (cbfsdisk)/lbversion

Alternatively, you may run this command in GRUB:

    lscoreboot

If you're using SeaBIOS, information is provided there aswell.

This will also work on non-release images (the version string is
automatically generated, using `git describe --tags HEAD`), built from
the git repository. A file named `version` will also be included in the
archives that you downloaded (if you are using release archives).

If it exists, you can also extract this `lbversion` file by using the
`cbfstool` utility which libreboot includes, from a ROM image that you
either dumped or haven't flashed yet. In your distribution, run
cbfstool on your ROM image (`libreboot.rom`, in this example):

    ./cbfstool libreboot.rom extract -n lbversion -f lbversion

You will now have a file, named `lbversion`, which you can read in
whatever program it is that you use for reading/writing text files.

For git, it's easy. Just check the git log.

For releases on or below 20150518, or snapshots generated from the git
repository below 127 commits after 20150518, you can find a file named
*commitid* inside the archives. If you are using pre-built ROM images
from the libreboot project, you can press C in GRUB for access to the
terminal, and then run this command:

    lscoreboot

You may find a date in here, detailing when that ROM image was built.
For pre-built images distributed by the libreboot project, this is a
rough approximation of what version you have, because the version
numbers are dated, and the release archives are typically built on the
same day as the release; you can correlate that with the release
information in [release announcements on the news page](/news/).

For 20160818, note that the lbversion file was missing from CBFS on GRUB
images. You can still find out what libreboot version you have by
comparing checksums of image dumps (with the descriptor blanked out with
00s, and the same done to the ROMs from the release archive, if you are
on a GM45 laptop).

There may also be a ChangeLog file included in your release archive, so
that you can look in there to figure out what version you have.
