---
title: Build GNU Boot binaries
x-reviewed: true
...

This guide documents how to compile GNU Boot binaries from the
available source code.

At the time of writing users wanting to build binaries need to
download the [https://git.savannah.gnu.org/cgit/gnuboot.git/ GNU Boot
source code] with git.

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

And these cannot build GNU Boot yet:

* Trisquel 11 (aramo): The issue is documented in the [Bug
  #64870](https://savannah.gnu.org/bugs/?64870).

* Guix: Guix doesn't have any ADA compiler and that is needed for
  building Coreboot for certain computers.

Git
===

GNU Boot build system still has some fragile scripts for building some
of the projects like Coreboot.

Because of that you need to configure git even if you only want to
build build a binary without modifying anything because the GNU Boot
build system uses git directly when applying patches to the software
it builds, and git expects some configuration to be present when
applying patches.

To fix that you need to set a valid username and email:
    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com

Change the name and email address to whatever you want, when doing this.

You may also want to follow more of the steps here:
<https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup>

Building GNU Boot binaries
==========================

GNU Boot includes a file called `Makefile` that you can use . This
Makefile calls some scripts like download or build that are in the
same directory, that you can also also use directly if you want.

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

When this is done you can build all the GNU Boot images with the
following command (this uses the Makefile):

    make

This single command will build ROM images for *every* computer
supported by GNU Boot. If you only wish to build a limited set, you
can use the build script directly:

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

To build release archives:

    make release

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
    
    sudo ./build dependencies trisquel-10

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

    ./download flashrom

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

    ./build module flashrom

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
[website-build/README](https://git.savannah.gnu.org/cgit/gnuboot.git/tree/website-build/README)
in the source code of GNU Boot.
