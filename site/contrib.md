---
title: Project contributors
x-toc-enable: true
...

This list does not necessarily reflect who is currently working on the project,
but it lists some people who have contributed to the project in meaningful ways.

If we forgot to mention you here, let us know and we'll add you. (or if
you don't want to be mentioned, let us know and we'll remove your
entry)

Information about who works on Libreboot, and how the project is run, can
be found on this page: [who.md](who.md)

You can know the history of the Libreboot project, simply by reading this page.
It goes into detail about all of the major contributions to the project, and in
general how the project was created (and who helped create it).

Leah Rowe
---------

**Founder of the Libreboot project, and currently the lead developer.** Leah
works on all aspects of Libreboot, such as:

* General management. Leah handles all outside contributions to Libreboot,
  reviews pull requests, deals with bug reports, delegates tasks when necessary
  or desirable. Leah controls the libreboot.org server infrastructure, hosted
  in her lab (of course it runs Libreboot!)
* Leah has the final say on all decisions, taking input via discussion with
  members of the public, mostly on IRC. Leah oversees releases of Libreboot,
  and generally keeps the project going. Without Leah, there would be no Libreboot!
* The build system (lbmk, short for Libreboot Make). This is the automated build
  system that sits at the heart of Libreboot; it downloads, patches, configures
  and compiles the relevant components like coreboot, GNU GRUB and generates
  the Libreboot ROM images that you can find in release archives.
* Upstream work on coreboot, when necessary (and other projects that Libreboot
  uses). This means also working with people from outside of the Libreboot
  project, to get patches merged (among other things) on the upstream projects
  that Libreboot uses
* Providing user support on IRC
* *Commercial* user support via her company listed
  on [the suppliers page](/suppliers.md)

Leah is also responsible for [osboot.org](https://osboot.org/) which is heavily
based on Libreboot, but with different project goals.

Other people are listed below, in alphabetical order:

Alyssa Rosenzweig
-----------------

Switched the website to use markdown in lieu of handwritten HTML and custom
PHP. **Former libreboot project maintainer (sysadmin for libreboot.org).**

Alyssa wrote the original static site generator (bash scripts converting
markdown to html, via pandoc) for libreboot.org. This static site generator has
now been heavily modified and forked into a formal project, by Leah Rowe:

<https://untitled.vimuser.org/> (untitled is Leah's work, not Alyssa's, but it's based on
Alyssa's original work on the static site generator that Libreboot used to use;
the Libreboot website is now built with Untitled)

Andrew Robbins
--------------

Worked on large parts of Libreboot's old build system and related documentation.
Andrew joined the Libreboot project as a full time developer during June 2017,
until his departure in March 2021.

I, Leah Rowe, am very grateful to Andrew Robbins for his numerous contributions
over the years.

Arthur Heymans
--------------

Merged a patch from coreboot into libreboot, enabling C3 and C4 power
states to work correctly on GM45 laptops. This was a long-standing issue
before Athur's contribution. Arthur also fixed VRAM size on i945 on
GM45 systems, allowing maximum VRAM allocation for the onboard GPUs on
these systems, another longstanding issue in libreboot.

Arthur also did work on the Libreboot build system, when he was a member of the
project. He still works on coreboot, to this day, and Libreboot greatly
benefits from his work. His contributions to the coreboot project, and Libreboot,
are invaluable.

Damien Zammit
-------------

Maintains the Gigabyte GA-G41M-ES2L coreboot port, which is integrated
in libreboot. Also works on other hardware for the benefit of the
libreboot project.

Damien didn't work directly on Libreboot itself, but he worked heavily with
Leah Rowe, integrating patches and new board ports into Libreboot, based on
Damien's upstream work on coreboot.

Denis Carikli
-------------

Based on the work done by Peter Stuge, Vladimir Serbineko and others in
the coreboot project, got native graphics initialization to work on the
ThinkPad X60, allowing it to be supported in libreboot. Denis gave
a lot of advice and helped found the libreboot project.

Denis was a mentor to Leah Rowe in the early days, when she founded the
Libreboot project. A lot of the decision decisions taken, especially with the
Libreboot build system (lbmk), were inspired from talks with Denis.

