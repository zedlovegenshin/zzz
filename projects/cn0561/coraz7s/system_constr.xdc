set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports iic_scl]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports iic_sda]

set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports cn0561_spi_sdi]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports cn0561_spi_sdo]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports cn0561_spi_sclk]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports cn0561_spi_cs]

set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports cn0561_dclk]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {cn0561_din[0]}]
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports {cn0561_din[1]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {cn0561_din[2]}]
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {cn0561_din[3]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports cn0561_odr]

set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports cn0561_pdn]

set_false_path -to [get_pins -hierarchical * -filter {NAME=~*busy_sync/inst/cdc_sync_stage1_reg[0]/D}]

##
#create_clock -period 10.416 -name spi_sclk [get_pins i_system_wrapper/system_i/cn0561_spi/execution/inst/sclk_reg/Q]
create_clock -period 10.416 -name spi_sclk [get_pins BUFG_inst/O]

#create_generated_clock -name spi_clk -source [get_pins BUFG_inst/O] -master_clock clk_fpga_0 [get_pins -filter name=~*CLKOUT0 -of [get_cells -hier -filter name=~*spi_clkgen*i_mmcm]]



set_false_path -to [get_cells -hier -filter {name =~ cdc_sync_stage1_reg}]


#create_clock -period 10.416 -name spi_sclk [get_pins i_system_wrapper/system_i/cn0561_spi/execution/inst/sclk_reg/Q]

