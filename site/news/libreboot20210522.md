% Libreboot 20210522 released!
% Leah Rowe
% 22 May 2021

Join us now and flash the firmware!
===================================

You'll be free!
---------------

Libreboot is free (as in freedom) boot firmware, which initializes the hardware
(e.g. memory controller, CPU, peripherals) in your computer so that software
can run. Libreboot then starts a bootloader to load your operating system. It
replaces the proprietary BIOS/UEFI firmware typically found on a computer.
Libreboot is compatible with specifical computer models that use the Intel/AMD
x86 architecture. Libreboot works well with GNU+Linux and BSD operating systems.

The last Libreboot release, version 20160907, was released on September 7th
in 2016. *This* new release, Libreboot 20210522, is being released today on May
22nd, 2021. This is a *testing* release, so expect there to be some bugs. Every
effort has been made to ensure reliability on all boards, however.

You can find this release in the `testing` directory on Libreboot release
mirrors. If you check in the `stable` directory, you'll still only find
the 20160907 release in there, so please ensure that you check the `testing`
directory!

Tested boards
-------------

More testing is needed, for this release. Frequent update releases are planned
after this release, fixing any issues that people may come across.

GM45 laptops (e.g. ThinkPad X200, T400) are well-tested and should work fine.
X4X platforms (e.g. Gigabyte GA-G41M-ES2L) should also work. A few people have
tested the KCMA-D8 and KGPE-D16 ROM images too, and those should work fine.
The ASUS KFSN4-DRE is *untested* for this release. Intel i945 platforms such
as ThinkPad X60/T60 and Macbook2,1 have been tested, and should work fine.
Intel D510MO and D945GCLF boards are untested! Acer G43T-AM3 is untested!

New boards
==========

Desktops
--------

### Acer G43T-AM3

This is a desktop mainboard, with similar hardware to the already supported
Gigabyte GA-G41M-ES2L

Laptops
-------

### Lenovo ThinkPad R500

This is another Intel GM45 target, similar to the ThinkPad T500 that Libreboot
already supports.

### Lenovo ThinkPad X301

This is another Intel GM45 target, similar to the ThinkPad X200 that Libreboot
already supports.

List of supported boards
------------------------

This release has focused on the build system, and updating to the latest
coreboot release. This Libreboot release uses coreboot 4.14. Only a few boards
have been added, but existing ones have been updated heavily. Another new
release is planned soon, specifically an update release with ROM images in it
for more boards, while being built from the Libreboot 20210522 source code.
Visit the [tasks page](/tasks/) to know which machines are on the TODO list.

### Desktops (AMD, Intel, x86)

-   Gigabyte GA-G41M-ES2L motherboard
-   Intel D510MO and D410PT motherboards
-   Intel D945GCLF
-   Apple iMac 5,2
-   Acer G43T-AM3

### Servers/workstations (AMD, x86)

-   ASUS KCMA-D8 motherboard
-   ASUS KGPE-D16 motherboard
-   ASUS KFSN4-DRE motherboard

### Laptops (Intel, x86)

-   ThinkPad X60 / X60S / X60 Tablet
-   ThinkPad T60 (with Intel GPU)
-   Lenovo ThinkPad X200 / X200S / X200 Tablet
-   Lenovo ThinkPad R400
-   Lenovo ThinkPad T400 / T400S
-   Lenovo ThinkPad T500
-   Lenovo ThinkPad W500
-   Lenovo ThinkPad R500
-   Lenovo ThinkPad X301
-   Apple MacBook1,1 and MacBook2,1

Dropped boards
--------------

ASUS Chromebook C201 was dropped. It will be re-added at a later date, when
the build system in Libreboot has better integration for ARM hardware.

More boards coming soon!
------------------------

I had planned to add a lot more boards before doing a new release, but the
existing boards are greatly improved already (lots of new fixes and features
in coreboot), and there already are a few boards added.

The next Libreboot release will likely just be a few more ROM images, but while
referencing this release (Libreboot 20210522) for the source code. See the
tasks page on libreboot.org for a list of the boards I plan to add.

lbmk
====

The build system in libreboot is called `lbmk`, short for Libreboot Make. In
the previous Libreboot release, this build system had no name. It was simply
called "the build system" or just "libreboot". It was scrapped, shortly after
the 20160907 release and an ambitious new re-write began.

I stepped down in early 2017, and other people took over the project. However,
they failed to produce new releases and were taking the project in a direction
I didn't like. The most fundamental disagreement here was the new build system
itself, which I felt was too complicated and a liability for the project.
I felt like the project was going nowhere, so I completely took over development
and removed the other developers. The Libreboot project is now alive and well,
under my firm hand. I have many plans. I resumed my own full-time work on
Libreboot, during December 2020.

The build system in Libreboot 20160907 was very conservative, focusing on
stability rather than features. That build system was designed to be easily
maintained, but it was highly monolithic and not very configurable. Also, that
build system was largely centered around x86 hardware (Intel/AMD).

The intention behind the re-write was to create a much more configurable, and
highly advanced build system, with many new features. However, that re-write
failed and the result was that there were no more regular Libreboot releases.
Moving forward, ideas/features that were implemented (whether on not they were
completed) will be implemented in lbmk instead. The design of lbmk is
intentionally much simpler. The focus of lbmk is purely to provide releases of
pre-compiled ROM images that the user can easily flash on their machine, with
simple and clear guidance provided on the Libreboot website.

Moving forward, lbmk will be incrementally improved over time. One of the flaws
it has (at this point in time) is that it still only supports Intel/AMD targets
from coreboot. It is planned that future releases will support ARM and RISCV
targets aswell, which means that the lbmk build system will need to support
integrating other projects (such as uboot).

The re-write was scrapped. Work on the old build system resumed in late 2020.
Fundamental design flaws were fixed, and it is much more configurable these
days. It started in the form of a Libreboot *fork* named osboot, which you can
see here: <https://osboot.org/> (I, Leah Rowe, am the founder and lead developer
of both libreboot *and* osboot. osboot is the younger sibling of libreboot)

The osboot Git repository was then forked into osboot-libre, available in the
branch named `libre`. *That* branch was then forked to create this Libreboot
release. The osboot build system is named osbmk (osboot-make) and the one in
the libre branch is named osboot-libre.

Here is a summary of the improvements made in lbmk (based on osbmk-libre), when
compared to the Libreboot 20160907 build system:

