
%%% <Comment File = "VoltageKind.m">
%%%     <Description>
%%%     �����������;
%%%     ����������������;
%%%     С������Ӧ��ֵȥ��;
%%%     </Description>
%%%     <UseMyFunction> 
%%%     WT_Filter.m;
%%%     VoltageKindShowPlot.m;
%%%     </UseMyFunction> 
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

clc;clear all;close all;     %�ر��������figure����

%%% ��������
%%% ����ʱ��ts 1/����Ƶ�� ������ʱ��ts_total ��λ ��s  
f = 50;                      %Ƶ�� ��λHz
w = 2 * pi * f;              %��Ƶ�� ��λrad/s
A = 311;                     %��ѹ��Чֵ220V ���������[��ѹ����ֵp.u.]
ts = 0.00005;                %����ʱ�� ����Ƶ��Ϊ20kHz
ts_total = 0.15;             %������ʱ��
t = 0 : ts : ts_total;       %����ȫ��ʱ��
v = 0 : ts : ts_total;       %����ȫ�̵�ѹ
v_noise = 0 : ts : ts_total; %����ȫ�̼�������ѹ
noise_rand = 0.25;           %�����

%%% 1.������Ƶ50Hz������ѹ
count = 1;               %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %����50Hz������ѹ
    v(count) = sin ( w * t_temp);
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand);
    count = count + 1;   %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'������Ƶ50Hz������ѹ','p.u.');

%%% 2.��ʱ��ѹ�½�/��ѹ�轵
t1 = 0.03;                   %������ѹ�½���ʱ��
t2 = 0.06;                   %������ѹ�½���ʱ��
alpha = 0.5;                 %��ѧģ���е� ��ѹ�½�����
count = 1;                   %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ����   
    if t_temp < t1
        v(count) = sin(w * t_temp);   
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = sin(w * t_temp);  
    end
    %ʱ�����t1С��t2ʱ����ѹ����
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * sin(w * t_temp);   
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'��ʱ��ѹ�½�','p.u.',t1,t2); 

%%% 3.��ʱ��ѹ����/��ѹ����
t1 = 0.02;                   %������ѹ������ʱ��
t2 = 0.09;                   %������ѹ������ʱ��
alpha = 1.3;                 %��ѧģ���е� ��ѹ��������
count = 1;                   %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ����  
    if t_temp < t1
        v(count) = sin(w * t_temp);      
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ����ѹ����
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * sin(w * t_temp);
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'��ʱ��ѹ����','p.u.',t1,t2); 

%%% 4.��ʱ��ѹ�ж�/��ѹ���
t1 = 0.04;                   %������ѹ��ϵ�ʱ��
t2 = 0.1;                    %������ѹ��ϵ�ʱ��
alpha = 0.005;               %��ѧģ���е� ��ѹ��ϱ���
count = 1;                   %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = sin(w * t_temp);       
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ����ѹ���
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * sin(w * t_temp);
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'��ʱ��ѹ�ж�','p.u.',t1,t2); 

%%% 5.������̬
t1 = 0.04;           %����������̬��ʱ��
alpha = 0.11;        %������̬��ѧģ���еı���
beta = 0.12;         %������̬��ѧģ���еı���
A = 4.8;             %������̬��ѧģ���еı���
ta = 0.03;           %������̬��ѧģ���еı���
tb = 0.03;           %������̬��ѧģ���еı���
count = 1;           %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = sin(w * t_temp);       
    end
    %t1ʱ�̷���������̬���� 
    if t_temp == t1
        v(count) = sin(w * t_temp) + A * (exp(-alpha * ...
            (t_temp - ta)-exp(-beta*(t_temp - tb))));
    end
    %ʱ�����t1ʱ����ѹ���� 
    if t_temp > t1
        v(count) = sin(w * t_temp);       
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'������̬','p.u.',t1); 

%%% 6.����̬/��Ƶ�ӵ�Ƶ��̬
t1 = 0.02;                   %��������̬��ʱ��
t2 = 0.033;                  %��������̬��ʱ��
A = 2;                       %����̬��ѧģ���еı���
An = 1;                      %����̬��ѧģ���еı���
lambda = 100;                %����̬��ѧģ���еı���
N = 1315;                    %����̬��ѧģ���еı���
count = 1;                   %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = sin(w * t_temp);       
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ������̬
    if t_temp >= t1 && t_temp <= t2
        total = 0;
        for n = 2:N
            total = total + An * sin (n * w * t_temp);
        end
        v(count) = sin(w * t_temp) + ...
            A * exp(-lambda * t_temp) * total; %����˥����
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'����̬','p.u.',t1); 

%%% 7.��λ����
t1 = 0.04;                     %������λ�����ʱ��
phi_deg = 60;                  %������λ����ĽǶ�
phi_rad = phi_deg * pi /180;   %������λ����Ļ���
count = 1;                     %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = 1 * sin(w * t_temp);      
    end
    %ʱ�����t1ʱ����ѹ������λ���� 
    if t_temp >= t1 
        v(count) = 1 * sin(w * t_temp + phi_rad);
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'��λ����','p.u.',t1); 

%%% 8.Ƶ��ƫ��
t1 = 0.04;                     %����Ƶ��ƫ�Ƶ�ʱ��
f_offset = 45;                 %����Ƶ��ƫ�Ƶ�Ƶ��
w_offset = 2 * pi * f_offset;  %����Ƶ��ƫ�ƵĽ�Ƶ��
count = 1;                     %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = 1 * sin(w * t_temp);      
    end
    %ʱ�����t1ʱ����ѹ����Ƶ��ƫ��
    if t_temp >= t1 
        v(count) = 1 * sin(w_offset * t_temp + (w - w_offset) * t1);
    end
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'Ƶ��ƫ��','p.u.',t1); 

%%% 9.����г��(��̬����)
count = 1;                     %forѭ�� ����������
noise_rand = 0.25;             %�����
A = 311;                       %��ѹ���ֵ
for t_temp = 0:ts:ts_total
    %��������ʱ�����Ͼ�����г��(3��г����5��г����7��г��)
    v(count) = 15/A * sin(3 * w * t_temp) + ...
           5/A * sin(5 * w * t_temp) + ...
           1/A * sin(7 * w * t_temp) + ...
           A/A * sin(w * t_temp);
    %��������
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'����г��','p.u.'); 

%%% <Summary>
%%%     ʮ�ֵ�������������ѧģ�ͼ��䲨��
%%%     ��ѹ�轵����ѹ��������ѹ��ϡ�г���Ŷ�
%%%     ��λ���䡢Ƶ��ƫ�ơ���Ƶ�񵴡���Ƶ��
%%%     ������̬�������������������
%%%     (��Ƶ�񵴺͸�Ƶ�񵴹�����̬����ѧģ��)
%%%     С������Ӧ��ֵȥ�벻��ȥ��Ч���� 
%%%     �����ܹ�����ԭ�е��ܸ�������
%%% </Summary>




























