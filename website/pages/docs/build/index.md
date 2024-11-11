---
title: Build GNU Boot binaries
...

This guide documents how to compile GNU Boot binaries from the
available source code.

At the time of writing users wanting to build binaries need to
download the [GNU Boot source
code](https://git.savannah.gnu.org/cgit/gnuboot.git/) with git.

Supported distributions for building GNU Boot binaries:
=======================================================

GNU Boot is currently based on the latest version of Libreboot that
doesn't ship nonfree software, and it also uses an older version of
Coreboot to support certain computers that are not supported anymore
in Coreboot. Because of that the versions of various software that GNU
Boot builds are old and cannot be built anymore on recent
distributions.

While there is work to fix that by both updating that software to more
recent versions and to also also allow to build older versions on
newer distributions, in the meantime we need to workaround this issue
by using specific distributions to build GNU Boot.

People managed to build GNU Boot with the following distributions:

* PureOS 10 (byzantium)

* Trisquel 10 (nabia)

* Trisquel 11 (aramo)

And these cannot build GNU Boot yet:

* Guix: The issue is documented in the [Bug
 #66188](https://savannah.gnu.org/bugs/index.php?66188)

If you don't use PureOS 10 (byzantium) or Trisquel 10 (nabia), there
are many ways to run them on top of other GNU/Linux distributions.

If you run Guix (either as an operating system or on top of another
distribution), Parabola, Trisquel 10 (nabia), Trisquel 11 (aramo), you
can use debootstrap to create a chroot of Trisquel 10 (nabia) or
PureOS 10 (byzantium). Here are the packages you need to install
depending on your distribution:

+----------------+-----------------------+-------------------------------------+
| Host distro    | Chroot distro         | Required packages                   |
+----------------+-----------------------+-------------------------------------+
| Guix           | PureOS 10 (byzantium) | debootstrap                         |
+----------------+-----------------------+-------------------------------------+
| Guix           | Trisquel 10 (nabia)   | debootstrap                         |
+----------------+-----------------------+-------------------------------------+
| Parabola       | PureOS 10 (byzantium) | debootstrap, pureos-archive-keyring |
+----------------+-----------------------+-------------------------------------+
| Parabola       | Trisquel 10 (nabia)   | debootstrap, trisquel-keyring       |
+----------------+-----------------------+-------------------------------------+
| Trisquel >= 10 | Trisquel 10 (nabia)   | debootstrap, trisquel-keyring       |
+----------------+-----------------------+-------------------------------------+

Once you have a chroot, you can either configure it and chroot inside
or convert it to run inside container engines like LXC, LXD, Docker
(with debuerreotype if your distribution has a package for it), etc.

It is also possible to install Trisquel 10 (nabia) or PureOS in a
virtual machine. Note that PureOS doesn't sign its releases so we
copied the official PureOS checksums found in several subdirectories
in https://downloads.puri.sm/byzantium in
resources/distros/pureos/20230614/ in the GNU Boot repository. The
commits of GNU Boot are usually signed by its maintainers, so it's
also possible to have a full chain of trust.

PureOS also has docker images on Docker Hub, and it also [has one for
PureOS byzantium](https://hub.docker.com/r/pureos/byzantium). On
Docker Hub, The PureOS images made by Puri.sm are the only images that
follow the [Free Distro
Guidelines](https://www.gnu.org/distros/). Also note that it is not
possible to easily check the integrity of images coming from docker
hub so by using them you blindly trust Docker Hub. The only way to
check the images is to create your own image and compare it with the
one hosted on docker hub.

Guix
====
While GNU Boot doesn't build yet on top of Guix, it started using some
Guix packages to build part of GNU Boot. While this provides many
benefits, you will need to install Guix on top of a supported
distribution to build GNU Boot binaries.

There are many ways to install Guix, and they are well documented in
the [Guix manual](https://guix.gnu.org/en/manual/) especially in the
[Installation](https://guix.gnu.org/en/manual/en/html_node/Installation.html)
chapter.

It is also a good idea to "enable substitutes" not to have to build
every packages and dependencies from source. If the installation
instructions you followed don't mention that, you can still find
documentation on it in the [Substitutes
chapter](https://guix.gnu.org/en/manual/en/guix.html#Substitutes) in
the Guix manual.

Once Guix is installed, users are advised to update it with guix pull
as explained in the [Invoking guix
pull](https://guix.gnu.org/en/manual/en/html_node/Invoking-guix-pull.html)
manual section to avoid any potential security issues.

In some cases (especially if you don't enable substitutes, and that
you have many CPU cores and not enough RAM per cores), building with
Guix can fail.

At the time of writing, Guix can use about 2GiB per core for
updates. Building packages can also use some RAM but the types of
packages that GNU Boot will build are unlikely to require that much
RAM per core.

If even with substitutes enabled the build still fails due to the lack
of RAM, or if you don't want to enable substitutes, it is also
possible to limit the amount of RAM used by limiting the number of
cores used by Guix by passing --with-guix-build-cores=1 to the GNU
boot ./configure script. This will pass the '-c 1' and '-M 1' options
to guix build.

Finally Guix keeps the files it downloads or builds (in /gnu/store) in
order to speed up things, but if you use Guix extensively, at some
point it might use too much storage space.

Guix users are able to to decide when to free up space by running the
'guix gc' command manually, but they can also control what to remove
with various criteria. The [Invoking guix gc Guix manual
section](https://guix.gnu.org/en/manual/devel/en/html_node/Invoking-guix-gc.html)
has more details on how to do that.

Building GNU Boot binaries
==========================

The GNU Boot build system has some configuration options. While the
defaults are good for most users, the way it is implemented requires
you to run the following command first:
    ./autogen.sh

And if you don't need to change the defaults, you can then run the
following command:
    ./configure

If you want to look at which settings can be changed you can use the
following command which explains various options and how to do that:
    ./configure --help

Once this is done, you can either use the `Makefile` or some shell
scripts to build GNU Boot.

The `Makefile` is much more simple to use but offers less flexibility
(for instance there is a single command to build all images but no way
to build an image for a specific computer).

To build GNU Boot you must first ensure that all build dependencies
are installed.

If you are running Trisquel 10 (nabia) you can run the following
command as it takes care of installing all the required dependencies
for you:

    sudo make install-dependencies-ubuntu

If instead you use PureOS 10 (byzantium) you can use the following
command instead:

    sudo make install-dependencies-pureos-10


You can then build everything with this command:

    make release

When the compilation ends this should have created images for all the
computers supported by GNU Boot in release/roms/. For instance if you
are building GNU Boot 0.1 RC1 the image for the Thinkpad X60 will be
in release/roms/gnuboot-0.1-rc1_x60.tar.xz.

It will also create an archive of all the upstream source code used to
build GNU Boot but without any nonfree software in it. For GNU Boot
0.1 RC1 the archive will be in release/gnuboot-0.1-rc1_src.tar.xz.

If you use git revisions that are not releases you might instead end
up with something like '0.2-10-g1234abcdefg' instead of '0.1-rc1'
inside the file names. For the curious, that part of the filename is
computed with the 'git describe HEAD' command.

If instead you only want to build all the images and not build an
archive of the source code you can use this command:

    make

If you only wish to build a limited set of images, you can use the
build script directly:

    ./build boot roms x200_8mb

You can specify more than one argument:

    ./build boot roms x200_8mb x60

ROM images appear under the newly created `bin/` directory in the build system.

For other commands, simply read the `Makefile` in your favourite text
editor.  The `Makefile` is simple, because each commands run a simple
script, so it's very easy to know what commands are available by
simply reading it.

Standard `clean` command available (cleans all modules except `crossgcc`):

    make clean

To clean your `crossgcc` builds:

    make crossgcc-clean


Build without using GNU Make
============================

The `Makefile` is included just for *compatibility*, so that someone who
instictively types `make` will get a result.

Actual development/testing is always done using the build, download,
update or modify scripts directly, and this includes when building
from source. Here are some instructions to get you started:

First, install build dependencies
---------------------------------

GNU Boot includes a script that automatically installs dependencies in
Trisquel 10 (nabia):
    
    sudo ./build dependencies trisquel

and for PureOS 10 (byzantium):

    sudo ./build dependencies pureos-10

The build script automatically runs all necessary commands; for example
`./build payload grub` will automatically run `./build module grub` if the
required utilities for GRUB are not built, to produce payloads.

As a result, you can now (after installing the correct build dependencies) run
just a single command, from a fresh Git clone, to build the ROM images:

    ./build boot roms

or even just build specific ROM images, e.g.:

    ./build boot roms x60

If you wish to build payloads, you can also do that. For example:

    ./build payload grub

    ./build payload seabios

Previous steps will be performed automatically. However, you can *still* run
individual parts of the build system manually, if you choose. This may be
beneficial when you're making changes, and you wish to test a specific part of
GNU Boot.

Therefore, if you only want to build ROM images, just do the above. Otherwise,
please continue reading!

Second, download all of the required software components
--------------------------------------------------------

If you didn't simply run `./build boot roms` (with or without extra
arguments), you can still perform the rest of the build process
manually.

It's as simple as that:

    ./download all

The above command downloads all modules defined in the GNU Boot build system.
However, you can download modules individually.

This command shows you the list of available modules:

    ./download list

Example of downloading an individual module:

    ./download coreboot

    ./download seabios

    ./download grub

    ./download i945-thinkpads-install-utilities

Third, build all of the modules:
--------------------------------

Building a module means that it needs to have already been downloaded.
Currently, the build system does not automatically do pre-requisite steps
such as this, so you must verify this yourself.

Again, very simple:

    ./build module all

This builds every module defined in the Libreboot build system, but you can
build modules individually.

The following command lists available modules:

    ./build module list

Example of building specific modules:

    ./build module grub

    ./build module seabios

    ./build module i945-thinkpads-install-utilities

Commands are available to *clean* a module, which basically runs make-clean.
You can list these commands:

    ./build clean list

Clean all modules like so:

    ./build clean all

Example of cleaning specific modules:

    ./build clean grub

    ./build clean cbutils

Fourth, build all of the payloads:
---------------------------------

Very straight forward:

    ./build payload all

You can list available payloads like so:

    ./build payload list

Example of building specific payloads:

    ./build payload grub

    ./build payload seabios

The build-payload command is is a prerequsite for building ROM images.

Fifth, build the ROMs!
----------------------

Run this command:

    ./build boot roms

Each board has its own configuration under `resources/coreboot/` which
specifies which payloads are supported.

By default, all ROM images are built, for all boards. If you wish to build just
a specific board, you can specify the board name based on the directory name
for it under `resources/coreboot/`. For example:

    ./build boot roms x60

Board names, like above, are the same as the directory names for each board,
under `resources/coreboot/` in the build system.

That's it!

If all went well, ROM images should be available to you under bin/

See also:
=========

If you want to contribute to the website instead, see the
[website/README](https://git.savannah.gnu.org/cgit/gnuboot.git/tree/website/README)
in the source code of GNU Boot.
