---
title: MacBook2,1 and MacBook1,1
x-toc-enable: true
...

There is an Apple laptop called the macbook1,1 from 2006 which uses the
same i945 chipset as the ThinkPad X60/T60. A developer (Mono Moosbart) ported
the Macbook2,1 to coreboot, working alongside Vladimir Serbinenko. The ROM
images also work on the macbook1,1. Libreboot's support and documentation for
this is based on the Libreboot project, which also supports macbook2,1

Some macbook2,1 models are late 2006, others are early 2007.
You do not need to use external flashing equipment when flashing the MacBook2,1
but the MacBook1,1 requires external flashing equipment while running Apple EFI
firmware.

Macbook2,1 laptops come with Core 2 Duo processors
which support 64-bit operating systems (and 32-bit). The MacBook1,1
uses Core Duo processors (supports 32-bit OS but not 64-bit), and it is
believed that this is the only difference.

Compatibility
=============

The following pages list many models of MacBook1,1 and MacBook2,1:

* <http://www.everymac.com/ultimate-mac-lookup/?search_keywords=MacBook1,1>
* <http://www.everymac.com/ultimate-mac-lookup/?search_keywords=MacBook2,1>

Models
------

Specifically (Order No. / Model No. / CPU) for macbook 1,1:

* MA255LL/A / A1181 (EMC 2092) / Core Duo T2500 *(tested - working)*
* MA254LL/A / A1181 (EMC 2092) / Core Duo T2400 *(tested - working)*
* MA472LL/A / A1181 (EMC 2092) / Core Duo T2500 (untested)

For macbook 2,1:

* MA699LL/A / A1181 (EMC 2121) / Intel Core 2 Duo T5600 *(tested -
    working)*
* MA701LL/A / A1181 (EMC 2121) / Intel Core 2 Duo T7200 *(tested -
    working)*
* MB061LL/A / A1181 (EMC 2139) / Intel Core 2 Duo T7200 (untested)
* MA700LL/A / A1181 (EMC 2121) / Intel Core 2 Duo T7200 *(tested -
    working)*
* MB063LL/A / A1181 (EMC 2139) / Intel Core 2 Duo T7400 (works)
* MB062LL/A / A1181 (EMC 2139) / Intel Core 2 Duo T7400 *(tested -
    working)*

Internal flashing
=================

Macbook2,1 can always be flashed internally, even if running Apple firmware:

    sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force -w your.rom

Macbook1,1 same as above, but if running Apple firmware see below for
external flashing.

External flashing
=================

macbook1,1 requires external flashing, if running the default Apple firmware.
macbook2,1 can be flased internally, regardless.
If running coreboot, libreboot or Libreboot, you can already internally re-flash.

