`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/25 16:04:21
// Design Name: 
// Module Name: top
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


module top(short,long,reset,seg_en,seg_out,clk,A,length,decode,backspace,change,in,mode,error1,error2,row,col,rst,sound,speed);
input short,long,reset,decode,backspace,change,rst,speed;
input[7:0] in;
input clk;
input[3:0] row;
output[3:0] col;
output  mode,error1,error2,sound;
output reg[7:0] seg_en,seg_out;
output reg[6:0] A;
output reg[2:0]length ;
assign mode=change;
wire [6:0]da;
wire [2:0]dl;
wire [7:0]dsen,dsout,esen,esout;
decode d(short,long,reset,dsen,dsout,clk,da,dl,decode,backspace,change,error1,error2);
coder c(clk,rst,esen,esout,decode,in,change,reset,backspace,row,col,sound,speed);
always @(posedge clk)
begin
    if(change==0)
    begin
        seg_en=dsen;
        seg_out=dsout;
        A=da;
        length=dl;
    end
    else
    begin
        seg_en=esen;
        seg_out=esout;
        A=7'b0;
        length=3'b0;
    end
end
endmodule
