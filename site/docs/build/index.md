---
title: Build from source
x-toc-enable: true
...

Libreboot's build system is named `lbmk`, short for `Libreboot Make`, and this
document describes how to use it. With this guide, you can know how to compile
Libreboot from the available source code.
This version, if hosted live on libreboot.org, assumes that you are using
the `lbmk` git repository, which
you can download using the instructions on [the code review page](../../git.md).

If you're using a release archive of Libreboot, please refer to the
documentation included with *that* release. Libreboot releases are only intended
as *snapshots*, not for development. For proper development, you should always
be working directly in the Libreboot git repository.

The following document describes how `lbmk` works, and how you can make changes
to it: [Libreboot maintenance manual](../maintain/)

Git
===

Libreboot's build system uses Git, extensively. You should perform the steps
below, *even if you're using a release archive*.

Before you use the build system, please know: the build system itself uses
Git extensively, when downloading software like coreboot and patching it.

You should make sure to initialize your Git properly, before you begin or else
the build system will not work properly. Do this:

    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com

Change the name and email address to whatever you want, when doing this.

You may also want to follow more of the steps here:
<https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup>

Python
======

Python 2 *and* 3 are used by different parts of the build system, not directly
but because certain projects Libreboot depends upon uses it.

You should have this configuration on your OS:

    python

    python2

    python3

Running `python` should give you python 3.x.

Running `python2` should give you python 2.x.

Running `python3` should give you python 3.x.

Therefore, you should install both python2 and python3 in your distro.

GNU Make
========

Libreboot Make includes a file called `Makefile`. You can still use
the `lbmk` build system directly, or you can use GNU Make. The `Makefile`
simply runs `lbmk` commands. However, using `lbmk` directly will offer you
much more flexibility; for example, the Makefile currently cannot build single
ROM images (it just builds all of them, for all boards).

You must ensure that all build dependencies are installed. If you're running
Ubuntu or similar distribution (Debian, Trisquel, etc) you can do this:

    sudo make install-dependencies-ubuntu

One exists specifically for Debian:

    sudo make install-dependencies-debian

Another exists for Arch:

    sudo make install-dependencies-arch

Now, simply build the coreboot images like so:

    make

This single command will build ROM images for *every* board integrated in
Libreboot. If you only wish to build a limited set, you can use `lbmk` directly:

    ./build boot roms x200_8mb

You can specify more than one argument:

    ./build boot roms x200_8mb x60

ROM images appear under the newly created `bin/` directory in the build system.

For other commands, simply read the `Makefile` in your favourite text editor.
The `Makefile` is simple, because it merely runs `lbmk` commands, so it's very
easy to know what commands are available by simply reading it.

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

Actual development/testing is always done using `lbmk` directly, and this
includes when building from source. Here are some instructions to get you
started:

First, install build dependencies
---------------------------------

Libreboot includes a script that automatically installs apt-get dependencies
in Ubuntu 20.04. It works well in other apt-get distros (such as Trisquel and
Debian):
    
    sudo ./build dependencies ubuntu2004

Separate scripts also exist:

    sudo ./build dependencies debian

    sudo ./build dependencies arch

    sudo ./build dependencies void

Technically, any GNU+Linux distribution can be used to build Libreboot.
However, you will have to write your own script for installing build
dependencies. 

Libreboot Make (lbmk) automatically runs all necessary commands; for example
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
lbmk.

Therefore, if you only want to build ROM images, just do the above. Otherwise,
please continue reading!

Second, download all of the required software components
--------------------------------------------------------

If you didn't simply run `./build boot roms` (with or without extra
arguments), you can still perform the rest of the build process manually. Read
on! You can read about all available scripts in `lbmk` by reading
the [Libreboot maintenance manual](../maintain/); lbmk is designed to be modular
which means that each script *can* be used on its own (if that's not true, for
any script, it's a bug that should be fixed).

It's as simple as that:

    ./download all

The above command downloads all modules defined in the Libreboot build system.
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

Each board has its own configuration in `lbmk` under `resources/coreboot/`
which specifies which payloads are supported.

By default, all ROM images are built, for all boards. If you wish to build just
a specific board, you can specify the board name based on the directory name
for it under `resources/coreboot/`. For example:

    ./build boot roms x60

Board names, like above, are the same as the directory names for each board,
under `resources/coreboot/` in the build system.

That's it!

If all went well, ROM images should be available to you under bin/
