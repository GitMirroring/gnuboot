title: Build GNU Boot binaries for specific computers
---

This guide documents how to compile GNU Boot binaries for a specific
computer.

The [Building GNU Boot from source
chapter](../../manual/gnuboot.html#Building-GNU-Boot-from-source) of
the GNU Boot manual instead documents how to build a GNU Boot release,
which builds binaries for all the computers supported by GNU Boot.

If you instead want to build only a specific computer instead (like
the ThinkPad X200 with 8MiB boot flash), you first need to follow the
manual to setup the build.

But instead of running the following command:

    make release

you can instead follow the "Building GNU Boot binaries" section below.

Building GNU Boot binaries
==========================

If you only wish to build images for a specific computer, once the GNU
Build system is initialized, configured and that the build
dependencies are also installed, you can use the build script (that is
also used by the GNU Build system) directly:

    ./build boot roms x200_8mb

Here it will build images for the ThinkPad X200 with 8MiB boot flash.

You can also specify more than one argument to build for multiple computers:

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
