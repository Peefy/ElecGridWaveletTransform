
%%% <Comment FunctionFile = "VoltageKindShowPlot.m">
%%%     <Description>
%%%     画原始信号、加噪声信号、滤波后信号的图
%%%     </Description>
%%%     <InputParams>
%%%     @ v              原始信号
%%%     @ v_noise        加噪声信号
%%%     @ v_filter       滤波后信号
%%%     @ t              采样时间向量 
%%%     @ titleStr       显示figure的标题
%%%     @ vStr           纵轴(电压轴)的单位
%%%     @ t1             图表中红色竖线的横坐标1
%%%     @ t2             图表中红色竖线的横坐标2
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ v_return       原始电压信号返回值
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function v_return = VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,vStr,t1,t2)
% 给返回值赋值
v_return = v;
%新建图表
h = figure;
%设定figure标题和x轴y轴显示
set(h,'name',titleStr,'Numbertitle','off');

%画原始信号
plot(t,v);
xlabel('时间/t');ylabel(['电压/',vStr]);   
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
if nargin == 8
    hold on 
    drawLineY = -0.5:0.001:0.5;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -0.5:0.001:0.5;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    hold off
end
if nargin == 7
    hold on 
    drawLineY = -0.5:0.001:0.5;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    hold off
end
%新建图表
h = figure;
str = '(加噪声后)';
set(h,'name',[titleStr,str],'Numbertitle','off');
%画加噪声信号
plot(t,v_noise);
xlabel('时间/t');ylabel(['电压/',vStr]);   
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
if nargin == 8
    hold on 
    drawLineY =  -0.5:0.001:0.5;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY =  -0.5:0.001:0.5;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    hold off
end
if nargin == 7
    hold on 
    drawLineY =  -0.5:0.001:0.5;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    hold off
end
%新建图表
h = figure;
str = '(小波自适应阈值去噪后)';
set(h,'name',[titleStr,str],'Numbertitle','off');
%画滤波后信号
plot(t,v_filter);
xlabel('时间/t');ylabel(['电压/',vStr]);   
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
if nargin == 8
    hold on 
    drawLineY =  -0.5:0.001:0.5;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY =  -0.5:0.001:0.5;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    hold off
end
if nargin == 7
    hold on 
    drawLineY =  -0.5:0.001:0.5;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    hold off
end


