---
title: GNU Boot source code history
...

Introduction
============

The GNU Boot project decided that it was a good thing to list all the
contributors that modified a file in the copyright headers. There are
many good reasons for that:

- It simplify things (we don't need to decide what contribution is big
   enough to include its author in the copyright headers).

- It also acknowledge people that did smaller but yet very valuable
  contributions.

- If for some reasons who we decide to include or not in the header
  has some legal effects, by including more people there we
  practically speaking make the copyleft stronger as the copyright
  ownership is more distributed, and so a single individual cannot
  easily re-license the whole project under non-copyleft licenses.

However in the [main GNU Boot
repository](https://git.savannah.gnu.org/git/gnuboot.git) there are
many files whose copyright headers are incomplete as they miss some of
the contributors.

Since some of the files have a very long history that spans through
multiple projects and repositories, we found the need to document the
complex history of the GNU Boot source code.

Git history
===========

Here's a summary of the git history that is scattered across
different repositories and projects:

![](../../history/git-history.jpg)

And are the corresponding files to the image above:

* [Image file](../../history/git-history.jpg)
* [Source file](../../history/git-history.dot)

Before Libreboot used git
=========================

Before using git, Libreboot was released as tarballs.

The commit cee90ae0fce6d6aee8d78969b60c952c8890abd6 in the

[obsolete-repository-preserved-for-historical-purposes](https://notabug.org/libreboot/obsolete-repository-preserved-for-historical-purposes)
repository has more details on the first releases.

So far we know about these tarball releases before git:

+------------------------------+----------+---------------------------------------------------------------------+
| Release                      | date     | URL                                                                 |
+------------------------------+----------+---------------------------------------------------------------------+
| 1st release                  | 20131212 | https://rsync.libreboot.org/oldstable/20131212/X60_source.tar.gz    |
+------------------------------+----------+---------------------------------------------------------------------+
| 2nd release                  | 20131213 | https://rsync.libreboot.org/oldstable/20131213/X60_source.tar.gz    |
+------------------------------+----------+---------------------------------------------------------------------+
| 3rd release                  | 20131214 | https://rsync.libreboot.org/oldstable/20131214/X60_source.tar.gz    |
+------------------------------+----------+---------------------------------------------------------------------+
| 4th release                  | 20140221 | https://rsync.libreboot.org/oldstable/20140221/X60_source.tar.gz    |
+------------------------------+----------+---------------------------------------------------------------------+
| 5th release, first revision  | lost     | lost                                                                |
+------------------------------+----------+---------------------------------------------------------------------+
| 5th release, second revision | 20140622 | https://rsync.libreboot.org/oldstable/20140622/libreboot_src.tar.gz |
+------------------------------+----------+---------------------------------------------------------------------+
| 6th release, first beta      | 20140711 | https://rsync.libreboot.org/oldstable/20140711/libreboot_src.tar.gz |
+------------------------------+----------+---------------------------------------------------------------------+

The "6th release, first beta" is also available in git, but we don't
know yet if the git commit and the tarball are equivalent, so we
included it as well.

Before the first Libreboot release
==================================

The first Libreboot release (20131212) also contains several git
repositories that contains build scripts:

* https://gitorious.org/gnutoo-for-coreboot/coreboot.git (forked
  Coreboot with deblobbing and extra patches).

* https://gitorious.org/gnutoo-for-coreboot/build-makefiles.git (build
  scripts and Makefile(s)).

So some of the files present in GNU boot may or may not come from there.

And the gnutoo-for-coreboot repositories were made from scratch by GNUtoo.

Incomplete history
==================

The history of the projects presented in this page is incomplete. So
far we only have a partial code history. Contributions are
welcome. See the [git.md](../../git.md) page about various ways to
contribute to GNU Boot or to contact the project to update the
information in this page.