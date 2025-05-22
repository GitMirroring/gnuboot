title: KGPE-D16 external flashing instructions 
x-unreviewed: true
---

Initial flashing instructions for KGPE-D16.

This guide is for those who want libreboot on their ASUS KGPE-D16
motherboard, while they still have the proprietary ASUS BIOS present.
This guide can also be followed (adapted) if you brick you board, to
know how to recover.

*Memory initialization is still problematic, for some modules. We
recommend avoiding Kingston modules.*

For more general information about this board, refer to
[../hardware/kgpe-d16.md](../hardware/kgpe-d16.md).

TODO: show photos here, and other info.

External programmer 
===================

Refer to [spi.md](spi.md) for a guide on how to re-flash externally.

The flash chip is in a PDIP 8 socket (SPI flash chip) on the
motherboard, which you take out and then re-flash with libreboot, using
the programmer. *DO NOT* remove the chip with your hands. Use a chip
extractor tool.
