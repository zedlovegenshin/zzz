## ADC FIFO depth in samples per converter
set adc_fifo_samples_per_converter [expr $ad_project_params(RX_KS_PER_CHANNEL)*1024]
## DAC FIFO depth in samples per converter
set dac_fifo_samples_per_converter [expr $ad_project_params(TX_KS_PER_CHANNEL)*1024]

source $ad_hdl_dir/projects/scripts/adi_pd.tcl
source $ad_hdl_dir/projects/common/fm87/fm87_system_qsys.tcl
source $ad_hdl_dir/projects/common/intel/dacfifo_qsys.tcl
source $ad_hdl_dir/projects/common/intel/adcfifo_qsys.tcl

set jesd204_ref_clock [format {%.6f} $ad_project_params(REF_CLK_RATE)]
# DUT F-Tile Ref clock
add_instance systemclk systemclk_f
set_instance_parameter_value systemclk syspll_mod_0 {User Configuration}
set_instance_parameter_value systemclk syspll_refclk_src_0 {RefClk #2}
set_instance_parameter_value systemclk syspll_freq_mhz_0 200.000000
set_instance_parameter_value systemclk refclk_fgt_output_enable_2 1
set_instance_parameter_value systemclk refclk_fgt_freq_mhz_2 $jesd204_ref_clock

add_interface ref_clk_fgt_2 clock sink
set_interface_property ref_clk_fgt_2 EXPORT_OF systemclk.out_refclk_fgt_2

add_interface ref_clk_in clock sink
set_interface_property ref_clk_in EXPORT_OF systemclk.refclk_fgt

set TRANSCEIVER_TYPE "F-Tile"
if [info exists ad_project_dir] {
  source ../../common/ad9081_fmca_ebz_qsys.tcl
} else {
  source ../common/ad9081_fmca_ebz_qsys.tcl
}

#system ID
set_instance_parameter_value axi_sysid_0 {ROM_ADDR_BITS} {9}
set_instance_parameter_value rom_sys_0 {ROM_ADDR_BITS} {9}

set_instance_parameter_value rom_sys_0 {PATH_TO_FILE} "[pwd]/mem_init_sys.txt"

sysid_gen_sys_init_file;