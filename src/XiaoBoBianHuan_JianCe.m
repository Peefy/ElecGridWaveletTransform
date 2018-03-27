
%%% <Comment File = "XiaoBoBianHuan_JianCe.m">
%%%     <Description>
%%%     ѡȡ��ͬ��С���任����
%%%     ������������ֹʱ�������
%%%     ����һ�������ԣ����dq�任
%%%     </Description>
%%%     <UseMyFunction> 
%%%     WT_Filter.m;
%%%     WT_GetData.m
%%%     WT_GetD1_D6.m
%%%     VoltageKindShowPlot.m;
%%%     </UseMyFunction> 
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

clc;clear all;close all;     %�ر��������figure����

%%% ��������
%%% ����ʱ��ts 1/����Ƶ�� ������ʱ��ts_total ��λ ��s  
f = 50;                      %Ƶ��
w = 2 * pi * f;              %��Ƶ��
A = 311;                     %��ѹ��ֵ���ֵ311V����Чֵ220V
ts = 0.00005;                %����ʱ�� ����Ƶ��Ϊ20kHz
ts_total = 0.15;             %������ʱ��
t = 0 : ts : ts_total;       %����ȫ��ʱ��
v = 0 : ts : ts_total;       %����ȫ�̵�ѹ
v_noise = 0 : ts : ts_total; %����ȫ�̼�������ѹ
noise_rand = 0.25;           %�����

%%% С���任����(��Ҫ)
level = 7;                   %С���ֽ������7�� ���ݹ�ʽ�����
wname = 'db8';               %С���任��������
isShowVin = 1;
%%% 1.����̬
t1 = 0.04;                   %��������̬��ʱ��
t2 = 0.06;                   %��������̬��ʱ��
count = 1;                   %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ����   
    if t_temp < t1
        v(count) =  A * sin(w * t_temp);      
    end
    %ʱ�����t2ʱ����ѹ����   
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ������̬ 
    if t_temp >= t1 && t_temp <= t2
        v(count) = A * sin(w * t_temp) + ...
       (800 * sin(30 * w * t_temp) + 3000 * sin(12 * w * t_temp))...
        * exp(-300 * (t_temp - 0.041));
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,'����̬','V'); 
%���˲���ĵ�ѹ�źŽ���С���任���ع�
%��ȡС���任��һ��͵ڶ���Ľ���ϵ��c1��c2����ϸ��ϵ��d1��d2 
% WT_GetData(v_filter,wname,level,ts_total);
% %�Ƚ�wname1��wname2��wname3��wname4С���任��ʽcd1��cd2�Ĳ�ͬ(ԭʼ�ź�)
% wname1 = 'db5';wname2 = 'db8';wname3 = 'db24';wname4 = 'db40';
% WT_GetDataCompare(wname1,wname2,wname3,wname4,level,v,ts_total);
% %�Ƚ�wname1��wname2��wname3��wname4С���任��ʽcd1��cd2�Ĳ�ͬ(ԭʼ�ź�)
% wname1 = 'coif2';wname2 = 'coif3';wname3 = 'coif4';wname4 = 'coif5';
% WT_GetDataCompare(wname1,wname2,wname3,wname4,level,v,ts_total);

%%% 2.����г��(��̬����)(���ۣ�����С���任����̬��������Ϊ��)
count = 1;               %ѭ������
noise_rand = 0.15;       %�����
for t_temp = 0:ts:ts_total
    %��������ʱ�����Ͼ�����г��(5��г����25��г��)
    v(count) = 15 * sin(5 * w * t_temp) + ...
           5 * sin(25 * w * t_temp) + ...
           A * sin(w * t_temp);
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '����5��15��г���ĵ�ѹ';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %����������С���߳߶ȱ任
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin);   
% %��������С���߳߶ȱ任
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin);   
% %���������˲����С���߳߶ȱ任
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin);  

%%% 3.��ѹ��ʱ��������С���߳߶ȱ任
t1 = 0.03;                   %������ѹ������ʱ��
t2 = 0.09;                   %������ѹ������ʱ��
alpha = 1.4;                 %��ѧģ���е� ��ѹ��������
noise_rand = 0.15;           %�����
count = 1;                   %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ����ѹ����
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ��ʱ����';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
% %��ʾ����ǰ�������ȥ���ĵ�ѹ����
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %����������С���߳߶ȱ任
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1,t2);   
% %��������С���߳߶ȱ任
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1,t2);   
% %���������˲����С���߳߶ȱ任
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1,t2);  

%%% 4.��ѹ��ʱ�½������߳߶�С���任��ע�⣺�˲���ʶ��ʧ�ܣ�
t1 = 0.03;                    %������ѹ�½���ʱ��
t2 = 0.07;                    %������ѹ�½���ʱ��
alpha = 0.57;                 %��ѧģ���е� ��ѹ�½�����
noise_rand = 0.15;            %�����
count = 1;                    %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ����  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ����ѹ����
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ��ʱ�½�';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %����������С���߳߶ȱ任
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1,t2);   
% %��������С���߳߶ȱ任
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1,t2);   
% %���������˲����С���߳߶ȱ任
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1,t2);  

