`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 22:01:37
// Design Name: 
// Module Name: Shape_Judge
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


module Shape_Judge
    #(parameter HANG288=287,HANG480=479,HANG740=739,LIE640=639,LIE1280=1279)  
    (
    input rst_n,
    input vid_clk,
    input vid_hsync,
    input vid_vsync,
    input vid_active_video,
    input data_in,
    input [10:0] hdata,
    input [9:0] vdata,
    output reg vid_hsync_out,
    output reg vid_vsync_out,
    output reg vid_active_video_out,

    output reg [3:0] digit=0,   
    output reg [7:0] data8_out
    );
    reg [1:0] x1=0;
    reg [1:0] x2=0;
    reg [1:0] y=0;
    reg x1_l=0;
    reg x2_l=0;
    reg x1_r=0;
    reg x2_r=0;
    
    reg vid_hsync_out_1,vid_vsync_out_1,vid_active_video_out_1;
    reg data_down_0=1;
    reg data_down_1=1;
    reg data_down;
    
    //The vid signal is delayed by two thresholds to determine the clock period.
    always@(posedge vid_clk) begin 
    if(!rst_n) begin 
    vid_hsync_out <= 0; 
    vid_vsync_out <= 0; 
    vid_active_video_out <= 0;
    end else begin 
    vid_hsync_out_1 <= vid_hsync; 
    vid_vsync_out_1 <= vid_vsync; 
    vid_active_video_out_1 <= vid_active_video;
    
    vid_hsync_out <= vid_hsync_out_1; 
    vid_vsync_out <= vid_vsync_out_1; 
    vid_active_video_out <= vid_active_video_out_1;
    end
    end
      
    //判断灰度数据下降沿
    always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            data_down_0<=1;
            data_down_1<=1;
        end else begin
            data_down_0<=data_in;
            data_down_1<=data_down_0;
        end
       data_down =~data_down_0&data_down_1;
    end
  
    //数字与x1交点个数
    always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            x1<=2'b00;
        end else if(vdata==HANG740) begin
            x1<=2'b00;
        end else if(vdata==HANG288) begin
            if(data_down) 
                x1<=x1+2'b01;
            else 
                x1<=x1;
        end else
                x1<=x1;
    end
    
    //数字与x1是否交于y左侧
    always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            x1_l<=1'b0;
        end else if(vdata==HANG740) begin
            x1_l<=1'b0;
        end else if(vdata==HANG288&&hdata<LIE640) begin
            if(data_down) 
                x1_l<=1'b1;
            else
                x1_l<=x1_l;                
        end else
                x1_l<=x1_l;
    end
    
    //数字与x1是否交于y右侧
     always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            x1_r<=1'b0;
        end else if(vdata==HANG740) begin
            x1_r<=1'b0;
        end else if(vdata==HANG288&&hdata>=LIE640) begin
            if(data_down) 
                x1_r<=1'b1;
            else
                x1_r<=x1_r;                
        end else
                x1_r<=x1_r;
    end
    
    //数字与x2交点个数
    always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            x2<=2'b00;
        end else if(vdata==HANG740) begin
            x2<=2'b00;
        end else if(vdata==HANG480) begin
            if(data_down) 
                x2<=x2+2'b01;
            else 
                x2<=x2;
        end else
                x2<=x2;
    end
    
    //数字与x2是否交与y左侧
     always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            x2_l<=1'b0;
        end else if(vdata==HANG740) begin
            x2_l<=1'b0;
        end else if(vdata==HANG480&&hdata<LIE640) begin
            if(data_down) 
                x2_l<=1'b1;
            else
                x2_l<=x2_l;                
        end else
                x2_l<=x2_l;
    end
    
    //数字与x2是否交与y右侧
    always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            x2_r<=1'b0;
        end else if(vdata==HANG740) begin
            x2_r<=1'b0;
        end else if(vdata==HANG480&&hdata>=LIE640) begin
            if(data_down) 
                x2_r<=1'b1;
            else
                x2_r<=x2_r;                
        end else
                x2_r<=x2_r;
    end   
    
    //数字与y交点个数
    always@(posedge vid_clk or negedge rst_n) begin
        if(!rst_n) begin
            y<=2'b00;
        end else if(hdata==LIE1280) begin
            y<=2'b00;
        end else if(hdata==LIE640) begin
            if(data_down) 
                y<=y+2'b01;
            else 
                y<=y;
        end else
                y<=y;
    end
    
    always@(posedge vid_clk) begin
        case({y,x1,x2}) 
        6'b101010:begin digit<=4'd0;data8_out=8'd0;end
        6'b010101:begin digit<=4'd1;data8_out=8'd1; end
        6'b101001:begin digit<=4'd4;data8_out=8'd4; end
        6'b110110:begin digit<=4'd6;data8_out=8'd6; end
        6'b100101:begin digit<=4'd7;data8_out=8'd7; end
        6'b111010:begin digit<=4'd8;data8_out=8'd8; end
        6'b111001:begin digit<=4'd9;data8_out=8'd9; end   
        6'b110101:begin 
            if(x1_r&&x2_l) begin
                digit<=4'd2;data8_out=8'd2;
            end else if(x1_r&&x2_r) begin
                digit<=4'd3;data8_out=8'd3;
            end else if(x1_l&&x2_r) begin
                digit<=4'd5;data8_out=8'd5;
            end else begin
                digit<=4'd2;data8_out=8'd2;
            end
            end
        default:begin digit<=4'd0;data8_out=8'd0; end
        endcase        
    end
    
endmodule
