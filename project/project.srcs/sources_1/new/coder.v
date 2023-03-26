`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/25 15:18:03
// Design Name: 
// Module Name: coder
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


module coder(clk,rst,seg_en,seg_out,decode,in,change,reset,backspace,row,col,sound,speed);//编码部分的主模块
input clk,decode,change,reset,backspace,rst,speed;//分别是1亿赫兹时钟信号，编码键（播放键）、模式转换开关（高电平则本模块工作）、重置键、退格键、小键盘的重置信号、蜂鸣器调速开关，三个按键分别是开发板上五个按键的下、右、上，转换开关是最右边的拨码开关、调速开关是从右往左第二个拨码开关。
input[7:0] in;//用于控制哪些数码管中显示的字符需要被播放，使用最左边8个拨码开关，分别对应上面的8个7位数码管。
input [3:0] row;//小键盘的行
output[3:0] col;//小键盘的列
output sound;//蜂鸣器震动
reg[5:0] s1=0,s2=0,s3=0,s4=0,s5=0,s6=0,s7=0,s8=0;//8个数码管的对应数字，用于数码管显示
reg[5:0] c1=0,c2=0,c3=0,c4=0,c5=0,c6=0,c7=0,c8=0;//8个数码管的对应摩斯电码，用于蜂鸣器播放
wire[5:0] cc8;//用于从转换模块获取摩斯电码
wire[3:0] ss8;//用于从小键盘获取输入
wire press;//代表小键盘被按下的变量
reg[31:0] d=0;//计时器，用于消抖电路
output [7:0] seg_en,seg_out;//数码管显示相关的两个变量
display dis2(s1,s2,s3,s4,s5,s6,s7,s8,seg_en,seg_out,clk);
key_top k(clk,rst,row,col,ss8,press);
change c(ss8,cc8);
sound s(in,clk,decode,c1,c2,c3,c4,c5,c6,c7,c8,sound,speed);
always @(posedge clk)
begin
    if(change==1)
    begin
        if(d<60000000)
            d=d+1;
        if((press==1||backspace==1)&&d>50000000)
        begin
            d=0;         
            if(press==1)
            begin
                if(s1==0)
                begin
                    c1=c2;
                    c2=c3;
                    c3=c4;
                    c4=c5;
                    c5=c6;
                    c6=c7;
                    c7=c8;
                    s1=s2;
                    s2=s3;
                    s3=s4;
                    s4=s5;
                    s5=s6;
                    s6=s7;
                    s7=s8;
                    s8=27+ss8;
                    c8=cc8;
                end
            end
            else if(backspace==1&&s8!=0)
            begin
                s8=s7;
                s7=s6;
                s6=s5;
                s5=s4;
                s4=s3;
                s3=s2;
                s2=s1;
                s1=0;
                c8=c7;
                c7=c6;
                c6=c5;
                c5=c4;
                c4=c3;
                c3=c2;
                c2=c1;
                c1=0;
            end
        end
        if(reset==1)
        begin
            s1=6'd0;
            s2=6'd0;
            s3=6'd0;
            s4=6'd0;
            s5=6'd0;
            s6=6'd0;
            s7=6'd0;
            s8=6'd0;
            c1=5'b0;
            c2=5'b0;
            c3=5'b0;
            c4=5'b0;
            c5=5'b0;
            c6=5'b0;
            c7=5'b0;
            c8=5'b0;
        end
    end
    else
    begin
         s1=6'd0;
         s2=6'd0;
         s3=6'd0;
         s4=6'd0;
         s5=6'd0;
         s6=6'd0;
         s7=6'd0;
         s8=6'd0;
         c1=5'b0;
         c2=5'b0;
         c3=5'b0;
         c4=5'b0;
         c5=5'b0;
         c6=5'b0;
         c7=5'b0;
         c8=5'b0;
    end
end
endmodule
