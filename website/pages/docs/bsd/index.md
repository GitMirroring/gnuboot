---
title: BSD operating systems
x-unreviewed: true
...

This section is largely x86-centric, pertaining to use of BSD operating systems.
Although not as popular, BSD systems are also (in most cases) *Free Software*,
but they are non-copyleft.

Libreboot is capable of booting many BSD systems. This section mostly documents
the peculiarities of Libreboot as it pertains to BSD; you can otherwise refer to
the official documentation for whatever BSD system you would like to use.

Video modes
===========

For BSD systems, it is desirable that you boot in *text mode*. ROM images
with `txtmode` in the file name, on x86 systems, boot up with int10h text mode
in use. This is the most "compatible" option, and BSD operating systems have
excellent support for text-mode startup. Many of them also support *kernel mode
setting* (KMS) nowadays, which you *need* if you want a graphical desktop on
the X window system. The reason is that Libreboot does not currently implement
int10h VGA modes on x86 systems. However, basic video initialization is
provided on all platforms (int10h text mode, or coreboot framebuffer).

Combined with the use of SeaBIOS payload, BSD systems (and any other OS that
can boot in text mode) will *just work*. If your BSD system supports kernel
mode setting, it can set up a framebuffer without making use of int10h VGA
modes. In this case, the driver (e.g. Intel video driver) will set modes
directly, and implement its own framebuffer.

Booting with a coreboot framebuffer will also work well on most BSD systems.
These ROM images have `corebootfb` in the filename, on recent Libreboot releases.
In this setup, you should make sure that your BSD system has a `corebootfb`
driver (to make use of the coreboot framebuffer), but when switching to X, your
video driver (e.g. Intel video driver) may already support kernel mode setting
which means that the coreboot framebuffer will no longer be used at that point.

Booting BSD
===========

On x86 platforms, Libreboot currently provides the choice of GNU GRUB and/or
SeaBIOS payload. You can use *either* payload, to boot BSD operating systems.

SeaBIOS payload
---------------

It is highly recommended that you use the SeaBIOS payload. ROM images are
available in the latest Libreboot release, which start with the SeaBIOS payload.

The ROM images with GNU GRUB *also* have SeaBIOS available in the boot menu.
GNU GRUB, when compiled as a coreboot payload, runs on *bare metal* and it can
boot any other coreboot payload if you use the `chainloader` command.

The way to use SeaBIOS is fairly self-explanatory. SeaBIOS functions the way
you would expect on a typical computer. Libreboot currently lacks any sort of
documentation for SeaBIOS, but you can refer to their
website: <https://seabios.org/SeaBIOS>

SeaBIOS is *especially* recommended if you're doing an encrypted installation.

The benefit to using SeaBIOS is that it's basically more reliable. For example,
ZFS support is less reliable in GRUB, but a FreeBSD system booted in SeaBIOS
would work just fine because you'd be using FreeBSD's own bootloader in that
instance.

GNU GRUB payload
----------------

GRUB can directly boot many BSD kernels, but support for this is quite unreliable
compared to its support for booting Linux kernels. However, you *can* use GRUB.

When you use GNU GRUB directly, in this way, the various BSD bootloaders are
bypassed entirely.

We have separate pages for each BSD system:

* [How to install NetBSD on x86 GNU GRUB payload](netbsd.html)
* [How to install OpenBSD on x86 GNU GRUB payload](openbsd.html)
* [How to install FreeBSD on a x86 GNU GRUB payload](freebsd.html)
