`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/25 17:40:03
// Design Name: 
// Module Name: change
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


module change(num,code);//������0-9ת��ΪĦ˹����
input[3:0] num;//���������
output reg [5:0] code;//�����Ħ˹���룬��ǰ��һλΪ��ʶ�������ڱ�ʾ������һ��Ħ˹����
always @*
begin
    case(num)
        4'b0000:code=6'b111111;
        4'b0001:code=6'b101111;
        4'b0010:code=6'b100111;
        4'b0011:code=6'b100011;
        4'b0100:code=6'b100001;
        4'b0101:code=6'b100000;
        4'b0110:code=6'b110000;
        4'b0111:code=6'b111000;
        4'b1000:code=6'b111100;
        4'b1001:code=6'b111110;
     endcase
end
endmodule
