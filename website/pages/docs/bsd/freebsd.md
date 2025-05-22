title: How to install FreeBSD on x86 GNU GRUB payload
---

This guide was written for FreeBSD at a time where Libreboot was still
fully free.

FreeBSD is not a fully free softrware operating system / distribution
and so the GNU Boot project can't force its contributors to test GNU
Boot with FreeBSD.

Because of that this page is only meant for people already Using
FreeBSD. See the [BSD index page](index.md) for more details about how
GNU Boot deals with this issue and the way forward to a better support
for BSD systems in GNU Boot.

According to the Libreboot project at the time, FreeBSD might show
graphical corruption during bootup. They also advised that you could
fix this by altering the order in which kernel modules/drivers were
loaded. First, by trying to move video to an earlier stage on the boot
process, or by trying to move it to a later stage instead. They
advised that with this, you should have been able to get a working
display.

They also told that freebsd.img was the installation image for
FreeBSD. And that you might have to adapt the filename accordingly,
for whatever FreeBSD version you used.

Prepare the USB drive (in FreeBSD)
----------------------------------

[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.html) on
the FreeBSD website shows how to create a bootable USB drive for
installing FreeBSD. Use the *dd* on that page.

Prepare the USB drive (in NetBSD)
---------------------------------

[This
page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/)
on the NetBSD website shows how to create a NetBSD bootable USB drive
from within NetBSD itself. You should use the *dd* method documented
there; you can use this with any ISO, including FreeBSD.

Prepare the USB drive (in LibertyBSD or OpenBSD)
------------------------------------------------

If you downloaded your ISO on a LibertyBSD or OpenBSD system, here is
how to create the bootable FreeBSD USB drive:

Connect the USB drive. Check dmesg:

    dmesg | tail

Check to confirm which drive it is, for example, if you think its sd3:

    disklabel sd3

Check that it wasn't automatically mounted. If it was, unmount it. For
example:

    doas umount /dev/sd3i

dmesg told you what device it is. Overwrite the drive, writing the
FreeBSD installer to it with dd. For example:

    doas dd if=freebsd.img of=/dev/rsdXc bs=1M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Prepare the USB drive (in GNU+Linux)
------------------------------------

If you downloaded your ISO on a GNU+Linux system, here is how to create
the bootable FreeBSD USB drive:

Connect the USB drive. Check dmesg:

    dmesg

Check lsblk to confirm which drive it is:

    lsblk

Check that it wasn't automatically mounted. If it was, unmount it. For
example:

    sudo umount /dev/sdX\*
    umount /dev/sdX\*

dmesg told you what device it is. Overwrite the drive, writing your
distro ISO to it with dd. For example:

    sudo dd if=freebsd.img of=/dev/sdX bs=8M; sync
    dd if=freebsd.img of=/dev/sdX bs=8M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Installing FreeBSD without full disk encryption
-----------------------------------------------

Press C in GRUB to access the command line:

    grub> kfreebsd (usb0,gpt3)/boot/kernel/kernel
    grub> set FreeBSD.vfs.mountfrom=ufs:/dev/da1p3\
    grub> boot

It will start booting into the FreeBSD installer. Follow the normal
process for installing FreeBSD.

Installing FreeBSD with full disk encryption
--------------------------------------------

TODO

Booting
-------

TODO

Configuring Grub
----------------

TODO

Troubleshooting
===============

According to the Libreboot project at a time when it was still fully
free, most of the issues occur when using coreboot's 'text mode'
instead of the coreboot framebuffer. This mode is useful for booting
payloads like memtest86+ which expect text-mode, but for FreeBSD,
accodring to Libreboot at the time, it can be problematic when they
are trying to switch to a framebuffer because it doesn't exist.

In most cases, you should use the corebootfb ROM images. There ROM images
have `corebootfb` in the file name, and they start in a high resolution frame
buffer, provided by coreboot's `libgfxinit` library.

won't boot...something about file not found
---------------------------------------------

Your device names (i.e. usb0, usb1, sd0, sd1, wd0, ahci0, hd0, etc) and
numbers may differ. Use TAB completion.
