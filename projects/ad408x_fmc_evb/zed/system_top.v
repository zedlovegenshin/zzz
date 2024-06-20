// ***************************************************************************
// ***************************************************************************
// Copyright (C) 2022-2024 Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 3:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 3:0]  ddr_dqs_n,
  inout   [ 3:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [53:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout   [31:0]  gpio_bd,

  output          hdmi_out_clk,
  output          hdmi_vsync,
  output          hdmi_hsync,
  output          hdmi_data_e,
  output  [15:0]  hdmi_data,

  output          i2s_mclk,
  output          i2s_bclk,
  output          i2s_lrclk,
  output          i2s_sdata_out,
  input           i2s_sdata_in,

  output          spdif,

  inout           iic_scl,
  inout           iic_sda,
  inout   [ 1:0]  iic_mux_scl,
  inout   [ 1:0]  iic_mux_sda,

  input           otg_vbusoc,

  // FMC connector
  // LVDS data interace
  input           adca_clk_p,
  input           adca_clk_n,

  input           adca_dco_p,
  input           adca_dco_n,

  input           adca_da_p,
  input           adca_da_n,
  input           adca_db_p,
  input           adca_db_n,

  input           adca_cnv_in_p,
  input           adca_cnv_in_n,

  input           adcb_clk_p,
  input           adcb_clk_n,

  input           adcb_dco_p,
  input           adcb_dco_n,

  input           adcb_da_p,
  input           adcb_da_n,
  input           adcb_db_p,
  input           adcb_db_n,

  input           adcb_cnv_in_p,
  input           adcb_cnv_in_n,

  output          adca_gp0_dir,
  output          adca_gp1_dir,
  output          adca_gp2_dir,
  output          adca_gp3_dir,
  inout           adca_gpio1_fmc,
  inout           adca_gpio2_fmc,
  inout           adca_gpio3_fmc,

  output          adcb_gp0_dir,
  output          adcb_gp1_dir,
  output          adcb_gp2_dir,
  output          adcb_gp3_dir,
  inout           adcb_gpio1_fmc,
  inout           adcb_gpio2_fmc,
  inout           adcb_gpio3_fmc,

  input           pwrgd,
  input           adf435x_lock,
  output          en_psu,
  output          pd_v33b,
  output          osc_en,
  output          ad9508_sync,

  // ADC SPI ports

  input           adca_gpio0_fmc,
  output          adca_sclk_src,
  output          adca_cs_n_src,
  output          adca_sdio_src,

  input           adcb_gpio0_fmc,
  output          adcb_sclk_src,
  output          adcb_cs_n_src,
  output          adcb_sdio_src,

  // Clock chips SPI

  input           ad9508_adf4350_sdi,
  output          ad9508_adf4350_sdo,
  output          ad9508_adf4350_sclk,
  output          ad9508_cs,
  output          adf4350_cs
);

  // internal signals

  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;

  wire    [ 1:0]  iic_mux_scl_i_s;
  wire    [ 1:0]  iic_mux_scl_o_s;
  wire            iic_mux_scl_t_s;
  wire    [ 1:0]  iic_mux_sda_i_s;
  wire    [ 1:0]  iic_mux_sda_o_s;
  wire            iic_mux_sda_t_s;

  wire            adca_filter_data_ready_n;
  wire            adcb_filter_data_ready_n;
  wire            sys_cpu_out_clk;

  reg             ad9508_sync_s = 1'b1;
  reg     [26:0]  dbg_cnt       =  'b0;


  assign gpio_i[63:40] = gpio_o[63:40];
  assign gpio_i[38]    = adf435x_lock;
  assign gpio_i[37]    = pwrgd;
  assign sync_req      = gpio_o[39];

  assign ad9508_sync   = ad9508_sync_s;

  assign adca_gp0_dir  = 1'b0;
  assign adca_gp1_dir  = 1'b0;
  assign adca_gp2_dir  = 1'b0;
  assign adca_gp3_dir  = 1'b0;

  assign adcb_gp0_dir  = 1'b0;
  assign adcb_gp1_dir  = 1'b0;
  assign adcb_gp2_dir  = 1'b0;
  assign adcb_gp3_dir  = 1'b0;
  assign en_psu        = 1'b1;
  assign osc_en        = pwrgd;
  assign pd_v33b       = 1'b1;

  always @(posedge sys_cpu_out_clk) begin
    dbg_cnt <= dbg_cnt + 1;
  end

  ad_iobuf #(
    .DATA_WIDTH(4)
  ) i_gpio_3_2_adca_adcb (
    .dio_t(gpio_t[36:33]),
    .dio_i(gpio_o[36:33]),
    .dio_o(gpio_i[36:33]),
    .dio_p({adcb_gpio3_fmc,adcb_gpio2_fmc,adca_gpio3_fmc,adca_gpio2_fmc}));

  ad_iobuf #(
    .DATA_WIDTH(1)
  ) i_gpio_1_adca (
    .dio_t(1'b1),
    .dio_i(1'b0),
    .dio_o(adca_filter_data_ready_n),
    .dio_p(adca_gpio1_fmc));

 ad_iobuf #(
   .DATA_WIDTH(1)
 ) i_gpio_1_adcb (
   .dio_t(1'b1),
   .dio_i(1'b0),
   .dio_o(adcb_filter_data_ready_n),
   .dio_p(adcb_gpio1_fmc));

  ad_iobuf #(
    .DATA_WIDTH(29)
  ) i_gpio_bd (
    .dio_t({gpio_t[31:22],gpio_t[18:0]}),
    .dio_i({gpio_o[31:22],gpio_o[18:0]}),
    .dio_o({gpio_i[31:22],gpio_i[18:0]}),
    .dio_p({gpio_bd[31:22],gpio_bd[18:0]}));

  ad_iobuf #(
    .DATA_WIDTH(2)
  ) i_iobuf_iic_scl (
    .dio_t ({iic_mux_scl_t_s,iic_mux_scl_t_s}),
    .dio_i (iic_mux_scl_o_s),
    .dio_o (iic_mux_scl_i_s),
    .dio_p (iic_mux_scl));

  ad_iobuf #(
    .DATA_WIDTH(2)
  ) i_iobuf_iic_sda (
    .dio_t ({iic_mux_sda_t_s,iic_mux_sda_t_s}),
    .dio_i (iic_mux_sda_o_s),
    .dio_o (iic_mux_sda_i_s),
    .dio_p (iic_mux_sda));

  system_wrapper i_system_wrapper (
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .hdmi_data (hdmi_data),
    .hdmi_data_e (hdmi_data_e),
    .hdmi_hsync (hdmi_hsync),
    .hdmi_out_clk (hdmi_out_clk),
    .hdmi_vsync (hdmi_vsync),
    .i2s_bclk (i2s_bclk),
    .i2s_lrclk (i2s_lrclk),
    .i2s_mclk (i2s_mclk),
    .i2s_sdata_in (i2s_sdata_in),
    .i2s_sdata_out (i2s_sdata_out),
    .iic_fmc_scl_io (iic_scl),
    .iic_fmc_sda_io (iic_sda),
    .iic_mux_scl_i (iic_mux_scl_i_s),
    .iic_mux_scl_o (iic_mux_scl_o_s),
    .iic_mux_scl_t (iic_mux_scl_t_s),
    .iic_mux_sda_i (iic_mux_sda_i_s),
    .iic_mux_sda_o (iic_mux_sda_o_s),
    .iic_mux_sda_t (iic_mux_sda_t_s),
    .otg_vbusoc (otg_vbusoc),
    .spdif (spdif),
    .spi0_clk_i (1'b0),
    .spi0_clk_o (adca_sclk_src),
    .spi0_csn_0_o (adca_cs_n_src),
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (adca_gpio0_fmc),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (adca_sdio_src),

    .spi1_clk_i (1'b0),
    .spi1_clk_o (adcb_sclk_src),
    .spi1_csn_0_o (adcb_cs_n_src),
    .spi1_csn_1_o (),
    .spi1_csn_2_o (),
    .spi1_csn_i (1'b1),
    .spi1_sdi_i (adcb_gpio0_fmc),
    .spi1_sdo_i (1'b0),
    .spi1_sdo_o (adcb_sdio_src),

    .adca_dco_p (adca_dco_p),
    .adca_dco_n (adca_dco_n),
    .adca_da_p (adca_da_p),
    .adca_da_n (adca_da_n),
    .adca_db_p (adca_db_p),
    .adca_db_n (adca_db_n),
    .adca_cnv_in_p(adca_cnv_in_p),
    .adca_cnv_in_n(adca_cnv_in_n),
    .adca_filter_data_ready_n(adca_filter_data_ready_n),
    .adca_sync_n (ad9508_sync),

    .adcb_dco_p (adcb_dco_p),
    .adcb_dco_n (adcb_dco_n),
    .adcb_da_p (adcb_da_p),
    .adcb_da_n (adcb_da_n),
    .adcb_db_p (adcb_db_p),
    .adcb_db_n (adcb_db_n),
    .adcb_cnv_in_p(adcb_cnv_in_p),
    .adcb_cnv_in_n(adcb_cnv_in_n),
    .adcb_filter_data_ready_n(adcb_filter_data_ready_n),
    .adcb_sync_n (ad9508_sync),

    .ad9508_adf4350_csn_o({adf4350_cs,ad9508_cs}),
    .ad9508_adf4350_csn_i(2'b11),
    .ad9508_adf4350_clk_i(1'b0),
    .ad9508_adf4350_clk_o(ad9508_adf4350_sclk),
    .ad9508_adf4350_sdo_i(1'b0),
    .ad9508_adf4350_sdo_o(ad9508_adf4350_sdo),
    .ad9508_adf4350_sdi_i(ad9508_adf4350_sdi),

    .sys_cpu_out_clk (sys_cpu_out_clk));

endmodule
