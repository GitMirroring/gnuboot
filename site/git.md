---
title: Code review
x-toc-enable: true
...

Libreboot repositories
======================

Information about who works on Libreboot and who runs the project can be
found on [who.md](who.md)

Libreboot has 5 Git repositories:

* Build system: <https://notabug.org/libreboot/lbmk>
* Website (+docs): <https://notabug.org/libreboot/lbwww>
* Images (for website): <https://notabug.org/libreboot/lbwww-img>
* Bucts (utility): <https://notabug.org/libreboot/bucts>
* ich9utils (utility): <https://notabug.org/libreboot/ich9utils>

You can download any of these repositories, make whatever changes you like, and
then submit your changes using the instructions below.

It is recommended that you build Libreboot (all parts of it) in a GNU+Linux
distribution. For example, the build system (lbmk) is untested on BSD systems.
Install `git` in your GNU+Linux system, and download one of the repositories.

Libreboot development is done using the Git version control system.
Refer to the [official Git documentation](https://git-scm.com/doc) if you don't
know how to use Git.

The `bucts` repository is hosted by the Libreboot project, because the original
repository on `stuge.se` is no longer available, last time we checked. The
`bucts` program was written by Peter Stuge. You need `bucts` if you're flashing
internally a Libreboot ROM onto a ThinkPad X60 or T60 that is currently running
the non-free Lenovo BIOS. Instructions for that are available here:\
[Libreboot installation guides](docs/install/)

The `ich9utils` repository is used heavily, by the `lbmk` build system. However,
you can also download `ich9utils` on its own and use it. It generates ICH9M
descriptor+GbE images for GM45 ThinkPads that use the ICH9M southbridge. It may
also work for other systems using the same platform/chipset.
Documentation for `ich9utils` is available here:\
[ich9utils documentation](docs/install/ich9utils.md)

lbmk (libreboot-make)
---------------------

This is the core build system in Libreboot. You could say that `lbmk` *is*
Libreboot! Download the Git repository:

    git clone https://notabug.org/libreboot/lbmk

The `git` command, seen above, will download the Libreboot build system `lbmk`.
You can then go into it like so:

    cd lbmk

Make whatever changes you like, or simply build it. For instructions on how to
build `lbmk`, refer to the [build instructions](docs/build/).

Information about the build system itself, and how it works, is available in
the [lbmk maintenance guide](docs/maintain/).

lbwww and lbwww-img
-------------------

The *entire* Libreboot website and documentation is hosted in a Git repository.
Download it like so:

    git clone https://notabug.org/libreboot/lbwww

Images are hosted on <https://av.libreboot.org/> and available in a separate
repository:

    git clone https://notabug.org/libreboot/lbwww-img

Make whatever changes you like. See notes below about how to send patches.

The entire website is written in Markdown, specifically the Pandoc version of
it. The static HTML pages are generated with [Untitled](https://untitled.vimuser.org/).
Leah Rowe, the founder of Libreboot, is also the founder of the Untitled static
site generator project.

If you like, you can set up a local HTTP server and build your own local
version of the website. Please note that images will still link to the ones
hosted on <https://av.libreboot.org/>, so any images that you add to `lbwww-img`
will not show up on your local `lbwww` site if you make the image links (for
images that you add) link to av.libreboot.org. However, it is required that such
images be hosted on av.libreboot.org.

Therefore, if you wish to add images to the website, please also submit to the
`lbwww-img` repository, with the links to them being
<https://av.libreboot.org/path/to/your/new/image/in/lbwww-img> for each one.
When it is merged on the libreboot website, your images will appear live.

For development purposes, you might make your images local links first, and
then adjust the URLs when you submit your documentation/website patches.

Instructions are on the Untitled website, for how to set up your local version
of the website. Download untitled, and inside your `untitled` directory, create
a directory named `www/` then go inside the www directory, and clone the `lbwww`
repository there. Configure your local HTTP server accordingly.

Again, instructions are available on the Untitled website for this purpose.

Name not required
-----------------

Contributions that you make are publicly recorded, in a Git repository which
everyone can access. This includes the name and email address of the
contributor.

In Git, for author name and email address, you do not have to use identifying
data. You can use Libreboot Contributor and your email address could be
specified as contributor@libreboot.org. You are permitted to do this, if
you wish to maintain privacy. We believe in privacy. If you choose to remain
anonymous, we will honour this.

Of course, you can use whichever name and/or email address you like.

Legally speaking, all copyright is automatic under the Berne Convention of
international copyright law. It does not matter which name, or indeed whether
you even declare a copyright (but we do require that certain copyright
licenses are used - read more about that on this same page).

If you use a different name and email address on your commits/patches, then you
should be fairly anonymous. Use
[git log](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
and [git show](https://git-scm.com/docs/git-show) to confirm that before you
push changes to a public Git repository.

Licenses
--------

We require all patches to be submitted under a free license:
<https://www.gnu.org/licenses/license-list.html>.

- GNU General Public License v3 is highly recommended
- For documentation, we require GNU Free Documentation License v1.3 or higher

*Always* declare a license on your work! Not declaring a license means that
the default, restrictive copyright laws apply, which would make your work
non-free.

GNU+Linux is generally recommended as the OS of choice, for Libreboot
development. However, BSD operating systems also boot on Libreboot machines.

Send patches
------------

Make an account on <https://notabug.org/> and navigate (while logged in) to the
repository that you wish to work on. Click *Fork* and in your account,
you will have your own repository of Libreboot. Clone your repository, make
whatever changes you like to it and then push to your repository, in your
account on NotABug. You can also do this on a new branch, if you wish.

In your Notabug account, you can then navigate to the official Libreboot
repository and submit a Pull Request. The way it works is similar to other
popular web-based Git platforms that people use these days.

You can submit your patches there. Alternative, you can log onto the Libreboot
IRC channel and notify the channel of which patches you want reviewed, if you
have your own Git repository with the patches.

Once you have issued a Pull Request, the Libreboot maintainers will be notified
via email. If you do not receive a fast enough response from the project, then
you could also notify the project via the #libreboot channel on Libera Chat.

Another way to submit patches is to email Leah Rowe directly:
[leah@libreboot.org](mailto:leah@libreboot.org) is Leah's project email address.

However, for transparency of the code review process, it's recommended that you
use Notabug, for the time being.
