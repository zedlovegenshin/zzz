.. _build_intel_boot_bin:

INTEL
===============================================================================

Necessary files for booting up a HDL project
-------------------------------------------------------------------------------

When booting a system with Linux + HDL (depending on the project), you will need
to write the following files on the root of the BOOT FAT32 partition. After that,
you must write the preloader image in a specific card partition, depending on
the case. 

-  For Arria10 SoC projects:

   -  ``socfpga_arria10-common/zImage``
   -  ``<target>/fit_spl_fpga.itb``
   -  ``<target>/socfpga_arria10_socdk_sdmmc.dtb``
   -  ``<target>/u-boot.img``
   -  ``<target>/extlinux.conf → extlinux /extlinux.conf``
   -  ``<target>/u-boot-splx4.sfp`` to the corresponding SD card partition
      (e.g. ``dd if=preloader_bootloader.bin of=/dev/mmcblk0p3``,
      usually it is the 3rd partition, which is only a couple of MB in size)

-  For Cyclone5 SoC projects:

   -  ``<target>/soc_system.rbf``
   -  ``<target>/socfpga.dtb``
   -  ``<target>/uImage``
   -  ``<target>/preloader_bootloader.img`` to the corresponding SD card
      partition (e.g. ``dd if=preloader_bootloader.img of=/dev/mmcblk0p3``)

-  For De10Nano SoC project:

   -  ``socfpga_cyclone5_common/zImage``
   -  ``<target>/extlinux.conf → extlinux /extlinux.conf``
   -  ``<target>/u-boot.scr``
   -  ``<target>/socfpga.dtb``
   -  ``<target>/soc_system.rbf``
   -  ``<target>/u-boot-with-spl.sfp`` to the corresponding SD card partition
      (e.g. ``dd if=u-boot-with-spl.sfp of=/dev/sdd3``)

Examples of building the boot image
-------------------------------------------------------------------------------

Below is a list of projects supported by us for each carrier to illustrate how
to build and showcase the different files that are involved in the process.

ADRV9371 + Arria 10 SoC Development Kit
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*Example*

ARRADIO + Terasic SoCkit Development Kit
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*Example*