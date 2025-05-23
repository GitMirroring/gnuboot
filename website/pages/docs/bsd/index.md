title: BSD operating systems
---

At the time of writing, there is no easily installable BSD operating
system or distribution that is fully free. Because of that we cannot
force contributors to the GNU Boot to install BSD operating systems to
run tests, so we instead need voulunteers already running BSD systems
to test booting such systems with GNU Boot.

At the time of writing, the most promising approach to fix this issue
is to wait for HyperbolaBSD to produce something that can be
downloaded so that any contributor could try it relatively easily.

As for the other BSD operating systems or distributions, The GNU
project documents [known freedom
issues](https://www.gnu.org/distros/common-distros.html) in various
distributions that are not entierely free, and the same page also [has
a section on BSD operating
systems](https://www.gnu.org/distros/common-distros.html#BSD).

Since GNU Boot is based on the last fully free version of Libreboot,
and that Libreboot was capable of booting many BSD systems, booting
BSD systems may still be possible in GNU Boot, but so far the GNU Boot
project has not heard of anyone who reported that working.

Video modes
===========

For BSD systems, it is desirable that you boot in *text mode*. ROM images
with `txtmode` in the file name, on x86 systems, boot up with int10h text mode
in use. This is the most "compatible" option, and BSD operating systems have
excellent support for text-mode startup. Many of them also support *kernel mode
setting* (KMS) nowadays, which you *need* if you want a graphical desktop on
the X window system. The reason is that GNU Boot relies on projects that didn't
implement int10h VGA modes on x86 systems. However, basic video initialization is
provided on all platforms (int10h (text mode), or high resolution coreboot
framebuffer).

Combined with the use of SeaBIOS, BSD systems (and any other OS that
can boot in text mode) should in theory *just work*, but they have not been
recently tested with GNU Boot. If your BSD system supports kernel
mode setting, it can set up a framebuffer without making use of int10h VGA
modes. In this case, the driver (e.g. Intel video driver) will set modes
directly, and implement its own framebuffer.

Booting with a coreboot framebuffer might also work well on most BSD systems,
though that hasn't been recently tested either. These ROM images have `corebootfb`
in the filename, on recent GNU Boot releases. In this setup, you should make sure
that your BSD system has a `corebootfb` driver (to make use of the coreboot
framebuffer), but when switching to X, your video driver (e.g. Intel video
driver) may already support kernel mode setting which means that the coreboot
framebuffer will no longer be used at that point.

Booting BSD
===========

GNU Boot currently provides the choice of GNU GRUB and/or SeaBIOS
payload. You can use *either* payload, to try to boot BSD operating
systems. If you do, please report your success or failure to the GNU
Boot project through a bug report. See the "Documentation and/or
testing" section in [Helping GNU
Boot](contribute.html#documentation-andor-testing) page for more details on how
to do that.

SeaBIOS payload
---------------

It is highly recommended that you use the SeaBIOS payload if you want
to boot a BSD operating system or distribution. GNU Boot Images which
start with the SeaBIOS payload are available in the latest GNU Boot
release, for all the supported computers.

Most GNU Boot images with GNU GRUB *also* have SeaBIOS available in
the boot menu, though it might not be the case for computers with a
very small boot flash size (512 KiB) like the Intel D945GCLF. GNU
GRUB, when compiled as a coreboot payload, runs on *bare metal* and it
can boot any other coreboot payload if you use the `chainloader`
command.

The way to use SeaBIOS is fairly self-explanatory. SeaBIOS functions
the way you would expect on a typical computer. GNU Boot currently
lacks any sort of documentation for SeaBIOS, but you can refer to
their website: <https://seabios.org/SeaBIOS>

SeaBIOS was *especially* recommended by the Libreboot project when it
was fully free for people doing an encrypted installation.

The Libreboot project also listed the fact that SeaBIOS was "basically
more reliable" at least with BSD systems by giving the example of ZFS
that was less reliable in GRUB and contrasting that with the fact that
if a FreeBSD system booted in SeaBIOS, it would work just fine because
the users would be using the bootloader provided by FreeBSD.

In addition, GNU boot may also remove support for booting encrypted
BSD systems in the GRUB images it provides at some point, in order to
make GRUB smaller to fit computer with a very small boot flash size
(512 KiB) like the Intel D945GCLF, and unify the documentation, but
also because it can't currently test that due to the lack of fully
free BSD systems that are easily installable.

GNU GRUB payload
----------------

GRUB can directly boot many BSD kernels, but according to the
Libreboot at the time where it was still fully free, support for this
was quite unreliable compared to its support for booting Linux
kernels. However, you *could* use GRUB.

When you used GNU GRUB directly, in this way, the various BSD bootloaders were
bypassed entirely.

The GNU Boot project has separate pages for each BSD system:

* [How to install NetBSD on x86 GNU GRUB payload](netbsd.html)
* [How to install OpenBSD on x86 GNU GRUB payload](openbsd.html)
* [How to install FreeBSD on a x86 GNU GRUB payload](freebsd.html)
