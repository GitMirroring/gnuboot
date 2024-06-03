% GNU Boot December 2023 News
% GNU Boot Maintainers
% December 2023

GNU Boot December 2023 News
===========================

Announcements:
--------------

The last project announcement was made in the gnuboot mailing
list[1][2] at a time where we didn't have a website or an announce
mailing list yet.

So this announce and the next ones will be published in multiple
places:

- On the gnuboot[3] and gnuboot-announce[4] mailing lists

- On the GNU Boot website[5].

GNU Boot 0.1 RC3:
-----------------

We just released GNU Boot 0.1 RC3. We also need help from testers for
this release, especially because few intrusive changes were made.

We also release GNU Boot 0.1 RC2 just before but some bugs that don't
affect the installable images were introduced in the last minute fixes
so we ended up making an RC3 as well (some tests were broken and some
website pages also needed fixes).

Nonfree software found in the source release of GNU Boot 0.1 RC1.
-----------------------------------------------------------------

In the GNU Boot source release (gnuboot-0.1-rc1_src.tar.xz) we found
the 3 files (F12MicrocodePatch03000002.c, F12MicrocodePatch0300000e.c,
F12MicrocodePatch03000027.c) that contain microcode in binary form,
without corresponding source code. GNU Boot 0.1 RC1 corresponding
source code tarball was remade without these files (and renamed). The
images for the Asus KCMA-D8, KFSN4-DRE and KGPE-D16 were also removed
as they may contain the nonfree code as well. The rest of the files
are unaffected.

Website:
--------

Since the last announce a lot of work was done on the code to deploy
the website to make to make it easy for contributors and maintainers
to do changes to the website and review them.

The website has also been published. Not everything is ready in
it, but it contains enough to understand how to contribute to GNU Boot.

The pages that are not ready yet were also published with a special
banner to indicate that.

Since we now have a website, contribution instructions[6], and even a
list of areas where we are looking for contributions[6], we can now
accept patches.

The website is also now integrated in the GNU Boot source code and we
have special code to make it easy to test it locally (and deploy it
semi-automatically). So it should make contributions easier.

Testing:
--------

We would also like to thank all the people who tested GNU Boot 0.1 RC1
since the last announce, especially since this can be a lot of
work, especially because there are many computers to test.

The following computers were tested with GNU Boot 0.1 RC1 and they all
boot fine:
* Lenovo Thinkpad R400, T400, T500, T60, W500, X60, X60T, X200, X301
* Asus: KGPE-D16
* Apple: MacBook 2.1

Since some popular computers were tested[7], we are now also looking
for testers and contributions on the installation instructions. Even
if GNU Boot 0.1 RC3 has already been published, it's probably easier
to do the tests with GNU Boot 0.1 RC1 and a computer that was already
tested (unless the computer is an Asus KCMA-D8, see above for more
details) as there is no changes that could affect the installation
instructions between 0.1 RC1 and 0.1 RC3.

The following computers / mainboards weren't tested yet with the 0.1
RC1 yet so we also need testers for them (ideally on the 0.1 RC3):

* Chromebook: C201
* Intel: D410PT, D510MO, D945GCLF2D
* Gigabyte: D945GCLF, GA-G41M-ES2L
* Asus: KCMA-D8, KFSN4-DRE
* Apple: MacBook 1.1, iMac 5,2
* Lenovo Thinkpads: R500, T400s, X60s, X200s, X200T, X60T.

And as stated above we also need to re-test with the RC3 the computers
that were already tested with the RC1 to make sure that we didn't
break anything.

GNU Boot running nonfree software:
----------------------------------
GNU Boot is still in its early stages and many of the directions the
project can take are still being evaluated.

So it's a good time to warn people that in some cases GNU Boot does
run nonfree software on computers other than laptops, and that it
may change in the future (we have to decide how to deal with this
problem).

The issue is that ATI and Nvidia external GPUs do contain nonfree
software. That nonfree software is stored on the card in a memory chip.

