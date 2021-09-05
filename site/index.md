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

Libreboot uses [coreboot](https://www.coreboot.org/) for [hardware
initialization](https://doc.coreboot.org/getting_started/architecture.html).
Coreboot is difficult to configure for most non-technical users; it handles
only basic initialization and jumps to a separate
[payload](https://doc.coreboot.org/payloads.html) program (e.g.
[GRUB](https://www.gnu.org/software/grub/),
[Tianocore](https://www.tianocore.org/)), which must also be configured.
*Libreboot solves this problem*; it is a *coreboot distribution* with
an [automated build system](docs/build/) that builds complete *ROM images*, for
easy installation. User-friendly documentation is provided.

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
Libreboot can be called Open Source,
[but you should call it Free Software](https://www.gnu.org/philosophy/open-source-misses-the-point.en.html).

