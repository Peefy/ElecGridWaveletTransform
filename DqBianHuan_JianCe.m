
%%% <Comment File = "DqBianHuan_JianCe.m">
%%%     <Description>
%%%     dq变换检测电能质量问题
%%%     计算速度较小波变换快
%%%     </Description>
%%%     <UseMyFunction> 
%%%     WT_Filter.m
%%%     DQ_GetVrms.m
%%%     DQ_ShowVrms.m
%%%     </UseMyFunction> 
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/14</LastRenewTime>
%%% </Comment>

clc;clear all;close all;     %关闭清除所有figure窗口

%%% 变量声明
%%% 采样时间ts 1/采样频率 采样总时长ts_total 单位 秒s  
f = 50;                      %频率
w = 2 * pi * f;              %角频率
A = 311;                     %电压幅值最大值311V、有效值220V
ts = 0.00005;                %采样时间 采样频率为20kHz
ts_total = 0.15;             %采样总时间
t = 0 : ts : ts_total;       %采样全程时间
v = 0 : ts : ts_total;       %采样全程电压
v_noise = 0 : ts : ts_total; %采样全程加噪声电压
noise_rand = 0.18;           %信噪比

%%% 考虑到故障往往发生在单相中，导致三相不对称
%%% 单独取出一相电压进行分析

%%% 3/2变换矩阵
syms w_sym t_sym
k = sqrt(2/3);
C1 = [k,-1/2 * k ,-1/2 * k;0,sqrt(3)/2 * k,-sqrt(3)/2 * k];
C2 = [sin(w_sym * t_sym),-cos(w_sym * t_sym);...
    -cos(w_sym * t_sym),-sin(w_sym * t_sym)];
C = C2 * C1;
%%% 真实的三相电压
Va = A * sin (w_sym * t_sym);
Vb = A * sin (w_sym * t_sym - 2 * pi / 3);
Vc = A * sin (w_sym * t_sym + 2 * pi / 3);
%%% 虚拟的三相电压
Va_xuni =  A * sin (w_sym * t_sym);
Vb_xuni =  A *( sin (w_sym * t_sym - pi / 3) - sin (w_sym * t_sym));
Vc_xuni = -A * sin (w_sym * t_sym - pi / 3);
%%% 求dq变换的d轴电压
Vd_temp = C * [Va_xuni;Vb_xuni;Vc_xuni];
Vd = Vd_temp(1);

%%% 1.短时电压下降/电压骤降
t1 = 0.04;                    %发生电压下降的时间
t2 = 0.06;                    %结束电压下降的时间
alpha = 0.57;                 %数学模型中的 电压下降比例
count = 1;                    %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %时间大于t1小于t2时，电压降低
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压短时下降';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise); 
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1,t2); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1,t2); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1,t2); 

%%% 2.短时电压上升/电压骤升
t1 = 0.05;                    %发生电压上升的时间
t2 = 0.10;                    %结束电压上升的时间
alpha = 1.27;                 %数学模型中的 电压上升比例
count = 1;                    %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %时间大于t1小于t2时，电压上升
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压短时上升';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise); 
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1,t2); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1,t2); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1,t2); 

%%% 3.短时电压间断/电压中断
t1 = 0.08;                    %发生电压间断的时间
t2 = 0.12;                    %结束电压间断的时间
alpha = 0.005;                %数学模型中的 电压间断比例
count = 1;                    %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %时间大于t1小于t2时，电压间断
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压短时中断';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise); 
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1,t2); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1,t2); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1,t2); 

%%% 4.振荡暂态
t1 = 0.04;                   %发生震荡暂态的时间
t2 = 0.06;                   %结束震荡暂态的时间
count = 1;                   %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常   
    if t_temp < t1
        v(count) =  A * sin(w * t_temp);      
    end
    %时间大于t2时，电压正常   
    if t_temp > t2
        v(count) = A * sin(w * t_temp);
    end
    %时间大于t1小于t2时，震荡暂态 
    if t_temp >= t1 && t_temp <= t2
        v(count) = A * sin(w * t_temp) + ...
       (200 * sin(30 * w * t_temp) + 1000 * sin(12 * w * t_temp))...
        * exp(-300 * (t_temp - 0.041));
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压震荡暂态';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);  
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1,t2); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1,t2); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1,t2); 

