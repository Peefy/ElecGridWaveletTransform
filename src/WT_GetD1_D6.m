
%%% <Comment FunctionFile = "WT_GetD1_D6.m">
%%%     <Description>
%%%     获取小波变换前六层的细节系数
%%%     作图时去掉0-0.02和0.13-0.15之间的点(前后各一个周期)，消除边缘效应的影响
%%%     </Description>
%%%     <UseMyFunction> 
%%%     WT_DrawOneTwoLine.m;
%%%     </UseMyFunction> 
%%%     <InputParams>
%%%     @ v_filter  输入的待小波变换的信号
%%%     @ wname     小波变换方法名称
%%%     @ level     小波变换的层数（必须大于等于6）
%%%     @ ts_total  采样时间总时长 
%%%     @ titleStr  显示figure的标题
%%%     @ isShowVin 是否显示显示输入电压波形
%%%     @ t1        图表中红色竖线的横坐标1
%%%     @ t2        图表中红色竖线的横坐标2
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ cd1       第一层小波变换的细节系数
%%%     @ cd2       第二层小波变换的细节系数
%%%     @ cd3       第三层小波变换的细节系数
%%%     @ cd4       第四层小波变换的细节系数
%%%     @ cd5       第五层小波变换的细节系数
%%%     @ cd6       第六层小波变换的细节系数
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/14</LastRenewTime>
%%% </Comment>

function [cd1,cd2,cd3,cd4,cd5,cd6] = WT_GetD1_D6(v_filter,wname,level,ts_total,titleStr,isShowVin,t1,t2)

%(重要)小波分解的系统函数
[C,L] = wavedec(v_filter,level,wname);  
%(重要)小波重构的系统函数
[cd1,cd2,cd3,cd4,cd5,cd6] = detcoef(C,L,[1,2,3,4,5,6]);     
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
%求第四层小波细节系数的长度 （小波细节系数是个一维的向量）
size_cd4 = size(cd4);
lenth_cd4 = size_cd4(2);
%求第五层小波细节系数的长度 （小波细节系数是个一维的向量）
size_cd5 = size(cd5);
lenth_cd5 = size_cd5(2);
%求第六层小波细节系数的长度 （小波细节系数是个一维的向量）
size_cd6 = size(cd6);
lenth_cd6 = size_cd6(2);
%根据小波细节系数的长度构造画图的时间轴
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
t_cd3 = linspace(0,ts_total,lenth_cd3);
t_cd4 = linspace(0,ts_total,lenth_cd4);
t_cd5 = linspace(0,ts_total,lenth_cd5);
t_cd6 = linspace(0,ts_total,lenth_cd6);

%去掉边缘效应 
removeCount = 200;
cd1 = cd1(1:1,round(removeCount):length(cd1) - round(removeCount));
cd2 = cd2(1:1,round(removeCount/2):length(cd2) - round(removeCount/2));
cd3 = cd3(1:1,round(removeCount/4):length(cd3) - round(removeCount/4));
cd4 = cd4(1:1,round(removeCount/8):length(cd4) - round(removeCount/8));
cd5 = cd5(1:1,round(removeCount/16):length(cd5) - round(removeCount/16));
cd6 = cd6(1:1,round(removeCount/32):length(cd6) - round(removeCount/32));
t_cd1 = t_cd1(1:1,round(removeCount):length(t_cd1) - round(removeCount));
t_cd2 = t_cd2(1:1,round(removeCount/2):length(t_cd2) - round(removeCount/2));
t_cd3 = t_cd3(1:1,round(removeCount/4):length(t_cd3) - round(removeCount/4));
t_cd4 = t_cd4(1:1,round(removeCount/8):length(t_cd4) - round(removeCount/8));
t_cd5 = t_cd5(1:1,round(removeCount/16):length(t_cd5) - round(removeCount/16));
t_cd6 = t_cd6(1:1,round(removeCount/32):length(t_cd6) - round(removeCount/32));

%新建figure
h = figure;
%设置figure的标题
str1 = '小波变换层数：7;';
str2 = '小波变换方法：';
set(h,'name',[titleStr,str1,str2,wname],'Numbertitle','off');
%lineLength = -0.1:0.001:0.1;
if isShowVin == 0
    %画六层细节系数的图
    subplot(231);
    plot(t_cd1,cd1);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd1,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd1,t1);
        hold off
    end
    subplot(232);
    plot(t_cd2,cd2);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd2,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd2,t1);
        hold off
    end
    subplot(233);
    plot(t_cd3,cd3);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd3,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd3,t1);
        hold off
    end
    subplot(234);
    plot(t_cd4,cd4);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd4,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd4,t1);
        hold off
    end
    subplot(235);
    plot(t_cd5,cd5);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd5,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd5,t1);
        hold off
    end
    subplot(236);
    plot(t_cd6,cd6);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd6,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd6,t1);
        hold off
    end
    xlabel('时间/t');
    set(gca,'Fontname','times new Roman'); 
    set(get(gca,'XLabel'),'Fontname','times new Roman');
    set(get(gca,'YLabel'),'Fontname','times new Roman');
end
if isShowVin == 1
    subplot(711);
    t = linspace(0,ts_total,length(v_filter));
    t = t(1:1,round(removeCount * 2):length(t) - round(removeCount * 2));
    v_filter = v_filter(1:1,round(removeCount * 2):length(v_filter) - round(removeCount * 2));
    plot(t,v_filter);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        line_lenth = -300:1:300;
        hold on 
        drawLineY = line_lenth;
        drawLineX = t1;
        plot(drawLineX,drawLineY,'r');
        set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
        drawLineY = line_lenth;
        drawLineX = t2;
        plot(drawLineX,drawLineY,'r');
        set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
        hold off
    end
    if nargin == 7
        line_lenth = -300:1:300;
        hold on 
        drawLineY = line_lenth;
        drawLineX = t1;
        plot(drawLineX,drawLineY,'r');
        set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
        hold off
    end
    subplot(712);
    plot(t_cd1,cd1);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd1,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd1,t1);
        hold off
    end
    subplot(713);
    plot(t_cd2,cd2);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd2,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd2,t1);
        hold off
    end
    subplot(714);
    plot(t_cd3,cd3);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd3,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd3,t1);
        hold off
    end
    subplot(715);
    plot(t_cd4,cd4);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd4,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd4,t1);
        hold off
    end
    subplot(716);
    plot(t_cd5,cd5);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd5,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd5,t1);
        hold off
    end
    subplot(717);
    plot(t_cd6,cd6);
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
    if nargin == 8
        hold on 
        WT_DrawOneTwoLine(cd6,t1,t2);
        hold off
    end
    if nargin == 7
        hold on 
        WT_DrawOneTwoLine(cd6,t1);
        hold off
    end
    xlabel('时间/t');
    set(gca,'Fontname','times new Roman'); 
    set(get(gca,'XLabel'),'Fontname','times new Roman');
    set(get(gca,'YLabel'),'Fontname','times new Roman');
end


