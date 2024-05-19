---
title: Code review
x-reviewed: true
...

Our short term plans and need for help
======================================

GNU Boot is seeking contributors for various jobs, both simple and
technical.

Information
-----------

The Libreboot name has a long history in the free software community.
Most occurrences of the uses were intended to refer to boot software
that was libre, and there is no way to edit those occurrences to refer
to libre boot software by a different name.  Therefore, we need help
from the wider community to inform people about the inclusion of
nonfree software in the Libreboot releases.

Another way to help GNU Boot and take a stand for fully free software
is to change URLs across the web from <libreboot.org> to
<gnu.org/software/gnuboot>, to make sure that the mentioned software
is reliably free software.

You can also help our project by informing people about GNU boot or
other 100% free boot software.

Documentation and/or testing
----------------------------

We need help for reviewing and fixing this website (which also
contains the documentation). Many pages are inherited from Libreboot
and might be outdated or specific to Libreboot.

In addition we also need help for testing releases and
testing/updating the installation instructions.

We currently have a list of what computers aren't tested yet in the
[bug 64754](https://savannah.gnu.org/bugs/?64754).

As for reporting what you tested, you can open a new bug or send a
mail to the [gnuboot](http://lists.gnu.org/mailman/listinfo/gnuboot)
or [Bug-gnuboot]
(https://lists.gnu.org/mailman/listinfo/bug-gnuboot) mailing list.

Technical contributions
-----------------------

GNU Boot is currently using old versions of upstream software (like
Coreboot, GRUB, etc) and so they need to be updated. Patches for that
need to be sent on the [gnuboot-patches]
(http://lists.gnu.org/mailman/listinfo/gnuboot-patches) mailing list.

We also have a bug tracker at
https://savannah.gnu.org/bugs/?group=gnuboot that contains a list of
bugs that needs to be fixed.

How to contribute
=================

GNU Boot repositories
---------------------

GNU Boot development is done using the Git version control system.
Refer to the [official Git documentation](https://git-scm.com/doc) if
you don't know how to use Git.

The main GNU Boot repository is at
<https://git.savannah.gnu.org/cgit/gnuboot.git>. It also contains the
documentation/website and code to build it.

GNU Boot also has two additional repositories: one for [presentations
done at
conferences](https://git.savannah.gnu.org/cgit/gnuboot/presentations.git)
or for [mirroring source code that
disappeared](https://git.savannah.gnu.org/cgit/gnuboot/acpica.org-mirror.git).

You can download any of these repositories, make whatever changes you like, and
then submit your changes using the instructions below.

Testing your modifications
--------------------------

For technical contributions or for contributing to the website, you
might need to test your modifications.

This currently requires to use a GNU/Linux distribution as building
GNU Boot or its website on other operating systems is completely
untested.

For instructions on building GNU Boot, you can refer to the [build
instructions](docs/build/).

Website
-------

The website is in the GNU Boot source code inside the website/ directory.

It is currently written in Markdown, specifically the Pandoc version
of it and the static HTML pages are generated with
[Untitled](https://untitled.vimuser.org/), a static website generator.

Its documentation is in the
[README](https://git.savannah.gnu.org/cgit/gnuboot.git/tree/website-build/README)
inside the website-build directory.

Name not required
-----------------

Many projects using free software licenses do accept contributions
from anyone but in many cases they also need to be able to track the
copyright ownership of the contributions for various reasons.

This usually makes anonymous or pseudonymous contributions to the code
more complicated, but that doesn't make them impossible.

The main difficulty for GNU Boot is that GNU boot wants to contribute
some of its changes to other projects it reuses such as Coreboot,
GRUB, Guix, and so we need GNU Boot code or documentation
contributions to be compatible with the way other projects track
copyright ownership.

Because of that, if you want to contribute anonymously or
pseudonymously the best way is to contact us publicly (for instance on
our mailing list, using a mail and name that you use only for that) so
we could look into it and try to find ways that work for GNU Boot but
also potentially for other upstream projects as well and this way
enable you to contribute to a wide variety of projects under free
licenses with way less friction.

We already looked into it for various cases, and pseudonymous
contributions should not have any special issues for contributing to
most of the GNU Boot documentation/website and for translating them,
for Guix packages, and for most parts of the GNU Boot build system. As
for contributions that include patches to other upstream projects like
Coreboot, we would need to look into it.

Note that if you send patches to GNU Boot, the contributions that you
make are publicly recorded, in a Git repository which everyone can
access.

And these contributions include a name, an email address and even a
precise date in which the contribution was made. It is relatively easy
to change the name and email with the ones you want as the git commit
command has options for that.

If you do that, before sending patches make sure to use [git log git
\-\-pretty=fuller](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
and [git show \-\-pretty=fuller](https://git-scm.com/docs/git-show) to
confirm that you used the right name and email before publishing your
changes.

Note that even if you do that, it might still be possible to link your
contributions to your identity for instance with
[stylometry](https://media.ccc.de/v/28c3-4781-en-deceiving_authorship_detection),
by looking at network connections if you don't use
[Tor](torproject.org), by looking at the time/timezone of the
contribution, etc.

Licenses
--------

We require all patches to be submitted under a free license:
<https://www.gnu.org/licenses/license-list.html>.

- GNU General Public License v3 is highly recommended
- For documentation, we require GNU Free Documentation License v1.3 or higher

*Always* declare a license on your work! Not declaring a license means that
the default, restrictive copyright laws apply, which would make your work
non-free.

GNU/Linux is generally recommended as the OS of choice, for GNU Boot
development. However, BSD operating systems also boot on GNU Boot
machines.

Send patches & contribute
-------------------------

You can submit your patches to the 
[gnuboot-patches mailing list](https://lists.gnu.org/mailman/listinfo/gnuboot-patches),
preferably by using [git send-email](https://git-scm.com/docs/git-send-email).

A simple guide to properly configure your git installation to send emails has
been made by [sourcehut](https://git-send-email.io/) or you can use the 
[sourcehut interface](https://man.sr.ht/git.sr.ht/#sending-patches-upstream) to create patches.

You'll have to specify the mailing list address:

	git config --local sendemail.to gnuboot-patches@gnu.org

Please also sign-off your patches, which you can configure with:

	git config format.signOff yes

Once you have submitted your patch, the GNU Boot maintainers will be
notified via the mailing list and will start reviewing it.

All the patches that are added to GNU Boot require the agreement of
two maintainers. The maintainer agreement is often indicated with text
like that:

	Acked-by: <maintainer name> <maintainer email>.

in an (email) reply form the given maintainer.

The maintainers agreement on a patch doesn't necessary mean that there
is an agreement on the order in which the patch will be added. So the
patches can also land into a 'gnuboot-next' branch temporarily and
potentially be re-ordered until all the GNU Boot maintainers agree to
push all the commits in the chosen order into the main branch.

That 'gnuboot-next' branch can also be used when the GNU Boot
maintainers agree to merge the patches but need to wait for the
approval of the GNU project for instance if there are legal questions
that also require the approval of the GNU Project.

Maintainers
-----------

Adrien 'neox' Bourmault and Denis 'GNUtoo' Carikli are the current
maintainers of this GNU Boot project.  They will also review patches
sent to the mailing list.
