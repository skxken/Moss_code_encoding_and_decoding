`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 21:46:08
// Design Name: 
// Module Name: display
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


module display(s1,s2,s3,s4,s5,s6,s7,s8,seg_en,seg_out,clk);//7位数码管的显示模块
input [5:0] s1,s2,s3,s4,s5,s6,s7,s8;//分别代表从左到右第1到第8个七位数码管
output reg[7:0] seg_en,seg_out;//哪几个数码管亮、显示什么
reg[20:0] times;//计时器，用于让不同的数码管显示不同数字
reg[5:0] num;//用于确定显示的一个变量
initial
begin
times=0;
end
input clk;
always @(posedge clk)
begin
    times=times+1;
    if(times<=100000)
    begin
        num=s1;
        seg_en=8'b01111111;
    end
    else if((times>100000)&(times<=200000))
    begin
        num=s2;
        seg_en=8'b10111111;
    end
    else if((times>200000)&(times<=300000))
    begin
        num=s3;
        seg_en=8'b11011111;
    end
    else if((times>300000)&(times<=400000))
    begin
        num=s4;
        seg_en=8'b11101111;
    end
    else if((times>400000)&(times<=500000))
    begin
        num=s5;
        seg_en=8'b11110111;
    end
    else if((times>500000)&(times<=600000))
    begin
       num=s6;
       seg_en=8'b11111011;
    end
    else if((times>600000)&(times<=700000))
    begin
        num=s7;
        seg_en=8'b11111101;
    end
    else if((times>700000)&(times<=800000))
    begin
        num=s8;
        seg_en=8'b11111110;
    end
    else
        times=0;
end
always @seg_en
begin
    case(num)
        6'd1:seg_out=8'b1000_1000;//a
        6'd2:seg_out=8'b1000_0011;//b
        6'd3:seg_out=8'b1100_0110;//c
        6'd4:seg_out=8'b1010_0001;//d
        6'd5:seg_out=8'b1000_0110;//e
        6'd6:seg_out=8'b1000_1110;//f
        6'd7:seg_out=8'b1100_0010;//g
        6'd8:seg_out=8'b1000_1001;//h
        6'd9:seg_out=8'b1111_0000;//i
        6'd10:seg_out=8'b1111_0001;//j
        6'd11:seg_out=8'b1000_1010;//k
        6'd12:seg_out=8'b1100_0111;//l
        6'd13:seg_out=8'b1100_1000;//m
        6'd14:seg_out=8'b1010_1011;//n
        6'd15:seg_out=8'b1010_0011;//o
        6'd16:seg_out=8'b1000_1100;//p
        6'd17:seg_out=8'b1001_1000;//q
        6'd18:seg_out=8'b1100_1110;//r
        6'd19:seg_out=8'b1011_0110;//s
        6'd20:seg_out=8'b1000_0111;//t
        6'd21:seg_out=8'b1100_0001;//u;
        6'd22:seg_out=8'b1110_0011;//v
        6'd23:seg_out=8'b1000_0001;//w
        6'd24:seg_out=8'b1001_1011;//x
        6'd25:seg_out=8'b1001_0001;//y
        6'd26:seg_out=8'b1010_0101;//z
        6'd27:seg_out=8'b1100_0000;  // 0
        6'd28:seg_out=8'b1111_1001;  // 1
        6'd29:seg_out=8'b1010_0100;  // 2
        6'd30:seg_out=8'b1011_0000;  // 3
        6'd31:seg_out=8'b1001_1001;  // 4
        6'd32:seg_out=8'b1001_0010;  // 5
        6'd33:seg_out=8'b1000_0010;  // 6
        6'd34:seg_out=8'b1111_1000;  // 7
        6'd35:seg_out=8'b1000_0000;  // 8
        6'd36:seg_out=8'b1001_0000;  // 9
        default: seg_out = 8'b1111_1111;
    endcase
end


endmodule
