`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 15:37:16
// Design Name: 
// Module Name: dr
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


module dr
#(parameter YUZHI=70, HANG288=287,HANG480=479,HANG740=739,LIE640=639,LIE1280=1279)
(
    input clk_100MHz,
    input rst_n,
    input Clk_Rx_Data_N, 
    input Clk_Rx_Data_P, 
    input [1:0]Rx_Data_N, 
    input [1:0]Rx_Data_P, 
    input Data_N, 
    input Data_P, 
    inout Camera_IIC_SDA, 
    output Camera_IIC_SCL, 
    output Camera_GPIO, 
    output TMDS_Tx_Clk_N, 
    output TMDS_Tx_Clk_P, 
    output [2:0]TMDS_Tx_Data_N, 
    output [2:0]TMDS_Tx_Data_P,
    output reg [7:0] seg,
    output GND 
    ); 
    //Clock 
    wire clk_100MHz_system; 
    wire clk_200MHz; 
    wire clk_10MHz; 
    wire clk_100MHz_out; 
    wire clk_Serial_out; 
    //MIPI camera OV5647 
    wire [23:0]RGB_Data;
    wire RGB_HSync; 
    wire RGB_VSync; 
    wire RGB_VDE; 
    wire [7:0] Dvp_data;
    wire [10:0] HCnt;
    wire [9:0] VCnt;
    wire RGB_HSync_0; 
    wire RGB_VSync_0; 
    wire RGB_VDE_0; 
     wire RGB_HSync_1; 
    wire RGB_VSync_1; 
    wire RGB_VDE_1;
    //IIC 
    wire IIC_Rst; 
    wire [7:0]Address; 
    wire [7:0]Data;
    wire [15:0]Reg_Addr;
    wire [7:0]IIC_Read_Data; 
    wire IIC_Busy; 
    wire Reg2Addr; 
    wire IIC_Write; 
    reg IIC_Read=0; 
    wire Camera_IIC_SDA_I; 
    wire Camera_IIC_SDA_O; 
    wire Camera_IIC_SDA_T;
    //RGB2GRAY
    wire [7:0]Gray_Data;
    wire [23:0]RGB_Data_0;
    wire [23:0]RGB_Data_1;  
    wire [7:0]RGB_Data_R;
    wire [7:0]RGB_Data_G;
    wire [7:0]RGB_Data_B;
    
    wire [3:0] digit;
    
    assign GND=0;
    
   assign RGB_Data_R=RGB_Data_0[23:16];
   assign RGB_Data_G=RGB_Data_0[15:8];
   assign RGB_Data_B=RGB_Data_0[7:0];
   
    clk_wiz_0 clk_10(
    .clk_out1(clk_100MHz_system),
    .clk_out2(clk_200MHz),
    .clk_out3(clk_10MHz),
    .clk_in1(clk_100MHz )
    );
    clk_wiz_1 clk_4(
    .clk_out1(clk_Serial_out),
    .clk_in1(clk_100MHz_out)
    );
     //Tri-state gate
    IOBUF Camera_IIC_SDA_IOBUF (
    .I(Camera_IIC_SDA_O), 
    .IO(Camera_IIC_SDA), 
    .O(Camera_IIC_SDA_I), 
    .T(~Camera_IIC_SDA_T)
    );
    //Camera driver 
    Driver_MIPI0 Driver_MIPI0_0( 
    .clk_200MHz(clk_200MHz), 
    .Clk_Rx_Data_N(Clk_Rx_Data_N), 
    .Clk_Rx_Data_P(Clk_Rx_Data_P), 
    .Rx_Data_N(Rx_Data_N), 
    .Rx_Data_P(Rx_Data_P), 
    .Data_N(Data_N), 
    .Data_P(Data_P),
    .Camera_GPIO(Camera_GPIO), 
    .RGB_HSync(RGB_HSync),
    .RGB_VSync(RGB_VSync), 
    .RGB_VDE(RGB_VDE), 
    .Data(Dvp_data),
    .HCnt(HCnt),
    .VCnt(VCnt),
    .clk_100MHz_out(clk_100MHz_out)
    ); 
    //RGBToDvi instantiation 
    rgb2dvi_0 rgb2dvi(
     .TMDS_Clk_p(TMDS_Tx_Clk_P),
     .TMDS_Clk_n(TMDS_Tx_Clk_N),
     .TMDS_Data_p(TMDS_Tx_Data_P), 
     .TMDS_Data_n(TMDS_Tx_Data_N),
      .aRst_n(1), 
      .vid_pData(RGB_Data_1),
      .vid_pVDE(RGB_VDE_1), 
      .vid_pHSync(RGB_HSync_1),
      .vid_pVSync(RGB_VSync_1),
      .PixelClk(clk_100MHz_out),
      .SerialClk(clk_Serial_out) 
      );
    //IIC driver 
    Driver_IIC_0 Driver_IIC0( 
    .clk(clk_100MHz_system),
    .Rst(IIC_Rst), 
    .Addr(Address), 
    .Reg_Addr(Reg_Addr),
    .Data(Data), 
    .IIC_Write(IIC_Write), 
    .IIC_Read(IIC_Read),
    .IIC_Read_Data(IIC_Read_Data), 
    .IIC_Busy(IIC_Busy), 
    .Reg_2Addr(Reg2Addr), 
    .IIC_SCL(Camera_IIC_SCL), 
    .IIC_SDA_In(Camera_IIC_SDA_I), 
    .SDA_Dir(Camera_IIC_SDA_T), 
    .SDA_Out(Camera_IIC_SDA_O)
    ); 
    //OV5647 camera initialization 
    OV5647_Init_0 Diver_OV5647_Init( 
    .clk_10MHz(clk_10MHz), 
    .IIC_Busy(IIC_Busy), 
    .Addr(Address), 
    .Reg_Addr(Reg_Addr), 
    .Reg_Data(Data), 
    .IIC_Write(IIC_Write),
    .Reg2Addr(Reg2Addr), 
    .Ctrl_IIC(IIC_Rst) 
    );
   
    Driver_Bayer_To_RGB Driver_Bayer_To_RGB0(
        .clk(clk_100MHz_out),
        .data_in(Dvp_data),
        .hsync_in(RGB_HSync),
        .vsync_in(RGB_VSync),
        .de_in(RGB_VDE),
        .hdata(HCnt),
        .vdata(VCnt),
        .hsync_out(RGB_HSync_0),
        .vsync_out(RGB_VSync_0),
        .de_out(RGB_VDE_0),
        .data_out(RGB_Data_0)
    );
    
    RGB_To_Gray_0 RGB_To_Gray0(
    .RGB_Data_R(RGB_Data_R),
    .RGB_Data_G(RGB_Data_G),
    .RGB_Data_B(RGB_Data_B),
    .Accuracy_Num(0),
    .Gray_Data(Gray_Data)
    );
    
    system_geometric_figure_cen_0_1_0 #(
        .YUZHI(YUZHI),
        .HANG288(HANG288),
        .HANG480(HANG480),
        .HANG740(HANG740),
        .LIE640(LIE640),
        .LIE1280(LIE1280)
         ) 
    geometric_figure_inst (
        .rst_n(rst_n),    
        .vid_clk(clk_100MHz_out),
        .vid_hsync(RGB_HSync_0),
        .vid_vsync(RGB_VSync_0),
        .vid_active_video(RGB_VDE_0),
        .vid_data(Gray_Data), 
        .hdata(HCnt),
        .vdata(VCnt),    
        .vid_data_out(RGB_Data_1), 
        .vid_hsync_out(RGB_HSync_1),
        .vid_vsync_out(RGB_VSync_1),
        .vid_active_video_out(RGB_VDE_1),
        .digit(digit)
        ); 
        
    SEG7 SEG7_0(
       .clk(clk_100MHz_system),
       .rst_n(rst_n),
       .digit(digit),
       .seg(seg)
       );
                 
endmodule
