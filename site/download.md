---
title: Downloads
x-toc-enable: true
...

New releases are announced in the [main news section](news/).

If you're more interested in libreboot development, go to the
[libreboot development page](../git.md), which also includes links to the
Git repositories. The page on [/docs/maintain/](docs/maintain/) describes how
Libreboot is put together, and how to maintain it. If you wish to build
Libreboot from source, [read this page](docs/build/).

GPG signing key
---------------

**The latest release is Libreboot 20211122, under the `testing` directory.**

### NEW KEY

Full key fingerprint: `98CC DDF8 E560 47F4 75C0  44BD D0C6 2464 FA8B 4856`

The above key is for Libreboot 20211122, and subsequent releases.

Download the key here: [lbkey.asc](lbkey.asc)

Libreboot releases are signed using GPG.

### OLD KEY:

This key is for Libreboot 20160907 and all older releases:

Full key fingerprint: CDC9 CAE3 2CB4 B7FC 84FD  C804 969A 9795 05E8 C5B2

The GPG key can also be downloaded with this exported dump of the
pubkey: [lbkeyold.asc](lbkeyold.asc).

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

**The latest release is Libreboot 20211122, under the `testing` directory.**

These mirrors are recommended, since they use TLS (https://) encryption.

You can download Libreboot from these mirrors:

* <https://rsync.libreboot.org/> (Libreboot project official mirror, UK)
* <https://www.mirrorservice.org/sites/libreboot.org/release/> (University
of Kent, UK)
* <https://mirrors.mit.edu/libreboot/> (MIT university, USA)
* <https://mirror.math.princeton.edu/pub/libreboot/> (Princeton
university, USA)
* <https://mirror.libremind.org/libreboot/> (libremind.org, Iceland)
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

Useful for mirroring Libreboot's entire set of release archives. You can put
an rsync command into crontab and pull the files into a directory on your
web server.

If you are going to mirror the entire set, it is recommended that you allocate
at least 25GiB. Libreboot's rsync is currently about 12GiB, so allocating 25GiB
will afford you plenty of space for the future. At minimum, you should ensure
that at least 15-20GiB of space is available, for your Libreboot mirror.

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
* <rsync://rsync.libremind.org/libreboot/> (libremind.org, Iceland)
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

**The latest release is Libreboot 20211122, under the `testing` directory.**

WARNING: these mirrors are non-HTTPS which means that they are
unencrypted. Your traffic could be subject to interference by
adversaries. Make especially sure to check the GPG signatures, assuming
that you have the right key. Of course, you should do this anyway, even
if using HTTPS.

* <http://mirror.linux.ro/libreboot/> (linux.ro, Romania)
* <http://mirror.helium.in-berlin.de/libreboot/> (in-berlin.de, Germany)

FTP mirrors {#ftp}
-----------

**The latest release is Libreboot 20211122, under the `testing` directory.**

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
