
## FIFO depth is 4Mb - 250k samples
set adc_fifo_address_width 16

## FIFO depth is 4Mb - 250k samples
set dac_fifo_address_width 15


source $ad_hdl_dir/projects/common/vcu118/vcu118_system_bd.tcl
source $ad_hdl_dir/projects/common/xilinx/adcfifo_bd.tcl
source $ad_hdl_dir/projects/common/xilinx/dacfifo_bd.tcl
source ../common/daq3_bd.tcl

ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_FBDIV 20
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_REFCLK_DIV 1
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG0 0x331C
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG1 0xD038
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG2 0xFC1
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG3 0x120
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG4 0x2
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG1_G3 0xD038
ad_ip_parameter util_daq3_xcvr CONFIG.QPLL_CFG2_G3 0xFC1

ad_ip_parameter util_daq3_xcvr CONFIG.CPLL_CFG0 0x3fe
ad_ip_parameter util_daq3_xcvr CONFIG.CPLL_CFG1 0x29
ad_ip_parameter util_daq3_xcvr CONFIG.CPLL_CFG2 0x203
ad_ip_parameter util_daq3_xcvr CONFIG.RX_CLK25_DIV 25
ad_ip_parameter util_daq3_xcvr CONFIG.TX_CLK25_DIV 25

ad_ip_parameter axi_ad9680_dma CONFIG.AXI_SLICE_DEST true
ad_ip_parameter axi_ad9680_dma CONFIG.AXI_SLICE_SRC true
ad_ip_parameter axi_ad9152_dma CONFIG.AXI_SLICE_DEST true
ad_ip_parameter axi_ad9152_dma CONFIG.AXI_SLICE_SRC true

set_property -dict [list CONFIG.ADVANCED_PROPERTIES { __view__ { clocking { SW0 { ASSOCIATED_CLK aclk1 } } }}] [get_bd_cells axi_mem_interconnect]

