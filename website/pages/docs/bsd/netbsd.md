title: How to install NetBSD on x86 GNU GRUB payload
---

This guide was written for NetBSD at a time where Libreboot was still
fully free.

NetBSD is not a fully free softrware operating system / distribution
and so the GNU Boot project can't force its contributors to test GNU
Boot with NetBSD.

Because of that this page is only meant for people already Using
NetBSD. See the [BSD index page](index.html) for more details about how
GNU Boot deals with this issue and the way forward to a better support
for BSD systems in GNU Boot.

According to the Libreboot project at the time, GRUB supported booting
NetBSD kernels directly. However, they told that you were better off
simply using the SeaBIOS payload; They also told that BSD worked well
with BIOS or UEFI setups.

They also warned that while GRUB was acceptable for booting
unencrypted BSD installations, encrypted BSD installations probably
required the use of SeaBIOS/Tianocore.

In addition, GNU boot may also remove support for booting encrypted
BSD systems in the GRUB images it provides at some point, in order to
make GRUB smaller to fit computer with a very small boot flash size
(512 KiB) like the Intel D945GCLF, and unify the documentation, but
also because it can't currently test that due to the lack of fully
free BSD systems that are easily installable.

So if you already use NetBSD with encrypted partitions, and that want
to continue using it on a computer running GNU Boot, you should use
GNU Boot images with SeaBIOS.

Prepare the USB drive (in NetBSD)
---------------------------------

[This
page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/)
on the NetBSD website shows how to create a NetBSD bootable USB drive
from within NetBSD itself. You should use the *dd* method documented
there.

Prepare the USB drive (in FreeBSD)
----------------------------------

[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.html) on
the FreeBSD website shows how to create a bootable USB drive for
installing FreeBSD. Use the *dd* on that page. You can also use the same
instructions with a NetBSD ISO image.

Prepare the USB drive (in OpenBSD or NetBSD)
-----------------------------------------------

If you downloaded your ISO on a OpenBSD or NetBSD system, here is how
to create the bootable NetBSD USB drive:

Connect the USB drive. Check dmesg:

    dmesg | tail

Check to confirm which drive it is, for example, if you think its sd3:

    disklabel sd3

Check that it wasn't automatically mounted. If it was, unmount it. For
example:

    doas umount /dev/sd3i

dmesg told you what device it is. Overwrite the drive, writing the
NetBSD installer to it with dd. For example:

    doas netbsd.iso of=/dev/rsdXc bs=1M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Prepare the USB drive (in GNU+Linux)
------------------------------------

If you downloaded your ISO on a GNU+Linux system, here is how to create
the bootable NetBSD USB drive:

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

    sudo dd if=install60.fs of=/dev/sdX bs=8M; sync
    dd if=netbsd.iso of=/dev/sdX bs=8M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Installing NetBSD without full disk encryption
----------------------------------------------

You might have to use an external USB keyboard during the installation.
Press C to access the GRUB terminal.

    grub> knetbsd -r sd0a (usb0,netbsd1)/netbsd
    grub> boot

It will start booting into the NetBSD installer. Follow the normal
process for installing NetBSD.

Installing NetBSD with full disk encryption
-------------------------------------------

TODO

Booting
-------

Press C in GRUB to access the command line:

    grub> knetbsd -r wd0a (ahci0,netbsd1)/netbsd
    grub> boot

NetBSD will start booting.

Configuring Grub
----------------

If you don't want to drop to the GRUB command line and type in a
command to boot NetBSD every time, you can create a GRUB configuration
that's aware of your NetBSD installation and that will automatically be
used by GNU Boot.

On your NetBSD root partition, create the `/grub` directory and add
the file `gnuboot_grub.cfg` to it. Inside the
`gnuboot_grub.cfg` add these lines:

    default=0
    timeout=3

    menuentry "NetBSD" {
        knetbsd -r wd0a (ahci0,netbsd1)/netbsd
    }

The next time you boot, you'll see the old Grub menu for a few seconds,
then you'll see the a new menu with only NetBSD on the list. After 3
seconds NetBSD will boot, or you can hit enter to boot.

Troubleshooting
===============

According to the Libreboot project at a time when it was still fully
free, most of the issues occur when using coreboot's 'text mode'
instead of the coreboot framebuffer. This mode is useful for booting
payloads like memtest86+ which expect text-mode, but for NetBSD,
accodring to Libreboot at the time, it can be problematic when they
are trying to switch to a framebuffer because it doesn't exist.

won't boot...something about file not found
---------------------------------------------

Your device names (i.e. usb0, usb1, sd0, sd1, wd0, ahci0, hd0, etc) and
numbers may differ. Use TAB completion.
