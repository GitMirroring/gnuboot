---
title: How to install OpenBSD on x86 GNU GRUB payload
x-toc-enable: true
...

This guide is written for OpenBSD 6.1, but it can be adapted easily for other
versions (of OpenBSD).

If you want an encrypted install, use SeaBIOS instead of GRUB and go here:
<https://www.openbsd.org/faq/faq4.html> (official installation guide, which
says how to use encryption)

GRUB supports booting OpenBSD kernels directly. However, you're better off
simply using the SeaBIOS payload; BSD works well with BIOS or UEFI setups.

GRUB is acceptable for booting unencrypted BSD installations. However,
encrypted BSD installations will probably require the use of SeaBIOS/Tianocore.

install61.fs is the installation image for OpenBSD 6.1. Adapt the
filename accordingly, for a different OpenBSD version or LibertyBSD.

Prepare the USB drive (in LibertyBSD or OpenBSD)
------------------------------------------------

If you downloaded your ISO on a LibertyBSD or OpenBSD system, here is
how to create the bootable LibertyBSD/OpenBSD USB drive:

Connect the USB drive and check the system message buffer:

    dmesg | tail

Check to confirm which drive it is, for example, if you think it's `sd3`:

    disklabel sd3

Check that it wasn't automatically mounted. If it was, unmount it:

    doas umount /dev/sd3i

Now write the OpenBSD installer to the drive with `dd`:

    doas dd if=install60.fs of=/dev/rsdXc bs=1M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Prepare the USB drive (in NetBSD)
---------------------------------

[This
page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/)
on the NetBSD website shows how to create a NetBSD bootable USB drive
from within NetBSD itself. You should use the `dd` method documented
there. This will also work with the OpenBSD image.

Prepare the USB drive (in FreeBSD)
----------------------------------

[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.md) on
the FreeBSD website shows how to create a bootable USB drive for
installing FreeBSD. Use the `dd` on that page. You can also use the same
instructions with a OpenBSD ISO image.

Prepare the USB drive (in GNU+Linux)
------------------------------------

If you downloaded your ISO on a GNU+Linux system, here is how to create
the bootable OpenBSD USB drive:

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

    sudo dd if=install61.fs of=/dev/sdX bs=8M; sync
    dd if=install61.fs of=/dev/sdX bs=8M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Installing OpenBSD without full disk encryption
-----------------------------------------------

Press C in GRUB to access the command line:

    grub> kopenbsd (usb0,openbsd1)/6.1/amd64/bsd.rd
    grub> boot

It will start booting into the OpenBSD installer. Follow the normal
process for installing OpenBSD.

Installing OpenBSD with full disk encryption
--------------------------------------------

If you are using SeaBIOS, OpenBSD's bootloader will be
chainloaded automatically and everything will just work.

Alternatively, it would be good to port OpenBSD either natively as a
coreboot payload, or port it to libpayload (payload library in coreboot;
it has a basic C library and a few functions for certain operations e.g.
text/bitmap).

Booting
-------

Press C in GRUB to access the command line:

    grub> kopenbsd -r sd0a (ahci0,openbsd1)/bsd
    grub> boot

OpenBSD will start booting. Yay!

Configuring Grub
----------------

If you don't want to drop to the GRUB command line and type in a
command to boot OpenBSD every time, you can create a GRUB configuration
that's aware of your OpenBSD installation and that will automatically
be used by Libreboot.

On your OpenBSD root partition, create the `/grub` directory and add the file
`libreboot_grub.cfg` to it. Inside the `libreboot_grub.cfg` add these lines:

    default=0
    timeout=3

    menuentry "OpenBSD" {
        kopenbsd -r sd0a (ahci0,openbsd1)/bsd
    }

If your OpenBSD installation uses a GPT scheme, use the `gpt4` partition
instead of `openbsd1`.

The next time you boot, you'll see the old Grub menu for a few seconds,
then you'll see the a new menu with only OpenBSD on the list. After 3
seconds OpenBSD will boot, or you can hit enter to boot.

Troubleshooting
===============

Most of these issues occur when using Libreboot with coreboot's 'text
mode' instead of the coreboot framebuffer. This mode is useful for
booting payloads like memtest86+ which expect text-mode, but for OpenBSD
it can be problematic when they are trying to switch to a framebuffer
because it doesn't exist.

Won't boot...something about file not found
---------------------------------------------

Your device names (i.e. usb0, usb1, sd0, sd1, wd0, ahci0, hd0, etc) and
numbers may differ. Use TAB completion.
