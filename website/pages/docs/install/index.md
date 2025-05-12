---
title: Get GNU Boot
...

Buy a computer with GNU Boot
============================

The FSF maintains a [certification](https://ryf.fsf.org) for computers
that mostly work without nonfree software.

Some (not all) of the computers that received the certification are
compatible with GNU Boot. In the case of
[Technoetical](https://ryf.fsf.org/vendors/Technoethical), the
computers that are compatible already come with GNU Boot installed.

As companies listed by the certification are business they are also
supposed to take care of things behind the hood such as testing
against hardware defects to make sure that all the hardware work with
free software (by replacing the WiFi card), make sure the hardware
really work, etc, and it might be the easiest way for non-technical
users to get GNU Boot.

See the [GNU Boot status page](../../status.md) for which RYF
computers are compatible with GNU Boot.

If you are a hardware vendor that is or was listed in
https://ryf.fsf.org/vendors/ and that you sold computers that are
compatible with GNU Boot, please [contact the GNU Boot
project](../../contact.md): we are looking for information on the
product being sold (flash chip size, customization, etc) to best
support them.

GNU Boot install parties
========================

Sometimes there are install parties that can help you install GNU Boot
and/or install it for you on a computer supported by the install party
(and GNU Boot).

It can be cheaper than buying a computer with GNU Boot, but the
install parties typically don't take care of everything.

First you will obviously need to find a compatible computer and doing
so without running nonfree software (like nonfree JavaScript) is
complicated.

Then install parties don't have replacement for batteries, WiFi cards
to get WiFi that work with free software, etc, and they work with the
hardware you bring to them. So if the hardware has defects they won't
be able to fix it.

Known install parties:

* In May 2024 there was a GNU Boot install party at the Libreplanet
  conference. Since this conference happens every year, you might want
  to check next year(s) if there is a GNU Boot install party there.

Installation instructions
=========================

There are various instructions to install GNU Boot yourself or to help
each other to do it together (this could be easier and faster).

When reading or following such instructions it's important to keep in
mind that:

* You always need to look at the [status page](status.md) to find out
  if the image you are about to install is known to work.

  If the image is not known to work, it could prevent your computer
  from booting. To fix that you will most likely need to disassemble
  your computer and use another computer and a flash programmer to
  recover it. This is exactly how people who test untested images do
  when things go wrong.

  There are also instructions to recover from non-booting computers on
  the GNU Boot website. Make sure to consult them first if you want to
  help the GNU Boot project to test images and that you are not
  familiar yet with how to recover a specific computers (the
  difficulty can vary a lot depending on the computer and your
  existing skills).

* You also need to make sure to use the right image for the computer.
  An image for the T400 will probably not work on the X301, and there
  is also the risk of breaking the computer for good if you use the
  wrong image because in some cases the code in the images is also
  responsible for setting the right voltage. It's also a important to
  know the version of GNU Boot you are installing because you need
  that to check the status page.

* Before installing or upgrading (to) GNU Boot, it is important to do
  a backup of what is in the flash chip you are about to
  override. This way if things are worse in the new image, you can
  still revert to the previous image.

  If you are testing images that were not tested before, it is also a
  good idea to put the backup somewhere that you can easily access if
  the computer doesn't boot anymore.

Upgrade yourself from an existing installation
----------------------------------------------

There is [general purpose documentation](install.md) for technical
users that can help you upgrade to a newer GNU Boot version.

Installation
------------

There is [general purpose documentation](install.md) for technical
users that can help you install GNU Boot.

Downloads
---------

The [Downloads](../../download.md) page has documentation on how to
download GNU Boot in various ways.

However if you want to install GNU Boot, it is very strongly advised
to use the install or upgrade documentation, as it contain tips that
help you avoid to breaking your computer.
