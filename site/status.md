---
title: Code review
...

GNU Boot 0.1 RC3 status
=======================

+----------+-----------------+-----------+-----------------------------+
| Vendor   | Product         | Stability | Installation instructions   |
+----------+-----------------+-----------+-----------------------------+
| Acer     | G43T-AM3        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | MacBook 1.1     | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | MacBook 2.1     | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | iMac 5,2        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | Chromebook C201 | Can't install due to missing images     |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KCMA-D8         | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KFSN4-DRE       | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KGPE-D16        | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Gigabyte | D945GCLF2D      | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Gigabyte | GA-G41M-ES2L    | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D410PT          | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D510MO          | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D945GCLF        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad R400   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad R500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T400   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T400S  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T60    | Untested  | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad W500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200S  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200T  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X301   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60    | Untested  | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60T   | Untested  | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60s   | Untested  | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Qemu     | PC (i440FX)     | Untested  | Missing                     |
+----------+-----------------+-----------+-----------------------------+

Stability:
----------

* Untested: The GNU Boot maintainers are not aware of anybody who
  tested GNU Boot 0.1 RC1 on that computer. If you have GNU Boot on
  this computer please report if it works or not (for instance by
  opening a bug report).

* Tested: Someone tested GNU Boot 0.1 RC1 on that computer and
  reported to the GNU Boot that it at least booted fine.

* Daily users: Some people contacted the GNU Boot maintainers and
  volunteered to send bug reports if installing GNU Boot made the
  computer unusable or very hard to use (like a memory corruption that
  makes it impossible to boot certain GNU/Linux distributions or
  crashes the computer randomly). If you want to help GNU Boot
  with that, please contact the maintainers through a bug report.

Installation instructions:
--------------------------

* Untested: Nobody tested the GNU Boot installation instructions for
  this computer.

* Can be simplified: There is work in progress to simplify the
  instructions by having GNU Boot release the tools required to do the
  installation and by requiring to keep the computer connected to the
  electricity (by keeping its power supply connected) instead of
  requiring to disassemble it to check a battery voltage.

* Tested: The installation instructions worked well.

* Missing: There are no installation instructions for this device and
  we need help from contributors to add them.

GNU Boot 0.1 RC2 status
=======================

There are no changes affecting images between GNU Boot 0.1 RC2 and GNU
Boot 0.1 RC3 so it's not worth testing the RC2. It's better to test
the RC3 directly. Yet GNU Boot maintainers tested some computers on
the RC2 to reduce the risk of testers.

+----------+-----------------+-----------+-----------------------------+
| Vendor   | Product         | Stability | Installation instructions   |
+----------+-----------------+-----------+-----------------------------+
| Apple    | MacBook 1.1     | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | MacBook 2.1     | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | iMac 5,2        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | Chromebook C201 | Can't install due to missing images     |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KCMA-D8         | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KFSN4-DRE       | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KGPE-D16        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Gigabyte | D945GCLF2D      | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Gigabyte | GA-G41M-ES2L    | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D410PT          | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D510MO          | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D945GCLF        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad R400   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad R500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T400   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T400S  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T60    | Tested    | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad W500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200S  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200T  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X301   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60    | Tested    | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60T   | Tested    | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60s   | Untested  | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Qemu     | PC (i440FX)     | Tested    | Missing                     |
+----------+-----------------+-----------+-----------------------------+

See the status of GNU Boot 0.1 RC3 above for the meaning of the
various fields.

GNU Boot 0.1 RC1 status
=======================

+----------+-----------------+-----------+-----------------------------+
| Vendor   | Product         | Stability | Installation instructions   |
+----------+-----------------+-----------+-----------------------------+
| Apple    | MacBook 1.1     | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | MacBook 2.1     | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Apple    | iMac 5,2        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | Chromebook C201 | Can't install due to missing images     |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KCMA-D8         | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KFSN4-DRE       | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Asus     | KGPE-D16        | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Gigabyte | D945GCLF2D      | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Gigabyte | GA-G41M-ES2L    | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D410PT          | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D510MO          | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Intel    | D945GCLF        | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad R400   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad R500   | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T400   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T400S  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T500   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad T60    | Tested    | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad W500   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200S  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X200T  | Untested  | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X301   | Tested    | Untested                    |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60    | Tested    | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60T   | Tested    | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+
| Lenovo   | Thinkpad X60s   | Untested  | Untested, can be simplified |
+----------+-----------------+-----------+-----------------------------+

