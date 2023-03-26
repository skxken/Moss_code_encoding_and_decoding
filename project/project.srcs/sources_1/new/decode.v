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


module decode(short,long,reset,seg_en,seg_out,clk,A,length,decode,backspace,change,error1,error2);//���벿�ֵ���ģ��
input short,long,reset,decode,backspace,change;//�ֱ��Ƕ̼������������ü�����/��������˸����״̬ת�����أ��͵�ƽ��ģ�鹤�������ֱ��Ӧ�������������ť�����С��ҡ��¡��Ϻ����ұߵĲ��뿪��
input clk;//ʱ���źţ�1�ں���
output [7:0] seg_en,seg_out;//�ֱ��ǿ�����λ�������һλ��������ʾʲô
output reg[6:0] A;//������ָʾ����ʹ�������7��led�ƣ���ʾ���ڻ�������ĳ��̼�
output reg[2:0]length ;//������ָʾ����ʹ��
output reg error1=0,error2=0;//ʹ��ĳ����led�Ʊ�ʾ���ִ��󣬵�һ���ǻ������������޷����룬�ڶ��������������
reg[5:0] s1,s2,s3,s4,s5,s6,s7,s8;//���ڴ洢8����λ����ܵ�����
reg[31:0] d;//����ʱ���ʱ�������ڷ���
reg[31:0] er=0;//�����źż�ʱ���������ô�����ʾ������һ���Ϩ��
wire [5:0] ss8;//���ڴ�ת��ģ���ȡ������
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
    if((short==1||long==1||backspace==1||decode==1)&&d>50000000)//d>50000000��ʱ���������źţ�ÿ�����֮���0.5���d�Ż��ٴδﵽҪ��
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
