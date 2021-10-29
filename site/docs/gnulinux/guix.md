---
title: Encrypted Guix GNU+Linux
x-toc-enable: true
...

Objective
=========

To provide step-by-step guide for setting up guix system (stand-alone guix) with
full disk encryption (including /boot) on devices powered by Libreboot.

Scope
=====

Any users, for their generalised use cases, need not stumble away from this
guide to accomplish the setup.

Advanced users, for deviant use cases, will have to explore outside this guide
for customisation; although this guide provides information that is of paramount
use.

Process
=======

Preparation
-----------

In your current GNU+Linux System, open terminal as root user.

Insert USB drive and get the USB device name /dev/sdX, where “X” is the variable
to make a note of.

    lsblk

Unmount the USB drive just in case if it’s auto-mounted.

    umount /dev/sdX

Download the latest (a.b.c) Guix System ISO Installer Package (sss) and it’s GPG
Signature; where “a.b.c” is the variable for version number and “sss” is the
variable for system architecture.

    wget https://ftp.gnu.org/gnu/guix/guix-system-install-a.b.c.sss-linux.iso.xz

    wget https://ftp.gnu.org/gnu/guix/guix-system-install-a.b.c.sss-linux.iso.xz.sig

Import required public key.

    gpg --keyserver pool.sks-keyservers.net --recv-keys 3CE464558A84FDC69DB40CFB090B11993D9AEBB5

Verify the GPG Signature of the downloaded package.

    gpg --verify guix-system-install-a.b.c.sss-linux.iso.xz.sig

Extract the ISO Image from the downloaded package.

    xz --decompress guix-system-install-a.b.c.sss-linux.iso.xz

Write the extracted ISO Image to the USB drive.

    dd if=guix-system-install-a.b.c.sss-linux.iso of=/dev/sdX; sync

Reboot the device.

    reboot

Pre-Installation
----------------

On reboot, as soon as you see the Libreboot Graphic Art, press arrow keys to
change the menu entry.

Choose “Search for GRUB2 configuration on external media [s]” and wait for the
Guix System from USB drive to load.

Set your keyboard layout lo, where “lo” is the two-letter keyboard layout code
(example: us or uk).

    loadkeys lo

Unblock network interfaces (if any).

    rfkill unblock all

Get the names of your network interfaces.

    ifconfig -a

Bring your required network interface nwif (wired or wireless) up, where “nwif”
is the variable for interface name. For wired connections, this should be
enough.

    ifconfig nwif up

For wireless connection, create a configuration file using text editor, where
“fname” is the variable for any desired filename.

    nano fname.conf

Choose, type and save ONE of the following snippets, where ‘nm’ is the name of
the network you want to connect, ‘pw’ is the corresponding network’s password or
passphrase and ‘un’ is user identity.

For most private networks:

    network={
      ssid="nm"
      key_mgmt=WPA-PSK
      psk="pw"
    }

(or)

For most public networks:

    network={
      ssid="nm"
      key_mgmt=NONE
    }


(or)

For most organisational networks:

    network={
      ssid="nm"
      scan_ssid=1
      key_mgmt=WPA-EAP
      identity="un"
      password="pw"
      eap=PEAP
      phase1="peaplabel=0"
      phase2="auth=MSCHAPV2"
    }


Connect to the configured network, where “fname” is the filename and “nwif” is
the network interface name.

    wpa_supplicant -c fname.conf -i nwif -B

Assign an IP address to your network interface, where “nwif” is the network
interface name.

    dhclient -v nwif

If your Guix installation image doesn't have support for LVM, do the following.

    guix pull --branch=master && guix install lvm2

Obtain the device name /dev/sdX in which you would like to deploy and install
Guix System, where “X” is the variable to make a note of.

    lsblk

Wipe the respective device. Wait for the command operation to finish.

    shred --random-source=/dev/urandom /dev/sdX

Load device-mapper module in the current kernel.

    modprobe dm_mod

Partition the respective device. Just do, GPT --> New --> Write --> Quit;
defaults will be set.

    cfdisk /dev/sdX

Encrypt the respective partition.

    cryptsetup --verbose --hash whirlpool --cipher serpent-xts-plain64 --verify-passphrase --use-random --key-size 512 --iter-time 500 luksFormat /dev/sdX1

Obtain and note down the “LUKS UUID”.

    cryptsetup luksUUID /dev/sdX1

Open the respective encrypted partition and map it as 'fde'.

    cryptsetup luksOpen /dev/sdX1 fde

Create a physical volume in the partition.

    pvcreate /dev/mapper/fde