%%% 5.��ѹ��ʱ��ϼ����߳߶�С���任
t1 = 0.05;                    %������ѹ��ϵ�ʱ��
t2 = 0.09;                    %������ѹ��ϵ�ʱ��
alpha = 0.005;                %��ѧģ���е� ��ѹ��ϱ���
noise_rand = 0.05;            %�����
count = 1;                    %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ����  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t2ʱ����ѹ����  
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ����ѹ���
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ��ʱ�ж�';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %����������С���߳߶ȱ任
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1,t2);   
% %��������С���߳߶ȱ任
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1,t2);   
% %���������˲����С���߳߶ȱ任
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1,t2);  

%%% 6.��λ���估���߳߶�С���任
t1 = 0.05;                        %������λ�����ʱ��
phi_deg = 10;                     %������λ����ĽǶ�
phi_rad = phi_deg * pi /180;      %������λ����Ļ���
noise_rand = 0.05;                %�����
count = 1;                        %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t1ʱ����ѹ������λ����
    if t_temp >= t1 
        v(count) = A * sin(w * t_temp + phi_rad);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ��λ����';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %����������С���߳߶ȱ任
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1);   
% %��������С���߳߶ȱ任
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1);   
% %���������˲����С���߳߶ȱ任
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1);  

%%% 7.Ƶ��ƫ�Ƽ����߳߶�С���任
t1 = 0.07;                     %����Ƶ��ƫ�Ƶ�ʱ��
f_offset = 25;                 %����Ƶ��ƫ�Ƶ�Ƶ��
w_offset = 2 * pi * f_offset;  %����Ƶ��ƫ�ƵĽ�Ƶ��
count = 1;                     %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t1ʱ����ѹ����Ƶ��ƫ��
    if t_temp >= t1 
        v(count) = A * sin(w_offset * t_temp + (w - w_offset) * t1);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹƵ��ƫ��';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %����������С���߳߶ȱ任
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1);   
% %��������С���߳߶ȱ任
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1);   
% %���������˲����С���߳߶ȱ任
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1);  

%%% 8.������̬�����߳߶�С���任
t1 = 0.10;           %����������̬��ʱ��
alpha = 0.11;        %������̬��ѧģ���еı���
beta = 0.12;         %������̬��ѧģ���еı���
A0 = 4.8;            %������̬��ѧģ���еı���
ta = 0.03;           %������̬��ѧģ���еı���
tb = 0.03;           %������̬��ѧģ���еı���
count = 1;           %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);       
    end
    %t1ʱ�̷���������̬���� 
    if t_temp == t1
        v(count) = (sin(w * t_temp) + A0 * (exp(-alpha * ...
            (t_temp - ta)-exp(-beta*(t_temp - tb))))) * A;
    end
    %ʱ�����t1ʱ����ѹ���� 
    if t_temp > t1
        v(count) = A * sin(w * t_temp);       
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ������̬';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
%����������С���߳߶ȱ任
WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1);   
%��������С���߳߶ȱ任
WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1);   
%���������˲����С���߳߶ȱ任
WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1);  

%%% 9.Ƶ��ƫ�Ƽ���λ���估���߳߶�С���任
t1 = 0.07;                     %����Ƶ��ƫ�Ƶ�ʱ��
t2 = 0.09;                     %������λ�����ʱ��  
f_offset = 25;                 %����Ƶ��ƫ�Ƶ�Ƶ��
w_offset = 2 * pi * f_offset;  %����Ƶ��ƫ�ƵĽ�Ƶ��
phi_deg = 10;                  %������λ����ĽǶ�
phi_rad = phi_deg * pi /180;   %������λ����Ļ���
count = 1;                     %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ���� 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t1ʱ����ѹ����Ƶ��ƫ��
    if t_temp >= t1 && t_temp < t2
        v(count) = A * sin(w_offset * t_temp + (w - w_offset) * t1);
    end
    %ʱ�����t2ʱ����ѹ������λ����
    if t_temp >= t2
        v(count) = A * sin(w_offset * t_temp + (w - w_offset) * t1 + phi_rad);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = 'Ƶ��ƫ�Ƽ���λ����';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);    
%��ʾ����ǰ�������ȥ���ĵ�ѹ����
VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
%����������С���߳߶ȱ任
WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(ԭʼ�ź�);'],isShowVin,t1,t2);   
%��������С���߳߶ȱ任
WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(������);'],isShowVin,t1,t2);   
%���������˲����С���߳߶ȱ任
WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(ȥ���);'],isShowVin,t1,t2);  

%%% <Summary>
%%%     ������̬�Ŷ�����г���Ŷ���С���任�޷�ʶ��
%%%     ��������ѹ��С�ı�ĵ�����������ʱ���޷�ʶ���ǵ�ѹ�½���������
%%%     С������Ӧ��ֵ�˲�Ч���ǳ������ǿ���ʹС���任���ʧ��
%%%     ���ѹ��ʱ�������½����жϣ����⼸�ֲ���dq�任�ǳ���ʹ
%%% </Summary>



