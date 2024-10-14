.. _axi_ad9144:

AXI AD9144 (OBSOLETE)
================================================================================

.. hdl-component-diagram::

.. warning::
   This IP is was discontinued, limited support available. Last release for this
   IP is ``hdl_2019_r2`` and can be found on our HDL repository, on the branch
   with the same name.

The :git-hdl:`AXI AD9144 <hdl_2019_r2:library/axi_ad9144>`  IP core can be used
to interface the AD9144 DAC. An AXI Memory Map interface is used for
configuration. Data is sent in a format that can be transmitted by Xilinx's
JESD IP. More about the generic framework interfacing ADCs, that contains the
``up_adc_channel`` and ``up_adc_common modules``, can be read in :ref:`axi_adc`.

Features
--------------------------------------------------------------------------------

* AXI based configuration
* Hardware PRBS generation
* Hardware DDS generation
* Xilinx Vivado compatible
* Altera Quartus compatible

Files
--------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1

   * - Name
     - Description
   * - :git-hdl:`AXI AD9144 <hdl_2019_r2:library/axi_ad9144/axi_ad9144.v>`
     - Verilog source for the AXI AD9144.
   * - :git-hdl:`AXI AD9144 <hdl_2019_r2:library/axi_ad9144/axi_ad9144_ip.tcl>`
     - TCL script to generate the Vivado IP-integrator project.
   * - :git-hdl:`AXI AD9144 <hdl_2019_r2:library/axi_ad9144/axi_ad9144_hw.tcl>`
     - TCL script to generate the Quartus IP-integrator project.
   * - :git-hdl:`AXI AD9144 <hdl_2019_r2:library/axi_ad9144/axi_ad9144_constr.xdc>`
     - Constraint file of the IP.


Block Diagram
--------------------------------------------------------------------------------

.. image:: block_diagram.svg
   :alt: AXI AD9144 block diagram
   :align: center

Configuration Parameters
--------------------------------------------------------------------------------

.. hdl-parameters::

   * - ID
     - Core ID should be unique for each IP in the system
   * - QUAD_OR_DUAL_N
     - Selects if 4 lanes (1) or 2 lanes (0) are connected
   * - DAC_DATAPATH_DISABLE
     - The delay group name which is set for the delay controller

Interface
--------------------------------------------------------------------------------

.. hdl-interfaces::

   * - jesd_interface
     - Data to be connected to the JESD core
   * - s_axi
     - Standard AXI Slave Memory Map interface
   * - dma_interface
     - FIFO interface for connecting to the DMA
   * - dac_clk
     - Loopback of the tx_clk. Most of the modules of the core run on this clock
   * - dac_enable
     - Set when the channel is enabled, activated by software
   * - dac_valid
     - Set when valid data is available on the bus
   * - adc_enable
     - Set when the channel is enabled, activated by software
   * - dac_ddata
     - Data for channel samples
   * - dac_dovf
     - Data overflow input
   * - dac_dunf
     - Data underflow input

Detailed Architecture
--------------------------------------------------------------------------------

   .. image:: detailed_architecture.svg
      :alt: AXI AD9144 detailed architecture
      :align: center

Detailed Description
--------------------------------------------------------------------------------

The top module instantiates

* The ADC channel register map.
* The ADC common register map.
* The AXI handling interface.

The data from the interface module is processed by the ADC channel module.
The Up_adc_common  module implements the ADC COMMON register map, allowing for
basic monitoring and control of the ADC.
The Up_adc_channel module implements the ADC CHANNEL register map, allowing for
basic monitoring and control of the ADC's channel.

Register Map
--------------------------------------------------------------------------------

.. hdl-regmap::
   :name: COMMON
   :no-type-info:

.. hdl-regmap::
   :name: ADC_COMMON
   :no-type-info:

.. hdl-regmap::
   :name: ADC_CHANNEL
   :no-type-info:

Design Guidelines
--------------------------------------------------------------------------------

The control of the chip is done through an SPI interface, which is needed at the
system level.
The :ref:`template_ip interface` must be connected directly to the top file of
the design, as IO primitives are part of the  IP.

The example design uses a DMA to move the data from the output of the IP to memory.
If the data needs to be processed in HDL before moving to the memory, it can be
done at the output of the IP (at the system level) or inside the ADC interface
module (at the IP level).

The example design uses a processor to program all the registers.

If no processor is available in your system, you can create your IP starting
from the interface module.

Software Guidelines (if necessary)
--------------------------------------------------------------------------------

To note all the details needed by the software to be in a certain way.

Software Support
--------------------------------------------------------------------------------

* Linux device driver at :git-linux:`/`
* Linux device tree at :git-linux:`/`
* Linux documentation at ...
* No-OS device driver at :git-no-os:`/`
* No-OS project at :git-no-os:`/`
* No-OS documentation at ...
* IIO support at ...

References
--------------------------------------------------------------------------------

* HDL IP core at :git-hdl:`library/axi_ad9783`
* HDL project at :git-hdl:`projects/ad9783_ebz`
* HDL project documentation at :ref:`ad9783_ebz`
* :adi:`AD9783`
* :xilinx:`Zynq-7000 SoC Overview <support/documentation/data_sheets/ds190-Zynq-7000-Overview.pdf>`.
* :xilinx:`Zynq-7000 SoC Packaging and Pinout <support/documentation/user_guides/ug865-Zynq-7000-Pkg-Pinout.pdf>`.