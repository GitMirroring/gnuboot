---
title: Build GNU Boot binaries
...

This guide documents how to compile GNU Boot binaries from the
available source code.

Perquisites
===========

To build GNU Boot, you first need to:

* Use a compatible GNU/Linux distribution and/or install it on top of
  the distribution you use.

* Install Guix on top of the compatible GNU/Linux distribution.

* Download the GNU Boot source code.

* Optionally, also verify the provenance of the GNU Boot source code
  with Guix.

Since we're moving more and more of the website to the manual, this
has now moved to the [Building GNU Boot from source
chapter](../../manual/gnuboot.html#Building-GNU-Boot-from-source)
of the GNU Boot manual.

Once all that is done, you can then come back to this page and proceed
to the "Building GNU Boot binaries" section below.

Building GNU Boot binaries
==========================

The GNU Boot build system has some configuration options. While the
defaults are good for most users, the way it is implemented requires
you to install some depencies first:

    sudo apt install autoconf libtool make

Once this is done you need run the following command:

    ./autogen.sh

If you don't need to change the defaults, you can then run the
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

If you are running a supported distribution , you can run the
following command as it takes care of installing all the required
dependencies for you:

    sudo make install-dependencies

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

If for any reasons, the build is interrupted, you will need to delete
both the bin/ and bin-dbg/ directories if they exist, otherwise the
build system will assume that the build went fine and this might
create issues later on, especially if you want to build a release.

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
various distributions. It has mainly been tested on PureOS 10
(byzantium), Trisquel 10 (nabia) and Trisquel 11 (aramo):
    
    sudo ./build install dependencies

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
