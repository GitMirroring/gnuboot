---
title: Gigabyte GA-G41M-ES2L desktop board 
...

This is a desktop board using intel hardware (circa \~2009, ICH7
southbridge, similar performance-wise to the Libreboot X200. It can make
for quite a nifty desktop. Powered by libreboot.

IDE on the board is untested, but it might be possible to use a SATA HDD
using an IDE SATA adapter. The SATA ports do work.

You need to set a custom MAC address in GNU+Linux for the NIC to work.
In /etc/network/interfaces on debian-based systems like Debian or
Devuan, this would be in the entry for your NIC:\
hwaddress ether macaddressgoeshere

Alternatively:

    cbfstool libreboot.rom extract -n rt8168-macaddress -f rt8168-macaddress

Modify the MAC address in the file `rt8168-macaddress` and then:

    cbfstool libreboot.rom remove -n rt8168-macaddress
    cbfstool libreboot.rom add -f rt8168-macaddress -n rt8168-macaddress -t raw

Now you have a different MAC address hardcoded. In the above example, the ROM
image is named `libreboot.rom` for your board. You can find cbfstool
under `coreboot/default/util/cbfstool/` after running the following command
in the build system:

    ./build module cbutils

You can learn more about using the build system, lbmk, here:\
[Libreboot build instructions](../build/)

Flashing instructions can be found at
[../install/](../install/)

RAM
---

Kingston 8 GiB Kit  KVR800D2N6/8G with Elpida Chips E2108ABSE-8G-E

this is a 2x4GB setup and these work quite well, according to a user on IRC.

Many other modules will probably work just fine, but raminit is very picky on
this board.
