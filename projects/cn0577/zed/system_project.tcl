# load script
source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

# The design can take 2 parameters: RES and TWOLANES
#
# * RES - specify the resolution - 16/18 bits
# * TWOLANES - specify one/two lane mode
#
# NOTE: The design supports the 16-bit version ONLY in TWO LANE mode!
#
# Usage:
#  * default: make
#    * equivalent to `make RES=18 TWOLANES=0`
#
#  * `make RES=16 TWOLANES=1` or just `make RES=16` (TWOLANES is by default 1)
#  * `make RES=18 TWOLANES=0` or just `make TWOLANES=0` (RES is by default 1)

# get the value of the parameter TWOLANES from make command, and if not given, then take value 1
set resolution 18
set twolanes_param [get_env_param  TWOLANES  1]

# will be printed in the vivado log
puts "\nGot RES = $resolution and TWOLANES = $twolanes_param\n"

if {[info exists ::env(RES)]} {
  set resolution $::env(RES)
} else {
  set env(RES) $resolution
}

adi_project cn0577_zed 0 [list \
  RES $resolution \
  TWOLANES $twolanes_param \
]
adi_project_files cn0577_zed [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_data_clk.v" \
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc"]

adi_project_run cn0577_zed
