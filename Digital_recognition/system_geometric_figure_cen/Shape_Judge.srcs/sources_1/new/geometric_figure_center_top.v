`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 09:52:30
// Design Name: 
// Module Name: geometric_figure_center_top
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


module geometric_figure_center_top
#(parameter YUZHI=70, HANG288=287,HANG480=479,HANG740=739,LIE640=639,LIE1280=1279)
    (
    input rst_n,    
    input vid_clk,
    
    input vid_hsync,
    input vid_vsync,
    input vid_active_video,
    input [7:0] vid_data, 

    input [10:0] hdata,
    input [9:0] vdata,
    
    output  [23:0] vid_data_out, 
    output  vid_hsync_out,
    output  vid_vsync_out,
    output  vid_active_video_out,
    output  [3:0] digit
   
    );
    
    wire data_out1, data_in;
    
    
    Threshold_Judge #(
        .YUZHI(YUZHI),
        .HANG288(HANG288),
        .HANG480(HANG480),
        .HANG740(HANG740),
        .LIE640(LIE640),
        .LIE1280(LIE1280)
         ) 
      Threshold_Judge_inst (
          .vid_clk(vid_clk), 
          .rst_n(rst_n), 
          .data_in(vid_data),
          .hdata(hdata),
          .vdata(vdata), 
          .data_out1(data_out1),
          .data_out24(vid_data_out)
          );
 
    assign    data_in = data_out1;

    Shape_Judge#(
            .HANG288(HANG288),
            .HANG480(HANG480),
            .HANG740(HANG740),
            .LIE640(LIE640),
            .LIE1280(LIE1280)
             ) 
     Shape_Judge_inst   (
                        .rst_n(rst_n), 
                        .vid_clk(vid_clk),
                        
                        .vid_hsync(vid_hsync),
                        .vid_vsync(vid_vsync),
                        .vid_active_video(vid_active_video),
                        .data_in(data_in),
                        
                        .hdata(hdata),
                        .vdata(vdata),
                        
                        .vid_hsync_out(vid_hsync_out),
                        .vid_vsync_out(vid_vsync_out),
                        .vid_active_video_out(vid_active_video_out),
                        
                        .digit(digit)
                                                                     
                        );    

endmodule
