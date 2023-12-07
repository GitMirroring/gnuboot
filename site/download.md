---
title: Downloads
x-toc-enable: true
...

New releases are announced in the [main news section](news/).

If you're more interested in GNU Boot development, go to the
[GNU Boot development page](../git.md), which also includes links to the
Git repositories. If you wish to build GNU Boot from source,
[read this page](docs/build/).

GPG signing key
---------------

**A release is currently work-in-progress**

### Maintainers keys

Adrien 'neox' Bourmault <neox@gnu.org>

    key fingerprint: `9AA8 CDA0 DC9C 0604 D26A    E4A7 2974 E1D5 F25D FCC8`

Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>

    key fingerprint: `FB31 DBA3 AB8D B76A 4157    329F 7651 568F 8037 4459`


Git repository
--------------

Links to regular release archives are listed on this page.

However, for the absolute most bleeding edge up-to-date version of GNU Boot,
there is a Git repository that you can download from. Go here:

[How to download GNU Boot from Git](git.md)

FTP mirrors {#ftp}
-------------

These mirrors are recommended, since they use TLS (https://) encryption.

You can download GNU Boot from these mirrors:

* <https://ftp.gnu.org/gnu/gnuboot/> (GNU Boot project official server)

Statically linked
------------------

Libreboot includes statically linked executables in some releases, built from
the available source code. Those executables have certain libraries built into
them, so that the executables will work on many GNU+Linux distros.

Libreboot 20160907 was built in Trisquel GNU+Linux, version 7.0 64-bit.
Some older Libreboot releases will have been built in Trisquel 6.0.1.

To comply with GNU GPL v2, Trisquel 6 and 7 source ISOs are supplied by the
Libreboot project. You can find these source ISOs in the `ccsource` directory
on the `rsync` mirrors.

Libreboot releases past version 20160907 do not distribute statically linked
binaries. Instead, these releases are source-only, besides pre-compiled ROM
images for which the regular Libreboot source code archives suffice. These newer
releases instead automate the installation of build dependencies, with instructions
in the documentation for building various utilities from source.

These executables are utilities such as `flashrom`.
