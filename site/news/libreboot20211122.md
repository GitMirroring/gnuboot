% Libreboot 20211122 released!
% Leah Rowe
% 22 November 2021

Join us now and flash the firmware!
===================================

You'll be free!
---------------

Libreboot is free (as in freedom) boot firmware, which initializes the hardware
(e.g. memory controller, CPU, peripherals) in your computer so that software
can run. Libreboot then starts a bootloader to load your operating system. It
replaces the proprietary BIOS/UEFI firmware typically found on a computer.
Libreboot is compatible with specifical computer models that use the Intel/AMD
x86 architecture. Libreboot works well with GNU+Linux and BSD operating systems.

The last Libreboot release, version 20210522, was released on May 22nd
in 2021. *This* new release, Libreboot 20211122, is released today on November
22nd, 2021. This is yet another *testing* release, so expect there to be some
bugs. Every effort has been made to ensure reliability on all boards, however.

You can find this release in the `testing` directory on Libreboot release
mirrors. If you check in the `stable` directory, you'll still only find
the 20160907 release in there, so please ensure that you check the `testing`
directory!

This is a *bug fix* release, relative to 20210522. No new boards or major
features have been added, but several problems that existed in the previous
release have now been fixed.

Work done since the 20210522 release:
-------------------------------------

* Updated to newer coreboot, SeaBIOS and GRUB versions. The 20210522
  release was using coreboot 4.14, on most boards, from May 2021. This release
  is using a coreboot revision from November 2021.
* Tianocore dropped from the build system. It was planned that this would be
  provided in ROM images, but Tianocore is very bloated and buggy, and not
  worth maintaining. It was supported in the build system, but not actually
  enabled on any boards. Instead, a future release of Libreboot will include
  a busybox+linux payload with the u-root bootloader:
  <https://github.com/u-root/u-root>
* New upstream used for SeaBIOS: <https://review.coreboot.org/seabios>
* Dummy PIKE2008 option ROM now automatically inserted into ASUS KGPE-D16 and
  KCMA-D8 ROM images. It is literally an empty file. This disables the option
  ROM from being loaded, which is known to hang SeaBIOS on these boards.
* 16MB configs now available, for more boards. For instance, ThinkPad X60 and
  T60, ASUS KGPE-D16, etc. It's always possible to upgrade the flash, and
  information about this is provided in the documentation.
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

New release schedule under consideration
========================================

The 20210522 release happened to coincide with coreboot 4.14's release, more
or less.

This release also coincides roughly with the coreboot 4.15 release, which came
out on November 5th. See:
<https://doc.coreboot.org/releases/coreboot-4.15-relnotes.html>

Coreboot has, since the 4.15 release, decided to release every 3 months instead
of every 6. That means the coreboot 4.16 release is planned for February 2022.

I'm considering this: 2 releases every 3 months, of Libreboot. A testing release
and then a fork of that is created, to fix bugs ready for a stable release 3
months later, while simultaneously working (in the lbmk master branch) towards
another testing release. *If no stable release is available at the same time as
a testing release, then delay it if the delay will be minimal, otherwise
cancel and abandon that particular stable branch.*

So: if I do this, the next stable release of Libreboot could be in February
2022 based on bug fixes of this November 2021 release, using coreboot 4.15.
A testing release could be simultaneously made, with perhaps extra features,
and based on coreboot 4.16.

I'm considering it. In general, I do want Libreboot to be in sync with the
coreboot project, but coreboot does not guarantee stability in their releases.
Rather, releases are regarded as *milestones* for the coreboot developers to
reflect on current developments, and plan the next few months.

When Libreboot first started, coreboot did not have a fixed release scheduled.
It was purely rolling release. Coreboot however has been quite reliable with
its own release schedules in the past few years, making it viable for Libreboot
to also have a fixed schedule.
