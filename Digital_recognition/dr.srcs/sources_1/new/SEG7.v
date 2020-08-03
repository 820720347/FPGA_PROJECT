`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 11:54:46
// Design Name: 
// Module Name: SEG7
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


module SEG7(
input clk,
input rst_n,
input [3:0] digit,
output reg [7:0] seg
);	

always @(*) begin
    if(!rst_n) begin
        seg[7:0] <= 8'b11111111;   
    end else begin
	   case (digit)
	    4'd0 	: seg[7:0] <= 8'b10111111;	//0
		4'd1 	: seg[7:0] <= 8'b10000110;	//1
		4'd2 	: seg[7:0] <= 8'b11011011;	//2
		4'd3 	: seg[7:0] <= 8'b11001111;	//3
		4'd4 	: seg[7:0] <= 8'b11100110;	//4
		4'd5 	: seg[7:0] <= 8'b11101101;	//5
		4'd6 	: seg[7:0] <= 8'b11111101;	//6
		4'd7 	: seg[7:0] <= 8'b10000111;	//7
		4'd8 	: seg[7:0] <= 8'b11111111;	//8
		4'd9 	: seg[7:0] <= 8'b11101111;	//9
		default : seg[7:0] <= 8'b11111111; 	//E-rror
	endcase
    end
end	
endmodule

