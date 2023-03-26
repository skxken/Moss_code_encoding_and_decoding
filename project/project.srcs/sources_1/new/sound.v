`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/27 21:10:23
// Design Name: 
// Module Name: sound
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


module sound(in,clk,start,c1,c2,c3,c4,c5,c6,c7,c8,play,speed);//蜂鸣器模块
input clk,start,speed;//1亿赫兹时钟信号，开始播放键和调整播放速度开关
input[7:0] in;//表示哪（几）位数码管对应的摩斯电码需要被播放
input[5:0] c1,c2,c3,c4,c5,c6,c7,c8;//8个数码管对应的摩斯电码
output reg play=0;//蜂鸣器的震动
wire[56:0] code={in[0],c1,in[1],c2,in[2],c3,in[3],c4,in[4],c5,in[5],c6,in[6],c7,in[7],c8,1'b0};//把和播放有关的变量绑到一块，便于处理
reg[7:0] i=0;//一个指针，表示现在处理到上面那个变量的第几位。
reg sclk=0;//被分频后的时钟信号，2000hz
reg[31:0] slow=0,stop1,stop2,times=0;//分频所需的计时器、控制播放时间和停止时间的两个变量、播放所需的计时器
always @(posedge clk)
begin
    slow=slow+1;
    if(slow<50000)
        sclk=0;
    else
    begin
        sclk=1;
        slow=0;
    end
end
always @(posedge sclk)
begin
    if(start==1)
        i=56;
    if(i>0)
    begin
        if(i%7==0)
        begin
            if(code[i]==0||code[i-1]==0)
                i=i-7;
            else
                i=i-2;
        end
        else
        begin
            if(code[i]==0)
                stop1=800;
            else
                stop1=1600;
            if(i%7==1)
                stop2=stop1+3200;
            else
                stop2=stop1+800;
            if(speed==1)
            begin
                stop1=stop1*2;
                stop2=stop2*2;
            end
            times=times+1;
            if(times<stop1)
            begin
                if(code[i]==0)
                if(times%2==0)
                    play=1;
                else
                    play=0;
                else
                if(times%3==0)
                    play=1;
                else
                    play=0;
            end
            else if(times>stop2)
            begin
                i=i-1;
                times=0;
            end
        end
    end
end
endmodule
