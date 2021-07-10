---
title: GNU+Linux installation guides
x-toc-enable: true
...

This page is useful for those who wish to use the GRUB GRUB payload directly.
If you're using SeaBIOS, the boot process will work similarly to traditional
BIOS systems; refer to the SeaBIOS documentation
on <https://seabios.org/SeaBIOS>

GNU+Linux is the operating system of choice, for Libreboot development. It is
highly recommended over any other operating system, precisely because it consists
of [Free Software](https://www.gnu.org/philosophy/free-sw.html) (free as in
freedom). There *are* other free operating systems, such as BSD, but most of
the software in a typical GNU+Linux system is also *copylefted*. To learn more
about the importance of copyleft, read this page on the GNU website:
<https://www.gnu.org/licenses/copyleft.html>

Useful links
============

Refer to the following pages:

* [How to Prepare and Boot a USB Installer in Libreboot Systems](grub_boot_installer.md)
* [Modifying the GRUB Configuration in Libreboot Systems](grub_cbfs.md)
* [Installing Hyperbola GNU+Linux, with Full-Disk Encryption (including /boot)](https://wiki.hyperbola.info/en:guide:encrypted_installation)
* [Installing Debian or Devuan GNU+Linux-Libre, with Full-Disk Encryption (including /boot)](encrypted_debian.md)
* [How to Harden Your GRUB Configuration, for Security](grub_hardening.md)

Guix, Parabola, Trisquel
------------------------

These guides were outdated, so they were deleted. You can find links to them
here: <https://notabug.org/libreboot/lbwww/issues/4>

The above issue page is the same as this entry on the TODO page:
[../../tasks/#move-all-distro-fdeboot-guides-to-distro-wikimanuals](../../tasks/#move-all-distro-fdeboot-guides-to-distro-wikimanuals)

The Debian guide has been retained, because it's currently up to date. The
Hyperbola guide is already on the Hyperbola website, and the above is just a
link.

In general, it is recommended that you use SeaBIOS but if you want extra security,
GRUB payload is recommended where you can then have a fully encrypted /boot
directory.

TODO: Nuke *all* distro-specific guides on libreboot.org. Instead, move these
instructions to the wiki pages of these projects, on their websites. The reasons
are explained in the above issue page.
