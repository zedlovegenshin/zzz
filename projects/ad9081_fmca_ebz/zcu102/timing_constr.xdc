###############################################################################
## Copyright (C) 2020-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# Primary clock definitions
create_clock -period 1.290 -name refclk [get_ports fpga_refclk_in_p]

# device clock
create_clock -period 2.580 -name tx_device_clk [get_ports clkin6_p]
create_clock -period 2.580 -name rx_device_clk [get_ports clkin10_p]


# Constraint SYSREFs
# Assumption is that REFCLK and SYSREF have similar propagation delay,
# and the SYSREF is a source synchronous Edge-Aligned signal to REFCLK
set_input_delay -clock [get_clocks tx_device_clk] 2.580 [get_ports sysref2_*]

# For transceiver output clocks use reference clock divided by two
# This will help autoderive the clocks correcly
set_case_analysis 0 [get_pins -quiet -hier {*_channel/TXSYSCLKSEL[0]}] -quiet
set_case_analysis 0 [get_pins -quiet -hier {*_channel/TXSYSCLKSEL[1]}] -quiet
set_case_analysis 0 [get_pins -quiet -hier {*_channel/TXOUTCLKSEL[0]}] -quiet
set_case_analysis 0 [get_pins -quiet -hier {*_channel/TXOUTCLKSEL[1]}] -quiet
set_case_analysis 1 [get_pins -quiet -hier {*_channel/TXOUTCLKSEL[2]}] -quiet

set_case_analysis 0 [get_pins -quiet -hier {*_channel/RXSYSCLKSEL[0]}] -quiet
set_case_analysis 0 [get_pins -quiet -hier {*_channel/RXSYSCLKSEL[1]}] -quiet
set_case_analysis 0 [get_pins -quiet -hier {*_channel/RXOUTCLKSEL[0]}] -quiet
set_case_analysis 0 [get_pins -quiet -hier {*_channel/RXOUTCLKSEL[1]}] -quiet
set_case_analysis 1 [get_pins -quiet -hier {*_channel/RXOUTCLKSEL[2]}] -quiet



