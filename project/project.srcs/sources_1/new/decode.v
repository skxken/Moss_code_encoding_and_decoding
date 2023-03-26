`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/05 19:28:06
// Design Name: 
// Module Name: encode
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


module decode(short,long,reset,seg_en,seg_out,clk,A,length,decode,backspace,change,error1,error2);//解码部分的主模块
input short,long,reset,decode,backspace,change;//分别是短键、长键、重置键、编/解码键、退格键和状态转换开关（低电平则本模块工作）。分别对应开发板上五个按钮的左、中、右、下、上和最右边的拨码开关
input clk;//时钟信号，1亿赫兹
output [7:0] seg_en,seg_out;//分别是控制七位数码管哪一位在亮和显示什么
output reg[6:0] A;//缓冲区指示器，使用最左边7个led灯，显示现在缓冲区里的长短键
output reg[2:0]length ;//缓冲区指示器，使用
output reg error1=0,error2=0;//使用某两个led灯表示两种错误，第一种是缓冲区中内容无法解码，第二种是数码管已满
reg[5:0] s1,s2,s3,s4,s5,s6,s7,s8;//用于存储8个七位数码管的内容
reg[31:0] d;//按键时间计时器，用于防抖
reg[31:0] er=0;//错误信号计时器，用于让错误显示灯亮起一秒后熄灭
wire [5:0] ss8;//用于从转换模块读取解码结果
initial begin
s1=6'd0;
s2=6'd0;
s3=6'd0;
s4=6'd0;
s5=6'd0;
s6=6'd0;
s7=6'd0;
s8=6'd0;
length=3'b0;
A=5'b0;
d=0;
end
exchange e(length,A,ss8);
display dis(s1,s2,s3,s4,s5,s6,s7,s8,seg_en,seg_out,clk);
always @(posedge clk)
begin
    if(change==0)
    begin
    if(er>0&&er<100000000)
        er=er+1;
    else
    begin
         er=0;
         error1=0;
         error2=0;
    end
    if(d<60000000)
        d=d+1;
    if((short==1||long==1||backspace==1||decode==1)&&d>50000000)//d>50000000的时候才能输出信号，每次输出之后的0.5秒后d才会再次达到要求
    begin
            d=0;
            if(short==1&&length<7)
            begin
                A[6-length]=0;
                length=length+1;
            end
            else if(long==1&&length<7)
            begin
                A[6-length]=1;
                length=length+1;
            end
            else if(backspace==1)
            begin
                if(length>0)
                begin
                    length=length-1;
                    A[6-length]=0;
                end
            end
            if(decode==1)
                begin
                    if(ss8!=0&&ss8!=6'd40&&s1==0)
                    begin
                        s1=s2;
                        s2=s3;
                        s3=s4;
                        s4=s5;
                        s5=s6;
                        s6=s7;
                        s7=s8;
                        s8=ss8;
                    end
                    else if(s1!=0)
                    begin
                        er=er+1;
                        error2=1;
                    end
                    else if(ss8==6'd40)
                    begin
                        er=er+1;
                        error1=1;
                    end
                    A=7'b0;
                    length=3'b0;
                end            
    end
    if(reset==1)
    begin
        A=7'b0;
        length=3'b0;
        s1=6'd0;
        s2=6'd0;
        s3=6'd0;
        s4=6'd0;
        s5=6'd0;
        s6=6'd0;
        s7=6'd0;
        s8=6'd0;
    end
    end
    else
    begin 
        A=7'b0;
        length=3'b0;
        s1=6'd0;
        s2=6'd0;
        s3=6'd0;
        s4=6'd0;
        s5=6'd0;
        s6=6'd0;
        s7=6'd0;
        s8=6'd0;
        error1=0;
        error2=0;
    end
end
endmodule
