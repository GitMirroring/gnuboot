---
title: Downloads
x-toc-enable: true
...

**The latest stable release is still Libreboot 20160907. However, rapid progress
is being made on a new testing release, which will be available soon. Check the
work being done in <https://notabug.org/osboot/osbmk/commits/libre> which is
osboot-libre (deblobbed version of osboot). I'm working on that first, and it's
nearly ready; osboot-libre will soon be forked, and a new git repository for
libreboot will be created based on it. At that point, a new beta release will
be uploaded to libreboot.org. I, Leah Rowe, am the founder and lead developer
of both osboot and libreboot. osboot-libre is a special branch of osboot, with
the same criteria as libreboot (only free software, no binary blobs), but with
one difference: after the libreboot release is out, osboot and osboot-libre will
both focus on being bleeding edge, rolling release coreboot distros (with
osboot-libre being similar to libreboot), while libreboot will focus on stable
releases. this is why i'm doing the work in osboot-libre. the upcoming libreboot
release will literally be a copy/paste of osboot-libre, renamed to libreboot**

Information about each Libreboot release can be found
at [/docs/release.md](docs/release.md)

If you're more interested in libreboot development, go to the
[libreboot development page](../git.md), which also includes links to the
Git repositories. The page on [/docs/maintain/](docs/maintain/) describes how
Libreboot is put together, and how to maintain it. If you wish to build
Libreboot from source, [read this page](docs/build/).

GPG signing key
---------------

![](https://av.libreboot.org/logo/logo_light.svg){.imgright}

Releases are signed with GPG.

    gpg --recv-keys 0x969A979505E8C5B2

Full key fingerprint: CDC9 CAE3 2CB4 B7FC 84FD  C804 969A 9795 05E8 C5B2

The GPG key can also be downloaded with this exported dump of the
pubkey: [lbkey.asc](lbkey.asc).

    sha512sum -c sha512sum.txt
    gpg --verify sha512sum.txt.sig

Git repository
--------------

Links to regular release archives are listed on this page.

However, for the absolute most bleeding edge up-to-date version of Libreboot,
there is a Git repository that you can download from. Go here:

[How to download Libreboot from Git](git.md)

HTTPS mirrors {#https}
-------------

![](https://av.libreboot.org/logo/logo.svg){.imgright}

These mirrors are recommended, since they use TLS (https://) encryption.

You can download Libreboot from these mirrors:

* <https://rsync.libreboot.org/> (Libreboot project official mirror, UK)
* <https://www.mirrorservice.org/sites/libreboot.org/release/> (University
of Kent, UK)
* <https://mirrors.mit.edu/libreboot/> (MIT university, USA)
* <https://mirror.math.princeton.edu/pub/libreboot/> (Princeton
university, USA)
* <https://mirror.splentity.com/libreboot/> (Splentity Software, USA)
* <https://mirror.sugol.org/libreboot/> (sugol.org)
(formerly nephelai.zanity.net/mirror/libreboot)
* <https://mirrors.qorg11.net/libreboot/> (qorg11.net, Spain)
* <https://elgrande74.net/libreboot/> (elgrande74.net, France)
* <https://mirror.koddos.net/libreboot/> (koddos.net, Netherlands)
* <https://mirror.swordarmor.fr/libreboot/> (swordarmor.fr, France)
* <https://mirror-hk.koddos.net/libreboot/> (koddos.net, Hong Kong)
* <https://mirror.cyberbits.eu/libreboot/> (cyberbits.eu, France)

RSYNC mirrors {#rsync}
-------------

![](https://av.libreboot.org/logo/logo_light.svg){.imgright}

Useful for mirroring Libreboot's entire set of release archives. You can put
an rsync command into crontab and pull the files into a directory on your
web server.

*It is highly recommended that you use the libreboot.org mirror*, if you wish
to host an official mirror. Otherwise, if you simply want to create your own
local mirror, you should use one of the other mirrors, which sync from
libreboot.org.

Before you create the mirror, make a directory on your web server. For 
example:

    mkdir /var/www/html/libreboot/

Now you can run rsync, for instance:

    rsync -avz --delete-after rsync://rsync.libreboot.org/mirrormirror/ /var/www/html/libreboot/

**It's extremely important to have the final forward slash (/) at the end of each path,
in the above rsync command. Otherwise, rsync will behave very strangely.**

If you wish to regularly keep your rsync mirror updated, you can add it to a
crontab. This page tells you how to use crontab:
<https://man7.org/linux/man-pages/man5/crontab.5.html>

The following rsync mirrors are available:

* <rsync://rsync.libreboot.org/mirrormirror/> (Libreboot project official mirror)
* <rsync://rsync.mirrorservice.org/libreboot.org/release/> (University of Kent,
UK)
* <rsync://mirror.math.princeton.edu/pub/libreboot/> (Princeton university, USA)
* <rsync://qorg11.net/mirrors/libreboot/> (qorg11.net, Spain)
* <rsync://ftp.linux.ro/libreboot/> (linux.ro, Romania)
* <rsync://mirror.koddos.net/libreboot/> (koddos.net, Netherlands)
* <rsync://mirror-hk.koddos.net/libreboot/> (koddos.net, Hong Kong)

Are you running a mirror? Contact the libreboot project, and the link will be
added to this page!

You can make your rsync mirror available via your web server, and also configure
your *own* mirror to be accessible via rsync. There are many resources online
that show you how to set up an rsync server.

HTTP mirrors {#http}
------------

![](https://av.libreboot.org/logo/logo.svg){.imgright}

WARNING: these mirrors are non-HTTPS which means that they are
unencrypted. Your traffic could be subject to interference by
adversaries. Make especially sure to check the GPG signatures, assuming
that you have the right key. Of course, you should do this anyway, even
if using HTTPS.

* <http://mirror.linux.ro/libreboot/> (linux.ro, Romania)
* <http://mirror.helium.in-berlin.de/libreboot/> (in-berlin.de, Germany)

FTP mirrors {#ftp}
-----------

WARNING: FTP is also unencrypted, like HTTP. The same risks are present.

* <ftp://ftp.mirrorservice.org/sites/libreboot.org/release/> (University
of Kent, UK)
* <ftp://ftp.linux.ro/libreboot/> (linux.ro, Romania)

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
