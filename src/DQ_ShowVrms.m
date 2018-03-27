
%%% <Comment FunctionFile = "DQ_ShowVrms.m">
%%%     <Description>
%%%     画滤波后信号和Vrms的图
%%%     </Description>
%%%     <InputParams>
%%%     @ v_filter       输入信号
%%%     @ v_rms          Vrms信号
%%%     @ t              采样时间向量 
%%%     @ titleStr       显示figure的标题
%%%     @ subTitle       图表的子标题
%%%     @ t1             图表中红色竖线的横坐标1
%%%     @ t2             图表中红色竖线的横坐标2
%%%     </InputParams>
%%%     <OutputParams>
%%%     Null
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/14</LastRenewTime>
%%% </Comment>

function DQ_ShowVrms(v_filter,v_rms,t,titleStr,subTitle,t1,t2,t3,t4)

%新建图表
h = figure;
%设定figure标题和x轴y轴显示
set(h,'name',titleStr,'Numbertitle','off');
%画输入信号
subplot(211);
plot(t,v_filter);
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
if nargin == 9
    hold on 
    drawLineY = -10:1:300;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t3;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t4;
    plot(drawLineX,drawLineY,'r');
    hold off
end

if nargin == 7
    hold on 
    drawLineY = -10:1:300;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    hold off
end
if nargin == 6
    hold on 
    drawLineY = -10:1:300;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    hold off
end

xlabel('时间/t');ylabel(['电压/','V']);   
%画Vrms信号
subplot(212);
plot(t,v_rms);set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
if nargin == 9
    hold on 
    drawLineY = -10:1:300;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t3;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t4;
    plot(drawLineX,drawLineY,'r');
    hold off
end

if nargin == 7
    hold on 
    drawLineY = -10:1:300;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -10:1:300;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    hold off
end
if nargin == 6
    hold on 
    drawLineY = -10:1:300;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    hold off
end
xlabel('时间/t');ylabel(['电压/','V']);   
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');