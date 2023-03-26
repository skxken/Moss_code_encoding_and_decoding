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


module sound(in,clk,start,c1,c2,c3,c4,c5,c6,c7,c8,play,speed);//������ģ��
input clk,start,speed;//1�ں���ʱ���źţ���ʼ���ż��͵��������ٶȿ���
input[7:0] in;//��ʾ�ģ�����λ����ܶ�Ӧ��Ħ˹������Ҫ������
input[5:0] c1,c2,c3,c4,c5,c6,c7,c8;//8������ܶ�Ӧ��Ħ˹����
output reg play=0;//����������
wire[56:0] code={in[0],c1,in[1],c2,in[2],c3,in[3],c4,in[4],c5,in[5],c6,in[6],c7,in[7],c8,1'b0};//�ѺͲ����йصı�����һ�飬���ڴ���
reg[7:0] i=0;//һ��ָ�룬��ʾ���ڴ��������Ǹ������ĵڼ�λ��
reg sclk=0;//����Ƶ���ʱ���źţ�2000hz
reg[31:0] slow=0,stop1,stop2,times=0;//��Ƶ����ļ�ʱ�������Ʋ���ʱ���ֹͣʱ���������������������ļ�ʱ��
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