Denis taught Leah about registers used by Intel GPUs for backlight control. In
the early days, the ThinkPad X60 and T60 laptops in Libreboot did not have
backlight control working, so the brightness was always 100%. With Denis's help,
Leah was able to get backlight controls working by reverse engineering the
correct values to write in those registers. Based on this, a simple fix was
written in coreboot; however, the fix just wrote directly to the register and
didn't work with ACPI based brightness controls. Others in coreboot later
improved it, making ACPI-based backlight controls work properly, based on this
earlier work.

Jeroen Quint
------------

Contributed several fixes to the libreboot documentation, relating to
installing Parabola with full disk encryption on libreboot systems.

Joshua Gay
----------

Joshua is former FSF staff.

Joshua helped with the early founding of the Libreboot project, in his capacity
(at that time) as the FSF's licensing and compliance manager. It was his job to
review products sent into to the FSF for review; the FSF has a certification
program called *Respects Your Freedom* (RYF) where the FSF will promote your
company's products if it comes with all Free Software.

I, Leah Rowe, was initially just selling ThinkPad X60 laptops with regular
coreboot on them, and this included CPU microcode updates. At the time, I didn't
think much of that. Joshua contacted me, in his capacity at the FSF, and asked
if I would be interested in the FSF's RYF program; I was very surprised that the
FSF would take me seriously, and I said yes. This is what started the early
work on Libreboot. Joshua showed me all the problems my products had, and from
that, the solution was clear:

A project needed to exist, providing a fully free version of coreboot, without
any binary blobs. At the time (and this is still true today), coreboot was not
entirely free software and shipped with binary blobs by default. In particular,
CPU microcode updates were included by default, on all x86 machines. Working
with Joshua who reviewed my work, I created a fully free version of coreboot.
At first, it wasn't called Libreboot, and the work was purely intended for my
company (at that time called Gluglug) to be promoted by the FSF.

Joshua used his media connections at the FSF to heavily promote my work, and
on December 13th, 2013, the Libreboot project was born (but not called that).
Joshua made sure that everyone knew what I was doing!

A few months later, the name *Libreboot* was coined, and the domain name
*libreboot.org* was registered. At that point, the Libreboot project (in early
2014) was officially born. Once again, Joshua provided every bit of help he
could, heavily promoting the project and he even wrote this article on the FSF
website, announcing it:

<https://www.fsf.org/blogs/licensing/replace-your-proprietary-bios-with-libreboot>

Klemens Nanni
-------------

Made many fixes and improvements to the GRUB configuration used in
libreboot, and several tweaks to the build system.

Leah Rowe initially helped Klemens get his project, autoboot, off the ground.
Autoboot (website autoboot.org) is no longer online, but was a fork of Libreboot
with different project goals; in late 2020, Leah Rowe decided to create her
own new fork of Libreboot called *osboot*, heavily inspired by Klemens's earlier
work. See: <https://osboot.org/>

The following is an archive of autoboot.org, from when it was online back in
2016: <http://web.archive.org/web/20160414205513/http://autoboot.org/> (the
autoboot website went offline a few months later, after Klemens abandoned the
project)

Lisa Marie Maginnis
-------------------

Lisa is a former sysadmin at the Free Software Foundation. In the early days of
the project, she provided Leah with a lot of technical advice. She initially
created Libreboot IRC channel, when Leah did not know how to
use IRC, and also handed +F founder status to Leah for the channel. As an FSF
sysadmin, it was Lisa's job to maintain a lot of the infrastructure used by
Libreboot; at the time, mailing lists on the GNU Savannah website were used by
the Libreboot project. Lisa was also the one who originally encouraged Leah to
have Libreboot join the GNU project (a decision that was later, rather
regrettably, reversed). When Paul Kocialkowski was a member of the project in
2016, she helped him get help from the FSF; he was the leader of the Replicant
project at the time, which had funding from the FSF, and the FSF authorized him
to use some of that funding for his work on Libreboot, thanks to Lisa's
encouragement while she worked at the FSF.

Lisa also stepped in when Leah Rowe missed her LibrePlanet 2016 talk. Leah was
scheduled to do a talk about Libreboot, but didn't show up in time. Lisa, along
with Patrick McDermott (former Libreboot developer, who was present at that
conference) did the talk in Leah's place. The talk was never recorded, but the
Free Software Foundation has these photos of that talk on their LibrePlanet
website (the woman with the blue hair is Lisa, and the long-haired dude with the
moustache is Patrick):

