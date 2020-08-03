`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 10:06:15
// Design Name: 
// Module Name: system_geometric_figure_cen_0_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


(* X_CORE_INFO = "geometric_figure_center_top,Vivado 2018.2" *)
(* CHECK_LICENSE_TYPE = "system_geometric_figure_cen_0_1,geometric_figure_center_top,{}" *)
(* CORE_GENERATION_INFO = "system_geometric_figure_cen_0_1,geometric_figure_center_top,{x_ipProduct=Vivado 2018.2,x_ipVendor=xilinx.com,x_ipLibrary=user,x_ipName=geometric_figure_center_top8,x_ipVersion=8.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,YUZHI=70,HANG288=287,HANG480=479,HANG740=739,LIE640=639,LIE1280=1279}" *)
(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_geometric_figure_cen_0_1 (
  rst_n,
  vid_clk,
  vid_hsync,
  vid_vsync,
  vid_active_video,
  vid_data,
  hdata,
  vdata,
  vid_data_out,
  vid_hsync_out,
  vid_vsync_out,
  vid_active_video_out,
  digit,
  data8_out
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *)
input wire rst_n;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_clk, FREQ_HZ 37125000, PHASE 0.0, CLK_DOMAIN /clk_wiz_1_clk_out1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_clk CLK" *)
input wire vid_clk;
input wire vid_hsync;
input wire vid_vsync;
input wire vid_active_video;
input wire [7 : 0] vid_data;
input wire [10 : 0] hdata;
input wire [9 : 0] vdata;
output wire [23 : 0] vid_data_out;
output wire vid_hsync_out;
output wire vid_vsync_out;
output wire vid_active_video_out;
output wire [3:0] digit;
output wire [7 : 0] data8_out;

  geometric_figure_center_top #(
    .YUZHI(70),
        .HANG288(287),
        .HANG480(479),
        .HANG740(739),
        .LIE640(639),
        .LIE1280(1279)
  ) inst (
    .rst_n(rst_n),
    .vid_clk(vid_clk),
    .vid_hsync(vid_hsync),
    .vid_vsync(vid_vsync),
    .vid_active_video(vid_active_video),
    .vid_data(vid_data),
    .hdata(hdata),
    .vdata(vdata),
    .vid_data_out(vid_data_out),
    .vid_hsync_out(vid_hsync_out),
    .vid_vsync_out(vid_vsync_out),
    .vid_active_video_out(vid_active_video_out),
    .digit(digit),
    .data8_out(data8_out)
  );
endmodule