See the status of GNU Boot 0.1 RC3 above for the meaning of the
various fields.

Upstream status
===============

+----------+-----------------+---------------------------+---------------------+
| Vendor   | Product         | Coreboot status           | Coreboot GPU driver |
+----------+-----------------+---------------------------+---------------------+
| Apple    | MacBook 1.1     | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Apple    | MacBook 2.1     | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Apple    | iMac 5,2        | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Asus     | Chromebook C201 | Unmaintained              |                     |
+----------+-----------------+---------------------------+---------------------+
| Asus     | KCMA-D8         | Removed                   |                     |
+----------+-----------------+---------------------------+---------------------+
| Asus     | KFSN4-DRE       | Removed                   |                     |
+----------+-----------------+---------------------------+---------------------+
| Asus     | KGPE-D16        | Removed                   |                     |
+----------+-----------------+---------------------------+---------------------+
| Gigabyte | D945GCLF2D      | Similar to Intel D945GCLF |                     |
+----------+-----------------+---------------------------+---------------------+
| Gigabyte | GA-G41M-ES2L    | Unmaintained              |                     |
+----------+-----------------+---------------------------+---------------------+
| Intel    | D410PT          | Unmaintained              |                     |
+----------+-----------------+---------------------------+---------------------+
| Intel    | D510MO          | Unmaintained              |                     |
+----------+-----------------+---------------------------+---------------------+
| Intel    | D945GCLF        | Unmaintained              | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad R400   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad R500   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad T400   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad T400s  | Similar to Thinkpad T400  | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad T500   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad T60    | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad W500   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X200   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X200s  | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X200T  | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X301   | Maintained                | new GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X60    | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X60T   | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+
| Lenovo   | Thinkpad X60s   | Maintained                | old GPU driver      |
+----------+-----------------+---------------------------+---------------------+

Coreboot status:
----------------

* Maintained / Unmaintained: GNU Boot depends on Coreboot to support
  specific computers. So if Coreboot stops supporting a computer that
  GNU Boot supports, then it will become harder and harder to support
  that computer in GNU Boot over time and at some point GNU Boot will
  likely stop supporting it unless someone adds back that computer in
  Coreboot. And if a computer has no maintainer in Coreboot it
  increases the likelihood that it will be removed at some point.

* Removed: Coreboot already removed the support for this computer.

* Similar to <another computer>: There is no official support for this
  computer in Coreboot but using the code from the other computer
  mentioned works.

Coreboot GPU driver:
--------------------

* old GPU driver / new GPU driver: Some computers uses an old GPU
  driver written in C that could have some stability issues that were
  fixed in the new GPU driver written in ADA. When the field is blank,
  it means that we didn't look at which GPU driver was used or its
  stability.

Upstream versions used in GNU Boot 0.1 RC3
==========================================

+------------------+---------+------------+------------------------------------+
| Upstream project | Version | Needs      | Computers using it                 |
|                  |         | deblobbing |                                    |
+------------------+---------+------------+------------------------------------+
| Coreboot         |   4.11+ | Yes        | Asus: KCMA-D8, KFSN4, KGPE-D16     |
+------------------+---------+------------+------------------------------------+
| Coreboot         |   4.15+ | Yes        | All but Asus KCMA-D8, KFSN4,       |
|                  |         |            | KGPE-D16.                          |
+------------------+---------+------------+------------------------------------+
| GRUB             |   2.06+ | No         | All supported computers            |
+------------------+---------+------------+------------------------------------+
| Memtest86+       |         |            | All but Gigabyte GA-G41M-ES2L and  |
| for Coreboot     |   v002+ | No         | Intel D510MO                       |
+------------------+---------+------------+------------------------------------+
| SeaBIOS          | 1.14.0+ | No         | All supported computers            |
+------------------+---------+------------+------------------------------------+
