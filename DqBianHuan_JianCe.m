
%%% <Comment File = "DqBianHuan_JianCe.m">
%%%     <Description>
%%%     dq�任��������������
%%%     �����ٶȽ�С���任��
%%%     </Description>
%%%     <UseMyFunction> 
%%%     WT_Filter.m
%%%     DQ_GetVrms.m
%%%     DQ_ShowVrms.m
%%%     </UseMyFunction> 
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/14</LastRenewTime>
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
noise_rand = 0.18;           %�����

%%% ���ǵ��������������ڵ����У��������಻�Գ�
%%% ����ȡ��һ���ѹ���з���

%%% 3/2�任����
syms w_sym t_sym
k = sqrt(2/3);
C1 = [k,-1/2 * k ,-1/2 * k;0,sqrt(3)/2 * k,-sqrt(3)/2 * k];
C2 = [sin(w_sym * t_sym),-cos(w_sym * t_sym);...
    -cos(w_sym * t_sym),-sin(w_sym * t_sym)];
C = C2 * C1;
%%% ��ʵ�������ѹ
Va = A * sin (w_sym * t_sym);
Vb = A * sin (w_sym * t_sym - 2 * pi / 3);
Vc = A * sin (w_sym * t_sym + 2 * pi / 3);
%%% ����������ѹ
Va_xuni =  A * sin (w_sym * t_sym);
Vb_xuni =  A *( sin (w_sym * t_sym - pi / 3) - sin (w_sym * t_sym));
Vc_xuni = -A * sin (w_sym * t_sym - pi / 3);
%%% ��dq�任��d���ѹ
Vd_temp = C * [Va_xuni;Vb_xuni;Vc_xuni];
Vd = Vd_temp(1);

%%% 1.��ʱ��ѹ�½�/��ѹ�轵
t1 = 0.04;                    %������ѹ�½���ʱ��
t2 = 0.06;                    %������ѹ�½���ʱ��
alpha = 0.57;                 %��ѧģ���е� ��ѹ�½�����
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
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1,t2); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1,t2); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1,t2); 

%%% 2.��ʱ��ѹ����/��ѹ����
t1 = 0.05;                    %������ѹ������ʱ��
t2 = 0.10;                    %������ѹ������ʱ��
alpha = 1.27;                 %��ѧģ���е� ��ѹ��������
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
titleStr = '��ѹ��ʱ����';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise); 
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1,t2); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1,t2); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1,t2); 

%%% 3.��ʱ��ѹ���/��ѹ�ж�
t1 = 0.08;                    %������ѹ��ϵ�ʱ��
t2 = 0.12;                    %������ѹ��ϵ�ʱ��
alpha = 0.005;                %��ѧģ���е� ��ѹ��ϱ���
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
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1,t2); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1,t2); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1,t2); 

%%% 4.����̬
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
       (200 * sin(30 * w * t_temp) + 1000 * sin(12 * w * t_temp))...
        * exp(-300 * (t_temp - 0.041));
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ����̬';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise);  
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1,t2); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1,t2); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1,t2); 

%%% 5.����г��(��̬����)
count = 1;               %ѭ������
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
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)'); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)'); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)'); 

%%% 6.��λ����
t1 = 0.05;                        %������λ�����ʱ��
phi_deg = 10;                     %������λ����ĽǶ�
phi_rad = phi_deg * pi /180;      %������λ����Ļ���
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
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1); 

%%% 7.Ƶ��ƫ��
t1 = 0.08;                     %����Ƶ��ƫ�Ƶ�ʱ��
f_offset = 45;                 %����Ƶ��ƫ�Ƶ�Ƶ��
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
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1); 

%%% 8.������̬
t1 = 0.1;            %����������̬��ʱ��
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
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1); 

%%% 2.��ʱ��ѹ�����ӵ�ѹ��ʱ�½�
t1 = 0.05;                    %������ѹ������ʱ��
t2 = 0.08;                    %������ѹ������ʱ��
t3 = 0.1;                     %������ѹ�½���ʱ��
t4 = 0.12;                    %������ѹ�½���ʱ��
alpha = 1.27;                 %��ѧģ���е� ��ѹ��������
alpha_down = 0.81;            %��ѧģ���е� ��ѹ�½�����
count = 1;                    %forѭ�� ����������
for t_temp = 0:ts:ts_total
    %ʱ��С��t1ʱ����ѹ����  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %ʱ�����t2С��t3ʱ����ѹ����  
    if t_temp > t2 && t_temp <= t3
        v(count) = A * sin(w * t_temp);
    end
     %ʱ�����t4ʱ����ѹ����  
    if t_temp > t4
        v(count) = A * sin(w * t_temp);
    end
    %ʱ�����t1С��t2ʱ����ѹ����
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %ʱ�����t3С��t4ʱ����ѹ����
    if t_temp >= t3 && t_temp <= t4
        v(count) = alpha_down * A * sin(w * t_temp);
    end
    %��������
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %����������
end
titleStr = '��ѹ��ʱ�����ӵ�ѹ��ʱ�½�';
%С������Ӧ��ֵ�˲�ȥ��
v_filter = WT_Filter(v_noise); 
%ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v,ts_total);
%��ʾԭʼ�źź�Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(ԭʼ�ź�)',t1,t2,t3,t4); 
%������ԭʼ�ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%��ʾ�������źź�Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(�������ź�)',t1,t2,t3,t4); 
%�˲����ź� dq�任������Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%��ʾ�˲����źź�Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(�˲����ź�)',t1,t2,t3,t4); 

%%% <Summary>
%%%     dq�任��Ƶ��ƫ�ơ���λ���䡢������̬ʶ��Ч������ 
%%%     ����С���任�Դ�ʶ��Ϻ� 
%%%     ����ʹ�ò���С���任��dq�任���ϵķ�ʽ 
%%% </Summary>











