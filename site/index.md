---
title: Libreboot project
...

Libreboot is
[freedom-respecting](https://www.gnu.org/philosophy/free-sw.html) *boot
firmware* that initializes the hardware (e.g. memory controller, CPU,
peripherals) on [specific Intel/AMD x86 computers](docs/hardware/) and starts
a bootloader for your operating system. [GNU+Linux](docs/gnulinux/)
and [BSD](docs/bsd/) are well-supported. It replaces proprietary BIOS/UEFI
firmware. Help is available
via [\#libreboot](https://web.libera.chat/#libreboot)
on [Libera](https://libera.chat/) IRC.

The latest version is [Libreboot 20210522](news/libreboot20210522.md), released
on 22 May 2021. It is a testing release.

Free your BIOS today! GNU GPL style
-----------------------------------

<div class="left">
<video controls="controls" poster="//static.fsf.org/nosvn/rms-photos/20140407-geneva-01.png" style="width:300px; padding:0; margin:0;" src="https://audio-video.gnu.org/video/TEDxGE2014_Stallman05_LQ.webm" type="video/webm">
RMS video
</video>
</div>

You have rights. The right to privacy, freedom of thought, freedom of speech
and the right to read. [Free
software](https://www.gnu.org/philosophy/free-sw.html) gives you these rights.
Your freedom matters.
[Right to repair](https://vid.puffyan.us/watch?v=Npd_xDuNi9k) matters.
Many people use [proprietary](https://www.gnu.org/proprietary/proprietary.html)
boot firmware, even if they use [GNU+Linux](https://www.gnu.org/distros/).
Non-free firmware often [contains](faq.html#intel) [backdoors](faq.html#amd),
and can be buggy. Libreboot was founded in in December 2013, with the express
purpose of making Free Software accessible for non-technical users at the
firmware level. Libreboot can be called Open Source, [but you should call it
Free
Software](https://www.gnu.org/philosophy/open-source-misses-the-point.en.html).


Libreboot uses [coreboot](https://www.coreboot.org/) for [hardware
initialization](https://doc.coreboot.org/getting_started/architecture.html).
Coreboot is notoriously difficult to install for most non-technical users; it
handles only basic initialization and jumps to a separate
[payload](https://doc.coreboot.org/payloads.html) program (e.g.
[GRUB](https://www.gnu.org/software/grub/),
[Tianocore](https://www.tianocore.org/)), which must also be configured.
*Libreboot solves this problem*; it is a *coreboot distribution* with
an [automated build system](docs/build/) that builds complete *ROM images*, for
more robust installation. Documentation is provided.

[![](https://av.vimuser.org/0001-300x225.jpg){.right}](https://av.vimuser.org/0001.jpg)

Libreboot has advanced features like
[encrypted /boot/](docs/gnulinux/encrypted_debian.md) and [GPG support](docs/gnulinux/grub_hardening.html).
Binary blobs are excluded, making Libreboot *100% free
software*, [endorsed by the Free Software
Foundation](https://www.fsf.org/blogs/licensing/replace-your-proprietary-bios-with-libreboot).
It has
[helped](https://www.gnu.org/education/how-i-fought-to-graduate-without-using-non-free-software.html)
many people, [including the FSF, GNU
project](https://www.fsf.org/bulletin/2017/fall/six-months-of-equipment-upgrades-at-the-fsf)
and [even Richard Stallman](https://stallman.org/stallman-computing.html).

How to help
-----------

Check the [tasks](tasks/) page and pick a task to work on. You can also check
bugs listed on the [bug tracker](https://notabug.org/libreboot/lbmk/issues).

If you spot a bug and have a fix, [here are instructions for how to send
patches](git.md), and you can also report it. Also, this entire website is
written in Markdown and hosted in a [separate
repository](https://notabug.org/libreboot/lbwww) where you can send patches.

Libreboot development discussion and user support are all done on the IRC
channel. More information is on the [contact page](contact.md).
