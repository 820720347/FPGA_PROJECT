`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 09:45:30
// Design Name: 
// Module Name: Threshold_Judge
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


module Threshold_Judge
#(parameter YUZHI=70,HANG288=279,HANG480=479,HANG740=739,LIE640=639,LIE1280=1279)
    (
    input vid_clk,
    input rst_n,
    input [7:0] data_in,
    input [10:0] hdata,
    input [9:0] vdata,
    
    output reg data_out1,
    output reg [23:0] data_out24
    
    );
    reg data_out1_1; 
    reg [23:0] data_out24_1;
    
    always @ (posedge vid_clk) begin
        if(!rst_n) begin 
        data_out24_1 <= 0; 
        data_out1_1 <= 0;
        end else begin
            if(data_in >= YUZHI) begin 
            data_out1_1 <= 1; 
            data_out24_1 <= 24'hff_ffff;
            end else begin 
            data_out1_1 <= 0; 
            data_out24_1 <= 0;
            end 
        end 
     end
    
    always @ (posedge vid_clk) begin 
        if(!rst_n) begin 
        data_out24 <= 0; 
        data_out1 <= 0;
        end else begin
        if((vdata == HANG288) || (vdata == HANG480) || (hdata ==LIE640)) begin 
        data_out1 <= data_out1_1;
        data_out24 <= 24'hff_0000;
        end else begin
            data_out1 <= data_out1_1;
            data_out24 <= data_out24_1;
        end
    end
end   
endmodule