Create a volume group in the physical volume, named 'matrix'.

    vgcreate matrix /dev/mapper/fde

Create a logical volume of 2GiB for swap, named 'swapvol'.

    lvcreate --size 2G matrix --name swapvol

Create a logical volume of rest of free-space for root, named 'rootvol'.

    lvcreate --extents 100%FREE matrix --name rootvol

Create swap space in the logical volume 'swapvol', labeled 'swap'.

    mkswap --label swap /dev/matrix/swapvol

Create filesystem in the logical volume 'rootvol', labeled 'root'.

    mkfs.btrfs --metadata dup --label root /dev/matrix/rootvol

Mount the root filesystem under the current system.

    mount --label root --target /mnt --types btrfs

Installation
------------

Make the installation packages to be written on the respective mounted
filesystem.

    herd start cow-store /mnt

Create the required directory.

    mkdir /mnt/etc

Create, edit and save the configuration file by typing the following code
snippet. WATCH-OUT for variables in the code snippet and replace them with your
relevant values.

    nano /mnt/etc/config.scm

Snippet:

	(use-modules
	 (gnu)
	 (gnu system nss))
	(use-package-modules
	 certs
	 gnome
	 linux)
	(use-service-modules
	 desktop
	 xorg)
	(operating-system
	  (kernel linux-libre-lts)
	  (bootloader
	   (bootloader-configuration
	    (bootloader
	     (bootloader
	      (inherit grub-bootloader)
	      (installer #~(const #t))))
	    (keyboard-layout keyboard-layout)))
	  (keyboard-layout
	   (keyboard-layout
	    "xy"
	    "altgr-intl"))
	  (host-name "hostname")
	  (mapped-devices
	   (list
	    (mapped-device
	     (source
	      (uuid "luks-uuid"))
	     (target "fde")
	     (type luks-device-mapping))
	    (mapped-device
	     (source "matrix")
	     (targets
	      (list
	       "matrix-rootvol"
	       "matrix-swapvol"))
	     (type lvm-device-mapping))))
	  (file-systems
	   (append
	    (list
	     (file-system
	       (type "btrfs")
	       (mount-point "/")
	       (device (file-system-label "root"))
	       (flags '(no-atime))
	       (options "space_cache=v2")
	       (needed-for-boot? #t)
	       (dependencies mapped-devices)))
	    %base-file-systems))
	  (swap-devices
	   (list
	    (file-system-label "swap")))
	  (users
	   (append
	    (list
	     (user-account
	      (name "username")
	      (comment "Full Name")
	      (group "users")
	      (supplementary-groups '("audio" "cdrom" "kvm" "lp" "netdev" "tape" "video" "wheel"))))
	    %base-user-accounts))
	  (packages
	   (append
	    (list
	     nss-certs)
	    %base-packages))
	  (timezone "Zone/SubZone")
	  (locale "ab_XY.1234")
	  (name-service-switch %mdns-host-lookup-nss)
	  (services
	   (append
	    (list
	     (service gnome-desktop-service-type))
	    %desktop-services)))

Initialise new Guix System.

    guix system init /mnt/etc/config.scm /mnt

Reboot the device.

    reboot

Post-Installation
------------

On reboot, as soon as you see the Libreboot Graphic Art, choose the option
'Load Operating System [o]'

Enter LUKS Key, for Libreboot's grub, as prompted.

You may have to go through warning prompts by repeatedly pressing the
"enter/return" key.

You will now see guix's grub menu from which you can go with the default option.

Enter LUKS Key again, for kernel, as prompted.

Upon login screen, login as "root" with password field empty.

Open terminal from the GNOME Dash.

Set passkey for "root" user. Follow the prompts.

    passwd root

Set passkey for "username" user. Follow the prompts.

    passwd username

Update the guix distribution. Wait for the process to finish.

    guix pull

Update the guix system. Wait for the process to finish.

    guix system reconfigure /etc/config.scm

Reboot the device.

    reboot

Conclusion
==========

Everything should be stream-lined from now. You can follow your regular boot
steps without requiring manual intervention. You can start logging in as regular
user with the respective "username".

You will have to periodically (at your convenient time) login as root and do the
update/upgrade part of post-installation section, to keep your guix distribution
and guix system updated.

That is it! You have now setup guix system with full-disk encryption on your
device powered by Libreboot. Enjoy!

References
==========

[1] Guix Manual (http://guix.gnu.org/manual/en/).

Acknowledgements
================

[1] Thanks to Guix Developer, Clement Lassieur (clement@lassieur.org),
for helping me with the Guile Scheme Code for the Bootloader Configuration.