At least in some configurations[8], if such GPU is present, GNU Boot
downloads and executes that software. Then later on in the boot,
Linux-libre also downloads and execute another nonfree software from
that same GPU.

If we decide to block that (it's relatively easy to do that in GNU
Boot) then users won't be able to use such GPU anymore. If we don't
block it, many users will not know about this freedom issue and will
think that they only run free software while nonfree software is
being executed behind their back.

This is also why the FSF RYF (Respect Your freedom) certification[9] is
important: it takes care of details like that and these GPUs or systems
with such GPUs are not certified by it.

Work in progress and future directions:
---------------------------------------
Work also started to improve the build system to make it easier to
understand and contribute. We also started adding tests along the way.

Though we still use old versions of Coreboot especially for the Asus
KCMA-D8, KFSN4-DRE and KGPE D16. Compiling GNU Boot images for these
computers requires specific distributions like PureOS 10 (byzantium)
or Trisquel 10 (nabia).

We plan to try to change that after the GNU Boot 0.1 release.

To do it we plan to update the versions of the software we build (like
Coreboot, GRUB, etc) but also to progressively switch to Guix to build
more and more parts of the images.

So far we managed to use Guix to building a GRUB payload (part of
that work was already upstreamed in Guix) and to build a custom Flashrom
that can be used to do installation on the I945 Thinkpads (X60, T60,
etc) but more work is needed (code cleanup, documentation, making it
easy to use for contributors) before we can integrate that code.

Integrating it now instead of waiting for the release would increase
the risk of introducing new bugs and inconsistencies (for instance in
the documentation), and reduce the amount of help we can get, and
since it is a big task there is also the risk of never finishing
it[10]. So we chose to do that step by step without breaking the
documentation or current usage of GNU Boot.

As for the website we are currently using Untitled, a static website
generator that use files in markdown with a custom header format.

We plan to migrate at least part of the website to Texinfo to generate a
proper manual with it and we already have code to convert from the
special markdown used to Texinfo, but the conversion sometimes needs
some manual intervention.

We're also not ready yet to do that conversion as keeping the markdown
a bit longer might make it easier for contributors to help us fix the
website.

We also evaluated Haunt, a static website generator that supports
markdown and Texinfo and that is also used by Guix for their website.

We managed to validate that we could easily write code to make it use
the custom markdown used by untitled. However we didn't invest time in
trying to make it generate a website (by default it generate blog
posts), so if some people already know haunt well or want to learn it
and are interested in helping it could be very useful. For that the
best would be to contact us on the gnuboot mailing list.

This is also important because according to its author, Untitled has
some design issues (and it is written in shell scripts) and so it will
most likely be rewritten from scratch in another programming language
by its author at some point.

In the meantime we sent patches upstream to fix some of the issues we
had with it and the patches were accepted.

Toward the 0.1 release:
------------------------
What is missing before we release GNU Boot 0.1 is basically more
testing and help on the website, especially the installation
instructions.

References:
-----------

 [1]"Testers needed for GNU Boot 0.1 RC1".

 [2]https://lists.gnu.org/archive/html/gnuboot/2023-09/msg00000.html

 [3]https://lists.gnu.org/mailman/listinfo/gnuboot

 [4]https://lists.gnu.org/mailman/listinfo/gnuboot-announce

 [5]https://gnu.org/software/gnuboot/web/news/gnuboot-december-2023.html

 [6]https://www.gnu.org/software/gnuboot/web/git.html

 [7]https://savannah.gnu.org/bugs/?64754

 [8]We know for sure that when SeaBIOS is used, it will download and
    execute nonfree software from GPU cards that are added to the
    computer. But we're not sure what happens if SeaBIOS is not
    used. An easy way to find out is if the GPU works under GNU/Linux
    and that the display is initialized, then at least some nonfree
    bytecode has been downloaded and executed by the operating system.

 [9]https://ryf.fsf.org/

[10]See "General tips on maintaining GNU software" in
    https://www.gnu.org/software/maintainer-tips for more details
    about common issues when maintaining a new project.