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


module coder(clk,rst,seg_en,seg_out,decode,in,change,reset,backspace,row,col,sound,speed);//���벿�ֵ���ģ��
input clk,decode,change,reset,backspace,rst,speed;//�ֱ���1�ں���ʱ���źţ�����������ż�����ģʽת�����أ��ߵ�ƽ��ģ�鹤���������ü����˸����С���̵������źš����������ٿ��أ����������ֱ��ǿ�����������������¡��ҡ��ϣ�ת�����������ұߵĲ��뿪�ء����ٿ����Ǵ�������ڶ������뿪�ء�
input[7:0] in;//���ڿ�����Щ���������ʾ���ַ���Ҫ�����ţ�ʹ�������8�����뿪�أ��ֱ��Ӧ�����8��7λ����ܡ�
input [3:0] row;//С���̵���
output[3:0] col;//С���̵���
output sound;//��������
reg[5:0] s1=0,s2=0,s3=0,s4=0,s5=0,s6=0,s7=0,s8=0;//8������ܵĶ�Ӧ���֣������������ʾ
reg[5:0] c1=0,c2=0,c3=0,c4=0,c5=0,c6=0,c7=0,c8=0;//8������ܵĶ�ӦĦ˹���룬���ڷ���������
wire[5:0] cc8;//���ڴ�ת��ģ���ȡĦ˹����
wire[3:0] ss8;//���ڴ�С���̻�ȡ����
wire press;//����С���̱����µı���
reg[31:0] d=0;//��ʱ��������������·
output [7:0] seg_en,seg_out;//�������ʾ��ص���������
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
