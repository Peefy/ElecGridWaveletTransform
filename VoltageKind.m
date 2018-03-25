
%%% <Comment File = "VoltageKind.m">
%%%     <Description>
%%%     电能质量检测;
%%%     电能质量问题种类;
%%%     小波自适应阈值去噪;
%%%     </Description>
%%%     <UseMyFunction> 
%%%     WT_Filter.m;
%%%     VoltageKindShowPlot.m;
%%%     </UseMyFunction> 
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

clc;clear all;close all;     %关闭清除所有figure窗口

%%% 变量声明
%%% 采样时间ts 1/采样频率 采样总时长ts_total 单位 秒s  
f = 50;                      %频率 单位Hz
w = 2 * pi * f;              %角频率 单位rad/s
A = 311;                     %电压有效值220V 本程序采用[电压标幺值p.u.]
ts = 0.00005;                %采样时间 采样频率为20kHz
ts_total = 0.15;             %采样总时间
t = 0 : ts : ts_total;       %采样全程时间
v = 0 : ts : ts_total;       %采样全程电压
v_noise = 0 : ts : ts_total; %采样全程加噪声电压
noise_rand = 0.25;           %信噪比

%%% 1.正常工频50Hz交流电压
count = 1;               %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %正常50Hz交流电压
    v(count) = sin ( w * t_temp);
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand);
    count = count + 1;   %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'正常工频50Hz交流电压','p.u.');

%%% 2.短时电压下降/电压骤降
t1 = 0.03;                   %发生电压下降的时间
t2 = 0.06;                   %结束电压下降的时间
alpha = 0.5;                 %数学模型中的 电压下降比例
count = 1;                   %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常   
    if t_temp < t1
        v(count) = sin(w * t_temp);   
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = sin(w * t_temp);  
    end
    %时间大于t1小于t2时，电压降低
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * sin(w * t_temp);   
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'短时电压下降','p.u.',t1,t2); 

%%% 3.短时电压上升/电压骤升
t1 = 0.02;                   %发生电压上升的时间
t2 = 0.09;                   %结束电压上升的时间
alpha = 1.3;                 %数学模型中的 电压上升比例
count = 1;                   %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常  
    if t_temp < t1
        v(count) = sin(w * t_temp);      
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = sin(w * t_temp);
    end
    %时间大于t1小于t2时，电压上升
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * sin(w * t_temp);
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'短时电压上升','p.u.',t1,t2); 

%%% 4.短时电压中断/电压间断
t1 = 0.04;                   %发生电压间断的时间
t2 = 0.1;                    %结束电压间断的时间
alpha = 0.005;               %数学模型中的 电压间断比例
count = 1;                   %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = sin(w * t_temp);       
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = sin(w * t_temp);
    end
    %时间大于t1小于t2时，电压间断
    if t_temp >= t1 && t_temp <= t2
        v(count) = alpha * sin(w * t_temp);
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'短时电压中断','p.u.',t1,t2); 

%%% 5.脉冲暂态
t1 = 0.04;           %发生脉冲暂态的时间
alpha = 0.11;        %脉冲暂态数学模型中的变量
beta = 0.12;         %脉冲暂态数学模型中的变量
A = 4.8;             %脉冲暂态数学模型中的变量
ta = 0.03;           %脉冲暂态数学模型中的变量
tb = 0.03;           %脉冲暂态数学模型中的变量
count = 1;           %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = sin(w * t_temp);       
    end
    %t1时刻发生脉冲暂态现象 
    if t_temp == t1
        v(count) = sin(w * t_temp) + A * (exp(-alpha * ...
            (t_temp - ta)-exp(-beta*(t_temp - tb))));
    end
    %时间大于t1时，电压正常 
    if t_temp > t1
        v(count) = sin(w * t_temp);       
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'脉冲暂态','p.u.',t1); 

%%% 6.震荡暂态/高频加低频暂态
t1 = 0.02;                   %发生震荡暂态的时间
t2 = 0.033;                  %结束震荡暂态的时间
A = 2;                       %震荡暂态数学模型中的变量
An = 1;                      %震荡暂态数学模型中的变量
lambda = 100;                %震荡暂态数学模型中的变量
N = 1315;                    %震荡暂态数学模型中的变量
count = 1;                   %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = sin(w * t_temp);       
    end
    %时间大于t2时，电压正常  
    if t_temp > t2
        v(count) = sin(w * t_temp);
    end
    %时间大于t1小于t2时，震荡暂态
    if t_temp >= t1 && t_temp <= t2
        total = 0;
        for n = 2:N
            total = total + An * sin (n * w * t_temp);
        end
        v(count) = sin(w * t_temp) + ...
            A * exp(-lambda * t_temp) * total; %附加衰减震荡
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'震荡暂态','p.u.',t1); 

%%% 7.相位跳变
t1 = 0.04;                     %发生相位跳变的时间
phi_deg = 60;                  %发生相位跳变的角度
phi_rad = phi_deg * pi /180;   %发生相位跳变的弧度
count = 1;                     %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = 1 * sin(w * t_temp);      
    end
    %时间大于t1时，电压发生相位跳变 
    if t_temp >= t1 
        v(count) = 1 * sin(w * t_temp + phi_rad);
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'相位跳变','p.u.',t1); 

%%% 8.频率偏移
t1 = 0.04;                     %发生频率偏移的时间
f_offset = 45;                 %发生频率偏移的频率
w_offset = 2 * pi * f_offset;  %发生频率偏移的角频率
count = 1;                     %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = 1 * sin(w * t_temp);      
    end
    %时间大于t1时，电压发生频率偏移
    if t_temp >= t1 
        v(count) = 1 * sin(w_offset * t_temp + (w - w_offset) * t1);
    end
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'频率偏移','p.u.',t1); 

%%% 9.含有谐波(稳态干扰)
count = 1;                     %for循环 迭代器变量
noise_rand = 0.25;             %信噪比
A = 311;                       %电压最大值
for t_temp = 0:ts:ts_total
    %整个采样时间轴上均含有谐波(3次谐波、5次谐波、7次谐波)
    v(count) = 15/A * sin(3 * w * t_temp) + ...
           5/A * sin(5 * w * t_temp) + ...
           1/A * sin(7 * w * t_temp) + ...
           A/A * sin(w * t_temp);
    %附加噪声
    v_noise(count) = v(count) + unifrnd(-noise_rand,noise_rand); 
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'含有谐波','p.u.'); 

%%% <Summary>
%%%     十种电能质量问题数学模型及其波形
%%%     电压骤降、电压骤升、电压间断、谐波扰动
%%%     相位跳变、频率偏移、低频振荡、高频振荡
%%%     脉冲暂态、九种问题加噪声问题
%%%     (低频振荡和高频振荡公用暂态振荡数学模型)
%%%     小波自适应阈值去噪不仅去噪效果好 
%%%     而且能够保持原有电能干扰特征
%%% </Summary>




























