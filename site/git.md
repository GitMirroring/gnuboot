---
title: Code review
x-reviewed: true
...

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

The website is in the GNU Boot source code inside the site/ directory.

It is currently written in Markdown, specifically the Pandoc version
of it and the static HTML pages are generated with
[Untitled](https://untitled.vimuser.org/), a static website generator.

Its documentation is in the
[README](https://git.savannah.gnu.org/cgit/gnuboot.git/tree/website-build/README)
inside the website-build directory.

Name not required
-----------------

Contributions that you make are publicly recorded, in a Git repository which
everyone can access. This includes the name and email address of the
contributor.

In Git, for author name and email address, you do not have to use identifying
data. You can use GNU Boot Contributor and your email address could be
specified as contributor@gnuboot. You are permitted to do this, if
you wish to maintain privacy. We believe in privacy. If you choose to remain
anonymous, we will honor this.

Of course, you can use whichever name and/or email address you like.

Legally speaking, all copyright is automatic under the Berne Convention of
international copyright law. It does not matter which name, or indeed whether
you even declare a copyright (but we do require that certain copyright
licenses are used - read more about that on this same page).

If you use a different name and email address on your commits/patches,
then you should be fairly anonymous. Use [git log git
\-\-pretty=fuller](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
and [git show \-\-pretty=fuller](https://git-scm.com/docs/git-show) to
confirm that before you push changes to a public Git repository.

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

Maintainers
-----------

Adrien 'neox' Bourmault and Denis 'GNUtoo' Carikli are the interim
maintainers of this GNU Boot project.  They will also review patches
sent to the mailing list.
