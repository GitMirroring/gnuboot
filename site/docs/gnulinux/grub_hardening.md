---
title: Hardening GNU GRUB
x-toc-enable: true
...

This article only applies to those people who use the GNU GRUB bootloader as
their default payload (options besides GNU GRUB are also available in
Libreboot). Whenever this article refers to GNU GRUB, or configuration files
used in GNU GRUB, it is referring exclusively to those files hosted in CBFS
(coreboot file system) in the Libreboot ROM image. In this configuration, GNU
GRUB is running on *bare metal* as a coreboot payload (instead of relying on
BIOS or UEFI services, like it does on *most* x86 based configurations).

This guide deals with various ways in which you can harden your GNU GRUB
configuration, for security purposes. These steps are optional, but *strongly*
recommended by the Libreboot project.

GNU GRUB provides *many* advanced security features, which most people don't
know about but are fully documented on the Libreboot website. Read on!

This article doesn't cover how to dump your ROM, or flash a new one. Please
read other sections in the Libreboot documentation if you don't know how to do
that. As such, this is an *expert only* guide. There is a great possibility for
bricking your system if you follow this guide incorrectly, or otherwise don't
know what you're doing.

GRUB secure boot with GPG
=========================

GNU GRUB contains code, based on [GnuPG](https://gnupg.org/), that can verify
PGP signatures on *any* type of file, on any storage medium supported by
GNU GRUB (it supports basically everything, including CBFS which is short
for coreboot file system and it is what we will focus on in this article).
We will be using this functionality to verify the signature of a Linux kernel,
at boot time. In conjunction with reproducible builds (both Libreboot and your
Linux kernel), this can greatly improve system security; Debian is an excellent
example of a GNU+Linux distribution that is fully reproducible nowadays (in
stable releases).

For your reference: a reproducible build is one where, given a precise (and
well documented) development setup, the exact same binary can be produced each
time the source code is compiled when that *very same development setup* is
replicated by another person. In other words, the file checksum (e.g.
SHA512 hash) will be exactly the same at all times. In practise, this means
that metadata such as time stamps are not included in the binary, or if they
are, they are constant (in many scenarios, it's based on the date of a Git
commit ID that the build is based on, if the software is built from a Git
repository). More information about reproducible builds can be found here:

<https://reproducible-builds.org/>

Reproducibility is a key goal of the Libreboot project, though it has not yet
achieved that goal. However, it is an important part of any secure system. We
suggest that, when securing your Libreboot system as instructed by this guide,
you should also use a reproducible GNU+Linux distribution (because checking GPG
signatures on a non-reproducible binary, such as a Linux kernel, is meaningless
if that binary can be compromised as a result of literally not being able to
verify that the source code *actually* corresponds to the provided binary,
which is exactly what reproducible builds allow). If *someone else* compiles an
executable for you, and that executable is non-reproducible, you have no way to
verify that the source code they provided *actually* corresponds to the binary
they gave you. Based on these facts, we can observe that checking GPG
signatures will improve your *operational* security, but only in specific
circumstances under *controlled conditions*.

This tutorial assumes you have a Libreboot image (ROM) that you wish to modify,
which from now on we will refer to simply as *`my.rom`*. It should go without
saying that this ROM uses the GNU GRUB bootloader as payload. This page shows
how to modify grubtest.cfg, which means that signing and password protection
will work after switching to it in the main boot menu and bricking due to
incorrect configuration will be impossible. After you are satisfied with the
new setup, you should transfer the new settings to grub.cfg to make your
machine truly secure.

First, extract the old grubtest.cfg and remove it from the Libreboot
image:

    cbfstool my.rom extract -n grubtest.cfg -f my.grubtest.cfg
    cbfstool my.rom remove -n grubtest.cfg

You can build `cbfstool` in the Libreboot build system. Run this command:

    ./build module cbutils

This assumes that you already downloaded coreboot:

    ./download coreboot

This, in turn, assumes that you have installed the build dependencies for
Libreboot. On Ubuntu 20.04 and other apt-get distros, you can do this:

    ./build dependencies trisquel-10

The `cbfstool` executables will be under each coreboot directory, under
each `coreboot/boardname/` directory for each board. Just pick one, presumably
from the coreboot directory for your board. Libreboot creates multiple coreboot
archives for different board revisions, on different boards.

References:

* [GRUB manual](https://www.gnu.org/software/grub/manual/html_node/Security.html#Security)
* [GRUB info pages](http://git.savannah.gnu.org/cgit/grub.git/tree/docs/grub.texi)
* [SATA connected storage considered dangerous.](../../faq.md#hddssd-firmware)
* [Coreboot GRUB security howto](https://www.coreboot.org/GRUB2#Security)

GRUB Password
=============

The security of this setup depends on a good GRUB password as GPG signature
checking can be disabled through the interactive console:

    set check_signatures=no

This is useful because it allows you to occasionally boot unsigned live CD/USB
media and such. You might consider supplying signatures on a USB stick, but the
signature checking code currently looks for `/path/to/filename.sig` when
verifying `/path/to/filename` and, as such, it will be impossible to supply
signatures in any other location (unless the software is modified accordingly).

It's worth noting that this is not your LUKS password but, rather, a password
that you must enter in order to use *restricted* functionality (such as the
GNU GRUB terminal for executing commands). This behaviour protects your system
from an attacker simply booting a live USB key (e.g. live GNU+Linux
distribution) for the purpose of flashing modified boot firmware, which from
your perspective is *compromised* boot firmware. *This should be different than
your LUKS passphrase and user password.*

GNU GRUB supports storing salted, hashed passwords in the configuration file.
This is a far more secure configuration, because an attacker cannot simply read
your password as *plain text* inside said file.

Use of the *diceware method* is *strongly* recommended, for generating secure
passphrases (as opposed to passwords). The diceware method involves rolling
dice to generate random numbers, which are then used as an index to pick a
random word from a large dictionary of words. You can use any language (e.g.
English, German). Look it up on a search engine. Diceware method is a way to
generate secure passphrases that are very hard (almost impossible, with enough
words) to crack, while being easy enough to remember. On the other hand, most
kinds of secure passwords are hard to remember and easier to crack. Diceware
passphrases are harder to crack because of far higher entropy (there are many
words available to use, but only about 50 commonly used symbols in
pass*words*). This high level of entropy is precisely what makes such pass
phrases secure, even if an attacker knows exactly which dictionary you used!

The GRUB password can be stored in one of two ways:

* plaintext
* protected with [PBKDF2](https://en.wikipedia.org/wiki/Pbkdf2)

We will *obviously* use the latter method. Generating the PBKDF2 derived key is
done using the `grub-mkpasswd-pbkdf2` utility. You can get it by
installing GRUB version 2. Generate a key by giving it a password:

NOTE: This utility is included under the `grub/` directory, when you build
GRUB using the Libreboot build system. Run the following commands (assuming
you have the correct build dependencies installed) to build GNU GRUB, from the
Libreboot Git repository:

    ./download grub

    ./build module grub

The following executable will then be available under the `grub/` directory:

    grub-mkpasswd-pbkdf2

Its output will be a string of the following form:

    grub.pbkdf2.sha512.10000.HEXDIGITS.MOREHEXDIGITS

Now open my.grubtest.cfg and put the following before the menu entries
(prefered above the functions and after other directives). Of course use
the pbdkf string that you had generated yourself:

    set superusers="root"
    password_pbkdf2 root grub.pbkdf2.sha512.10000.711F186347156BC105CD83A2ED7AF1EB971AA2B1EB2640172F34B0DEFFC97E654AF48E5F0C3B7622502B76458DA494270CC0EA6504411D676E6752FD1651E749.8DD11178EB8D1F633308FD8FCC64D0B243F949B9B99CCEADE2ECA11657A757D22025986B0FA116F1D5191E0A22677674C994EDBFADE62240E9D161688266A711

Obviously, replace it with the correct hash that you actually obtained for the
password you entered. In other words, *do not use the hash that you see above!*

With this configuration in place, you must now enter the passphrase *every
single time you boot your computer*. This completely restricts an attacker in
such a way that they cannot simply boot an arbitrary operating system on your
computer. NOTE: An attacker could still open your system and re-flash new
firmware externally. You should implement some detection mechanism, such as
epoxy applied in a *random pattern* on every screw; this slows down the attack
and means that you will know someone tampered with it because they cannot
easily re-produce the exact same blob of epoxy in the same pattern (when you
apply it, swirl it around a bit for a few minutes while it cures. The purpose
is not to prevent disassembly, but to slow it down and make it detectable when
it has occured).

Another good thing to do, if we chose to load signed on-disk GRUB
configurations, is to remove (or comment out) `unset superusers` in
function try\_user\_config:

    function try_user_config {
       set root="${1}"
       for dir in boot grub grub2 boot/grub boot/grub2; do
          for name in '' autoboot_ libreboot_ coreboot_; do
             if [ -f /"${dir}"/"${name}"grub.cfg ]; then
                #unset superusers
                configfile /"${dir}"/"${name}"grub.cfg
             fi
          done
       done
    }

The `unset superusers` command disables password authentication, which will
allow the attacker to boot an arbitrary operating system, regardless of
signature checking. The default Libreboot configuration is tweaked for *easy of
use* by end users, and it is *not* done with security in mind (though security
is preferred). Thus, Libreboot is less restrictive by default. What you are
doing, per this article, is making your system *more secure* but at the expense
of user-friendliness.

That just about covers it, where password setup is concerned!

GPG keys
========

First, generate a GPG keypair to use for signing. Option RSA (sign only)
is ok.

WARNING: GRUB does not read ASCII armored keys. When attempting to
trust ... a key filename it will print `error: bad signature` on the screen.

    mkdir --mode 0700 keys
    gpg --homedir keys --gen-key
    gpg --homedir keys --export-secret-keys --armor > boot.secret.key # backup
    gpg --homedir keys --export > boot.key

Now that we have a key, we can sign some files with it. We must sign:

-   a kernel
-   (if we have one) an initramfs
-   (if we wish to transfer control to it) an on-disk `grub.cfg`
-   `grubtest.cfg` (so that you can go back to `grubtest.cfg` after signature
    checking is enforced. You can always get back to `grub.cfg` by pressing ESC,
    but, afterwards, `grubtest.cfg` is not signed and it will not load.

Suppose that we have a pair of `my.kernel` and `my.initramfs` and an
on-disk `libreboot_grub.cfg`. We will sign them by running the following
commands:

    gpg --homedir keys --detach-sign my.initramfs
    gpg --homedir keys --detach-sign my.kernel
    gpg --homedir keys --detach-sign libreboot_grub.cfg
    gpg --homedir keys --detach-sign my.grubtest.cfg

Of course, some further modifications to my.grubtest.cfg will be required. We
need to *trust* the key and enable signature enforcement (put this before menu
entries):

    trust (cbfsdisk)/boot.key
    set check_signatures=enforce

What remains now is to include the modifications into the Libreboot image
(ROM):

    cbfstool my.rom add -n boot.key -f boot.key -t raw
    cbfstool my.rom add -n grubtest.cfg -f my.grubtest.cfg -t raw
    cbfstool my.rom add -n grubtest.cfg.sig -f my.grubtest.cfg.sig -t raw

Now, flash it. If it works, copy it over to `grub.cfg` in CBFS.
