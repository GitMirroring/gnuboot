% Translations wanted
% Leah Rowe
% 11 December 2021

The libreboot website is currently only available in English.

I've recently added support for translations to
the [Untitled Static Site Generator](https://untitled.vimuser.org/), which the
Libreboot website uses. Pages on libreboot.srht.site are written in Markdown, and
this software generates HTML pages.

This very page that you are reading was created this way!

Getting started
===============

The Libreboot website is available, in Markdown, from a Git repository:\
<https://notabug.org/libreboot/lbwww>

Instructions for how to send patches are available here:\
<https://libreboot.srht.site/git.html>

If you're working on a translation, make note of the commit ID from `lbwww.git`
and keep track of further changes (to the English website) in that repository.

When you send the translation, please specify what commit ID in `lbwww.git` it
is up to date with. From then on, I will keep track of changes to the English
website, which is what I work on. My native language is English. When the first
translation is made available on libreboot.srht.site, I will create a new page (in
English only), and add notes to it whenever I make site changes, and show
where these changes need to then be performed in translated versions of each
page that I change.

How to translate libreboot.srht.site
==============================

The documentation on <https://untitled.vimuser.org/> tells you how to handle
translations.

I recommend that you set up a local Nginx HTTP server on your computer, and
configure Untitled for it, using the instructions on the Untitled website. This
will make it easier to see what your translated website looks like, before it
goes live.

**It is recommended that you install a firewall, if you're running Nginx,
unless you actually want it to be publicly accessible. The `ufw` software is
quite nice:**

    sudo apt-get install ufw
    sudo ufw enable

This will block all unsolicited incoming traffic. It's good practise anyway,
for workstations. You don't have to use ufw, but it's a nice frontend for
iptables/ip6tables on systems that use the Linux kernel. More information
about `ufw` available here:

<https://help.ubuntu.com/community/UFW>

When viewing your local website, you can just type `http://localhost/` in your
browser. This will resolve to your local loopback address.

In general, you will be working with `md` files and `include` files.
Keep an eye out for files with `template`, `footer` and `nav` in the name.
More information about how Untitled works is available on the Untitled
website. You should also add a translated `strings.cfg` file to Untitled, for
your translation, if Untitled doesn't support it.

You can add pages in any language to Untitled. The software automatically
generates language selection menus, on a per-page basis, when a translation is
available for a given page.