[This page shows disassembly
guides](https://www.ifixit.com/Device/MacBook_Core_2_Duo)

Locate the flash. It'll be a SOIC8, which looks like this:

![](https://av.libreboot.org/chip/soic8.jpg)

motherboard. [How to remove the
motherboard](https://www.ifixit.com/Guide/MacBook+Core+2+Duo+PRAM+Battery+Replacement/529).

Refer to the following guide:\
[Externally rewrite 25xx NOR flash via SPI protocol](../install/spi.md)

You need to replace OS X with GNU+Linux before flashing Libreboot. (OSX
won't run at all in Libreboot), if you wish to internally flash on a macbook21.
Libreboot won't boot OSX either (well, maybe with Tianocore it would, but that's
untested and OSX is inferior to GNU+Linux). In general you should think of
your Macbook like a regular laptop, for the purposes of anything coreboot.

If it's a macbook2,1 with the core2duo processors, you can run
a 64-bit distro. For macbook 1,1 the CPU probably only has 32-bit support.

GNU+Linux on Apple EFI firmware
===============================

How to boot an ISO: burn it to a CD (like you would normally) and hold
down the Alt/Control key while booting. The bootloader will detect the
GNU+Linux CD as 'Windows' (because Apple doesn't think GNU+Linux
exists). Install it like you normally would. When you boot up again,
hold Alt/Control once more. The installation (on the HDD) will once
again be seen as 'Windows'. (it's not actually Windows, but Apple
likes to think that Apple and Microsoft are all that exist.)

Coreboot wiki page
==================

The following page has some information:

* <https://www.coreboot.org/Board:apple/macbook21>

Issues and solutions/workarounds
================================

There is one mouse button only, however multiple finger tapping
works. Battery life is poor compared to X60/T60. The Apple logo on the
back is a hole, exposing the backlight, which means that it glows. You
should [cover it up](http://cweiske.de/tagebuch/tuxbook.htm).
The MacBook2,1 consumes more power with libreboot than with the Apple EFI firmware, which means it overheats a lot.

*The MacBook2,1 comes with a webcam which does not work with free
software. Webcams are a privacy and security risk; cover it up! Or
remove it.*

Make it overheat less
---------------------

The MacBook2,1 overheats a lot with libreboot, we still don't know why but a simple workaround is to install macfanctld.

Macfanctld is available on the default repos of many distributions.

For example, to install macfanctld on an Arch-based distro (Parabola, ...), you would run as root

   pacman -S macfanctld

and don't forget to enable it by using `systemctl` or by a script that will run macfanctld if using runit.

Then, you want to install powertop and tlp.
And then, run the following on battery

   sudo tlp start && sudo powertop --calibrate

Then, after quitting powertop, run :

   sudo powertop --auto-tune

Now, configure tlp, edit the `/etc/tlp.conf` and uncomment/add/modify the following:

   CPU_BOOST_ON_AC=1
   CPU_BOOST_ON_BAT=0

   SCHED_POWERSAVE_ON_AC=0
   SCHED_POWERSAVE_ON_BAT=1

   PLATFORM_PROFILE_ON_AC=performance
   PLATFORM_PROFILE_ON_BAT=low-power

The MacBook will still overheat, just less.

Vitali64 on irc is planning to make a linux kernel that would be optimized expecially for the MacBook2,1.

Enable AltGr
------------

The keyboard has a keypad enter instead of an AltGr. The first key on
the right side of the spacebar is the Apple "command" key. On its
right is the keypad enter. We can make it act as an AltGr.

If your operating system is Trisquel or other dpkg-based distribution,
there is an easy solution. Under root (or sudo) run

    dpkg-reconfigure keyboard-configuration

and select the option "apple laptop", leave other settings as their
defaults until you are given the option "Use Keypad Enter as
AltGr". Select this. The keypad enter key will then act as an AltGr
everywhere.


For Parabola or other systemd-based distributions you can enable AltGr
manually. Simply add the line

    KEYMAP_TOGGLE=lv3:enter_switch

to the file /etc/vconsole.conf and then restart the computer.

Enable 3-finger tap
-------------------

A user submitted a utility to enable 3-finger tap on this laptop. It's
available at *resources/utils/macbook21-three-finger-tap* in the
Libreboot git repository.

Make touchpad more responsive
-----------------------------

Linux kernels of version 3.15 or lower might make the touchpad
extremely sluggish. A user reported that they could get better
response from the touchpad with the following in their xorg.conf:

    Section "InputClass"
     Identifier "Synaptics Touchpad"
     Driver "synaptics"
     MatchIsTouchpad "on"
     MatchDevicePath "/dev/input/event*"
     Driver "synaptics"
    The next two values determine how much pressure one needs
    for tapping, moving the cursor and other events.
     Option "FingerLow" "10"
     Option "FingerHigh" "15"
    Do not emulate mouse buttons in the touchpad corners.
     Option "RTCornerButton" "0"
     Option "RBCornerButton" "0"
     Option "LTCornerButton" "0"
     Option "LBCornerButton" "0"
    One finger tap = left-click
     Option "TapButton1" "1"
    Two fingers tap = right-click
     Option "TapButton2" "3"
    Three fingers tap = middle-mouse
     Option "TapButton3" "2"
    Try to not count the palm of the hand landing on the touchpad
    as a tap. Not sure if helps.
     Option "PalmDetect" "1"
    The following modifies how long and how fast scrolling continues
    after lifting the finger when scrolling
     Option "CoastingSpeed" "20"
     Option "CoastingFriction" "200"
    Smaller number means that the finger has to travel less distance
    for it to count as cursor movement. Larger number prevents cursor
    shaking.
     Option "HorizHysteresis" "10"
     Option "VertHysteresis" "10"
    Prevent two-finger scrolling. Very jerky movement
     Option "HorizTwoFingerScroll" "0"
     Option "VertTwoFingerScroll" "0"
    Use edge scrolling
     Option "HorizEdgeScroll" "1"
     Option "VertEdgeScroll" "1"
    EndSection