<https://media.libreplanet.org/u/libreplanet/m/session-02-c-mws-png-libreplanet-2016-sessions/>
(archive link: <http://web.archive.org/web/20170319043913/https://media.libreplanet.org/u/libreplanet/m/session-02-c-mws-png-libreplanet-2016-sessions/>)

<https://media.libreplanet.org/u/libreplanet/m/session-02-c-wide-png-libreplanet-2016-sessions/>
(archive link: <http://web.archive.org/web/20170319043915/https://media.libreplanet.org/u/libreplanet/m/session-02-c-wide-png-libreplanet-2016-sessions/>)

Fun fact: Patrick is also the lead developer of ProteanOS, an FSF-endorsed
embedded OS project: <http://proteanos.com/> (uses BusyBox and Linux-libre)

Leah Rowe ran *2* LibrePlanet workshops; one in 2015 and another in 2016, while
visiting Boston, MA, USA on both occasions to attend these conferences. These
workshops were for Libreboot installations. People came to both workshops, to
have Libreboot installed onto their computers. As FSF sysadmin, at that time,
Lisa provided all of the infrastructure and equipment used at those workshops.
Without her help, those workshops would have not been possible.

When the ASUS KGPE-D16 mainboard (high-end server board) was ported to Libreboot,
Leah, working with Timothy Pearson (the one who ported it), shared patches back
and forth with Lisa around mid 2016, mostly raminit patches, to get the board
running at the FSF offices. This work ultimately lead to a most wonderful
achievement:

The <https://www.gnu.org/> and <https://www.fsf.org/> websites now run on
Librebooted ASUS KGPE-D16 based servers, on a fully free GNU+Linux distro. This
means that the FSF now has full software freedom for their hosting infrastructure.

The FSF also provides access to this infrastructure for many other projects
(besides GNU projects); for example, Trisquel uses a D16 provided by the FSF
for their development server used for building Trisquel releases and testing
changes to the Trisquel GNU+Linux distribution. Trisquel is a fully free
GNU+Linux distribution, heavily promoted by the FSF.

Lisa was a strong supporter of Libreboot in the very early days of the project,
and her contributions were invaluable. I, Leah Rowe, owe her a debt of gratitude.

Marcus Moeller
--------------

Made the libreboot logo.

Patrick "P. J." McDermott
---------------------------

Patrick also did a lot of research and wrote the libreboot FAQ section
relating to the [Intel Management Engine](../faq.md#intelme), in addition
to making several improvements to the build system in libreboot. **Former
libreboot project maintainer.**

In 2016, Leah Rowe ran a Libreboot installation workshop at the FSF's
LibrePlanet conference. Working alongside Leah, Patrick helped run the workshop
and assisted with installing Libreboot onto people's machines.

Paul Kocialkowski
-----------------

Ported the ARM (Rockchip RK3288 SoC) based *Chromebook* laptops to
libreboot. Also one of the main [Replicant](http://www.replicant.us/)
developers.

Paul Menzel
-----------

Investigated and fixed a bug in coreboot on the ThinkPad X60/T60 exposed
by Linux kernel 3.12 and up, which caused 3D acceleration to stop
working and video generally to become unstable. The issue was that coreboot,
when initializing the Intel video chipset, was mapping *GTT Stolen Memory* in
the wrong place, because the code was based on kernel code and the Linux kernel
had the same bug. When Linux fixed it, it exposed the same bug in coreboot.

Paul worked with Libreboot on
this, sending patches to test periodically until the bug was fixed
in coreboot, and then helped her integrate the fix in libreboot.

Peter Stuge
-----------

Helped write the [FAQ section about DMA](../faq.md#hddssd-firmware), and provided
general advice in the early days of the project. Peter was a coreboot developer
in those days, and a major developer in the *libusb* project (which flashrom
makes heavy use of).

Peter also wrote the *bucts* utility used to set Backup Control (BUC) Top Swap
(TS) bit on i945 laptops such as ThinkPad X60/T60, which is useful for a
workaround to flash Libreboot without using external hardware; on this machine,
with Lenovo BIOS present, it's possible to flash everything except the main
bootblock, but Intel platforms have 2 bootblocks, and you specify which one is
to be used by setting the TS bit. You then boot with only one bootblock flashed
(by the coreboot project's bootblock on that machine), and afterwards you reset
bucts before flashing the ROM again, to flash the main bootblock. Libreboot
hosts a copy of his work, because his website hosting bucts is no longer
responsive.

Steve Shenton
-------------

Steve did the early reverse engineering work on the Intel Flash Descriptor used
by ICH9M machines such as ThinkPad X200. He created a C struct defining (using
bitfields in C) this descriptor region. With some clever tricks, he was able to
discover the existence of a bit in the descriptor for *disabling* the Intel ME
(management engine) on those platforms.

His initial proof of concept only defined the descriptor, and would do this:

* Read the default descriptor and GbE regions from a Lenovo X200 ROM (default
  firmware, not coreboot)
* Disable the ME, by setting 2 bits in the descriptor
* Disable the ME region
* Move descriptor+GbE (12KiB in total) next to each other
* Allocate the remaining flash space to the BIOS region
* Generated the 12KiB descriptor+GbE region, based on this, to insert into a
  coreboot ROM image.

In the early days, before Libreboot supported GM45+ICH9M platforms such as
ThinkPad X200/T400, you could use those machines but to avoid the Intel ME you
had to flash it without a descriptor region. This worked fine in those days,
because the ME only handled TPM and AMT on those machines, and the system would
work normally, but that Intel Flash Descriptor also handles the Intel GbE NVM
region in flash, which is used for the Intel Gigabit Ethernet interface.

So you either had Intel ME, or no ethernet support. Steve figured out how to
disable the Intel ME via 2 toggle bits in the descriptor, and also how to
remove the Intel ME region from flash.

Based on his research, I, Leah Rowe, working alongside Steve, also reverse
engineered the layout of the Intel GbE NVM (non-volatile memory) region in the
boot flash. This region defines configuration options for the onboard Intel
GbE NIC, if present.

Based on this, I was able to take Steve's initial proof of concept and write
the `ich9gen` utility, which generates an Intel Flash Descriptor and GbE NVM
region, from scratch, without an Intel ME region defined. It is this tool,
the `ich9gen` tool, that Libreboot uses to provide ROM images for GM45+ICH9M
platforms (such as ThinkPad X200/T400/T500/W500), with a fully functional
descriptor and functional Gigabit Ethernet, but *without* needing Intel
Management Engine (ME) firmware, thus making those machines *libre* (the ME
is fully disabled, when you use a descriptor+gbe image generated by `ich9gen`).

With *my* `ich9gen` tool (Steve's tool was called `ich9deblob`), you didn't
need a dump of the original Lenovo BIOS firmware anymore! I could not have
written this tool, without Steve's initial proof of concept. I worked with him,
extensively, for many months. All GM45+ICH9M support (X200, T400, etc) in
Libreboot is made possible because of the work he did, back in 2014.

Swift Geek
----------

Contributed a patch for ich9gen to generate 16MiB descriptors.

After that, Swift Geek slowly became more involved until he became a full time
developer. Swift Geeks contributions were never really in the form of *code*,
but what he lacked in code, he made up for in providing excellent support, both
to users and other developers, helping others learn more about technology at a
low level.

When Swift Geek was a member of the project, his role was largely providing
user support (in the IRC channel), and conducting research. Swift Geek knows a
lot about hardware. Swift Geek also did some upstream development on GNU GRUB.

Swift Geek has provided technical advice on numerous occasions, to Leah Rowe,
and helped her to improve her soldering skills in addition to teaching her
some repair skills, to the point where she can now repair most faults on
ThinkPad mainboards (while looking at the schematics and boardview).

Swiftgeek left the project in March 2021. I, Leah Rowe, wish him all the best
in his endeavours, and I'm very grateful to his numerous contributions over the
years.

Timothy Pearson
---------------

Ported the ASUS KGPE-D16 board to coreboot for the company Raptor
Engineering of which Timothy is the CEO.
Timothy maintains this code in coreboot,
helping the project with the libreboot integration for it. This person's
contact details are on the raptor site, or you can ping **tpearson** on
the Libera IRC network.

vitali64
--------

Added cstate 3 support on macbook21, enabling higher battery life and cooler
CPU temperatures on idle usage. vitali64 on irc

Vladimir Serbinenko
-------------------

Ported many of the thinkpads supported in libreboot, to coreboot, and
made many fixes in coreboot which benefited the libreboot project.

Vladimir wrote a lot of the original video initialization code used by various
Intel platforms in Libreboot, when flashing it (now rewritten
by others in Ada, for libgfxinit in coreboot, but originally it was written in
C and included directly in coreboot; libgfxinit is a 3rdparty submodule of
coreboot).
