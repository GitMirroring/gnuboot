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

Fedora won't boot?
==================

This may also apply to CentOS or Redhat. Chroot guide can be found on
[fedora website](https://docs.fedoraproject.org/en-US/quick-docs/bootloading-with-grub2/#restoring-bootloader-using-live-disk)

linux16 issue
-------------

When you use Libreboot's default GRUB config, and libreboot's grub uses fedora's
default `grub.cfg` (in `/boot/grub2/grub.cfg`), fedora by default makes use of the
`linux16` command, whereas it should be saying `linux`

Do this in fedora:

Open `/etc/grub.d/10_linux`

Set the `sixteenbit` variable to an empty string, then run:

    grub2-mkconfig -o /boot/grub2/grub.cfg

BLS issue
---------

With [newer versions of fedora](https://fedoraproject.org/wiki/Changes/BootLoaderSpecByDefault),
scripts from grub package default to generating [BLS](https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/)
instead of `grub.cfg`. To change that behaviour add following line
to `/etc/default/grub` (or modify existing one if it already exists):

    GRUB_ENABLE_BLSCFG=false

Then generate `grub.cfg` with:

    grub2-mkconfig -o /boot/grub2/grub.cfg
