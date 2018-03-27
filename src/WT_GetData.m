
%%% <Comment FunctionFile = "WT_GetData.m">
%%%     <Description>
%%%     小波变换获取近似系数和细节系数并画细节系数的图
%%%     </Description>
%%%     <InputParams>
%%%     @ v_filter       待小波变换的信号
%%%     @ wname          小波变换方式名称
%%%     @ level          小波变换分解的层数
%%%     @ ts_toal        采样总时长 
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ ca1       第一层小波变换的近似系数
%%%     @ ca2       第二层小波变换的近似系数
%%%     @ cd1       第一层小波变换的细节系数
%%%     @ cd2       第二层小波变换的细节系数
%%%     @ cd3       第三层小波变换的细节系数
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function [ca1,ca2,cd1,cd2,cd3] = WT_GetData(v_filter,wname,level,ts_total)

%(重要)小波分解的系统函数
[C,L] = wavedec(v_filter,level,wname);  
%(重要)小波重构的系统函数
[cd1,cd2,cd3] = detcoef(C,L,[1,2,3]);     
%小波重构 1层近似分量
ca1 = appcoef(C,L,wname,1);       
%小波重构 2层近似分量
ca2 = appcoef(C,L,wname,2);             
%求第一层小波细节系数的长度 （小波细节系数是个一维的向量）
size_cd1 = size(cd1);
lenth_cd1 = size_cd1(2);
%求第二层小波细节系数的长度 （小波细节系数是个一维的向量）
size_cd2 = size(cd2);
lenth_cd2 = size_cd2(2);
%求第三层小波细节系数的长度 （小波细节系数是个一维的向量）
size_cd3 = size(cd3);
lenth_cd3 = size_cd3(2);
%求第一层小波近似系数的长度 （小波近似系数是个一维的向量）
size_ca1 = size(ca1);
lenth_ca1 = size_ca1(2);
%求第二层小波近似系数的长度 （小波近似系数是个一维的向量）
size_ca2 = size(ca2);
lenth_ca2 = size_ca2(2);
%根据小波近似系数和细节系数的长度构造画图的时间轴
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
t_cd3 = linspace(0,ts_total,lenth_cd3);
%t_ca1 = linspace(0,ts_total,lenth_ca1);
%t_ca2 = linspace(0,ts_total,lenth_ca2);

%新建figure
h = figure;
%设置figure的标题
str1 = '信号滤波后 小波';
str2 = wname;
str3 = '变换第1层分解细节系数';
set(h,'name',[str1,str2,str3],'Numbertitle','off');
%画第一层近似系数的图
plot(t_cd1,cd1);
xlabel('时间/t');ylabel('cd1');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%新建figure
h = figure;
%设置figure的标题
str1 = '信号滤波后 小波';
str2 = wname;
str3 = '变换第2层分解细节系数';
set(h,'name',[str1,str2,str3],'Numbertitle','off');
%画第二层近似系数的图
plot(t_cd2,cd2);
xlabel('时间/t');ylabel('cd2');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%新建figure
h = figure;
%设置figure的标题
str1 = '信号滤波后 小波';
str2 = wname;
str3 = '变换第3层分解细节系数';
set(h,'name',[str1,str2,str3],'Numbertitle','off');
%画第三层近似系数的图
plot(t_cd3,cd3);
xlabel('时间/t');ylabel('cd3');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');