###############################################################################
## Copyright (C) 2022-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports pmod0_0_1_PA_ON]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports pmod0_1_3_MOSI]
set_property -dict {PACKAGE_PIN A22 IOSTANDARD LVCMOS33} [get_ports pmod0_2_5_MISO]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports pmod0_3_7_SCLK]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports pmod0_4_2_TR]
set_property -dict {PACKAGE_PIN C21 IOSTANDARD LVCMOS33} [get_ports pmod0_5_4_TX_LOAD]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports pmod0_6_6_RX_LOAD]
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS33} [get_ports pmod0_7_8_SCL]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports pmod1_0_1_CSB1]
set_property -dict {PACKAGE_PIN E20 IOSTANDARD LVCMOS33} [get_ports pmod1_1_3_CSB3]
set_property -dict {PACKAGE_PIN D22 IOSTANDARD LVCMOS33} [get_ports pmod1_2_5_CSB5]
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports pmod1_3_7_SDA]
set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports pmod1_4_2_CSB2]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports pmod1_5_4_CSB4]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports pmod1_6_6_5V_CTRL]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports pmod1_7_8_PWR_UP_DOWN]

# XUD #1 custom break out board

set_property -dict {PACKAGE_PIN AH2 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_sclk]
set_property -dict {PACKAGE_PIN AJ2 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_mosi]
set_property -dict {PACKAGE_PIN AH4 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_gpio0]
set_property -dict {PACKAGE_PIN AJ4 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_gpio1]
set_property -dict {PACKAGE_PIN AH7 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_miso]
set_property -dict {PACKAGE_PIN AH6 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_csb]
set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_rst]
set_property -dict {PACKAGE_PIN AJ6 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_mosi]
set_property -dict {PACKAGE_PIN AJ5 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_csb]
set_property -dict {PACKAGE_PIN AG3 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_gpio0]
set_property -dict {PACKAGE_PIN AH3 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_gpio1]
set_property -dict {PACKAGE_PIN AE2 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_gpio2]
set_property -dict {PACKAGE_PIN AE1 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_imu_gpio3]
set_property -dict {PACKAGE_PIN AE5 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_sclk]
set_property -dict {PACKAGE_PIN AF5 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_miso]
set_property -dict {PACKAGE_PIN AD7 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_gpio2]
set_property -dict {PACKAGE_PIN AD6 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_gpio3]
set_property -dict {PACKAGE_PIN AG10 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_gpio4]
set_property -dict {PACKAGE_PIN AG9 IOSTANDARD LVCMOS18} [get_ports fmc_bob_xud1_gpio5]



set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports debug_tdd_tx_offload_sync]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports debug_tdd_rx_offload_sync]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports debug_tdd_enabled]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports debug_tdd_rx_mxfe_en]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports debug_tdd_tx_mxfe_en]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports debug_tdd_tx_stingray_en]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports debug_tdd_sync_in]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports debug_tdd_sync_out]



