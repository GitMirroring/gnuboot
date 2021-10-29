---
title: GNU+Linux guides
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
* [Installing Guix System, with Full-Disk Encryption (including /boot)](guix.md)
* [How to Harden Your GRUB Configuration, for Security](grub_hardening.md)

Guix, Parabola, Trisquel
========================

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

Rebooting system in case of freeze
===================================

Linux kernel has a feature to do actions to the system any time, even
with it freezes, this is called a
[Magic SysRq keys](https://en.wikipedia.org/wiki/Reisub). You can do these
actions with Alt + Sysrq + Command. These are the actions:

* Alt + SysRq + B: Reboot the system
* Alt + SysRq + I: Send SIGKILL to every process except PID 1
* Alt + SysRq + O: Shut off the system

If some of them don't work, you have to enable it in the kernel
command line paramter. So append `sysrq_always_enabled=1` to your
`GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`

You can also run `# sysctl kernel.sysrq=1` to enable them.

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