%%% 5.含有谐波(稳态干扰)
count = 1;               %循环变量
for t_temp = 0:ts:ts_total
    %整个采样时间轴上均含有谐波(5次谐波和25次谐波)
    v(count) = 15 * sin(5 * w * t_temp) + ...
           5 * sin(25 * w * t_temp) + ...
           A * sin(w * t_temp);
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '含有5、15次谐波的电压';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);  
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)'); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)'); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)'); 

%%% 6.相位跳变
t1 = 0.05;                        %发生相位跳变的时间
phi_deg = 10;                     %发生相位跳变的角度
phi_rad = phi_deg * pi /180;      %发生相位跳变的弧度
count = 1;                        %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t1时，电压发生相位跳变
    if t_temp >= t1 
        v(count) = A * sin(w * t_temp + phi_rad);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压相位跳变';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);  
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1); 

%%% 7.频率偏移
t1 = 0.08;                     %发生频率偏移的时间
f_offset = 45;                 %发生频率偏移的频率
w_offset = 2 * pi * f_offset;  %发生频率偏移的角频率
count = 1;                     %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t1时，电压发生频率偏移
    if t_temp >= t1 
        v(count) = A * sin(w_offset * t_temp + (w - w_offset) * t1);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压频率偏移';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);  
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1); 

%%% 8.脉冲暂态
t1 = 0.1;            %发生脉冲暂态的时间
alpha = 0.11;        %脉冲暂态数学模型中的变量
beta = 0.12;         %脉冲暂态数学模型中的变量
A0 = 4.8;            %脉冲暂态数学模型中的变量
ta = 0.03;           %脉冲暂态数学模型中的变量
tb = 0.03;           %脉冲暂态数学模型中的变量
count = 1;           %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);       
    end
    %t1时刻发生脉冲暂态现象 
    if t_temp == t1
        v(count) = (sin(w * t_temp) + A0 * (exp(-alpha * ...
            (t_temp - ta)-exp(-beta*(t_temp - tb))))) * A;
    end
    %时间大于t1时，电压正常 
    if t_temp > t1
        v(count) = A * sin(w * t_temp);       
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压脉冲暂态';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);  
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1); 

%%% 2.短时电压上升加电压短时下降
t1 = 0.05;                    %发生电压上升的时间
t2 = 0.08;                    %结束电压上升的时间
t3 = 0.1;                     %发生电压下降的时间
t4 = 0.12;                    %结束电压下降的时间
alpha = 1.27;                 %数学模型中的 电压上升比例
alpha_down = 0.81;            %数学模型中的 电压下降比例
count = 1;                    %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常  
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t2小于t3时，电压正常  
    if t_temp > t2 && t_temp <= t3
        v(count) = A * sin(w * t_temp);
    end
     %时间大于t4时，电压正常  
    if t_temp > t4
        v(count) = A * sin(w * t_temp);
    end
    %时间大于t1小于t2时，电压上升
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * A * sin(w * t_temp);
    end
    %时间大于t3小于t4时，电压上升
    if t_temp >= t3 && t_temp <= t4
        v(count) = alpha_down * A * sin(w * t_temp);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '电压短时上升加电压短时下降';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise); 
%原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v,ts_total);
%显示原始信号和Vrms
DQ_ShowVrms(v,v_rms,t,titleStr,'(原始信号)',t1,t2,t3,t4); 
%加噪声原始信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_noise,ts_total);
%显示加噪声信号和Vrms
DQ_ShowVrms(v_noise,v_rms,t,titleStr,'(加噪声信号)',t1,t2,t3,t4); 
%滤波后信号 dq变换后计算的Vrms
v_rms = DQ_GetVrms(v_filter,ts_total);
%显示滤波后信号和Vrms
DQ_ShowVrms(v_filter,v_rms,t,titleStr,'(滤波后信号)',t1,t2,t3,t4); 

%%% <Summary>
%%%     dq变换对频率偏移、相位跳变、脉冲暂态识别效果不佳 
%%%     但是小波变换对此识别较好 
%%%     所以使用采用小波变换和dq变换相结合的方式 
%%% </Summary>











