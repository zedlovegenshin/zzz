###############################################################################
## Copyright (C) 2022-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# load script
source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

# if the TWOLANES parameter is not defined, by default it will use TWOLANES=1

# configuration mode: one-lane (0) or two-lane (1)
set TWOLANES 1

if [info exists ::env(TWOLANES)] {
  set TWOLANES $::env(TWOLANES)
} else {
  set env(TWOLANES) $TWOLANES
}

adi_project cn0577_zed 0 [list \
  TWOLANES      $TWOLANES \
]

adi_project_files cn0577_zed [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_data_clk.v" \
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc"]

adi_project_run cn0577_zed
