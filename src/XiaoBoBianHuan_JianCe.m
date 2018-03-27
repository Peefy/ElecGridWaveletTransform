
%%% <Comment File = "XiaoBoBianHuan_JianCe.m">
%%%     <Description>
%%%     选取不同的小波变换方法
%%%     检测电能质量起止时间和种类
%%%     具有一定局限性，配合dq变换
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
noise_rand = 0.25;           %信噪比

%%% 小波变换参数(重要)
level = 7;                   %小波分解层数：7层 根据公式计算得
wname = 'db8';               %小波变换方法名称
isShowVin = 1;
%%% 1.振荡暂态
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
       (800 * sin(30 * w * t_temp) + 3000 * sin(12 * w * t_temp))...
        * exp(-300 * (t_temp - 0.041));
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,'震荡暂态','V'); 
%将滤波后的电压信号进行小波变换并重构
%获取小波变换第一层和第二层的近似系数c1，c2，和细节系数d1，d2 
% WT_GetData(v_filter,wname,level,ts_total);
% %比较wname1，wname2，wname3，wname4小波变换方式cd1和cd2的不同(原始信号)
% wname1 = 'db5';wname2 = 'db8';wname3 = 'db24';wname4 = 'db40';
% WT_GetDataCompare(wname1,wname2,wname3,wname4,level,v,ts_total);
% %比较wname1，wname2，wname3，wname4小波变换方式cd1和cd2的不同(原始信号)
% wname1 = 'coif2';wname2 = 'coif3';wname3 = 'coif4';wname4 = 'coif5';
% WT_GetDataCompare(wname1,wname2,wname3,wname4,level,v,ts_total);

%%% 2.含有谐波(稳态干扰)(结论：看出小波变换对稳态干扰无能为力)
count = 1;               %循环变量
noise_rand = 0.15;       %信噪比
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
%显示加噪前、加噪后、去噪后的电压波形
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %不加噪声的小波七尺度变换
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin);   
% %加噪声的小波七尺度变换
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin);   
% %加噪声且滤波后的小波七尺度变换
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin);  

%%% 3.电压短时上升及其小波七尺度变换
t1 = 0.03;                   %发生电压上升的时间
t2 = 0.09;                   %结束电压上升的时间
alpha = 1.4;                 %数学模型中的 电压上升比例
noise_rand = 0.15;           %信噪比
count = 1;                   %for循环 迭代器变量
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
% %显示加噪前、加噪后、去噪后的电压波形
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %不加噪声的小波七尺度变换
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1,t2);   
% %加噪声的小波七尺度变换
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1,t2);   
% %加噪声且滤波后的小波七尺度变换
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1,t2);  

%%% 4.电压短时下降及其七尺度小波变换（注意：滤波后识别失败）
t1 = 0.03;                    %发生电压下降的时间
t2 = 0.07;                    %结束电压下降的时间
alpha = 0.57;                 %数学模型中的 电压下降比例
noise_rand = 0.15;            %信噪比
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
%显示加噪前、加噪后、去噪后的电压波形
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %不加噪声的小波七尺度变换
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1,t2);   
% %加噪声的小波七尺度变换
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1,t2);   
% %加噪声且滤波后的小波七尺度变换
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1,t2);  

%%% 5.电压短时间断及其七尺度小波变换
t1 = 0.05;                    %发生电压间断的时间
t2 = 0.09;                    %结束电压间断的时间
alpha = 0.005;                %数学模型中的 电压间断比例
noise_rand = 0.05;            %信噪比
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
%显示加噪前、加噪后、去噪后的电压波形
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %不加噪声的小波七尺度变换
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1,t2);   
% %加噪声的小波七尺度变换
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1,t2);   
% %加噪声且滤波后的小波七尺度变换
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1,t2);  

%%% 6.相位跳变及其七尺度小波变换
t1 = 0.05;                        %发生相位跳变的时间
phi_deg = 10;                     %发生相位跳变的角度
phi_rad = phi_deg * pi /180;      %发生相位跳变的弧度
noise_rand = 0.05;                %信噪比
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
%显示加噪前、加噪后、去噪后的电压波形
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %不加噪声的小波七尺度变换
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1);   
% %加噪声的小波七尺度变换
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1);   
% %加噪声且滤波后的小波七尺度变换
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1);  

%%% 7.频率偏移及其七尺度小波变换
t1 = 0.07;                     %发生频率偏移的时间
f_offset = 25;                 %发生频率偏移的频率
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
%显示加噪前、加噪后、去噪后的电压波形
% VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
% %不加噪声的小波七尺度变换
% WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1);   
% %加噪声的小波七尺度变换
% WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1);   
% %加噪声且滤波后的小波七尺度变换
% WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1);  

%%% 8.脉冲暂态及其七尺度小波变换
t1 = 0.10;           %发生脉冲暂态的时间
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
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
%不加噪声的小波七尺度变换
WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1);   
%加噪声的小波七尺度变换
WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1);   
%加噪声且滤波后的小波七尺度变换
WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1);  

%%% 9.频率偏移加相位跳变及其七尺度小波变换
t1 = 0.07;                     %发生频率偏移的时间
t2 = 0.09;                     %附加相位跳变的时间  
f_offset = 25;                 %发生频率偏移的频率
w_offset = 2 * pi * f_offset;  %发生频率偏移的角频率
phi_deg = 10;                  %发生相位跳变的角度
phi_rad = phi_deg * pi /180;   %发生相位跳变的弧度
count = 1;                     %for循环 迭代器变量
for t_temp = 0:ts:ts_total
    %时间小于t1时，电压正常 
    if t_temp < t1
        v(count) = A * sin(w * t_temp);      
    end
    %时间大于t1时，电压发生频率偏移
    if t_temp >= t1 && t_temp < t2
        v(count) = A * sin(w_offset * t_temp + (w - w_offset) * t1);
    end
    %时间大于t2时，电压发生相位跳变
    if t_temp >= t2
        v(count) = A * sin(w_offset * t_temp + (w - w_offset) * t1 + phi_rad);
    end
    %附加噪声
    v_noise(count) = v(count) + ...
        unifrnd(-noise_rand * A,noise_rand * A);
    count = count + 1;     %迭代器递增
end
titleStr = '频率偏移加相位跳变';
%小波自适应阈值滤波去噪
v_filter = WT_Filter(v_noise);    
%显示加噪前、加噪后、去噪后的电压波形
VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,'V'); 
%不加噪声的小波七尺度变换
WT_GetD1_D6(v,wname,level,ts_total,[titleStr,'(原始信号);'],isShowVin,t1,t2);   
%加噪声的小波七尺度变换
WT_GetD1_D6(v_noise,wname,level,ts_total,[titleStr,'(加噪声);'],isShowVin,t1,t2);   
%加噪声且滤波后的小波七尺度变换
WT_GetD1_D6(v_filter,wname,level,ts_total,[titleStr,'(去噪后);'],isShowVin,t1,t2);  

%%% <Summary>
%%%     对于稳态扰动（如谐波扰动）小波变换无法识别
%%%     当发生电压大小改变的电能质量问题时，无法识别是电压下降还是上升
%%%     小波自适应阈值滤波效果非常棒但是可能使小波变换检测失败
%%%     如电压短时上升、下降、中断，但这几种采用dq变换非常好使
%%% </Summary>



