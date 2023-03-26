`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/11 16:31:42
// Design Name: 
// Module Name: exchange
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


module exchange(//把摩斯电码转化为数字或字母的模块
input [2:0]length,[6:0] A,//输入需要转换的长度和最多7位的摩斯电码
output reg [5:0]num//输出对应的字母或数字，输出和对应数字的对应关系可以在数码管的显示模块中查看。
);
always@* begin
if(length==3'b001)
    case(A[6])
        1'b0:num=6'b000101;
        1'b1:num=6'b010100;
        endcase
else if(length==3'b010)
    case({A[6],A[5]})
        2'b00:num=6'b001001;
        2'b01:num=6'b000001;
        2'b10:num=6'b001110;
        2'b11:num=6'b001101;
        endcase
else if(length==3'b011)
    case({A[6],A[5],A[4]})
        3'b100:num=6'b000100;
        3'b101:num=6'b001011;
        3'b010:num=6'b010010;
        3'b000:num=6'b010011;
        3'b001:num=6'b010101;
        3'b111:num=6'b001111;
        3'b110:num=6'b000111;
        3'b011:num=6'b010111;
        endcase
else if(length==3'b100)
    case({A[6],A[5],A[4],A[3]})
        4'b1000:num=6'b000010;
        4'b1010:num=6'b000011;
        4'b0010:num=6'b000110;
        4'b0000:num=6'b001000;
        4'b0111:num=6'b001010;
        4'b0100:num=6'b001100;
        4'b0110:num=6'b010000;
        4'b1101:num=6'b010001;
        4'b0001:num=6'b010110;
        4'b1001:num=6'b011000;
        4'b1011:num=6'b011001;
        4'b1100:num=6'b011010;
        default:num=6'd40;
        endcase
else if(length==3'b101)
    case({A[6],A[5],A[4],A[3],A[2]})
        5'b11111:num=6'b011011;
        5'b01111:num=6'b011100;
        5'b00111:num=6'b011101;
        5'b00011:num=6'b011110;
        5'b00001:num=6'b011111;
        5'b00000:num=6'b100000;
        5'b10000:num=6'b100001;
        5'b11000:num=6'b100010;
        5'b11100:num=6'b100011;
        5'b11110:num=6'b100100;
        default:num=6'd40;
        endcase
else if(length==3'b0)
    num=6'b0;
else
    num=6'd40;
end
endmodule
