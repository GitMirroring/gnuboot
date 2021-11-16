% New Libreboot release soon: ETA November 15th, 2021
% Leah Rowe
% 9 November 2021

**UPDATE on 16 November 2021:**

**I've received reports on IRC that SpeedStep is broken in the Libreboot 20210522 release, on some GM45 laptops; W500 and T400 have been reported.**

**Since the release I'm working on is based heavily on 20210522, I'm holding back the Libreboot release to get this fixed.**

The original article, prior to the above update, is as follows:

Rapid progress is being made on the next release of Libreboot. The overall goal
of this upcoming release is stability; development was intentionally frozen
after the Libreboot 20210522 testing release, to allow time for people to submit
lots of bug reports. Sure enough, people submitted reports.

I've been fixing bugs and polishing up what's there, ready for another release.
You can already build Libreboot from the latest Git repository, and it's known
to be stable on all currently supported laptops. Desktops still require a bit
more polishing and tweaking.

Work done so far since the 20210522 release:

* `memtest86+` included on more ROMs by default (where text mode startup is used)
* `memtest86+`: Now coreboot's own fork is used, instead of upstream. This fork
  works much more reliably on coreboot targets, when running on bare metal.
* More 16MB configs added, for more boards. This will be finished by the time
  of the next release. Already, several older laptops such as the ThinkPad X60
  or T60, have these configs in the latest `lbmk.git`. If you upgrade the
  default SPI flash to 16MByte / 128MBit (maximum size possible), you can then
  easily put an entire busybox+linux system in the flash.
* `coreboot`: Added persmule's 2016 patch to enable more SATA/eSATA ports on
  ThinkPad T400. This change benefits T400S users.
* `grub.cfg`
* `grub.cfg`: LUKS setups are now detected on mdraid setups.
* `grub.cfg`: Default timeout changed to 10 seconds, instead of 1. This benefit
  desktop users, who previously complained about not having time to respond if
  they wanted to interact with the boot menu.
* `grub.cfg`: Performance optimization when scanning for encrypted LUKS volumes.
  GRUB will stall a lot less often, and feel more responsive, when dealing with
  LUKS-encrypted setups.
* `coreboot`: cstate 3 now supported on MacBook2,1 and Macbook1,1. This results
  in lower CPU temperatures and higher battery life on idle.
* Reset bug fixed, on GM45 platforms (ThinkPad X200/T400/T500 and so on). These
  laptops did not reliably reboot, on the Libreboot 20210522 testing release.
  They now reboot reliably, with this fix. See:
  <https://notabug.org/libreboot/lbmk/issues/3>
* `lbmk`: Use `env` instead of hardcoding the bash path, in bash scripts. This
  should make the build system slightly more portable between distros.
* Turkish keyboard layout added on GRUB payloads

Further plans
-------------

The only major plans left before the actual release, are as follows:

* Add more 16MB configs
* Re-do desktop/server configs: currently, only text-mode startup is provided
  and it is assumed that SeaBIOS will be the first payload, then you can use
  onboard graphics or an add-on graphics card more easily. This is not ideal.
  The configs will be split: corebootfb and textmode startup, or "normal" where
  there is no video init from coreboot, and instead an option ROM can be loaded
  from a graphics card.
* Random documentation improvements, especially the addition of ThinkPad X301
  and G43T-AM3 documentation.

PS:

As some of you know, I run a company at <https://minifree.org/> selling laptops
with Libreboot pre-installed on them.

Although the new stable release isn't out yet, what's currently in the Libreboot
git repository is stable, as of November 3rd, 2021. Until that release comes
out, I'm giving customers a version of Libreboot build from `lbmk.git`. I will
immediately switch to the stable release when it comes out, but the only thing
that will change basically is the version number and build date printed by
the `lscoreboot` command in GRUB. I'm making no further changes to the laptops
until after the upcoming release.

Plans for after release
=======================

After the next stable release, I have the following immediate plans:

* Add a lot more boards from coreboot, because there are a lot more boards
  ready to add in Libreboot. Mostly x4x intel platforms, same as on the Gigabyte
  GA-G41M-ES2L board.
* u-root based boot experience (see below about BusyBox+Linux+Musl)

That's for 2021. The purpose of my 2021 efforts has been to reboot the Libreboot
project, adding all viable x86 targets from coreboot, and adding some nice
features. The upcoming stable release will be during November 2021, and I plan
to have the next stable release afterwards, released on 2 January 2022, but
with a possible early December or late November testing release inbetween.

The work never ends. From 2022 onwards, my focus will shift towards non-x86
targets. ARM and RISC-V are becoming increasingly more viable for the Libreboot
project these days, and I want to take advantage of that.

BusyBox+Linux+Musl
------------------

I've been studying Heads, LinuxBoot and coreboot's LinuxBoot integration.
I'm attempting to create my own busybox+linux distro, with musl libc, similar
to these projects. I want to do this so that I can provide u-root on 16MB ROM
configs in Libreboot.

Coreboot's own build system has a Makefile in it, defining how to build
LinuxBoot. LinuxBoot is another such distro.

u-root is a powerful bootloader written in Go, which runs in a minimal busybox
and linux environment. It provides many of the same features as GNU GRUB, while
also providing kexec based loading of Linux kernels. Because it's running on
a Linux kernel, that also means you get superior drivers. For example, Linux
has very mature LUKS drivers, but GRUB does not. Linux also has great netboot
features. u-root also implements a minimal UEFI environment.

More info here:

<https://github.com/u-root/u-root>

Info about LinuxBoot:

<https://www.linuxboot.org/>

In the future, I want u-root to become a standard feature in Libreboot. This
will not make it into the upcoming stable release, but I plan to put it in a
testing release afterwards.

oreboot project
---------------

Oreboot is a special fork of coreboot, re-written in Rust. Coreboot without C,
hence Oreboot. It focuses on RISC-V hardware:

<https://github.com/oreboot>

However, coreboot will still be used for most targets, including the current
x86 targets. I plan to integrate oreboot at a future date, separately, for
a few boards.