* Generally it is much more cleanly written, and more modular
* The way coreboot boards are added is greatly simplified. It has reverted to
  using a directory per coreboot board, *but* a coreboot board can simply link
  to another board, while using its own configs. The other board doesn't need
  to have any configs either, so in this release there are 3 "boards" that aren't
  actually boards, but specify a coreboot revision and patches, for other boards
  to use:
    * `default` (most boards use this one) (uses coreboot 4.14 in this release)
    * `fam15h_udimm` (fam10h and 15h targets with UDIMM modules use this)
    * `fam15h_rdimm` (fam10h and 15h targets with RDIMM modules use this. it
      uses a raminit patch that fixes RDIMM training but breaks a lot of UDIMM
      modules. The udimm version doesn't have this patch)
    * the fam15h branches use coreboot 4.11, with some custom patches applied.
      a full fork of coreboot 4.11 is planned, with newer coreboot features
      backported to it, and it will be maintained over time (e.g. ensure that
      it continues to build using modern toolchains, and fix bugs that appear)
* Coreboot configs are much more flexible. The build system can now generate
  many more types of configurations. For example, desktop boards now load PCI
  ROMs automatically, if found (on add-on cards, such as graphics cards).
  Separate options are provided, for coreboot configs where loading of PCI ROMs
  is disabled. This was done because Libreboot now supports a lot more desktop
  hardware than the previous release; the build system has historically been
  optimized towards building coreboot configs for laptops. It is now much more
  flexible in this regard, creating perfectly usable ROM images for more types
  of hardware.
* Multiple crossgcc revisions are now used, if multiple coreboot revisions are
  also used. In Libreboot 20160907, the same crossgcc revision was always used,
  from an arbitrarily selected coreboot revision. This worked because at the
  time, all boards used more or less the same coreboot version, give or take a
  few commits. There were more revisions used, but they were closer together.
  In *this* release, coreboot 4.11 and 4.14 are the versions used, and these
  revisions are quite far apart from each other.
* You no longer have to manually run individual commands within lbmk (in osboot
  it's called osbmk. osboot-make): each command checks if previous commands
  required were run, and runs them if not. **This means you can just type a
  single command to build a ROM image if you wish!**
* Makefile included, making the build system even easier to use. The Makefile
  contains no logic, it just runs osbmk (osboot-make) commands
* The GRUB payload is now handled by a completely separate command. The
  command `./build payload grub` generates the GRUB payload executables, and
  puts them in `payload/grub/`, in a completely modular way.
* Same thing for SeaBIOS. SeaBIOS is handled by the `./build payload seabios`
  command in lbmk, and the payloads appear under `payload/seabios/` when built.
  In the Libreboot 20160907 release, SeaBIOS and GRUB were always built precisely
  while building the ROM images, so the logic for payload building and coreboot
  ROM building was shoehorned into a single script. Now it is a separate script
* The commands `./build roms withgrub` and `./build roms withseabios` are
  scrapped. Instead, a single command `./build boot roms` is used. Each board
  defined in `resources/coreboot/` (in 20160907 it was `resources/libreboot`),
  a file named `board.cfg` defines, among other things, what payloads are to be
  used. The config files for coreboot boards are specified as having *no*
  payload, and lbmk inserts the payload externally, using `cbfstool`.
* Vastly improved `grub.cfg`: un-hardcodes a lot of functionality, improved
  usability on i945 targets such as X60/T60/macbook21, USB HDD support out of
  the box
* Tianocore payload supported, for UEFI. NOTE: this is inherited from osboot,
  but Tianocore itself doesn't work well or is otherwise untested on currently
  supported platforms in Libreboot. The build system is capable of building it,
  and what it builds *does* work on some sandybridge and ivybridge laptops that
  were tested in osboot (the non-libre version, in the master branch). However,
  Tianocore is a very large and complex codebase (it's actually bigger than the
  Linux kernel!). It is untested on everything in Libreboot except i945 and GM45,
  and on those it completely stalls (it gets to the logo screen, but crashes,
  so it never reaches the UEFI shell program). Getting Tianocore to work is
  a priority for the *next* Libreboot release; Tianocore is free software, and
  can work quite well but it does need some maintenance first. GNU+Linux distros
  expect it nowadays (on x86), though the linux kernel can still run on bare
  metal and that is unlikely to change (so, GNU GRUB payload will always be
  possible on x86). lbmk doesn't actually build tianocore. Instead, it modifies
  the *coreboot* build system, and uses the coreboot build system with a dummy
  board config, selecting Tianocore as the payload, and then it copies the
  Tianocore ELF into `payload/tianocore/`
* SeaBIOS now included as standard, on all ROM images; on images with the GRUB
  payload, SeaBIOS is an option in the boot menu.
* The build system is *much* easier to use when adding new board configs
* Each `board.cfg` for each board defines what payloads it is to use, what
  architecture, etc. Coreboot trees are now handled on a directory basis,
  instead of creating multiple branches in a newly initialized Git repository;
  this is less efficient on disk space, but it is simpler to maintain, so now
  the priority is to minimize how ever many coreboot revisions are used.
* Boards can link to other boards; for example, X200 could use the same setup
  as T400. However, in this case the specific board would still have it's own
  specific coreboot configuration files. Basically similar in spirit to the
  variants concept in the coreboot build system, but for the purposes of
  integrating various coreboot configs and revisions together, for several
  boards.
* Build system highly optimized; unnecessary steps are skipped. If you just
  want to build for 1 board, you can! Only the things necessary for that board
  will be compiled by osbmk, at least automatically that is!
* In general, it is a *much more automated* automated build system!
  It's better documented, and easier for the average person to maintain.

Documentation
=============

Generally, the documentation is much improved. In particular, the "maintain"
page has been reintroduced, which describes every aspect of the build system
in great detail.

Build system documentation was absent for the last few years, due to the
rewrite. The rewrite had a very over-inflated scope in its agenda and it was
extremely complex considering what Libreboot is supposed to be: a coreboot
distro.

The installation guides for Libreboot are greatly improved. In particular, the
external flashing guides now have a lot more information; for example, there is
now a single page that clearly defines each type of flash IC you'll likely
encounter. It also has information about flashing new chips in a breadboard,
and replacing WSON8 ICs with SOIC8 ICs (useful for ThinkPad X200 Tablet and
X200S owners who wish to install Libreboot).

The documentation is not fundamentally different from the last release, mostly
because the documentation wasn't worked on much over the last few years. Rather,
the documentation has been *tweaked* over the years. We didn't focus as much on
adding new hardware to Libreboot, because of the re-write that occured.

Ever since the re-write was scrapped, the focus is now once again on hardware
support, rather than build system changes. As such, the installation guides
are greatly improved and there are *more* systems documented now.

GRUB
====

In GNU GRUB payloads, a much more recent version is used. The difference is
literally: the GRUB version that Libreboot 20160907 uses was released 5 years
ago. The version that this new Libreboot release uses is from *a few days ago*.

In Libreboot 20160907, only a limited subset of GRUB modules were included. In
this new Libreboot list, all modules (from `moddeps.lst` when building GRUB) are
used. One consequence of this is that there are no longer errors in the GRUB
payload complaining about missing modules.

In particular, GRUB now supports LUKSv2. In the Libreboot 20160907 release, it
was necessary to downgrade LUKSv2 to LUKSv1 if you were doing a fully encrypted
GNU+Linux installation (where the GRUB payload was expected to decrypt the /boot
directory).

Keymaps are mostly the same, but now Colemak keyboard layout is supported. It
is possible to add any keymap to GRUB, if you follow the notes in the Libreboot
documentation and then re-build the ROM from source.

The default GRUB configuration in Libreboot is much more automated now, with
less hardcoded functionality. It's more optimized in general, especially on
ICH7 platforms (e.g. ThinkPad X60, T60). Other features are implemented, such
as automatically booting an installed GNU+Linux distro from an external USB
HDD or SSD (or flash drive!)

In GRUB payloads, SeaBIOS is no longer used to start GRUB, on any platform in
Libreboot. Instead, GRUB is always loaded directly (by coreboot). The effort to
produce a so-called "SeaGRUB" payload has been abandoned. We simply use a
standard SeaBIOS setup now. SeaBIOS is available in the GRUB menu (GRUB can
load and execute any other coreboot payload).

One could argue that it's a GNU GRUB setup!

Anyway, Libreboot 20160907 used GRUB at git commit ID
7f2a856faec951b7ab816880bd26e1e10b17a596 March 2016.

This new Libreboot releases used GRUB c0e647eb0e2bd09315612446cb4d90f7f75cb44c
from May 10th, 2021.

Download GNU GRUB from the Git repository shown on
<https://www.gnu.org/software/grub/> and check every commit since then.

GM45/X4X now set 352MiB VRAM by default
=======================================

In the previous Libreboot release, PCI MMIO size was set to 1GiB. It is now
set to 2GiB, allowing for 352MiB VRAM to be allocated when using the onboard
Intel GPUs. It used to be tht 352MiB VRAM was unstable, so the previous
Libreboot release set it to 256MiB. It is now 352MiB, by default.

The following patch in coreboot allowed that (shortly after the Libreboot
20160907 release in fact!):

<https://review.coreboot.org/c/coreboot/+/16831>

Quad-core CPU mod on ThinkPad T500 etc
=======================================

NOTE: The actual modification (to the hardware) is only documented for T500,
but it should be possible to adapt those instructions for similar GM45 laptops
that have a socketed CPU.

NOTE: Hardware modifications are required to make quad-core CPUs work. You have
to cut/disable a few signals and solder 1 wire. Look online for ThinkPad T500
quad core mod. Alongside this hardware mod, the boot firmware also must be
configured to allow for quad core CPUs. This new Libreboot release has such
configuration already enabled, so if you've already performed the modifications
to your hardware then it should Just Work.

The option `MAX_CPUS=4` is now the default, on these machines in coreboot:

* ThinkPad R400
* ThinkPad T400
* ThinkPad T500
* ThinkPad R500
* ThinkPad W500

This is necessary, for a special mod that is possible on these machines, to
enable quad-core CPUs (core2quad).

libgfxinit
==========

In Libreboot 20160907, *native graphics initialization* was C code implemented
on each platform, and it was very messy, but it *worked*.

Since that release, coreboot re-wrote the core of its native video
initialization code in Ada and put it in a 3rdparty submodule
called `libgfxinit`. When downloading the `default` coreboot version in
Libreboot (using `./download coreboot default`) you can check the code for
libgfxinit in `coreboot/default/3rdparty/libgfxinit/`, and this is also in the
source code release archive of this Libreboot release.

The new code is much better, and more reliable. For example, during testing,
some screens on ThinkPad T400 that didn't work in Libreboot 20160907 work
perfectly with libgfxinit in recent coreboot revisions and on the new
coreboot 4.14 release. Other features like VBT are much improved

The following platforms in Libreboot are now handled by `libgfxinit` for video
initialialization:

* Intel GM45 (ThinkPad X200, T400, T500, W500, R400, R500, T400S, X200S,
  X200T, X301)
* Intel X4X (Gigabyte GA-G41M-ES2L, Acer G43T-AMT3, Intel DG43GT etc)

From looking at the coreboot source code, it seems that the following platforms
are not yet migrated over to libgfxinit:

* Intel pineview (Intel D510MO, Gigabyte GA-D510UD, Foxconn D41S)
* Intel i945 (ThinkPad X60, T60, Macbook2,1, Macbook1,1 etc)
* AMD Fam10h / Fam15h (ASpeed AST2050 framebuffer chip used on ASUS KCMA-D8
  and KGPE-D16 - NOTE: these and other AMD boards in Libreboot are currently
  stuck on coreboot 4.11)

The code is much cleaner. Much of the code in coreboot is still written in C,
for *interfacing* with the Ada code. The actual video initialization is handled
with the Ada code, in the libgfxinit submodule.

Right now there aren't many commits in that repository, so we will just list
them here. You can run `git log` in `3rdparty/libgfxinit` when
running `git submodule update --init` in a coreboot git clone:

````
* 8d5c24d (origin/master, origin/HEAD, master) Add support to switch LSPCON modes
* 0a8174b gfx dp_aux: Add I2C_{Read,Write}_Byte procedures
* ae186bd gfx gma skylake: Implement some workarounds
* bc0588e (HEAD) gma: Export backlight control interface
* 994971a gma: actually enable/disable backlight with new backlight control
* dde0630 gma: Add `Cannon_Point` PCH
* e79babd gma: Introduce `PCH_Type`
* c9ad9de gma: Fix setting of `Raw Clock` scratchpad
* 3318bf2 Drop generation suffix from `Power_And_Clocks`
* 450c24c haswell: Make VGA on FDI work
* 3f86b0b Move `PSR_Off` out of `Power_And_Clocks_Haswell`
* c0db994 common/Makefile.inc: Factor out generation TLAs
* 8fc8e49 common/Makefile.inc: eliminate duplicate substitutions
* 2a3dbba gma config: allow override of presence straps
* 2e87c0d gma: Map dummy PTEs for buggy VT-d
* cdbfce2 gma config: Add Comet Lake PCI IDs
* 5dbaf4b gma bxt panel: Allow to use secondary panel control logic
* 1f63d51 gma bxt panel: Correct panel backlight handling
* 3ea5d60 gma bxt panel: Correct power-cycle delay programming
* 7050d2d gma bxt: Add panel power and backlight register definitions
* 2bbd6e7 gma panel: Introduce `Panel_Control` type
* 8a6e7bd gma panel config: Turn `internal display type` into a `panel port`
* 8beafd7 gma: Split `Internal` port type into `eDP` & `LVDS`
* fe7985f gma: Fix GTT size reading for Gen8+
* a563ec2 gfx_test: Refactor animation loop and handle hotplug events
* 92de9c4 gma display_probing: Add Hotplug_Events()
* b0bbdbc gma: Automatically update CDClk and dot clocks
* 8469b00 gma bxt: Implement CDClk switching
* 6b4678d gma skl: Implement CDClk switching
* d0f84b9 gma hsw: Implement CDClk switching
* 1eb5faa gma ilk: Handle CDClk and calculate dot-clock limits
* b47a5c4 gma g45: Read CDClk and calculate dot-clock limits
* 07ff1b9 gma config: Allow to cache CDClk in variable config state
* 3d3452f dp_info: read eDP 1.4+ DPCD link rates
* 04c1d01 gma ilk hdmi: Add workaround for enable-bit quirk
* f6a2d18 gma ilk: Handle Ibex Peak DP correctly
* 6c10d36 Increase range of our main Frequency_Type
* 530651b gma g45 config: Limit HDMI rate to 165MHz
* a4e7f25 gma i2c: Increase timeout, again
* e317e9c gma: Merge `Config_State` into `State`
* c5c66ec gma: Allow private sub-packages to access PCI config
* 7f3e280 gma: Give GM45 its own designation (separate from G45)
* 9a4c4c3 gma: Refactor Update_Outputs()
* 88da05e gma config_helpers: Add dot-clock helper functions
* 9e96a45 gma config_helpers: Introduce Valid_FB()
* 312433c gma pcode: Move and revise mailbox handling
* 82ca09f gma registers: Implement `Success` parameter for Wait*()
* efa3ca8 gma i2c: Rework GMBUS reset procedure
* 4fc6dc2 gma display_probing: End probing after all ports failed
* 75a707f gma pipe setup: Fix secondary pipe cursors <= Sandy Bridge
* d8282b6 gfx_test: Refactor to allow Restrictions (No_Elaboration_Code)
* a815704 gma bdw+ transcoder: Use always-on path for primary pipe on eDP
* 94fb916 dp training: Write correct training data when switching patterns
* f80c3e4 dp training: Always end with normal output
* 68f439d gma i2c: Increase timeout to >100ms
* c1d2030 gma i2c: Try to clear NAK indicator
* 040d9b6 gma: Publish Read_EDID()
* 2c92794 gma: Add more PCI IDs for Coffee/Whiskey/Amber Lake
* 88badbe gma: Add Kaby Lake support
* 25fdb15 gma: Add support for ULX variants
* d49b56b gma pipe setup: Refactor calculation to ease proof
* b3b9fa3 gma: Fix Ironlake panel fitting, revisited
* 8a9062a gma config: Enable Restrictions (No_Elaboration_Code)
* 6a996dc gma: Implement automatic CPU detection
* adfe11f gma config: Make Config.CPU and Config.CPU_Var variable
* d936561 gma config: Tag constants depending on generation or CPU
* 27088aa gma config: Initialize stateful configs late
* 30e8408 gma config: Group mutable state into a record
* 86445f3 gma pipe setup: Drop explicit Global and Depends contracts
* 63ec836 gma: Give constants depending on Config.CPU* a type
* 63dc919 gma: Turn constants depending on Config.CPU* into functions
* d7809ab gma config: Limit types of CPU and CPU_Var
* 998ee2b gma config: Introduce per CPU booleans
* 6621a14 gma: Introduce Generation type
* c76749d gfx_test: Use GMA.Read_GTT() instead of own GTT mapping
* ceda17d gma registers: Add Read_GTT() procedure
* 0b2329a gma registers: Separate 32- and 64-bit GTT access
* d0d8b79 gma registers: Draw usage of Config.Fence_Count into the code
* 1ee5714 gma broxton power/clocks: Turn pre-condition into code
* ef3b093 gma config: Introduce Has_New_FDI_(Sink|Source)
* 117db37 gma config: Introduce Have_HDMI_Buf_Override
* 318bca1 gma config, port detection: Scatter Valid_Port initialization
* cf88f3d gma: Provide `Global` contracts for public procedures
* 67cf6d8 gma config: Introduce Is_ULT
* f70edda gma pipe_setup: Work around a PFIT_CONTROL quirk on G45
* d58de7d gma config: Introduce Has_Tertiary_Pipe
* eb4e8f9 gma config: Fix CPU range for Has_PCH_DAC
* 7ba7bd6 gma pipe setup: Add missing `pragma Debug`
* 865f1fa gfx: Introduce Size_Type for framebuffer size in bytes
* c5c767a Use (Width|Height)_Type for modeline sizes
* da1185e gfx, gma pipe_setup: Rewrite Scale_Keep_Aspect
* db68441 gma skylake power/clocks: Refactor to allow proof without inlining
* 57bebc7 gma panel: Refactor to allow proof without inlining
* 8a5a3b5 gma: Add contract to Enable_Output() to rely less on proof inlining
* 5a3191f gma display probing: Use expression functions for less proof inlining
* 7eb1350 edid: Use expression functions to rely less on proof inlining
* 565f33b gma broxton: Tighten types to rely less on proof inlining
* b679013 gfx: Increase range of Frequency_Type
* 718c79b g45/hw-gfx-gma-gmch-hdmi.adb: Use GMCH_HDMI_MODE_SELECT_DVI
* f361ec8 gma: Introduce Pipe_Config.Scaler_Available()
* 958c564 gma: Revise scaling on G45
* b217ece gfx, gma: Add helper to decide scaling aspect
* 7167746 gfx, gma: Move Requires_Scaling() up into GFX
* 3299ad5 gfx, gma: Move inline functions into private package parts
* ab69e36 gma ironlake..broadwell: Enable X-tiling
* a63e833 gfx_test: Move Cursors
* 7bb10c6 gfx_test: Draw cursors
* 15ffc4f gma: Add interface functions to update/place/move cursor
* 4dc4c61 gma: Configure cursor plane
* a02b2c6 gma: Add cursor infrastructure
* 7a74043 Rename Pos_Type --> Position_Type
* abb16d9 gma hsw transcoder: Choose PDW path for scaling on DDI A
* 3d06de8 gma hsw: Enable Power Down Well for scaling on DDI A
* 73ea032 gma: Add G45 support
* d519844 gma: Add flag to set up GMCH Panel Fitter
* fdb0df1 gma: Fix Ironlake panel fitting
* a455f0e gfx_test: Add loop that shows cuttings of the test image
* f7f537e gma pipe_setup: Replace Update_Offset() with Setup_FB()
* 8fd92a1 gma pipe_setup: Write DSPSURF register last
* cbbaade gma config_helpers: Pass only the modeline to Validate_Config()
* b4b7279 gma pipe_setup: Explicitly disable panel fitter if unused
* 5ef4d60 Add Start_X and Start_Y offsets for framebuffer panning
* 34be654 gma: Reverse meaning of GTT_Rotation_Offset
* 98a673d gma ddi: Move conditionally used Program_Buffer_Translations()
* 60d0e5f gma: Add Pipe_Index to the Connectors.Post_On method
* e87d0d1 gma: Add flag to use GMCH PP registers
* 5d08a93 gma: Add GPU_Port types that are convenient for GMCH to use
* 636390c gma: Add a flag to use GMCH transcoder registers
* 229ed1c gma: Add flag to use GMCH GMBUS registers
* dfcdd77 gma: Add flag to allow use of VGACNTRL on GMCH
* d1988d1 gma: Make Raw_Clock a variable
* 7628493 gfx_test: Update i915 binding in wrapper script
* 9ca69f1 gfx_test: Add top marker for rotated framebuffers
* 88f3c98 gfx_test: Add rotation parameter
* 244ea7e gfx_test: Add corner markers to test screen
* 9b47941 gma: Add support for rotated framebuffers
* b747049 Add Rotation setting to Framebuffer
* 0164b02 gma: Set tiled framebuffers up through Plane_Control
* b03c8f1 gma registers: Add procedures to set fence registers
* 51375ad Add Tiling setting to Framebuffer
* e7ac6eb gma: Implement PCI Id based generation check
* 208857d gma hsw+: Treat DDI E and PCH DAC disabling separately
* 907e415 gma hsw+: Don't use DDI E if DDI A uses all lanes
* 19729a7 gma hsw+: Revise Has_DDI_D flag
* 5fd9a31 gma: Fix decoding the size of Stolen Memory on Gen4
* 3b654a0 gfx_test: Set our own framebuffers up, update README
* 42fb2d0 gma: Add procedure to power up legacy VGA block
* 3a0e2a0 gma skl: Disable DDI clocks on reset path
* 8540805 gma skl: Prevent race by late timeout check
* 234e772 dp training: Allow to adjust pre-emphasis during clock recovery
* 41b18ca dp training: Fix channel equalization phase
* 1bc496f gma-display_probing: Only check display type on DVI-I
* c3f66f6 gma: Add Map_Linear_FB()
* eedde88 gma: Check that framebuffer fits stolen memory and aperture
* 5374c3a gma: Add Setup_Default_FB()
* 194e57e gma: Allow offsets /= 0 in Setup_Default_GTT()
* bebca13 gma: Move a warning justification to spec
* e015e82 gma: Fix refined contract of Initialize()
* 17d64b6 gma: Clear "fence" registers during initialization
* 2b6f699 gma: Add a HW.PCI.Dev for dynamic MMIO setup
* b8ae618 gma: Move GTT constants into GMA.Config
* fda2d6e gfx_test: Update to use *libhwbase* new PCI interface
* 58afc20 gma skl: Add I_boost configuration
* 18ff0c1 gma skl: Add DDI buffer translations
* 730f17c gma hsw bdw: Add DDI buffer translations
* 01b680f gma hsw+: Add boilerplate for DDI buffer translations
* 247adf3 gma hsw+: Add default value for HDMI buffer levels
* 0923b79 gma-connectors: Add Initialize() procedure
* fb4f8ce Add a README describing libgfxinit and the build process
* 1d0abe4 Add linux user-space app `gfx_test`
* 3586101 gma: Juggle with types of a precondition
* 1c3b928 gma broxton: Add final glue
* fdd9365 gma broxton: Add signal level control for DDI PHYs
* afadcac gma broxton: Implement pre-PLL setup for DDI PHYs
* 4b0239f gma broxton: Fill in port PLL configuration
* f626600 gma broxton: Implement DDI PHY power handling
* 4082044 gma broxton: Start off with power domains and CDClk
* 21da574 gma: Add config plus stubs for Broxton SoC
* b83107c common/hw-gfx-gma: Remove trailing space in debug output
* 799752f configs: Escape hash characters
* ac455ad gma ddi: Don't try to disable non-existent DDI D
* bcb2c47 gma registers: Add generic Wait() procedure
* 31a5217 gma: Justify some use-visibility warnings
* 8fb0f31 gma: Do not check for hot-plug events on analog port
* 4c7356d gma: Add option to keep port power after Scan_Ports()
* 4798c66 gma: Always clear hot-plug events before enabling a pipe
* 564103f gma: Rework power handling in Update_Outputs()
* b56b9c5 gma: Disable all stale pipes before enabling any new
* 3be61d4 gma: Refactor Hotplug_Detect() interface and usage
* 43370ba gma: Factor enabling of a single pipe out of Update_Outputs()
* 1a712d3 gma: Drop state tracking of active `DP_Links`
* af9cc9e dp_info: Refactor debug output for DP settings
* 6e327c9 gma: Get rid of Get_Pipe_Hint()
* 7ad2d65 gma: Move transcoder setup into own package
* 113a14b gma pipe_setup: Untangle pipe and transcoder config
* 33912aa gma: Move Legacy_VGA_Off() into Pipe_Setup
* f3e2366 gma: Move pipe/transcoder register selection into Pipe_Setup
* 02cfbb3 gma: Choose FDI-link settings after mode determination
* d6d6f6b gma config: Fix framebuffer alignment check
* 793a8d4 gma: Make cleaning the hardware state optional
* 6a4dfc8 gma skl: Use framebuffer size as plane source size
* 7892ff6 gma ironlake: Reorder panel power handling
* 6f9a50d gma-display_probing: Enable panel power early
* 8c45bcf gma: Split out config derivation and port probing
* 3c544ee gma: Refactor Port_Config derivation
* 6b7a40b gma: Probe sibling ports for improper connected displays
* 845de36 gma: Do not probe EDID if a port's sibling is configured
* 1b2c9a3 gma: Refactor Scan_Ports()
* 995436b gma: Get rid of Port_Config in Read_EDID()
* dca242d gma: Drop Auto_Configure()
* 0d454cd gma: Rename ports Digital[123] => HDMI[123]
* 99f10f3 gma: Rename Config_Type => Pipe_Config
* 43cf8d5 gma haswell: Turn comment into sane code
* 88a7f17 edid: Sanitize bad EDID header patterns
* aa91bb5 gma: Add parameter to Scan_Ports to limit number of pipes
* 74ec962 gma: Limit HDMI pixel rate
* fbb4220 gma: Implement Ivy Bridge VGA plane workaround
* 3675db5 gma: Add option for VGA plane on the primary pipe
* 4916e34 gma: Configure panel fitter / pipe scaler
* 770fe4a gma: Use framebuffer size as pipe source size
* 47ff069 gma: Show that we never try to downscale the image
* dcd274b gma: Validate maximum scalable width
* c7a4fee gma: Validate pipe configurations
* 6a35667 gma: Fix loop logic in Scan_Ports()
* d55afeb gma i2c: Make I2C port for VGA displays a config option
* 393aa8a gma edid: Check expected display type
* abe3de2 gma dp aux: Program 2x bit clock divider
* f54d096 gma: Program PCH_RAWCLK_FREQ register
* 125a29e Relicense libgfxinit under GPL v2+
* be4eadd gma pch lvds: Fully initialize port register
* 16f3dec edid: Correctly initialize BPC if it's unset in EDID
* 2600c36 common/Makefile: Avoid double slashes in generated paths
* 3e50827 Strip quotes from config variables to be Kconfig compatible
* eeb5a39 gma: Expect zero Audio_VID_DID on Ibex Peak
* 83693c8 Initial upstream commit
````

coreboot release logs
=====================

The following is a page linking to release logs for coreboot, upstream:\
<https://doc.coreboot.org/releases/index.html>

In this section, we will explore the entries (from coreboot release logs) that
are most relevant to Libreboot. Roughly speaking, Libreboot 20160907 (the
previous release, 4 years and 8 months ago) used revisions of coreboot near or
around coreboot version 4.4 and 4.5, depending on the board.

coreboot 4.14
-------------

Lots of random fixes, too many to list. Instead, see git logs on this page for
specific boards/platforms.

This release of coreboot focused mostly on adding new boards, and none of them
are suitable for Libreboot at the present time. (except for Pine64 Rockpro64,
which is a candidate for Libreboot, but more research is needed on it)

However, the following fixes were made for Lenovo X200 recently:

* <https://review.coreboot.org/c/coreboot/+/51118>
* <https://review.coreboot.org/c/coreboot/+/51123>

coreboot 4.13
-------------

* Mostly re-factoring and minor bug fixes, but it has some interesting fixes
  that benefit libreboot
* Acer G43T-AM3 mainboard added. This is also in the Libreboot release. This
  board was also present in Libreboot, prior to it updating to use coreboot
  4.14, but now it is in the latest coreboot stable release
* Initial support for x86\_64. Not yet used by Libreboot, but it might be
  interesting in the future on x86 targets
* New resource allocator: enables more efficient use of memory during bootup

coreboot 4.12
-------------

* SMMSTORE is now a thing. See: <https://doc.coreboot.org/drivers/smmstore.html>.
  This is relevant for Tianocore, a UEFI payload, which libreboot currently
  does not integrate for any boards, but Tianocore integration is planned in
  the future. Tianocore provides the option to use any UEFI-compliant operating
  system, and this benefits GNU+Linux distributions aswell (it Just Works).
  SMMSTORE is basically UEFI's answer to CMOS "NVRAM". it is a way to store
  configurations, in SPI flash. it's handled via SMM interrupts (SMIs). NOTE:
  SMMSTOREv2 is also becoming a thing now
* relocatable ramstage, postcar stage and C\_ENVIRONMENTAL\_BOOTBLOCK (as
  opposed to romcc) are now mandatory features for all boards. This means that
  fam15h/10h boards were dropped from coreboot, which didn't implement those
  features yet (in other words, ASUS KCMA-D8 and KGPE-D16, not to mention
  KFSN4-DRE, are currently stuck on coreboot 4.11 in libreboot) - it would be
  too much work to get these boards working again in coreboot master, and the
  code for these boards already work well, so a fork of coreboot 4.11 for
  libreboot and osboot is planned, to backport newer coreboot features whenever
  necessary, and in general keeping the boards building properly (newer GCC
  toolchains will be used, over time). D8/D16 uses AMD AGESA codebase which
  is AMD's own thing, not written at all with coreboot's coding style in mind,
  to the point where the whole thing would have to be re-written to integrate it
  into coreboot again. this is largely a waste of time, so maintaining coreboot
  4.11 is a much better decision (again, AMD's code works very well. it's from
  the time when AMD was actually sharing AGESA source code with coreboot. AGESA
  was AMD's codebase for hardware initialization, and for a time, coreboot was
  bolting it on in its own build system. You can find it under `src/vendorcode/`
  in coreboot 4.11 source code

coreboot 4.11
-------------

* C\_ENVIRONMENTAL\_BOOTBLOCK is now preferred, instead of the old romcc
  bootblocks. i945, x4x and gm45 platforms have been adapted to use this (this
  affects almost every libreboot target)
* vboot support for gm45 (but libreboot currently doesn't do anything with it)
* Generally, this was another "code cleanup release" of coreboot. A lot of code
  in coreboot was re-factored

coreboot 4.10
-------------

* nothing noteworthy to libreboot, this was mainly a "code cleanup" release in
  coreboot

coreboot 4.9
------------

* Less repetition in the codebase, for similar boards. For example, X200
  thinkpad is its own codebase, and similar boards are "variants" where only
  the differences are implemented (e.g. X301 thinkpad support). similar for
  T400 thinkpad: T500, W500, R500 etc are implemented as variants nowadays
* Intel X4X platform: Add DDR3 support (raminit)
* 

coreboot 4.8
------------

* Improved VBT implementations in libgfxinit
* i945 (X60/T60/macbook21 etc): native video initialization is now skipped
  during resume from S3 (sleep mode). This means that the OS needs to handle it
  now. The i915 video driver in the linux kernel can handle it, but at the time
  of this coreboot release, the framebuffer driver couldn't. this will need to
  be tested!

coreboot 4.7
------------

* GM45 laptops: set display backlight PWM correctly
* Add romstage timings
* raminit: improved compatibility with mixed DIMMs
* Intel X4X: fix booting with FSB800 DDR667 combination
* Intel X4X: Rework ram DQZ receiver enable training sequence
* Intel X4X: Rework and fixSPD reading and decoding
* Intel X4X: Allow external GPU to take VGA cycles

coreboot 4.6
------------

* fix buggy S3 suspend/resume on Gigabyte GA-G41M-ES2L mainboard, and fix bugs
  in raminit
* intel x4x/gm45/i945 boards: improvements/fixes to raminit and native video 
  initialization
* all platforms: video init re-written. old code was in C, new code is in Ada,
  with many improvements in general
* nb/i945/raminit: Add fixes for 800MHz & 1067MHz FSB CPUs
* nb/intel/gm45: Fix panel-power-sequence clock divisor


Detailed coreboot git logs
==========================

The following are lists of changes in coreboot 4.14, versus coreboot revisions
used in various platforms/mainboards from Libreboot 20160907. These lists are
mostly pulled directly from the coreboot git log.

These logs are made by copying the coreboot git log, on specific directories
such as directories for mainboards, or entire platforms, in the git log of
coreboot.

These changes will be split into distinct categories:

* Northbridge changes
* Southbridge changes
* Board-specific changes

There are many other aspects of coreboot that can be shown here, but it's not
useful to list all of them. Listing just the platform/board changes gives an
excellent picture overall.

Northbridge changes
-------------------

For all intents and purposes, the northbridge and southbridge code *is* the
platform for a given board, and then you have board specific code.

### git log src/northbridge/intel/i945/

This mainly benefits the ThinkPad X60, T60, Macbook2,1, Macbook1,1 and other
i945 hardware that Libreboot supports.

````
* 88dcb3179b src: Retype option API to use unsigned integers
* c8116f6ea0 nb/intel: Don't select VBOOT_SEPARATE_VERSTAGE
* f9c939029b nb/intel: Use get_int_option()
* 1d4044ae88 nb/intel/i945: Use new fixed BAR accessors
* e97a66d371 nb/intel/i945/raminit.c: Replace `DIMM0`
* a60b42a26a nb/intel/i945: Refactor `dump_spd_registers` function
* b238caaaca device/device.c: Rename .disable to .vga_disable
* 98f7d60d97 nb/intel/i945: Use UPMC4 macro
* 030d338bb2 nb/intel: Add missing <types.h>
* 8f20b12c95 nb/i945/raminit.c: Don't hard code 'bool integrated_graphics'
* 6f35c53bbb src/nb: Remove unused <console/console.h>
* 4299cb4829 nb/intel/i945: Use common {DMI,EP,MCH}BAR accessors
* b70ff52b83 intel: Define `RCBA_LENGTH` in Kconfig and use it
* 6e732d34a0 intel: Turn `DEFAULT_RCBA` into a Kconfig symbol
* 37cae54034 nb/intel/x/bootblock.c Revert `include <arch/pci_io_cfg.h>`
* 00b5f53361 treewide [Kconfig]: Remove useless comment
* 487c1a24f5 nb/intel/i945/bootblock.c: include <arch/pci_io_cfg.h>
* 9b04f56d4a nb/intel/i945: Drop casts from DEFAULT_{MCH,DMI}BAR
* a6b0922aa1 nb/intel/i945: Define and use MMCONF_BUS_NUMBER
* 7d638784a2 device/Kconfig: Declare MMCONF symbols' type once
* 15ef9b6513 nb/intel/i945/northbridge.c: Reserve upper part of lower memory
* a6e4afc1cb nb/intel/i945/northbridge.c: Improve readability
* c6589aefc1 drivers/intel/gma: Include gfx.asl by default for all platforms...
* 8b56c8c6b2 drivers: Replace set_vbe_mode_info_valid
* 02a23b510c nb/intel/i945: Introduce memmap.h
* 92f46aaac7 src: Include <arch/io.h> when appropriate
* e298391337 nb/intel/i945/acpi: Convert i945.asl to ASL 2.0 syntax
* dddd1cc691 src/northbridge: Drop unneeded empty lines
* 4a2f08c846 nb/intel/i945: Deduplicate PCIEXBAR decoding
* cff4d1649f nb/intel/i945: Refactor `get_pcie_bar`
* c96292492c nb/intel/i945/gma.c: Remove extra indentation
* f48acbda7b src: Change BOOL CONFIG_ to CONFIG() in comments & strings
* 3580d816e6 nb/intel/i945: Put names to northbridge PCI devices
* 81c9c275e6 nb/intel/i945: Drop dead code
* f67bf49ead nb/intel/i945: Use ASL 2.0 syntax
* 837141fa56 nb/intel/i945/acpi: Tidy up comments and cosmetics
* 1a1b04ea51 device/smbus_host: Declare common early SMBus prototypes
* f3973bd4cf i945 boards: Factor out MAX_CPUS
* 22aeed307d nb/intel/i945/rcven.c: Correct comment
* 304925714d nb/intel/i945: Clean up raminit coding style
* e3c68d2e1b nb/intel/i945: Use PCI bitwise ops
* 1fc0edd9fe src: Use pci_dev_ops_pci where applicable
* dd59762729 intel/gma: Only enable bus mastering if we are going to use it
* dfdf102000 intel/gma: Don't bluntly enable I/O
* f2a0be235c drivers/intel/gma: Move IGD OpRegion to CBMEM
* 7cf96aeeb7 northbridge/intel/i945: Mark legacy VGA memory as reserved
* c4b70276ed src: Remove leading blank lines from SPDX header
* 6b5bc77c9b treewide: Remove "this file is part of" lines
* c49d7a3e63 src/: Replace GPL boilerplate with SPDX headers
* 36787b0e7b northbridge/*/Kconfig: Replace GPLv2 long form headers with SPDX header
* f49f4d48ba nb/intel/i945/memmap: Convert to 96 characters line length
* 76cedd2c29 acpi: Move ACPI table support out of arch/x86 (3/5)
* 7536a398e9 device: Constify struct device * parameter to acpi_fill_ssdt()
* 0f007d8ceb device: Constify struct device * parameter to write_acpi_tables
* 48d5b8d463 nb/intel/i945: Add vboot support
* 3dff32c804 nb/i945: Improve code formatting
* 2f8ba69b0e Replace DEVICE_NOOP with noop_(set|read)_resources
* a461b694a6 Drop unnecessary DEVICE_NOOP entries
* 961658f3dc nb/intel/i945: Use 'const' to set pci_devfn_t statically
* 4b42983c7a src/northbridge: Use SPDX for GPL-2.0-only files
* deeccbf4e9 Drop explicit NULL initializations from `device_operations`
* fd054bc7d4 nb/intel/i945: Simplify GMA SSDT generator
* 68680dd7cd Trim `.acpi_fill_ssdt_generator` and `.acpi_inject_dsdt_generator`
* 95cdd9f21b nb/intel/i945: Make some cosmetic changes
* f3f36faf35 src (minus soc and mainboard): Remove copyright notices
* b4d9f229d4 nb/intel/i945/raminit: Simplify if condition
* d789b658f7 nb/intel/i945/raminit: Use boolean type for helper variables
* 842dd3328d nb/intel/i945/raminit: Remove space for correct alignment
* 8273e13a11 intel/i945: Call fixup_i945_errata() only for mobile version
* 3cd4327ad9 src/nb: Use 'print("%s...", __func__)'
* 8247cc3328 northbridge: Remove unused include <device/pci.h>
* 2119d0ba43 treewide: Capitalize 'CMOS'
* ef90609cbb src: capitalize 'RAM'
* e0cd2eb6d3 nb/intel/i945: Use boot path macros
* 7adc370dc7 intel/{i945,pineview},i82801gx: Move enable_smbus() call
* 0c9630eeff nb/intel/{i945,sandybridge}/bootblock.c: Fix typo
* bd65985a63 nb/intel/{i945,x4x,pineview}: Remove wrapper spd_read_byte()
* cbf9571588 drivers/pc80/rtc: Separate {get|set}_option() prototypes
* dc987fecce src/northbridge: Remove unused <stdlib.h>
* de64078102 bootblock: Provide some common prototypes
* 442fb05acf nb/{haswell,i945,sandybridge}: Drop outdated comment
* 13746076e9 mainboard/(i945,ich7): Remove commented RCBA32(0x341c) code
* 8cb5ea7879 nb/i945: Fix typo
* c05b1a66b3 Kconfig: Drop the C_ENVIRONMENT_BOOTBLOCK symbol
* c583920a74 nb/intel/i945: Initialize console in bootblock
* e27c013f39 nb/intel/i945: Move to C_ENVIRONMENT_BOOTBLOCK
* dc584c3f22 nb/intel/i945: Move boilerplate romstage to a common location
* 399b6c11ef sb/intel/i82801gx: Add common early code
* b236352281 sb/intel/i82801gx: Add a function to set up BAR
* 4ec67fc82c nb/intel: Use defined DEFAULT_RCBA
* 340e4b8090 lib/cbmem_top: Add a common cbmem_top implementation
* c7783a39f8 nb/intel: Remove unused 'barrier()'
* fcdb03358d acpi: Drop wrong _ADR objects for PCI host bridges
* f9891c8b46 kontron/986lcd-m,roda/rk886ex: Drop secondary PCI reset
* ad787e18e0 intel/i945,i82801gx: Refactor early PCI bridge reset
* 2647b6f9ba intel/i945: Define peg_plugin for potential add-on PCIe card
* 9137cbd5e4 intel/i945: Delay bridge VGA IO enable to ramstage
* 444d2af9a9 intel/i945: Define p2peg for PCIe x16 slot
* df128a55b1 intel/pci: Utilise pci_def.h for PCI_BRIDGE_CONTROL
* e39becf521 intel/cpu: Switch older models to TSC_MONOTONIC_TIMER
* 10348399a6 {i945,i82801gx}: Remove unneeded include <cpu/x86/cache.h>
* 1e3d16e8d1 nb/i945: Remove unused include <cpu/cpu.h>
* d53fd704f2 intel/smm/gen1: Use smm_subregion()
* cd7a70f487 soc/intel: Use common romstage code
* a963acdcc7 arch/x86: Add <arch/romstage.h>
* f091f4daf7 intel/smm/gen1: Rename header file
* 544878b563 arch/x86: Add postcar_frame_common_mtrrs()
* 5bc641afeb cpu/intel: Refactor platform_enter_postcar()
* b3267e002e cpu/intel: Replace bsp_init_and_start_aps()
* 0f5e01a962 arch/x86: Flip option NO_CAR_GLOBAL_MIGRATION
* 9fc12e0d4e arch/x86: Enable POSTCAR_CONSOLE by default
* 0a4457ff44 lib/stage_cache: Refactor Kconfig options
* fe481eb3e5 northbridge/intel: Rename ram_calc.c to memmap.c
* bccd2b6c49 intel/i945,gm45,pineview,x4x: Fix stage cache location
* aba8fb1158 intel/i945,gm45,pineview,x4x: Move stage cache support function
* 8881d57531 nb/i945/gma: Store vga_disable if MAINBOARD_DO_NATIVE_VGA_INIT
* 4593d66a20 nb/i945: Fix gate graphics hardware for frequency change
* 7fbed223c7 intel/i945: Fix udelay() prototypes
* 8abf66e4e0 cpu/x86: Flip SMM_TSEG default
* 6e2d0c1b90 arch/x86: Adjust size of postcar stack
* 3bf4e28fb8 nb/i945: Drop CHANNEL_XOR_RANDOMIZATION selection
* 51401c3050 src/northbridge: Add missing 'include <types.h>'
* 686b539949 i945: Add device identification D2:F1
* 274dabd7a0 src/northbridge: Remove unneeded include <arch/io.h>
* 32b9a99e16 nb/intel/i945: Use macro instead of magic number
* 45b824d694 src: Remove unused include <halt.h>
* 5db9871a5e ich7/i945: Use system_reset()
* 01912201a4 nb/intel/i945: Check if interleaved even if rank #4 size is zero
* 420d7e009d ich7/i945: Use full_reset()
* b217baa4ee nb/intel/i945: Fix ich7_setup_root_complex_topology
* f74f6cbde5 nb/intel/{gm45,i945,x4x}: Correct array bounds checks
* 5d1f9a0096 Fix up remaining boolean uses of CONFIG_XXX to CONFIG(XXX)
* 346d201d73 nb/intel/i945: Use DEBUG_RAM_SETUP
* 4a0f07166f {northbridge, soc, southbridge}/intel: Make use of pci_dev_set_subsystem()
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* 3449fafec3 nb/intel/i945: Remove 2nd write on SLOTCAP (R/WO)
* e183429bd2 nb/intel/stage_cache.c: Drop unnecessary includes
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 89989cf61f src: Drop unused include <arch/acpi.h>
* 503d3247e4 Remove DEFAULT_PCIEXBAR alias
* 13f66507af device/mmio.h: Add include file for MMIO ops
* 065857ee7f arch/io.h: Drop unnecessary include
* 2796b242b2 nb/intel/i945: Remove redundant use of ACPI offset operator
* f1b58b7835 device/pci: Fix PCI accessor headers
* c01a505282 sb/intel/common: Rename i2c_block_read() to i2c_eeprom_read()
* d3fa7fa5d8 nb/intel/i945: Fix typo on DMIBAR32(0x334)
* 3452eca26d nb/intel/i945: Remove initialization already done at bootblock
* dce3927f20 nb/intel/i945: Put stage cache in TSEG
* 1a9034cca6 i945,ICH7: Write on RPFN only once
* f266932836 nb/intel/i945: Use parallel MP init
* b31aee9973 nb/intel/{i945,pineview}: Remove unused function
* c2c1dc9c76 {mb,nb,soc/fsp_baytrail}: Get rid of dump_mem()
* 4e008c699b nb/intel/i945: Reduce pcidev_on_root() calls
* c70eed1e62 device: Use pcidev_on_root()
* 1f4cb326fa northbridge: Remove useless include <device/pci_ids.h>
* cf3076eff1 nb/intel/i945: Use common SMM_TSEG code
* a6634f1f78 nb/intel/i945: Add and use defines for registers of device 0:01.0
* a9068aa4e0 nb/intel/i945/early_init.c: Correct the PEG_LC address of DEV(0:01.0)
* 68aed91eb9 intel/i945: Fix booting on a dual channel configuration
* 8a5283ab1b src: Remove unneeded include <cbmem.h>
* f765d4f275 src: Remove unneeded include <lib.h>
* e9a0130879 src: Remove unneeded include <console/console.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* 771328f7df intel/i945: add timestamps in romstage
* 2a1c4302d1 nb/intel/i945: Remove irrelevant conditional statement
* d522db048b nb/intel/*: Use 2M TSEG instead of 8M on pre-arrandale hardware
* 17ad4598e9 nb/intel/*: Account for cbmem_top alignment
* 794f56bdf5 nb/intel/i945: Fix domain resources
* d44221f9c8 Move compiler.h to commonlib
* ef20ecc92b nb/intel/{gm45,i945,pineview}: Use macro instead of GGC address
* e6c8f7ec20 nb/intel/*/gma.c: Skip NGI when VGA decode is not enabled
* 1faa11ed39 Fix PCI ACPI _OSC methods
* 64f6b71af5 src/northbridge: Fix typo
* a4fc7bef7f nb/i945/raminit: Correct C0DRAMW & C1DRAMW for 4 DIMMs
* a8a9f34e9b sb/intel/i82801{g,j}x: Automatically generate ACPI PIRQ tables
* fe2510764d nb/intel/i945: Remove dead code
* e07df9d783 nb/intel/i945: Enable and allocate 8M for TSEG
* f6d14773b2 nb/intel/i945: Add a common function to compute TSEG size
* 730df3cc43 arch/x86: Make RELOCATABLE_RAMSTAGE the default
* 2dcc3a5c68 nb/intel/i945: Switch to POSTCAR_STAGE
* 089b9089c1 nb/intel: Use postcar_frame_add_romcache()
* f369e60329 northbridge/intel: Remove unneeded includes
* 654cc2fe10 {cpu,drivers,nb,soc}/intel: Use CACHE_ROM_BASE where appropriate
* 5474eb15ef src/northbridge: Add and update license headers
* 9749a85cb0 nb/intel/i945/raminit.c: Remove not necessary braces {}
* 96184e9f2d nb/intel/i945/bootblock.c: Correct comment
* 3de303179a {mb,nb,soc}: Remove references to pci_bus_default_ops()
* 658a9348f0 nb/intel/i945: Get rid of device_t
* 5e7ad65f6f nb/intel/i945/gma: Skip native VGA init for ACPI S3 resume
* b23833fb29 nb/intel/i945/gma: Factor out code to new `gma_ngi()`
* c8412ed1f9 nb/intel/i945/gma: Log native graphics init in level INFO
* 82683c0d6d nb/intel/i945/gma: Fix aligment of equal sign
* bcf9a0a7ab nb/intel/i945/gma: Log configured VGA mode
* fc31e44e47 device/ddr2,ddr3: Rename and move a few things
* 8324d87bf4 nb/intel/i945: Use ESMRAMC instead of 0x9e
* 242ea84b01 intel: Replace msr(0x198) with msr(IA32_PERF_STATUS)
* f6aa7d94c8 nb/intel/*/gma: Port ACPI opregion to older platforms
* 5661945c3b nb/i945/raminit: Don't fall back to smbus read on failed SPD decode
* 105e368247 nb/intel/i945: Add space after comma in log message
* 0ab4904481 nb/i945/raminit: Use common ddr2 decode functions
* 5c84f87fcf nb/intel/i945/early_init.c: Replace numbers with macros
* 5613b175de nb/intel/i945/raminit.c: Replace numbers with macros
* 0b80bd1cf4 nb/intel/i945: Clear timeout bits after disabling watchdog
* 250272340b nb/intel/i945/raminit.c: Refactor tRD selection
* 8da2286885 nb/intel/*/gma.c: Use macros for GMBUS numbers
* 6a00113de8 Rename __attribute__((packed)) --> __packed
* 8868fc616c nb/intel/i945/gma.c: Remove redefined "DISPPLANE_BGRX888"
* 692e7df6c1 nb/intel/i945/gma.c: Add whitespace around '<<'
* 33232604a7 nb/intel: add IS_ENABLED() around Kconfig symbol references
* 6d8266b91d Kconfig: Add choice of framebuffer mode
* 7971582ec4 Kconfig: Introduce HAVE_(VBE_)LINEAR_FRAMEBUFFER
* ce642f08b9 Kconfig: Rework MAINBOARD_HAS_NATIVE_VGA_INIT_TEXTMODECFG
* c5fba2c17c nb/intel/i945: Define and use a default MMCONF_BASE_ADDRESS
* 2f6b52e3a0 nb/intel/i945: Fix PEG port on 945gc
* 46cf5c29b3 nb/intel/i945: Move INTEL_EDID
* b45bbb253f nb/intel/i945: Fix SPD dumps
* 70a8e34853 nb/intel/i945: Fix errors found by checkpatch.pl
* 8e079000dc nb/i945/gma.c: Refactor panel setup
* 44a3066015 nb/i945: Clean "Programming DLL Timings" function
* 308aefffc6 nb/intel/i945: Fix sdram_enhanced_addressing_mode for channel1
* bce7e33f23 intel/i945: Fix up whitespace and indentation
* 39bfc6cb13 nb/i945/raminit.c: Fix dll timings on 945GC
* 75da1fb2ba nb/i945/raminit: sdram_set_channel_mode Test if DIMM slot 3 is populated
* d81078d944 nb/i945/gma.c: Remove writes to FIFO Watermark registers
* 85cfddb4b4 nb/i945/gma.c: Change name and type of mmiobase in functions argument
* 561bebfbaa drivers/intel/gma/vbt: Add Kconfig symbol for SSC ref
* 186e9c4313 nb/i945/raminit.c: Use Makefile.inc instead of '#include rcven.c'
* 1853781748 nb/intel/945gc: Hardcode the integrated graphic frequencies
* 6d0c65ebc6 nb/intel/*/northbridge.c: Remove #include <device/hypertransport.h>
* 62902ca45d sb/ich7: Use common/gpio.h to set up GPIOs
* f7acdf82cb nb/i945/early_init.c: Add FSB800 and 1067 to Egress Port Virtual Channel
* 885c289bba nb/intel/i945: Make pci_mmio_size a devicetree parameter
* 122e5bc6b1 intel i945 gm45 x4x: Switch to RELOCATABLE_RAMSTAGE
* 8183025be9 intel/i945: Use romstage_handoff for S3
* 823020d56b intel i945 gm45 x4x post-car: Use postcar_frame for MTRR setup
* 811932a614 intel i945 gm45 x4x: Apply cbmem_top() alignment
* 27198ac2e3 MMCONF_SUPPORT: Drop redundant logging
* e25b5ef39f MMCONF_SUPPORT: Consolidate resource registration
* 3d15e10aef MMCONF_SUPPORT: Flip default to enabled
* 6f66f414a0 PCI ops: MMCONF_SUPPORT_DEFAULT is required
* d9e654321c nb/i945/raminit.h: Fix fsb_frequency's comment
* 533a3859c8 nb/intel/i945/gma: Declare count variable outside 'for' loop
* bac0fad408 Remove explicit select MMCONF_SUPPORT
* 128c104c4d nb/intel: Fix some spelling mistakes in comments and strings
* a4ffe9dda0 intel post-car: Separate files for setup_stack_and_mtrrs()
* 5db945062c nb/intel/i945/early_init.c: Add DDR2-667 detection for 945GC
* 6372a0eef1 nb/intel/i945/early_init.c: Use "IS_ENABLED(CONFIG_ ....)"
* f3f4bea6b5 nb/i945/gma.c: use an if else statement for use of native init
* d0e0118be8 nb/i945/gma.c: Do not try to load vbios when selecting native init
* a299345f4a nb/intel/i945/gma.c: Homogenize code for PCI IDs.
* 04be6b5949 nb/intel/i945: Add PCI id for I945GC
* c057a0611b nb/i945/gma.c: Set the MSAC register correctly
* a6b0fc9d7c nb/i945/Kconfig: select the correct VGA_BIOS_ID for 945GC
* 9c5fc62f96 nb/i945/gma.c: use IS_ENABLED instead of #if, #endif
* 8b6df62fc2 nb/i945/raminit: Add fix for clock crossing for 800MHz FSB CPU
* e189761603 nb/i945/raminit: Add fix for 1067MHz FSB CPUs
* 75f9131453 nb/i945,gm45,x4x/gma.c: fix unsigned arithmetics
* c8c73a68be nb/i945/gma.c: correct VSYNC end offset
* 62f4dad88d i945/gma.c: Only init LVDS if it is detected
* 7141ff3b9f nb/intel/*/graphic_init: use sizeof instead of hardcoding edid size
* 626f8c8440 i945/raminit.c: correctly write CLKCFG for 945GC
* c9848a82e2 intel/i945: Use "IS_ENABLED" for fsbclk & memclk
* 7db506c3dd src/northbridge: Remove unnecessary whitespace
* 0b9ecb5831 mb/intel/d945gclf: Allow use of native graphic init
* b59bcb2d5f i945/gma.c: add native VGA init
* 7dfc8a5ebd i945/gma.c: use linux code to calculate divisors
* 333176e5d3 i945/gma.c: Generate fake VBT
* 0a15fe9299 northbridge/intel/i945: Add space around operators
* a1e1e5c7e3 i945.h: fix #include path
* 6e8b3c1110 src/northbridge: Improve code formatting
* 70f5b825c6 northbridge/intel/i945: transition away from device_t
* 12df950583 northbridge/intel: Add required space before opening parenthesis '('
* 874a8f961f i945: Enable changing VRAM size
* 38424987c6 src/northbridge: Remove unnecessary whitespace before "\n" and "\t"
* 15279a9696 src/northbridge: Capitalize CPU, RAM and ROM
* e6b5a4f5f0 intel/i945: Use common ACPI S3 recovery
* a969ed34db Move definitions of HIGH_MEMORY_SAVE
* c7a1a3e994 northbridge/i945/gma: Re-enable NVRAM tft_brightness
````

### git log src/northbridge/intel/pineview/

This benefits the Intel D510MO / D410PT mainboards, and any other pineview
board that Libreboot has added or will add.

````
* 88dcb3179b src: Retype option API to use unsigned integers
* f9c939029b nb/intel: Use get_int_option()
* 11cabea60d nb/intel/pineview: Replace remaining BAR accessors
* 0aeaee7d9d nb/intel/pineview: Use new fixed BAR accessors
* 7720f1da36 nb/intel: Factor out remaining MCHBAR macros
* 07ccc8d9cd nb/intel/pineview: Correct COMP register write
* e7a68ec05a nb/intel/pineview/raminit.c: Correct clkset1 programming
* 7ee1c47cba nb/intel/pineview: Correct HICLKGTCTL write
* 7383318856 nb/intel/pineview: Drop MCHBAR macro from DMIBAR access
* ff254ea60b nb/intel/pineview: Drop unused `GPIO32` macro
* 030d338bb2 nb/intel: Add missing <types.h>
* 24b1d8af06 nb/intel/pineview: Use common {DMI,EP,MCH}BAR accessors
* 94eea6fe16 nb/intel/pineview: Rewrite hex values in lowercase
* 896a1f7609 nb/intel/pineview: Delete rude and useless comment
* 12d3768ec5 nb/intel/pineview: Clean up FIXMEs in raminit
* f1f560568b nb/intel/pineview: Guard {MCH,DMI,EP}BAR macros
* b70ff52b83 intel: Define `RCBA_LENGTH` in Kconfig and use it
* 6e732d34a0 intel: Turn `DEFAULT_RCBA` into a Kconfig symbol
* 00b5f53361 treewide [Kconfig]: Remove useless comment
* 1318ab475d nb/intel/pineview: Define and use MMCONF_BUS_NUMBER
* 7d638784a2 device/Kconfig: Declare MMCONF symbols' type once
* 4338ae3194 nb/intel/pineview/northbridge.c: Fix overlapping resources
* 95a1142019 nb/intel/pineview/northbridge.c: Improve readability
* eef4343a9f nb/intel/pineview: Extract HPET setup and delay function
* c6589aefc1 drivers/intel/gma: Include gfx.asl by default for all platforms...
* baf27dbaeb cbfs: Enable CBFS mcache on most chipsets
* ac12976f0c nb/intel/pineview: Fix clearing memory
* 8f0b3e546a nb/intel/pineview: Place raminit definitions in raminit.h
* dddd1cc691 src/northbridge: Drop unneeded empty lines
* 6549661b9c nb/intel/pineview: Guard DMIBAR/EPBAR macro parameters
* d25e2f6c80 nb/intel/pineview/iomap.h: Rename to memmap.h
* a4dd33cc8b src: Use PCI_BASE_ADDRESS_* macros instead of magic numbers
* 90de10c17a nb/intel/pineview: Refactor `decode_pcie_bar`
* 653d8717ba nb/intel/pineview: Change signature of `decode_pciebar`
* 69356489fe nb/intel/pineview: Use `MiB` definition
* aaf5b09a5a nb/intel/pineview: Remove dead assignments
* 0a760cd05b nb/intel/pineview/hostbridge_regs.h: Clean up registers
* 0ddc2459bc nb/intel/pineview: Put host bridge registers into its own file
* 5f201ef866 nb/intel/pineview/acpi: Remove unmatched comment start
* bfc80098da nb/intel/pineview: Convert to ASL 2.0 syntax
* 4d962b2ecf nb/intel/pineview: Tidy up comments and cosmetics
* ec5b71ae30 nb/intel/pineview: Drop undefined function declaration
* 1a1b04ea51 device/smbus_host: Declare common early SMBus prototypes
* 26766fd85d nb/intel/pineview: Use PCI bitwise ops
* 1fc0edd9fe src: Use pci_dev_ops_pci where applicable
* dd59762729 intel/gma: Only enable bus mastering if we are going to use it
* dfdf102000 intel/gma: Don't bluntly enable I/O
* f2a0be235c drivers/intel/gma: Move IGD OpRegion to CBMEM
* 5ac723e5a4 nb/intel: Fix 16-bit read/write PCI_COMMAND register
* c4b70276ed src: Remove leading blank lines from SPDX header
* 6b5bc77c9b treewide: Remove "this file is part of" lines
* c49d7a3e63 src/: Replace GPL boilerplate with SPDX headers
* 36787b0e7b northbridge/*/Kconfig: Replace GPLv2 long form headers with SPDX header
* ac9590395e treewide: replace GPLv2 long form headers with SPDX header
* 02363b5e46 treewide: Move "is part of the coreboot project" line in its own comment
* 76cedd2c29 acpi: Move ACPI table support out of arch/x86 (3/5)
* 2d7173d462 src: Remove unused 'include <cpu/x86/cache.h>'
* 0f007d8ceb device: Constify struct device * parameter to write_acpi_tables
* 2f8ba69b0e Replace DEVICE_NOOP with noop_(set|read)_resources
* a461b694a6 Drop unnecessary DEVICE_NOOP entries
* 4b42983c7a src/northbridge: Use SPDX for GPL-2.0-only files
* deeccbf4e9 Drop explicit NULL initializations from `device_operations`
* affd771ba3 nb/intel/pineview: drop intel_gma_get_controller_info()
* 68680dd7cd Trim `.acpi_fill_ssdt_generator` and `.acpi_inject_dsdt_generator`
* f3f36faf35 src (minus soc and mainboard): Remove copyright notices
* 39ff703aa9 nb/intel/pineview: Clean up code and comments
* 8247cc3328 northbridge: Remove unused include <device/pci.h>
* 2119d0ba43 treewide: Capitalize 'CMOS'
* ef90609cbb src: capitalize 'RAM'
* 7adc370dc7 intel/{i945,pineview},i82801gx: Move enable_smbus() call
* bd65985a63 nb/intel/{i945,x4x,pineview}: Remove wrapper spd_read_byte()
* cbf9571588 drivers/pc80/rtc: Separate {get|set}_option() prototypes
* 1f66809111 src: Remove unneeded 'include <arch/io.h>'
* 748caed022 northbridge: Add missing include <device/pci_def.h>
* f97c1c9d86 {nb,soc}: Replace min/max() with MIN/MAX()
* dc987fecce src/northbridge: Remove unused <stdlib.h>
* de64078102 bootblock: Provide some common prototypes
* c05b1a66b3 Kconfig: Drop the C_ENVIRONMENT_BOOTBLOCK symbol
* 399b6c11ef sb/intel/i82801gx: Add common early code
* b236352281 sb/intel/i82801gx: Add a function to set up BAR
* 4ec67fc82c nb/intel: Use defined DEFAULT_RCBA
* 340e4b8090 lib/cbmem_top: Add a common cbmem_top implementation
* 34715df801 src: Remove unused '#include <cpu/cpu.h>'
* fcdb03358d acpi: Drop wrong _ADR objects for PCI host bridges
* 2437fe9dfa sb/intel/i82801gx: Move CIR init to a common place
* 246334390b nb/intel/pineview/Kconfig: Remove romcc leftover
* c73c92368f sb/intel/nm10: Fix enabling HPET
* df128a55b1 intel/pci: Utilise pci_def.h for PCI_BRIDGE_CONTROL
* e39becf521 intel/cpu: Switch older models to TSC_MONOTONIC_TIMER
* d53fd704f2 intel/smm/gen1: Use smm_subregion()
* cd7a70f487 soc/intel: Use common romstage code
* a963acdcc7 arch/x86: Add <arch/romstage.h>
* 157b189f6b cpu/intel: Enter romstage without BIST
* f091f4daf7 intel/smm/gen1: Rename header file
* 544878b563 arch/x86: Add postcar_frame_common_mtrrs()
* 5bc641afeb cpu/intel: Refactor platform_enter_postcar()
* b3267e002e cpu/intel: Replace bsp_init_and_start_aps()
* 0f5e01a962 arch/x86: Flip option NO_CAR_GLOBAL_MIGRATION
* 9fc12e0d4e arch/x86: Enable POSTCAR_CONSOLE by default
* 0a4457ff44 lib/stage_cache: Refactor Kconfig options
* fe481eb3e5 northbridge/intel: Rename ram_calc.c to memmap.c
* bccd2b6c49 intel/i945,gm45,pineview,x4x: Fix stage cache location
* aba8fb1158 intel/i945,gm45,pineview,x4x: Move stage cache support function
* 78107939de nb/intel/pineview: Remove dead code in switch
* 8abf66e4e0 cpu/x86: Flip SMM_TSEG default
* 6e2d0c1b90 arch/x86: Adjust size of postcar stack
* d10680bbbf nb/intel/pineview: Remove unused code
* af159d4416 nb/intel/pineview/raminit.c: Remove variable set but not used
* 51401c3050 src/northbridge: Add missing 'include <types.h>'
* 82882288c9 nb/intel/pineview: Use MTRR as a proxy for proper reset
* 99e578e3c1 nb/intel/pineview: Move to C_ENVIRONMENT_BOOTBLOCK
* f00d37342c nb/intel/pineview/early_init.c: Remove variable set but not used
* 274dabd7a0 src/northbridge: Remove unneeded include <arch/io.h>
* 1bc7b6e135 {gm45,pineview,sandybridge,x4x}: Use {full,system}_reset() function
* 45b824d694 src: Remove unused include <halt.h>
* 363b77177e nb/intel/pineview: Use system_reset()
* 0f49dd26ad src/northbridge/intel: Remove unused variables
* 425e75a2db sb/intel/i82801gx: Use SOUTHBRIDGE_INTEL_COMMON_PMCLIB
* b70c77691b nb/intel/pineview: Correct lsbpos(0) and msbpos(0)
* f5cf60f25b Move calls to quick_ram_check() before CBMEM init
* 4a0f07166f {northbridge, soc, southbridge}/intel: Make use of pci_dev_set_subsystem()
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* 74aa99a543 src: Drop unused '#include <halt.h>'
* e183429bd2 nb/intel/stage_cache.c: Drop unnecessary includes
* 484efffa58 {mb,nb/pineview}/*.asl: Remove unneeded include i82801gx.h
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 503d3247e4 Remove DEFAULT_PCIEXBAR alias
* 13f66507af device/mmio.h: Add include file for MMIO ops
* 065857ee7f arch/io.h: Drop unnecessary include
* bdaec07a85 arch/io.h: Add missing includes
* f1b58b7835 device/pci: Fix PCI accessor headers
* c01a505282 sb/intel/common: Rename i2c_block_read() to i2c_eeprom_read()
* 20f71369d9 nb/intel/pineview: Put stage cache in TSEG
* 84fdda3812 nb/intel/pineview: Use parallel MP init
* da44e34743 nb/intel/pineview: Select 1M TSEG
* c6ff1ac29e nb/intel/pineview: Move the boilerplate mainboard_romstage_entry
* b31aee9973 nb/intel/{i945,pineview}: Remove unused function
* c70eed1e62 device: Use pcidev_on_root()
* 66b462dd4f nb/intel/pineview/raminit.c: Remove unused variable
* 1f4cb326fa northbridge: Remove useless include <device/pci_ids.h>
* 586f24dab4 northbridge: Remove unneeded include <pc80/mc146818rtc.h>
* de6bda63d9 nb/intel/pineview: Use common code for SMM in TSEG
* d522db048b nb/intel/*: Use 2M TSEG instead of 8M on pre-arrandale hardware
* 17ad4598e9 nb/intel/*: Account for cbmem_top alignment
* a342f3937e src: Remove unneeded whitespace
* ef20ecc92b nb/intel/{gm45,i945,pineview}: Use macro instead of GGC address
* b60920df52 northbridge: Use 'unsigned int' to bare use of 'unsigned'
* e6c8f7ec20 nb/intel/*/gma.c: Skip NGI when VGA decode is not enabled
* eb6f2f55ff nb/intel/pineview: Use a common MMCONF_BASE_ADDRESS
* 015339fbf0 nb/intel/pineview: Use the correct address for the RCVEN strobe
* 1f6369e333 nb/intel/pineview: Use i2c block read to fetch SPD
* 3d45000c9c src: Fix typo
* 64f6b71af5 src/northbridge: Fix typo
* 15e1b39e6e nb/intel/pineview: Don't use PCI operations on the pci_domain device
* fd051dc018 src/northbridge: Use "foo *bar" instead of "foo* bar"
* a8a9f34e9b sb/intel/i82801{g,j}x: Automatically generate ACPI PIRQ tables
* 4bdfebd4d8 nb/intel/pineview: Enable and allocate 8M for TSEG
* 730df3cc43 arch/x86: Make RELOCATABLE_RAMSTAGE the default
* aa7cf5597b nb/intel/pineview: Switch to POSTCAR_STAGE
* 089b9089c1 nb/intel: Use postcar_frame_add_romcache()
* f369e60329 northbridge/intel: Remove unneeded includes
* 654cc2fe10 {cpu,drivers,nb,soc}/intel: Use CACHE_ROM_BASE where appropriate
* 5474eb15ef src/northbridge: Add and update license headers
* 3de303179a {mb,nb,soc}: Remove references to pci_bus_default_ops()
* 6275360d56 nb/intel/pineview: Get rid of device_t
* bb98b38b93 nb/intel/pineview: Port ACPI opregion to pineview
* aaebb415d7 nb/intel/pineview: Enable dram remapping
* 5bb27b7815 nb/intel/pineview: Fix typo in DRAM timing computation
* 12a4e98cea nb/intel/pineview/raminit: Refactor timings selection
* 3b633bbf1d cpu/intel/pineview: Include speedstep
* 33232604a7 nb/intel: add IS_ENABLED() around Kconfig symbol references
* 53815e1561 nb/intel/pineview/raminit: Remove very long delays
* 6bf13012c1 nb/intel/pineview/raminit.c: Use static const for lookup tables
* d4ebeaf475 device/Kconfig: Put gfx init methods into a `choice`
* ce642f08b9 Kconfig: Rework MAINBOARD_HAS_NATIVE_VGA_INIT_TEXTMODECFG
* d2ca9d12dc nb/pineview/raminit: Don't do Jedec init on resume from S3
* f6cf3a8f0d nb/intel/pineview: Select RELOCATABLE_RAMSTAGE
* 62e784bd8a nb/intel/pineview: Move to early cbmem
* 00fd3ff507 nb/pineview/raminit: Fix raminit failing on hot reset path
* 097d753980 nb/intel/pineview/raminit: Fix CONFIG_DEBUG_RAM_SETUP=y not compiling
* 2a0e998ec2 nb/intel/pineview: Make preallocated igd memory a cmos parameter
* 6d0c65ebc6 nb/intel/*/northbridge.c: Remove #include <device/hypertransport.h>
* 530f677cdc buildsystem: Drop explicit (k)config.h includes
* 3d15e10aef MMCONF_SUPPORT: Flip default to enabled
* bac0fad408 Remove explicit select MMCONF_SUPPORT
* 128c104c4d nb/intel: Fix some spelling mistakes in comments and strings
* d3284a6977 nb/intel/*/gma.c: remove spaces at the fake vbt generation
* 6e8b3c1110 src/northbridge: Improve code formatting
* 12df950583 northbridge/intel: Add required space before opening parenthesis '('
* 32a38ee85b intel/pineview: Do not use scratchpad register for ACPI S3
* 4dc680aaf1 nb/intel/pineview/northbridge.c: Remove legacy_hole_size_k declaration
* 66fbeaec98 intel/pineview: Don't try to store 34 bits in 32
````

### git log src/northbridge/intel/gm45/

This benefits GM45 ThinkPads in Libreboot e.g. X200, T400, T500, R500, W500 etc

````
* 88dcb3179b src: Retype option API to use unsigned integers
* c8116f6ea0 nb/intel: Don't select VBOOT_SEPARATE_VERSTAGE
* f9c939029b nb/intel: Use get_int_option()
* 3f1f8ef931 nb/intel/gm45: Use new fixed BAR accessors
* 677ac69868 nb/intel/gm45/gm45.h: Guard `CxDRC1_NOTPOP` macro parameters
* 030d338bb2 nb/intel: Add missing <types.h>
* f462b3d379 nb/intel/gm45: Factor out {DMI,EP,MCH}BAR accessors
* b70ff52b83 intel: Define `RCBA_LENGTH` in Kconfig and use it
* 6e732d34a0 intel: Turn `DEFAULT_RCBA` into a Kconfig symbol
* 37cae54034 nb/intel/x/bootblock.c Revert `include <arch/pci_io_cfg.h>`
* 00b5f53361 treewide [Kconfig]: Remove useless comment
* c4d1b47ad9 nb/intel/gm45/bootblock.c: include <arch/pci_io_cfg.h>
* 1ac6f8b804 nb/intel/gm45: Define and use MMCONF_BUS_NUMBER
* 7d638784a2 device/Kconfig: Declare MMCONF symbols' type once
* 58ba83fe74 nb/intel/gm45: Reserve MMIO and firmware memory below 1MiB
* 8e400f0cca Revert "nb/intel/gm45/gm45.h: Remove duplicated include"
* 4537332d64 northbridge/intel/gm45/bootblock.c: Remove repeated word
* 27af8a7e5d nb/intel/gm45/gm45.h: Remove duplicated include
* a93cb11ed6 nb/intel/gm45: Guard macro parameters
* 08ba81b6e4 nb/intel/gm45: Guard `CxDRBy_BOUND_SHIFT` macro parameters
* c6589aefc1 drivers/intel/gma: Include gfx.asl by default for all platforms...
* 2f30e8ca03 nb/intel/gm45: Clean up header handling
* ae2a522827 nb/intel/gm45: Introduce memmap.h
* 3e33be2e69 nb/intel/gm45: Add more DMIBAR/EPBAR registers
* c88a4794c8 nb/intel/gm45: Answer question about conversion stepping A1
* ac4e4b423f nb/intel/gm45/gm45.h: Clean up cosmetics
* 9c2d15ff7f nb/intel/gm45: Drop unused `DEFAULT_HECIBAR` macro
* 3378de12f6 nb/intel/gm45: Drop casts from DEFAULT_{MCHBAR,DMIBAR}
* dddd1cc691 src/northbridge: Drop unneeded empty lines
* c0c951630a nb/intel/gm45: Deduplicate PCIEXBAR decoding
* b9bbed2c41 nb/intel/gm45/northbridge.c: Use `MiB` definition
* b053583a1c nb/intel/gm45: Use PCI bitwise ops
* f48acbda7b src: Change BOOL CONFIG_ to CONFIG() in comments & strings
* c9e42b98ef nb/intel/gm45/acpi/gm45.asl: Drop dead code
* 29cd350c46 nb/intel/gm45: Use ASL 2.0 syntax
* d85d7e2329 nb/intel/gm45: Tidy up comments and cosmetics
* e1a616cf99 sb/intel/i82801ix: Use pmutil.h definitions
* 1a1b04ea51 device/smbus_host: Declare common early SMBus prototypes
* 8ad0a4c0b8 nb/intel/gm45/iommu.c: Fix regression when updating PCI command
* 1fc0edd9fe src: Use pci_dev_ops_pci where applicable
* dd59762729 intel/gma: Only enable bus mastering if we are going to use it
* dfdf102000 intel/gma: Don't bluntly enable I/O
* f2a0be235c drivers/intel/gma: Move IGD OpRegion to CBMEM
* 5ac723e5a4 nb/intel: Fix 16-bit read/write PCI_COMMAND register
* d13bd05b7a nb/intel: Const'ify pci_devfn_t devices
* c4b70276ed src: Remove leading blank lines from SPDX header
* e30c396ffa src: Remove unused '#include <stddef.h>'
* 6b5bc77c9b treewide: Remove "this file is part of" lines
* c49d7a3e63 src/: Replace GPL boilerplate with SPDX headers
* 36787b0e7b northbridge/*/Kconfig: Replace GPLv2 long form headers with SPDX header
* 76cedd2c29 acpi: Move ACPI table support out of arch/x86 (3/5)
* 7536a398e9 device: Constify struct device * parameter to acpi_fill_ssdt()
* 0f007d8ceb device: Constify struct device * parameter to write_acpi_tables
* 2f8ba69b0e Replace DEVICE_NOOP with noop_(set|read)_resources
* a461b694a6 Drop unnecessary DEVICE_NOOP entries
* 4b42983c7a src/northbridge: Use SPDX for GPL-2.0-only files
* deeccbf4e9 Drop explicit NULL initializations from `device_operations`
* e91883f545 nb/intel/gm45: Simplify GMA SSDT generator
* 68680dd7cd Trim `.acpi_fill_ssdt_generator` and `.acpi_inject_dsdt_generator`
* 6343cd846a drivers/intel/gma: fold gma.asl into default_brightness_levels.asl
* 612a867677 drivers/intel/gma/acpi: Add Kconfigs for backlight registers
* f3f36faf35 src (minus soc and mainboard): Remove copyright notices
* 8247cc3328 northbridge: Remove unused include <device/pci.h>
* 2119d0ba43 treewide: Capitalize 'CMOS'
* ef90609cbb src: capitalize 'RAM'
* c9a717ddb0 nb/intel/gm45: Fix typo in console message
* 1cfafe25e3 intel/{gm45,x4x},i82801{ix|jx}: Move enable_smbus() call
* cbf9571588 drivers/pc80/rtc: Separate {get|set}_option() prototypes
* 4a216475f5 src: Remove some romcc workarounds
* 748caed022 northbridge: Add missing include <device/pci_def.h>
* ba9b504ec5 src: Replace min/max() with MIN/MAX()
* dc987fecce src/northbridge: Remove unused <stdlib.h>
* de64078102 bootblock: Provide some common prototypes
* c05b1a66b3 Kconfig: Drop the C_ENVIRONMENT_BOOTBLOCK symbol
* 4ec67fc82c nb/intel: Use defined DEFAULT_RCBA
* ea2bec2c4b nb/intel/gm45: Add VBOOT support
* 340e4b8090 lib/cbmem_top: Add a common cbmem_top implementation
* be9533aba9 nb/intel/gm45: Add C_ENVIRONMENT_BOOTBLOCK support
* 34715df801 src: Remove unused '#include <cpu/cpu.h>'
* 468d02cc82 src/[northbridge,security]: change "unsigned" to "unsigned int"
* fcdb03358d acpi: Drop wrong _ADR objects for PCI host bridges
* 29e53582cc nb/intel/gm45: Don't run graphics init on s3 resume
* 9ed0df4c38 sb/intel/i82801ix: Add common code to set up LPC IO decode ranges
* d7205bebd5 nb,sb/intel: Clean up some __BOOTBLOCK__ and  __SIMPLE_DEVICE__ use
* e39becf521 intel/cpu: Switch older models to TSC_MONOTONIC_TIMER
* d53fd704f2 intel/smm/gen1: Use smm_subregion()
* cd7a70f487 soc/intel: Use common romstage code
* 4a86b3b036 nb/intel/gm45: Call ddr3_calibrate_zq() only for DDR3 :)
* a963acdcc7 arch/x86: Add <arch/romstage.h>
* 157b189f6b cpu/intel: Enter romstage without BIST
* f091f4daf7 intel/smm/gen1: Rename header file
* 544878b563 arch/x86: Add postcar_frame_common_mtrrs()
* 5bc641afeb cpu/intel: Refactor platform_enter_postcar()
* b3267e002e cpu/intel: Replace bsp_init_and_start_aps()
* 08456363f2 nb/intel/gm45: Don't create DMAR tables for disabled IGD
* 15063e8819 nb/intel/gm45/acpi.c: Don't read PCI config to check presence
* 0f5e01a962 arch/x86: Flip option NO_CAR_GLOBAL_MIGRATION
* 9fc12e0d4e arch/x86: Enable POSTCAR_CONSOLE by default
* 0a4457ff44 lib/stage_cache: Refactor Kconfig options
* fe481eb3e5 northbridge/intel: Rename ram_calc.c to memmap.c
* bccd2b6c49 intel/i945,gm45,pineview,x4x: Fix stage cache location
* aba8fb1158 intel/i945,gm45,pineview,x4x: Move stage cache support function
* 8abf66e4e0 cpu/x86: Flip SMM_TSEG default
* 9265f89f4e arch/x86: Avoid HAVE_SMI_HANDLER conditional with smm-class
* 6e2d0c1b90 arch/x86: Adjust size of postcar stack
* 7f9f3d0cf3 northbridge/gm45: document that raminit doesn't support mirrored ranks
* 51401c3050 src/northbridge: Add missing 'include <types.h>'
* 274dabd7a0 src/northbridge: Remove unneeded include <arch/io.h>
* 1bc7b6e135 {gm45,pineview,sandybridge,x4x}: Use {full,system}_reset() function
* ad0b48222f sb/intel/i82801ix: Use SOUTHBRIDGE_INTEL_COMMON_PMCLIB
* f74f6cbde5 nb/intel/{gm45,i945,x4x}: Correct array bounds checks
* bf0970e762 src: Use include <delay.h> when appropriate
* 4a0f07166f {northbridge, soc, southbridge}/intel: Make use of pci_dev_set_subsystem()
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* e183429bd2 nb/intel/stage_cache.c: Drop unnecessary includes
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 89989cf61f src: Drop unused include <arch/acpi.h>
* 503d3247e4 Remove DEFAULT_PCIEXBAR alias
* 13f66507af device/mmio.h: Add include file for MMIO ops
* 065857ee7f arch/io.h: Drop unnecessary include
* f1b58b7835 device/pci: Fix PCI accessor headers
* 0c152cf1bb src: Remove unused include device/pnp_def.h
* 3b0eb602b9 nb/intel/gm45: Use a common romstage
* c3e9ba03b6 nb/intel/gm45: Put stage cache in TSEG
* 6336d4c48d nb/intel/gm45: Use parallel MP init
* 5c29daa150 buildsystem: Promote rules.h to default include
* a6ce5d3faa nb/intel/gm45: Remove the C native graphic init
* e7377556cc device: Use pcidev_path_on_root()
* c70eed1e62 device: Use pcidev_on_root()
* 98a917443e device: Replace ugly cases of dev_find_slot()
* 1f4cb326fa northbridge: Remove useless include <device/pci_ids.h>
* 4d2d171f02 nb/intel/gm45: Make fetching the blc_pwm freq global
* c679b1f333 nb/intel/gm45: Make fetching the blc_pwm freq its own function
* 009518e79b nb/intel/gm45: Correctly cache TSEG
* 6df3b64c77 src: Remove duplicated round up function
* 48fa9225ca nb/intel/gm45/northbridge.c: Check for NULL pointers
* 8a5283ab1b src: Remove unneeded include <cbmem.h>
* e9a0130879 src: Remove unneeded include <console/console.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* f33e835a06 nb/intel/gm45: Use macro instead of magic number
* d522db048b nb/intel/*: Use 2M TSEG instead of 8M on pre-arrandale hardware
* 17ad4598e9 nb/intel/*: Account for cbmem_top alignment
* ef20ecc92b nb/intel/{gm45,i945,pineview}: Use macro instead of GGC address
* b60920df52 northbridge: Use 'unsigned int' to bare use of 'unsigned'
* e6c8f7ec20 nb/intel/*/gma.c: Skip NGI when VGA decode is not enabled
* 3d45000c9c src: Fix typo
* 64f6b71af5 src/northbridge: Fix typo
* 8908931f1e nb/intel/gm45: Don't use PCI operations on the pci_domain device
* aade90e68d nb/intel/gm45: Use common code for SMM in TSEG
* fd051dc018 src/northbridge: Use "foo *bar" instead of "foo* bar"
* 21b71ce66b src/nb: Fix non-local header treated as local
* 7866d497ad arch/x86/acpi: Add DMAR RMRR helper functions
* e798e6a0b9 sb/intel/i82801ix: Use the common ACPI pirq generator
* f2dd0499b6 libgfxinit: Enable G45 support (for GM45/X4X)
* 730df3cc43 arch/x86: Make RELOCATABLE_RAMSTAGE the default
* 3a4edb6ea8 nb/intel/gm45: Switch to POSTCAR_STAGE
* 089b9089c1 nb/intel: Use postcar_frame_add_romcache()
* f369e60329 northbridge/intel: Remove unneeded includes
* 654cc2fe10 {cpu,drivers,nb,soc}/intel: Use CACHE_ROM_BASE where appropriate
* 5474eb15ef src/northbridge: Add and update license headers
* 3de303179a {mb,nb,soc}: Remove references to pci_bus_default_ops()
* 6dcdaaf205 nb/intel/gm45: Get rid of device_t
* 2f828ebb59 nb/intel/gm45/raminit: Use CxDRT*_MCHBAR instead of magic numbers
* 8b76605a4a nb/intel/gm45: Allocate a 8M TSEG region
* b31119a348 nb/intel/gm45: Enable LAPIC monotonic timer
* f6aa7d94c8 nb/intel/*/gma: Port ACPI opregion to older platforms
* ca3e121607 nb/intel/gm45: Remove UMA alignment optimization
* 8da2286885 nb/intel/*/gma.c: Use macros for GMBUS numbers
* d65ff22988 nb/intel/gm45: Don't allow too low values for gfx_uma_size
* 049347fee0 nb/intel/gm45: Add romstage timestamps
* 6d8266b91d Kconfig: Add choice of framebuffer mode
* 7971582ec4 Kconfig: Introduce HAVE_(VBE_)LINEAR_FRAMEBUFFER
* ce642f08b9 Kconfig: Rework MAINBOARD_HAS_NATIVE_VGA_INIT_TEXTMODECFG
* 12e6562289 nb/intel/gm45: Fix raminit with mixed raw card types
* 267d086a08 nb/intel/gm45: Fix some errors/warnings given by checkpatch
* 1dcb2ac199 nb/intel/gm45: Define and use default MMCONF_BASE_ADDRESS
* 20cb85fa98 nb/intel/gm45: Set display backlight according to EDID string
* 53485d2eab nb/intel/gm45/gma.c: Decode EDID before NGI path
* 54235ca1b7 console: Add convenient debug level macros for raminit
* 0624f92118 nb/intel/gm45: Hide some output behind DEBUG_RAM_SETUP
* 561bebfbaa drivers/intel/gma/vbt: Add Kconfig symbol for SSC ref
* bb1af99622 nb/intel/gm45/igd: Hide IGD while disabling
* 1f06028793 nb/gm45/gma.c: Fix reported Pixel clock
* 6d0c65ebc6 nb/intel/*/northbridge.c: Remove #include <device/hypertransport.h>
* eaebbd10e6 nb/intel/gm45: Use lapic udelay in SMM
* 122e5bc6b1 intel i945 gm45 x4x: Switch to RELOCATABLE_RAMSTAGE
* a6ac187731 intel/gm45: Use romstage_handoff for S3
* 823020d56b intel i945 gm45 x4x post-car: Use postcar_frame for MTRR setup
* 811932a614 intel i945 gm45 x4x: Apply cbmem_top() alignment
* 530f677cdc buildsystem: Drop explicit (k)config.h includes
* 3d15e10aef MMCONF_SUPPORT: Flip default to enabled
* 6f66f414a0 PCI ops: MMCONF_SUPPORT_DEFAULT is required
* 12bed2608f nb/gm45/gma.c: Compute BLC_PWM_CTL value from PWM frequency
* d85a71a75c nb/intel/gm45: Fix panel-power-sequence clock divisor
* bac0fad408 Remove explicit select MMCONF_SUPPORT
* 128c104c4d nb/intel: Fix some spelling mistakes in comments and strings
* eeaf9e4687 nb/gm45: Refactor IGD vram decoding
* a4ffe9dda0 intel post-car: Separate files for setup_stack_and_mtrrs()
* c5d972d073 Move select UDELAY_LAPIC from nb/gm45/Kconfig to cpu/model_1067x/Kconfig
* 10141c3006 nb/intel/gm45: Use LAPIC udelay instead of custom version
* 606b8bccb5 nb/gm45/gma.c: Remove writes to DP, FDI registers
* ff1286d500 nb/gm45,x4x/gma.c remove writes to nonexisting FDI registers
* 75f9131453 nb/i945,gm45,x4x/gma.c: fix unsigned arithmetics
* 063cd5f6ee nb/gm45,x4x/gma.c: Compute p2 in VGA init instead of hardcoding it
* fe3eabcaed nb/gm45/gma.c: use linux code to compute LVDS dotclock divisors
* 7141ff3b9f nb/intel/*/graphic_init: use sizeof instead of hardcoding edid size
* 7db506c3dd src/northbridge: Remove unnecessary whitespace
* 58afca4a1a nb/gm45: allow use of 352M preallocated ram for igd
* d3284a6977 nb/intel/*/gma.c: remove spaces at the fake vbt generation
* 9a9c8dba8d northbridge/intel/gm45: Add space around operators
* 0b1a5c259b gm45/gma.c: use correct id string for fake VBT
* c51522f516 nb/gm45/gma.c: enable VESA framebuffer mode on VGA output
* de6ad8369f gm45/gma.c: use screen on vga connector if connected
* 25f75b28e4 northbridge/intel/gm45: transation away from device_t
* 88af372fe8 nb/intel/gm45: Fix DMAR table - IOMMU advertisement for ME interfaces
* 8ba2010d12 gm45/gma.c: clean up some registers
* 0cd338e6e4 Remove non-ascii & unprintable characters
* 15279a9696 src/northbridge: Capitalize CPU, RAM and ROM
````

### git log src/northbridge/intel/x4x/

This benefits mainly the Gigabyte GA-G41M-ES2L mainboard in Libreboot, and other
x4x boards that have now been added. In Libreboot 20160907, the only x4x board
was the Gigabyte GA-G41M-ES2L

````
* 88dcb3179b src: Retype option API to use unsigned integers
* f9c939029b nb/intel: Use get_int_option()
* 2bb361f0f5 nb/intel/x4x: Refactor sync DLL programming (part 2)
* a20a02e82a nb/intel/x4x: Refactor sync DLL programming (part 1)
* b6a2ebe5ef nb/intel/x4x: Sort code in program_dll()
* a5146f3239 nb/intel/x4x: Use new fixed BAR accessors
* 93aab51ec1 nb/intel/x4x: Correct and use macros for CLKCFG
* 70dc0a8cc3 nb/intel/x4x/dq_dqs.c: Avoid breaking strings over multiple lines
* e82191451c nb/intel/x4x: Add missing newlines to log message
* dd7ce4e1d3 nb/intel/x4x: Reflow long lines
* 5c3160ed80 nb/intel/x4x/dq_dqs.c: Fix typo in variable name
* c024c14790 nb/intel/x4x: Correct sync DLL phase search
* 7720f1da36 nb/intel: Factor out remaining MCHBAR macros
* afb3d7e7ec device/dram/ddr3: Get rid of useless typedefs
* b238caaaca device/device.c: Rename .disable to .vga_disable
* 3051a9ecfa nb/intel/x4x: Use a variable for s3resume
* b33c6fbfd5 nb/intel/x4x,sandybridge: Move INITRAM timestamps
* 4ce0a07f06 nb/intel/x4x,sandybridge: Move romstage_handoff_init() call
* 030d338bb2 nb/intel: Add missing <types.h>
* e88f705946 nb/intel/x4x: Use common {DMI,EP,MCH}BAR accessors
* 06d224f65e nb/intel/x4x: Correct DDR3 turnaround table
* a6daff192f nb/intel/x4x: Constify write leveling arrays
* 9e58afef59 nb/intel/x4x: Update write leveling comment
* b35adab862 nb/intel/x4x: Constify DDR2 ODT table
* 7d3bd6b505 nb/intel/x4x: Clean up RCOMP cosmetics
* a0b97f3743 nb/intel/x4x: Drop unused first array index
* 244391a075 nb/intel/x4x: Unroll programming RCOMP data group
* 6b17794dda nb/intel/x4x: Report if running in async mode
* 43a5e0cc07 nb/intel/x4x: Factor out setting Tx DLL tap and PI
* 22fd0dca17 nb/intel/x4x: Correct ctrlset{2,3} register mask
* b99d592752 nb/intel/x4x: Clean up cosmetics of raminit tables
* 32f9bcaa91 nb/intel/x4x: Drop commented-out statement
* b70ff52b83 intel: Define `RCBA_LENGTH` in Kconfig and use it
* 6e732d34a0 intel: Turn `DEFAULT_RCBA` into a Kconfig symbol
* 37cae54034 nb/intel/x/bootblock.c Revert `include <arch/pci_io_cfg.h>`
* 00b5f53361 treewide [Kconfig]: Remove useless comment
* 875c21f491 nb/intel/x4x/bootblock.c: include <arch/pci_io_cfg.h>
* bbc80f4405 nb/intel/x4x: Define and use MMCONF_BUS_NUMBER
* 7d638784a2 device/Kconfig: Declare MMCONF symbols' type once
* 985821c4f2 cpu/intel/socket_LGA775: Increase DCACHE_RAM_SIZE
* f669c81cf4 northbridge/intel/x4x/dq_dqs.c: Remove repeated word
* 6538d91bc3 northbridge/intel/x4x/raminit_ddr23.c: Remove repeated word
* 9d20c84460 nb/intel/x4x: Clean up raminit comments
* bc15e01958 nb/intel/x4x: Reset DQS probe on all channels
* c6589aefc1 drivers/intel/gma: Include gfx.asl by default for all platforms...
* baf27dbaeb cbfs: Enable CBFS mcache on most chipsets
* 41e66ac38f nb/intel/x4x: Place raminit definitions in raminit.h
* fd19075045 nb/intel/x4x: Move register headers into a subfolder
* a5314b62b6 nb/intel/x4x: Clean up DMIBAR/EPBAR definitions
* 6c2568f4f5 drivers/spi: Add BOOT_DEVICE_SPI_FLASH_NO_EARLY_WRITES config
* 6fd9adbecb nb/intel/x4x/x4x.h: Clean up cosmetics
* 2a8ceefb27 nb/intel/x4x/iomap.h: Rename to memmap.h
* dddd1cc691 src/northbridge: Drop unneeded empty lines
* b8b117c7e7 nb/intel/x4x: Clean up TPM-related code
* ad9cd687b8 mrc_cache: Add mrc_cache fetch functions to support non-x86 platforms
* cf0f7ed3ee nb/intel/x4x/raminit_ddr23.c: Remove dead assignment
* 5ba154a597 src: Use space after 'if', 'for'
* 6aa9d66873 src: Use space after switch, while
* d1c590a666 nb/intel/x4x: Define and use `HOST_BRIDGE` macro
* 579ccdf9c9 nb/intel/x4x: Remove dead assignments
* 8f917b1d4b nb/intel/x4x: Refactor `decode_pcie_bar`
* ecec9474d8 nb/intel/x4x: Change signature of `decode_pciebar`
* 6b2be99eb1 nb/intel/x4x/hostbridge_regs.h: Clean up registers
* 3896576a16 nb/intel/x4x: Put host bridge registers into its own file
* 879c4de66f nb/intel/x4x/rcven.c: Rename memory barrier function
* 225be5f7ee src: Remove unused 'include <types.h>'
* 7c71f7d15b nb/intel/x4x/acpi: Use ASL 2.0 syntax
* 0b5673dd33 nb/intel/x4x/acpi: Clean up comments
* 1a1b04ea51 device/smbus_host: Declare common early SMBus prototypes
* a1dfce1ce0 x4x boards: Factor out MAX_CPUS
* 306e8930a7 nb/intel/x4x: Drop unused `pci_ops.h` include
* 4a9569a123 nb/intel/x4x: Use PCI bitwise ops
* 1fc0edd9fe src: Use pci_dev_ops_pci where applicable
* 379aab47f9 src: Remove unused 'include <cpu/x86/mtrr.h>'
* 0c154af217 src: Remove redundant includes
* dd59762729 intel/gma: Only enable bus mastering if we are going to use it
* dfdf102000 intel/gma: Don't bluntly enable I/O
* f2a0be235c drivers/intel/gma: Move IGD OpRegion to CBMEM
* 5ac723e5a4 nb/intel: Fix 16-bit read/write PCI_COMMAND register
* c4b70276ed src: Remove leading blank lines from SPDX header
* 6b5bc77c9b treewide: Remove "this file is part of" lines
* c49d7a3e63 src/: Replace GPL boilerplate with SPDX headers
* 36787b0e7b northbridge/*/Kconfig: Replace GPLv2 long form headers with SPDX header
* ac9590395e treewide: replace GPLv2 long form headers with SPDX header
* 02363b5e46 treewide: Move "is part of the coreboot project" line in its own comment
* 76cedd2c29 acpi: Move ACPI table support out of arch/x86 (3/5)
* 2d7173d462 src: Remove unused 'include <cpu/x86/cache.h>'
* 7536a398e9 device: Constify struct device * parameter to acpi_fill_ssdt()
* 0f007d8ceb device: Constify struct device * parameter to write_acpi_tables
* 2f8ba69b0e Replace DEVICE_NOOP with noop_(set|read)_resources
* a461b694a6 Drop unnecessary DEVICE_NOOP entries
* 4b42983c7a src/northbridge: Use SPDX for GPL-2.0-only files
* 33f89eea9f nb/intel/x4x: Simplify GMA SSDT generator
* 68680dd7cd Trim `.acpi_fill_ssdt_generator` and `.acpi_inject_dsdt_generator`
* 6343cd846a drivers/intel/gma: fold gma.asl into default_brightness_levels.asl
* 612a867677 drivers/intel/gma/acpi: Add Kconfigs for backlight registers
* f3f36faf35 src (minus soc and mainboard): Remove copyright notices
* 8247cc3328 northbridge: Remove unused include <device/pci.h>
* 2119d0ba43 treewide: Capitalize 'CMOS'
* ef90609cbb src: capitalize 'RAM'
* 1cfafe25e3 intel/{gm45,x4x},i82801{ix|jx}: Move enable_smbus() call
* bd65985a63 nb/intel/{i945,x4x,pineview}: Remove wrapper spd_read_byte()
* cbf9571588 drivers/pc80/rtc: Separate {get|set}_option() prototypes
* 1f66809111 src: Remove unneeded 'include <arch/io.h>'
* 748caed022 northbridge: Add missing include <device/pci_def.h>
* dc987fecce src/northbridge: Remove unused <stdlib.h>
* de64078102 bootblock: Provide some common prototypes
* 68ec3eb1f0 src: Move 'static' to the beginning of declaration
* a854c9d787 nb/intel/x4x: Factor out hiding PCI devs in pure fn
* c05b1a66b3 Kconfig: Drop the C_ENVIRONMENT_BOOTBLOCK symbol
* 7843bd560e nb/intel/x4x: Move to C_ENVIRONMENT_BOOTBLOCK
* bf53acca5e nb/intel/x4x: Move boilerplate romstage to a common location
* 2452afbe04 mb/*/*(ich7/x4x): Use common early southbridge init
* aa990e9289 sb/intel/i82801jx: Move early sb init to a common place
* dc972e17c7 nb/intel/x4x.h: Include stdint.h
* 4ec67fc82c nb/intel: Use defined DEFAULT_RCBA
* 6190d0bfe6 nb/intel/x4x/x4x.h: Include iomap.h
* 340e4b8090 lib/cbmem_top: Add a common cbmem_top implementation
* 44b275e209 nb/intel/{nehalem,x4x}: Remove unused 'include <pc80/vga_io.h>'
* 34715df801 src: Remove unused '#include <cpu/cpu.h>'
* fcdb03358d acpi: Drop wrong _ADR objects for PCI host bridges
* d7205bebd5 nb,sb/intel: Clean up some __BOOTBLOCK__ and  __SIMPLE_DEVICE__ use
* 197a3c6cea nb/intel/x4x: Avoid x4x.h header with romcc-bootblock
* e39becf521 intel/cpu: Switch older models to TSC_MONOTONIC_TIMER
* 8bb2bace86 nb/intel/x4x/raminit: Move dummy reads after JEDEC init
* d53fd704f2 intel/smm/gen1: Use smm_subregion()
* cd7a70f487 soc/intel: Use common romstage code
* a963acdcc7 arch/x86: Add <arch/romstage.h>
* f091f4daf7 intel/smm/gen1: Rename header file
* 544878b563 arch/x86: Add postcar_frame_common_mtrrs()
* 5bc641afeb cpu/intel: Refactor platform_enter_postcar()
* b3267e002e cpu/intel: Replace bsp_init_and_start_aps()
* 0f5e01a962 arch/x86: Flip option NO_CAR_GLOBAL_MIGRATION
* 9fc12e0d4e arch/x86: Enable POSTCAR_CONSOLE by default
* 0a4457ff44 lib/stage_cache: Refactor Kconfig options
* fe481eb3e5 northbridge/intel: Rename ram_calc.c to memmap.c
* bccd2b6c49 intel/i945,gm45,pineview,x4x: Fix stage cache location
* aba8fb1158 intel/i945,gm45,pineview,x4x: Move stage cache support function
* 5033d6ce51 nb/intel/x4x: Die on invalid memory speeds
* 8abf66e4e0 cpu/x86: Flip SMM_TSEG default
* 6e2d0c1b90 arch/x86: Adjust size of postcar stack
* e951e8ec7f nb/x4x: Rename {ddr,fsb}2{mhz,ps} as {ddr,fsb}_to_{mhz,ps}
* c53665ce55 nb/intel/x4x: Remove variable set but not used
* 2dbc095677 nb/intel/x4x/rcven.c: Remove variable set but not used
* 51401c3050 src/northbridge: Add missing 'include <types.h>'
* 502008d5dc nb/northbridge/intel/x4x/acpi.c: Remove variable set but not used
* 0c89c1c05e nb/intel/x4x/early_init.c: Remove variable set but not used
* 274dabd7a0 src/northbridge: Remove unneeded include <arch/io.h>
* 1bc7b6e135 {gm45,pineview,sandybridge,x4x}: Use {full,system}_reset() function
* b559b3c785 nb/x4x: Use system_reset() and full_reset()
* 0f49dd26ad src/northbridge/intel: Remove unused variables
* f74f6cbde5 nb/intel/{gm45,i945,x4x}: Correct array bounds checks
* bf0970e762 src: Use include <delay.h> when appropriate
* f5cf60f25b Move calls to quick_ram_check() before CBMEM init
* 4a0f07166f {northbridge, soc, southbridge}/intel: Make use of pci_dev_set_subsystem()
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* 74aa99a543 src: Drop unused '#include <halt.h>'
* e183429bd2 nb/intel/stage_cache.c: Drop unnecessary includes
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 503d3247e4 Remove DEFAULT_PCIEXBAR alias
* 13f66507af device/mmio.h: Add include file for MMIO ops
* 065857ee7f arch/io.h: Drop unnecessary include
* f1b58b7835 device/pci: Fix PCI accessor headers
* c01a505282 sb/intel/common: Rename i2c_block_read() to i2c_eeprom_read()
* a402a9e7ab nb/intel/x4x: Put stage cache in TSEG
* c82950bf79 nb/intel/x4x: Use parallel MP init
* 15b83da39a nb/intel/x4x: Remove spurious pcidev_on_root() usage
* f5a57a883b mb: Move timestamp_add_now to northbridge x4x
* c70eed1e62 device: Use pcidev_on_root()
* 98a917443e device: Replace ugly cases of dev_find_slot()
* 1f4cb326fa northbridge: Remove useless include <device/pci_ids.h>
* 586f24dab4 northbridge: Remove unneeded include <pc80/mc146818rtc.h>
* 4c65bfc3e8 nb/intel/x4x: Use common code for SMM in TSEG
* 0ce41f1a11 src: Add required space after "switch"
* 8a5283ab1b src: Remove unneeded include <cbmem.h>
* f765d4f275 src: Remove unneeded include <lib.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* 0f14df46aa nb/intel/x4x/raminit: Add missing space
* d522db048b nb/intel/*: Use 2M TSEG instead of 8M on pre-arrandale hardware
* 17ad4598e9 nb/intel/*: Account for cbmem_top alignment
* a342f3937e src: Remove unneeded whitespace
* b1ba6624cd nb/intel/x4x: Fix P45 CAPID max frequency
* 8ddd7d1e5e nb/intel/x4x: Program read training results to all ranks
* 88607a4b10 src: Use tabs for indentation
* b0c6cffb09 nb/intel/x4x: Don't use cached settings if CPU FSB has been changed
* 3e3bae03cf nb/intel/x4x/gma.c: fix skipping of native graphics init
* e6c8f7ec20 nb/intel/*/gma.c: Skip NGI when VGA decode is not enabled
* 3d45000c9c src: Fix typo
* 64f6b71af5 src/northbridge: Fix typo
* 3a2f900cfe x4x/raminit_ddr23: use MCHBAR AND/OR/AND_OR macros [2/2]
* c6e13b6690 nb/intel/x4x: Don't use PCI operations on the pci_domain device
* 432575c5d3 x4x/raminit_ddr23: use MCHBAR AND/OR/AND_OR macros [1/2]
* 6cd2c2f6ff northbridge/x4x: add MCHBAR AND/OR/AND_OR access macros
* a8a9f34e9b sb/intel/i82801{g,j}x: Automatically generate ACPI PIRQ tables
* df946b8696 nb/intel/x4x: Issue a hard reset with empty MRC cache on warm reset
* e8093054d3 nb/intel/x4x: Deprecate native graphic init
* 7345a17a43 nb/intel/x4x: Fix a few things in set_enhanced_mode
* 5a9dbde59c nb/intel/x4x: Work around a quirk
* 0602ce67a6 nb/intel/x4x: Add the option for stacked channel map settings
* f2dd0499b6 libgfxinit: Enable G45 support (for GM45/X4X)
* 730df3cc43 arch/x86: Make RELOCATABLE_RAMSTAGE the default
* 4ff675ebd0 nb/intel/x4x: Switch to POSTCAR_STAGE
* 089b9089c1 nb/intel: Use postcar_frame_add_romcache()
* f369e60329 northbridge/intel: Remove unneeded includes
* 654cc2fe10 {cpu,drivers,nb,soc}/intel: Use CACHE_ROM_BASE where appropriate
* 0d284959dc nb/intel/x4x: Adapt post JEDEC for DDR3
* 3fa103a602 nb/intel/x4x/raminit: Add DDR3 enhanced mode and power settings
* b4a78045d5 nb/intel/x4x/raminit: Add DDR3 specific dra/drb settings
* b5170c3e92 nb/intel/x4x: Implement write leveling
* f1287266ab nb/intel/x4x: Add DDR3 JEDEC init
* e6cc21e262 nb/intel/x4x/raminit: DDR3 specific ODT
* 0d1c9b0e32 nb/intel/x4x: Add DDR3 rcomp
* 638240e98b nb/intel/x4x/raminit: Support programming initials DD3 DLL setting
* 66a0f55c2e nb/intel/x4x/raminit: Support programming DDR3 timings
* 7a3a319e3a nb/intel/x4x/raminit: Make programming launch ddr3 specific
* 840c27ecfc nb/intel/x4x/raminit: Make programming crossclock support DDR3
* a2cc23169a nb/intel/x4x: Rename a things that are not specific to DDR2
* 1848ba3b54 nb/x4x/raminit: Decode ddr3 dimms
* 701da39fb7 nb/intel/x4x/raminit: Fix programming dual channel registers
* 3de303179a {mb,nb,soc}: Remove references to pci_bus_default_ops()
* 16a70a48c6 nb/intel/x4x: Change memory layout to improve MTRR
* dfce932cf0 nb/intel/x4x: Fix programming CxDRB
* 95c48cbbb5 nb/intel/x4x: Implement both read and write training
* fea02e1439 nb/x4x: Get rid of device_t
* d4e5762bd7 nb/intel/x4x: Fix computing page_size
* a4e8f67b94 nb/intel/x4x/rcven.c: Change the verbosity of some messages
* 276049f9ee nb/intel/x4x: Add a convenient macro to loop over bytelanes
* 1994e448be nb/intel/x4x: Clarify the raminit memory mapping
* 0bf87de667 nb/intel/x4x: Refactor setting default dll settings
* adc571a54c nb/intel/x4x: Use SPI flash to cache raminit results
* fc31e44e47 device/ddr2,ddr3: Rename and move a few things
* 7be74dbb38 nb/x4x/raminit_ddr2: Refactor clock configuration slightly
* d6f3dd83dc nb/intel/x4x: Disable watchdog, halt TCO timer and clear timeout
* 3cf94032bc nb/x4x/raminit: Rewrite SPD decode and timing selection
* f6f4ba9e45 nb/intel/x4x/rcven.c: Fix programming coarse offset
* f6aa7d94c8 nb/intel/*/gma: Port ACPI opregion to older platforms
* 524d497355 nb/intel/x4x: Select LAPIC_MONOTONIC_TIMER
* 24798a1544 nb/intel/x4x: Fix booting with FSB800 DDR667 combination
* 6d7a8c1125 nb/intel/x4x/raminit: Rework receive enable calibration
* c3cbe9433c nb/intel/x4x/gma.c: Probe VGA EDID on DVI-I ports
* 8da2286885 nb/intel/*/gma.c: Use macros for GMBUS numbers
* 3876f24221 nb/intel/x4x: Rework programming DQ and DQS DLL timings
* 349e08535a sb/intel/i82801jx: Add correct PCI ids and change names
* 6d8266b91d Kconfig: Add choice of framebuffer mode
* 7971582ec4 Kconfig: Introduce HAVE_(VBE_)LINEAR_FRAMEBUFFER
* ce642f08b9 Kconfig: Rework MAINBOARD_HAS_NATIVE_VGA_INIT_TEXTMODECFG
* 37689fae38 nb/intel/x4x/raminit: Initialise async variable
* 27f0ca18bc nb/intel/x4x: Use a struct for dll settings instead of an array
* cfa2eaa4cc nb/intel/x4x: Make raminit less verbose with CONFIG_DEBUG_RAM_SETUP
* e729366d7a nb/intel/x4x/raminit: Remove very long delay
* cfd433b96d nb/intel/x4x: Fix uninitialized variable issue
* 512a2d1c4f nb/intel/x4x: Define and use default MMCONF_BASE_ADDRESS
* 293445ae1f nb/intel/x4x: Add support for second PEG slot
* 5e3cb72a71 nb/x4x: Do not enable IGD when not supported
* 2e7efe65a2 nb/intel/x4x: Don't run NGI if IGD has not been assigned VGA cycles
* c80748c2d0 nb/x4x: Add ramstage IGD disable function
* 4c4f56a6ba nb/x4x/nortbridge.c: Compute TSEG resource allocation dynamically
* ddc8828697 nb/x4x/raminit.c: Remove ME locking code
* 8565c03caf nb/intel/x4x/raminit: Change reset type on incomplete raminit reset
* 4bc9c28811 nb/intel/x4x/Kconfig: Don't fix CBFS_SIZE on i82801gx southbridge
* bb5e77c478 nb/x4x: Move checkreset before SPD reading
* 70a1dda927 nb/intel/x4x: Fix issues found by checkpatch.pl
* ef7e98a2ac nb/intel/x4x: Implement resume from S3 suspend
* 97e13d84c3 nb/intel/x4x: Fix raminit on reset path
* eee4f6b224 nb/x4x/raminit: Fix programming dram timings
* 6d0c65ebc6 nb/intel/*/northbridge.c: Remove #include <device/hypertransport.h>
* 9e70ce0c3e nb/x4x: Add other Eaglelake IGD PCI DID to list
* 122e5bc6b1 intel i945 gm45 x4x: Switch to RELOCATABLE_RAMSTAGE
* 823020d56b intel i945 gm45 x4x post-car: Use postcar_frame for MTRR setup
* 811932a614 intel i945 gm45 x4x: Apply cbmem_top() alignment
* 530f677cdc buildsystem: Drop explicit (k)config.h includes
* 3d15e10aef MMCONF_SUPPORT: Flip default to enabled
* 5b30b823c8 nb/x4x: Fix sticky scratchpad register offset
* 3c20906e42 nb/intel/x4x/raminit: Fix DIMM_IN_CHANNEL calculation
* 696abfcfd3 nb/intel/x4x: Fix and deflate `dimm_config` in raminit
* bac0fad408 Remove explicit select MMCONF_SUPPORT
* 128c104c4d nb/intel: Fix some spelling mistakes in comments and strings
* a4ffe9dda0 intel post-car: Separate files for setup_stack_and_mtrrs()
* 8a3514d0ae nb/x4x/raminit.c: Improve crossclock table cosmetics
* f8a4f41d48 nb/x4x/gma.c: Remove writes to DP, FDI registers
* ff1286d500 nb/gm45,x4x/gma.c remove writes to nonexisting FDI registers
* 75f9131453 nb/i945,gm45,x4x/gma.c: fix unsigned arithmetics
* 063cd5f6ee nb/gm45,x4x/gma.c: Compute p2 in VGA init instead of hardcoding it
* 7141ff3b9f nb/intel/*/graphic_init: use sizeof instead of hardcoding edid size
* de14ea77c3 x4x/gma.c: Add VESA native resolution mode
* 7db506c3dd src/northbridge: Remove unnecessary whitespace
* d3284a6977 nb/intel/*/gma.c: remove spaces at the fake vbt generation
* 6e8b3c1110 src/northbridge: Improve code formatting
* 60a6e153b0 northbridge/intel/x4x: transition away from device_t
* 614ffc60cf nb/intel/x4x: Correct typos in interrupt routing for PEG
* a99c64e129 nb/intel/x4x: Turn on PEG graphics in device enable
* 523e90f9c7 nb/intel/x4x: Increase MMIO PCI space to 2GiB
* 57321db3ca nb/intel/x4x: Fix DMI init
* 12df950583 northbridge/intel: Add required space before opening parenthesis '('
* eff0c6a99d x4x: make preallocated IGD memory a cmos option
* 27f94eea6c x4x: add non documented vram sizes
* 7c2e5396a3 nb/intel/x4x: Fix CAS latency detection and max memory detection
* b921725b52 nb/intel/x4x: Fix CAS latency detection
* df6eb79a22 intel/x4x: Do not use scratchpad register for ACPI S3
* 9ae0985328 nb/intel/x4x: Fix underclocking of 800MHz DDR2 RAM
* 68e1dcfdd9 nb/intel/x4x: Fix unpopulated value
* a090ae04c2 nb/intel/x4x: Add DMI/EP init
````

fam10h / fam15h AMD platform
----------------------------

Unlike other boards in this Libreboot release, the AMD fam10h/fam15h boards
are stuck on coreboot 4.11. The other boards use coreboot 4.14. The commits
listed below are since the coreboot revisions used in Libreboot 20160907, right
up to coreboot 4.11.

### Northbridge changes

#### fam10h

Running `git log src/northbridge/amd/amdfam10/` we get these commits:

````
* 468d02cc82 src/[northbridge,security]: change "unsigned" to "unsigned int"
* 23d4d9f368 amdfam_10h-15h: Use ENV_PCI_SIMPLE_DEVICE
* c99d3afe3e amdfam10: Remove use of __PRE_RAM__
* 5cf9ccc57d src: Include <stdint.h> instead of <inttypes.h>
* 04d025cf50 amdfam10: Declare get_sysinfo()
* 8560db6116 amdfam10: Declare empty activate_spd_rom() stub
* f77f7cdf89 device,nb/amd: Deduplicate add_more_links()
* 09c31d557f nb/amd/amdfam10: Use 64 bits in multiplication
* 44245693ec nb/amd/amdfam10/northbridge.c: Remove variable set but not used
* 27ca962058 nb/amd/amdfam10: die() on out of bounds reads
* 51401c3050 src/northbridge: Add missing 'include <types.h>'
* 5de93e9011 nb/amd/amdfam10/util.c: Use "CONFIG" only when appropriate
* 5d1f9a0096 Fix up remaining boolean uses of CONFIG_XXX to CONFIG(XXX)
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* d21495549b nb/amd/amdfam10: Remove define macro already done in 'amdfam10.h'
* 6b2e436995 nb/amd/amdfam10: Remove 'IS_ENABLED()'
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 065857ee7f arch/io.h: Drop unnecessary include
* bdaec07a85 arch/io.h: Add missing includes
* 3e6913b389 arch/io.h: Fix PCI and PNP simple typedefs
* f1b58b7835 device/pci: Fix PCI accessor headers
* 251514d986 src: Don't use a #defines like Kconfig symbols
* c2c1dc9c76 {mb,nb,soc/fsp_baytrail}: Get rid of dump_mem()
* ef62994b94 northbridge/amdfam10: Deal with PCI_ADDR() better
* 20c294884f amdfam10 boards: Simplify early resourcemap
* 2dce923524 mb: Move timestamp_add_now to northbridge/amd/amdfam10
* e7377556cc device: Use pcidev_path_on_root()
* c70eed1e62 device: Use pcidev_on_root()
* f112f9f912 amdfam10 boards: Use defaults for get_pci1234()
* 21c60fa2b2 amdfam10 boards: Add temporary pirq_router_bus variable
* c0b1be0ba1 amdfam10 boards: Call get_bus_conf() just once
* a2cfe9e900 amdfam10 boards: Add Makefiles and fix resourcemap.c
* 1db4e3a358 amdfam10 boards: Declare get_pci1234() just once
* 9e7ac6b034 amdfam10 boards: Drop AMD_SB_CIMX
* 1f4cb326fa northbridge: Remove useless include <device/pci_ids.h>
* 586f24dab4 northbridge: Remove unneeded include <pc80/mc146818rtc.h>
* 134da98a51 amd/{nb/amdfam10,cpu/pi}/Kconfig: Remove unused symbols
* 414779db10 src/mainboard: Remove unused "HW_MEM_HOLE_SIZE_AUTO_INC"
* f765d4f275 src: Remove unneeded include <lib.h>
* e9a0130879 src: Remove unneeded include <console/console.h>
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* 400ce55566 cpu/amd: Use common AMD's MSR
* 83bd46e5e5 selfboot: remove bounce buffers
* d44221f9c8 Move compiler.h to commonlib
* 88607a4b10 src: Use tabs for indentation
* b60920df52 northbridge: Use 'unsigned int' to bare use of 'unsigned'
* 3d45000c9c src: Fix typo
* 64f6b71af5 src/northbridge: Fix typo
* b0f1988f89 src: Get rid of unneeded whitespace
* c8a649c08f src: Use of device_t is deprecated
* 7904e720d5 arch/x86: Flag platforms without RELOCATABLE_RAMSTAGE
* 448d9fb431 src: Use "foo *bar" instead of "foo* bar"
* 5474eb15ef src/northbridge: Add and update license headers
* 5b3bf4ad27 nb/amd/amdfam10: Get rid of device_t
* 3de303179a {mb,nb,soc}: Remove references to pci_bus_default_ops()
* aa090cb6ea device: acpi_name() should take a const struct device
* b98391c0ee AMD K8 fam10-15: Tidy up CAR disable
* b08d73b845 src/northbridge: Add guards on all header files
* 6a00113de8 Rename __attribute__((packed)) --> __packed
* 77a58b92e8 nb/amd: add IS_ENABLED() around Kconfig symbol references
* 67ed261200 amd/amdfam10: Remove dead code
* 0f3a18ad28 [nb|sb]/amd/[amdfam10|sb700]: Add LPC bridge ACPI names for NB/SB
* 75a3d1fb7c amdfam10: Perform major include ".c" cleanup
* 48f82a9beb AMD fam10 binaryPI: Remove invalid PCI ops on CPU domain
* 27198ac2e3 MMCONF_SUPPORT: Drop redundant logging
* e25b5ef39f MMCONF_SUPPORT: Consolidate resource registration
* 6f66f414a0 PCI ops: MMCONF_SUPPORT_DEFAULT is required
* 425890e59a AMD fam10h-15h: MMCONF_SUPPORT_DEFAULT is already set
* e0ee4c87e8 northbridge/amd/amdfam10: Remove commented code
* 7db506c3dd src/northbridge: Remove unnecessary whitespace
* 0d4b11a4f8 src/northbridge: Remove whitespace after sizeof
* 04f8fd981f northbridge/amd/amdfam10: Improve code formatting
* f65ccb2cd6 northbridge/amd/amdfam10: transition away from device_t
* 6e8b3c1110 src/northbridge: Improve code formatting
* 5a7e72f1ae northbridge/amd: Add required space before opening parenthesis '('
* 47f7b0e196 amd/amdfam10: eliminate dead code
* 0cd338e6e4 Remove non-ascii & unprintable characters
* 15279a9696 src/northbridge: Capitalize CPU, RAM and ROM
* 84da72c988 nb/amd/mct_ddr3: Report correct DIMM size in SMBIOS structure
````

#### fam15h

Running `git log src/northbridge/amd/amdmct/` we get this:

````
* 468d02cc82 src/[northbridge,security]: change "unsigned" to "unsigned int"
* 23d4d9f368 amdfam_10h-15h: Use ENV_PCI_SIMPLE_DEVICE
* c99d3afe3e amdfam10: Remove use of __PRE_RAM__
* 9172b6920c src: Remove variable length arrays
* 5cf9ccc57d src: Include <stdint.h> instead of <inttypes.h>
* 63f98f2304 src: Use CRx_TYPE type for CRx
* 7d881b5189 nb/amd/amdmct/mct_ddr3: Remove unused code
* 31755adc5a nb/amd/amdmct/mct: Remove duplicate if condition
* 19cbe03534 nb/amd/amdmct/mct_ddr3: Remove duplicate conditional
* 86d8c4279d nb/amd/amdmct/mct_ddr3: Remove duplicate code
* e94335e9fd nb/amd/amdmct/mct: Simplify conditional
* 156936b771 nb/amd/amdmct/mct_ddr3/mct_d.c: Remove variable set but not used
* 51401c3050 src/northbridge: Add missing 'include <types.h>'
* 3dbfb2bef9 nb/amd/amdmct/mct/mctdqs_d.c: Remove variable set but not used
* f0a576595a nb/amd/amdmct/mct/mctpro_d.c: Remove variable set but not used
* 7a5d4e2b4a nb/amd/amdmct/mct/mctecc_d.c: Remove variable set but not used
* d768e919ae src/northbridge/amd: Remove unused variables
* 351e3e520b src: Use include <console/console.h> when appropriate
* 20eaef024c src: Add missing include 'console.h'
* bf0970e762 src: Use include <delay.h> when appropriate
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* bdaec07a85 arch/io.h: Add missing includes
* f1b58b7835 device/pci: Fix PCI accessor headers
* 0f8b8d920c src: Move constant to the right side of comparison
* c70eed1e62 device: Use pcidev_on_root()
* afc63844e2 src/northbridge: Get rid of device_t
* 00d0ddb62b nb/amd/amdmct/{mct,mct_ddr3}: Replace "magic" numbers with macros
* e9a0130879 src: Remove unneeded include <console/console.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* de462804e1 nb/amd/amdmct/mct_ddr3: Replace MTRR addresses with macros
* a9473ecbb1 src: Replace common MSR addresses with macros
* d35c7fe1bf amd/mtrr: Fix IORR MTRR
* 718c6faff4 reset: Finalize move to new API
* 8a643703b8 {cpu,drivers,nb,sb}/amd: Replace {MSR,MTRR} addresses with macros
* dfbe6bd5c3 src: Add missing include <stdint.h>
* a342f3937e src: Remove unneeded whitespace
* 400ce55566 cpu/amd: Use common AMD's MSR
* d44221f9c8 Move compiler.h to commonlib
* 3d45000c9c src: Fix typo
* 64f6b71af5 src/northbridge: Fix typo
* bd4a3f8cd9 cpu/amd: Correct number of MCA banks cleared
* fd051dc018 src/northbridge: Use "foo *bar" instead of "foo* bar"
* b0f1988f89 src: Get rid of unneeded whitespace
* 68c851bcd7 src: Get rid of device_t
* 1943f3798d {device,drivers,lib,mb,nb}: Use only one space after 'if'
* b6616ea636 amd/mct/ddr3: Correctly configure CsMux67
* 0722613563 nb/amd_fam10/mct_ddr3: Use common function to compute crc16 checksum
* 6a00113de8 Rename __attribute__((packed)) --> __packed
* 77a58b92e8 nb/amd: add IS_ENABLED() around Kconfig symbol references
* 30221b45e0 drivers/spi/spi_flash: Pass in flash structure to fill in probe
* 610d1c67b2 Revert "nb/amd/mct_ddr3: Fix RDIMM training failure on Fam15h"
* 37e30aa624 nb/amd/amdmct: Remove another currently unused table
* a6b1b258d2 nb/amd/amdmct: Remove two currently unused tables
* 9b4c888f7b nb/amd/ddr3: Make the maximum CDD a signed value
* a19d44d276 amd/mct: Add default values to highest_rank_count for DDR2
* 17b66c3846 amd/mct/ddr2: Remove orphaned Tab_TrefT_k variable
* 88a2e3b3bf amd/mct/ddr3: Fix unintended sign extension warning
* 590a3e1f6c amd/mct/ddr3: Avoid using uninitialized register address in ECC setup
* a20d0e0f79 amd/mct/ddr3: Free malloced resources in failure branches
* 6f9468f019 amd/mct/ddr3: Rework memory speed to clock value conversion logic
* 8fa624784e amd/mct/ddr3: Correctly program maximum read latency
* 5153cbfeb3 amd/mct/ddr3: Allow critical delay delta to go negative
* cf1cb5b2d4 amd/mct/ddr3: Correctly configure CsMux45
* aeaabd3fa3 amd/mct/ddr3: Wait for northbridge P-state transitions
* 21b01b80d6 amd/mct/ddr3: Fix incorrect DQ mask calculation
* a4dcdca7ba amd/mct/ddr2|ddr3: Refactor persistent members of DCTStatStruc
* 75a3d1fb7c amdfam10: Perform major include ".c" cleanup
* c28984d9ea spi: Clean up SPI flash driver interface
* bb09f285c3 nb/amd/amdmct/mct: Remove commented code
* 6bc3b96831 northbridge/amd/amdmct/mct_ddr3: Remove commented code
* 7db506c3dd src/northbridge: Remove unnecessary whitespace
* e1606731b6 northbridge/amd/amdmct: Improve code formatting
* 6e8b3c1110 src/northbridge: Improve code formatting
* 5a7e72f1ae northbridge/amd: Add required space before opening parenthesis '('
* 38424987c6 src/northbridge: Remove unnecessary whitespace before "\n" and "\t"
* 0cd338e6e4 Remove non-ascii & unprintable characters
* 84da72c988 nb/amd/mct_ddr3: Report correct DIMM size in SMBIOS structure
* d112f46bed nb/amd/mct_ddr3: Add support for non-ECC DIMMs on AMD Family 15h
````

### Board changes

#### ASUS KGPE-D16

Running `git log src/mainboard/asus/kgpe-d16/` we get:

````
* eb50d9a4fe mb/*: Use common IPMI KCS driver
* cb3e16f287 AMD fam10: Remove HAVE_ACPI_RESUME support
* 04d025cf50 amdfam10: Declare get_sysinfo()
* 8560db6116 amdfam10: Declare empty activate_spd_rom() stub
* e39db681df src/mainboard: Add missing 'include <types.h>'
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 13f66507af device/mmio.h: Add include file for MMIO ops
* 065857ee7f arch/io.h: Drop unnecessary include
* f1b58b7835 device/pci: Fix PCI accessor headers
* 0c152cf1bb src: Remove unused include device/pnp_def.h
* 6b239d8e08 mb/asus/kgpe-d16: Add BMC KCS to ACPI
* 5513c0a216 mb/asus/kgpe-d16: Enable IPMI KCS access
* 20c294884f amdfam10 boards: Simplify early resourcemap
* 22521ab2e6 amdfam10 boards: Drop extern on apicid_sp5100
* 2dce923524 mb: Move timestamp_add_now to northbridge/amd/amdfam10
* 9faae2b939 Kconfig: Unify power-after-failure options
* c70eed1e62 device: Use pcidev_on_root()
* 8803b21bbb amdfam10 boards: Use defaults for get_pci1234()
* b30e2bfe34 amdfam10 boards: Drop array bus_sp5100
* 6bc6c5548e amdfam10 boards: Use PCI_DEVFN()
* 651f4d231c amdfam10 boards: Drop array bus_sr5650
* 228746b346 amdfam10 boards: Drop const variable sbdn_sp5100
* af39e0ebc1 amdfam10 boards: Drop variable sbdn_sr5650
* c9394017db amdfam10 boards: Drop extern on bus_sr5650 and sbdn_sr5650
* c0b1be0ba1 amdfam10 boards: Call get_bus_conf() just once
* a2cfe9e900 amdfam10 boards: Add Makefiles and fix resourcemap.c
* d482c7dace amdfam10 boards: Drop global bus_isa variable
* 1db4e3a358 amdfam10 boards: Declare get_pci1234() just once
* a79b3f1c63 amdfam10 boards: Drop unused mb_sysconf.h
* a26b02466e drivers/aspeed/ast: Select `MAINBOARD_HAS_NATIVE_VGA_INIT`
* 21c8f9cab3 mainboard: Remove useless include <device/pci_ids.h>
* 472d68b066 mb/asus/kgpe-d16: Set ASpeed GPIO SPD mux lines during boot
* f0c5be2a4f mb/*/*/Kconfig: Remove useless comment
* 6d19a20f5f mb: Set coreboot as DSDT's manufacturer model ID
* 0cca6e24b7 ACPI: Fix DSDT's revision field
* f765d4f275 src: Remove unneeded include <lib.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* 1156b35a23 mainboard: Remove unneeded include <console/console.h>
* 718c6faff4 reset: Finalize move to new API
* e20dd19dde amdfam10: Convert to `board_reset()`
* 2c5652d72b mb: Fix non-local header treated as local
* 400ce55566 cpu/amd: Use common AMD's MSR
* dd35e2c8a9 mb: Use 'unsigned int' to bare use of 'unsigned'
* 068253c369 mb/*/*/cmos.default: Harmonise CMOS files syntax
* f716f2ac1a mb/*/*/cmos.default: Decrease debug_level to 'Debug'
* 65bb5434f6 src: Get rid of non-local header treated as local
* 08fc8fff25 src/mainboard: Fix typo
* db70f3bb4d drivers/tpm: Add TPM ramstage driver for devices without vboot.
* 95bca33efa src/mb: Use "foo *bar" instead of "foo* bar"
* c07f8fbe6f security/tpm: Unify the coreboot TPM software stack
* e0e1e64855 amdfam10: Drop tests for LATE_CBMEM_INIT
* d54e859ace mb/asus: Get rid of whitespace before tab
* 1bad4ce421 sb/amd/sr5650: Fix invalid function declarations
* 02b05d1f6b mb/asus: Get rid of device_t
* d88fb36e61 security/tpm: Change TPM naming for different layers.
* 64e2d19082 security/tpm: Move tpm TSS and TSPI layer to security section
* 482d16fb0a src/mainboard: Fix various typos
* ec48c749c2 AMD boards: Fix function name (soft_reset) in message
* 74bd2b0e4c mb/asus/kcma-d8,kgde-d16: Don't select SPI_FLASH_WINBOND
* b29078e401 mb/*/*: Remove rtc nvram configurable baud rate
* 8a8386eeb9 asus/kgpe-d16: Add romstage_handoff
* a26377b063 asus/kcma-d8 kgpe/d16: Fix regression for shutdown
* 714709fde6 AMD fam10 ACPI: Use common fixed sleepstates.asl
* 90e07b460c AMD K8 fam10-15: Consolidate post_cache_as_ram call
* f95911ad37 mainboard/[a-e]: add IS_ENABLED() around Kconfig symbol references
* 26ce9af9a0 device/Kconfig: Introduce MAINBOARD_FORCE_NATIVE_VGA_INIT
* e213bf3767 asus/kgpe-d16: Add video card ID for VGA BIOS name
* 00b9f4c4b1 mb/*/*/cmos.layout: Make multibyte options byte aligned
* 2d35809530 mb/asus/kgpe-d16: Enable TPM when selected in Kconfig
* eca093ecfe mainboard/asus/kgpe-d16: Remove obsolete reference to TPM ASL file
* 06a629e4b1 arch/x86: do not define type of SPIN_LOCK_UNLOCKED
* 75a3d1fb7c amdfam10: Perform major include ".c" cleanup
* a8025db49f amd-based mainboards: Fix whitespace in _PTS comments
* 3a0cb458dc cpu/amd/mtrr.h: Drop excessive includes
* 4607cacf30 cpu/x86/msr.h: Drop excessive includes
* 425890e59a AMD fam10h-15h: MMCONF_SUPPORT_DEFAULT is already set
* f2b8d7cbd6 mb/asus/kcma-d8,kgpe-d16: use MAINBOARD_DO_NATIVE_VGA_INIT
* 3b87812f00 Kconfig: Update default hex values to start with 0x
* b87a734771 mainboard/*/*/dsdt.asl: Use tabs for indents
* 6350a2e43f src/mainboard/a-trend - emulation: Add space around operators
* 7931c6a81d mb/asus/kgpe-d16: Add TPM support
* 64444268e2 mb/asus/[kgpe-d16|kcma-d8]: Fix whitespace errors in devicetree.cb
* d23ee5de22 mainboard: Clean up boot_option/reboot_bits in cmos.layout
* 8ab989e315 src/mainboard: Capitalize ROM, RAM, CPU and APIC
* bb9722bd77 Add newlines at the end of all coreboot files
* 95fe8fb1e0 mainboard: Format irq_tables.c
* 150f476c96 timestamp: Drop duplicate TS_END_ROMSTAGE entries
* ca543396a7 mainboard/asus/[kgpe-d16|kcma-d8]: Enable secondary serial port header
* 99894127ab mainboard/asus/[kgpe-di6|kcma-d8]: Fix board ROM information
````

#### ASUS KCMA-D8

Running `git log src/mainboard/asus/kcma-d8/` we get:

````
* cb3e16f287 AMD fam10: Remove HAVE_ACPI_RESUME support
* 04d025cf50 amdfam10: Declare get_sysinfo()
* 8560db6116 amdfam10: Declare empty activate_spd_rom() stub
* e39db681df src/mainboard: Add missing 'include <types.h>'
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 13f66507af device/mmio.h: Add include file for MMIO ops
* 065857ee7f arch/io.h: Drop unnecessary include
* f1b58b7835 device/pci: Fix PCI accessor headers
* 0c152cf1bb src: Remove unused include device/pnp_def.h
* 20c294884f amdfam10 boards: Simplify early resourcemap
* 22521ab2e6 amdfam10 boards: Drop extern on apicid_sp5100
* 2dce923524 mb: Move timestamp_add_now to northbridge/amd/amdfam10
* 9faae2b939 Kconfig: Unify power-after-failure options
* c70eed1e62 device: Use pcidev_on_root()
* 8803b21bbb amdfam10 boards: Use defaults for get_pci1234()
* b30e2bfe34 amdfam10 boards: Drop array bus_sp5100
* 6bc6c5548e amdfam10 boards: Use PCI_DEVFN()
* 651f4d231c amdfam10 boards: Drop array bus_sr5650
* 228746b346 amdfam10 boards: Drop const variable sbdn_sp5100
* af39e0ebc1 amdfam10 boards: Drop variable sbdn_sr5650
* c9394017db amdfam10 boards: Drop extern on bus_sr5650 and sbdn_sr5650
* c0b1be0ba1 amdfam10 boards: Call get_bus_conf() just once
* a2cfe9e900 amdfam10 boards: Add Makefiles and fix resourcemap.c
* d482c7dace amdfam10 boards: Drop global bus_isa variable
* 1db4e3a358 amdfam10 boards: Declare get_pci1234() just once
* a79b3f1c63 amdfam10 boards: Drop unused mb_sysconf.h
* a26b02466e drivers/aspeed/ast: Select `MAINBOARD_HAS_NATIVE_VGA_INIT`
* 21c8f9cab3 mainboard: Remove useless include <device/pci_ids.h>
* f0c5be2a4f mb/*/*/Kconfig: Remove useless comment
* 6d19a20f5f mb: Set coreboot as DSDT's manufacturer model ID
* 0cca6e24b7 ACPI: Fix DSDT's revision field
* f765d4f275 src: Remove unneeded include <lib.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* 1156b35a23 mainboard: Remove unneeded include <console/console.h>
* 718c6faff4 reset: Finalize move to new API
* e20dd19dde amdfam10: Convert to `board_reset()`
* 2c5652d72b mb: Fix non-local header treated as local
* 400ce55566 cpu/amd: Use common AMD's MSR
* dd35e2c8a9 mb: Use 'unsigned int' to bare use of 'unsigned'
* 068253c369 mb/*/*/cmos.default: Harmonise CMOS files syntax
* f716f2ac1a mb/*/*/cmos.default: Decrease debug_level to 'Debug'
* 65bb5434f6 src: Get rid of non-local header treated as local
* 08fc8fff25 src/mainboard: Fix typo
* 95bca33efa src/mb: Use "foo *bar" instead of "foo* bar"
* e0e1e64855 amdfam10: Drop tests for LATE_CBMEM_INIT
* d54e859ace mb/asus: Get rid of whitespace before tab
* 1bad4ce421 sb/amd/sr5650: Fix invalid function declarations
* 02b05d1f6b mb/asus: Get rid of device_t
* 482d16fb0a src/mainboard: Fix various typos
* ec48c749c2 AMD boards: Fix function name (soft_reset) in message
* 74bd2b0e4c mb/asus/kcma-d8,kgde-d16: Don't select SPI_FLASH_WINBOND
* b29078e401 mb/*/*: Remove rtc nvram configurable baud rate
* c2a921bec1 asus/kcma-d8: Add romstage_handoff
* a26377b063 asus/kcma-d8 kgpe/d16: Fix regression for shutdown
* 714709fde6 AMD fam10 ACPI: Use common fixed sleepstates.asl
* 90e07b460c AMD K8 fam10-15: Consolidate post_cache_as_ram call
* f95911ad37 mainboard/[a-e]: add IS_ENABLED() around Kconfig symbol references
* 26ce9af9a0 device/Kconfig: Introduce MAINBOARD_FORCE_NATIVE_VGA_INIT
* 00b9f4c4b1 mb/*/*/cmos.layout: Make multibyte options byte aligned
* 06a629e4b1 arch/x86: do not define type of SPIN_LOCK_UNLOCKED
* 75a3d1fb7c amdfam10: Perform major include ".c" cleanup
* a8025db49f amd-based mainboards: Fix whitespace in _PTS comments
* 3a0cb458dc cpu/amd/mtrr.h: Drop excessive includes
* 4607cacf30 cpu/x86/msr.h: Drop excessive includes
* 425890e59a AMD fam10h-15h: MMCONF_SUPPORT_DEFAULT is already set
* f2b8d7cbd6 mb/asus/kcma-d8,kgpe-d16: use MAINBOARD_DO_NATIVE_VGA_INIT
* 3b87812f00 Kconfig: Update default hex values to start with 0x
* b87a734771 mainboard/*/*/dsdt.asl: Use tabs for indents
* 6350a2e43f src/mainboard/a-trend - emulation: Add space around operators
* 64444268e2 mb/asus/[kgpe-d16|kcma-d8]: Fix whitespace errors in devicetree.cb
* d23ee5de22 mainboard: Clean up boot_option/reboot_bits in cmos.layout
* 8ab989e315 src/mainboard: Capitalize ROM, RAM, CPU and APIC
* bb9722bd77 Add newlines at the end of all coreboot files
* 95fe8fb1e0 mainboard: Format irq_tables.c
* 150f476c96 timestamp: Drop duplicate TS_END_ROMSTAGE entries
* ca543396a7 mainboard/asus/[kgpe-d16|kcma-d8]: Enable secondary serial port header
* 99894127ab mainboard/asus/[kgpe-di6|kcma-d8]: Fix board ROM information
````

#### ASUS KFSN4-DRE

Running `git log src/mainboard/asus/kfsn4-dre/` we get:

````
* ad0f485361 src/mainboard: change "unsigned" to "unsigned int"
* 12ef4f2d71 mb/asus/kfsn4-dre: Return early if CK804 not found
* 04d025cf50 amdfam10: Declare get_sysinfo()
* 8560db6116 amdfam10: Declare empty activate_spd_rom() stub
* a1e22b8192 src: Use 'include <string.h>' when appropriate
* cd49cce7b7 coreboot: Replace all IS_ENABLED(CONFIG_XXX) with CONFIG(XXX)
* 7362768c50 arch/io.h: Drop includes in fam10 romstages
* 3855c01e0a device/pnp: Add header files for PNP ops
* 065857ee7f arch/io.h: Drop unnecessary include
* bdaec07a85 arch/io.h: Add missing includes
* f1b58b7835 device/pci: Fix PCI accessor headers
* 8b9768effe amd: Remove unused defines
* 0c152cf1bb src: Remove unused include device/pnp_def.h
* 20c294884f amdfam10 boards: Simplify early resourcemap
* 2dce923524 mb: Move timestamp_add_now to northbridge/amd/amdfam10
* 993bc7098c amdfam10 boards: Use smp_write_pci_intsrc()
* e9fc8fd9b6 amdfam10 boards: Use PCI_DEVFN()
* 9faae2b939 Kconfig: Unify power-after-failure options
* c70eed1e62 device: Use pcidev_on_root()
* f112f9f912 amdfam10 boards: Use defaults for get_pci1234()
* c0b1be0ba1 amdfam10 boards: Call get_bus_conf() just once
* a2cfe9e900 amdfam10 boards: Add Makefiles and fix resourcemap.c
* d482c7dace amdfam10 boards: Drop global bus_isa variable
* 1db4e3a358 amdfam10 boards: Declare get_pci1234() just once
* 21c8f9cab3 mainboard: Remove useless include <device/pci_ids.h>
* f0c5be2a4f mb/*/*/Kconfig: Remove useless comment
* 6d19a20f5f mb: Set coreboot as DSDT's manufacturer model ID
* f765d4f275 src: Remove unneeded include <lib.h>
* ead574ed02 src: Get rid of duplicated includes
* d2b9ec1362 src: Remove unneeded include "{arch,cpu}/cpu.h"
* 1156b35a23 mainboard: Remove unneeded include <console/console.h>
* 718c6faff4 reset: Finalize move to new API
* e20dd19dde amdfam10: Convert to `board_reset()`
* 400ce55566 cpu/amd: Use common AMD's MSR
* dd35e2c8a9 mb: Use 'unsigned int' to bare use of 'unsigned'
* ddcf5a05e3 mb/asus/kfsn4-dre: Use common pnp_{enter,exit} functions
* 068253c369 mb/*/*/cmos.default: Harmonise CMOS files syntax
* f716f2ac1a mb/*/*/cmos.default: Decrease debug_level to 'Debug'
* 65bb5434f6 src: Get rid of non-local header treated as local
* 08fc8fff25 src/mainboard: Fix typo
* b0f1988f89 src: Get rid of unneeded whitespace
* 448d9fb431 src: Use "foo *bar" instead of "foo* bar"
* 7f268eab78 mainboard/asus: Add license headers
* 02b05d1f6b mb/asus: Get rid of device_t
* 963d312e62 mainboard/asus: Add spaces around '=='
* ec48c749c2 AMD boards: Fix function name (soft_reset) in message
* b29078e401 mb/*/*: Remove rtc nvram configurable baud rate
* 90e07b460c AMD K8 fam10-15: Consolidate post_cache_as_ram call
* f95911ad37 mainboard/[a-e]: add IS_ENABLED() around Kconfig symbol references
* d4ebeaf475 device/Kconfig: Put gfx init methods into a `choice`
* 00b9f4c4b1 mb/*/*/cmos.layout: Make multibyte options byte aligned
* ce642f08b9 Kconfig: Rework MAINBOARD_HAS_NATIVE_VGA_INIT_TEXTMODECFG
* 75a3d1fb7c amdfam10: Perform major include ".c" cleanup
* a8025db49f amd-based mainboards: Fix whitespace in _PTS comments
* 3a0cb458dc cpu/amd/mtrr.h: Drop excessive includes
* 4607cacf30 cpu/x86/msr.h: Drop excessive includes
* 425890e59a AMD fam10h-15h: MMCONF_SUPPORT_DEFAULT is already set
* 3b87812f00 Kconfig: Update default hex values to start with 0x
* b87a734771 mainboard/*/*/dsdt.asl: Use tabs for indents
* 6350a2e43f src/mainboard/a-trend - emulation: Add space around operators
* 837618bf20 mainboard/asus/*: transition away from device_t
* d23ee5de22 mainboard: Clean up boot_option/reboot_bits in cmos.layout
* 8ab989e315 src/mainboard: Capitalize ROM, RAM, CPU and APIC
* bb9722bd77 Add newlines at the end of all coreboot files
````

-------------------------------------------------------------------------------

I present unto thee:

The Free Firmware Song! Also known as the Libreboot Theme Song.

Sing it with me!

♫\
♫

Join us now and flash free firmware! ♫\
You’ll be free! Hackers, you’ll be free! ♪

Join us now and flash free firmware! ♫\
You’ll be free! Hackers, you’ll be free! ♪

NSA can spy on all of us, that is true. ♫\
Hackers, that is true. ♪\
But they cannot touch our firmware! ♫\
That is good. Hackers, that is good! ♪

When we have enough free firmware, at our call, ♫\
hackers, at our call: ♪\
We’ll kick out the management engine, evermore, ♫\
hackers, evermore! ♪

Join us now and flash free firmware! ♫\
You’ll be free! Hackers, you’ll be free! ♪

Join us now and flash free firmware! ♫\
You’ll be free! Hackers, you’ll be free! ♪

♫\
♫
