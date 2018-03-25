
%%% <Comment FunctionFile = "WT_DrawOneTwoLine.m">
%%%     <Description>
%%%     在原始图像上画竖线一条或者两条
%%%     </Description>
%%%     <InputParams>
%%%     @ v_filter  输入的待小波变换的信号
%%%     @ wname     小波变换方法名称
%%%     @ t1        图表中红色竖线的横坐标1
%%%     @ t2        图表中红色竖线的横坐标2
%%%     </InputParams>
%%%     <OutputParams>
%%%     Null
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/14</LastRenewTime>
%%% </Comment>

function WT_DrawOneTwoLine(cd,t1,t2)
if nargin == 3
    lineCount = max(abs(cd)) / 2;
    lineLength = -lineCount : lineCount/100:lineCount;
    drawLineY = lineLength ;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    drawLineY = -lineLength ;
    drawLineX = t2;
    plot(drawLineX,drawLineY,'r');
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
end
if nargin == 2
    lineCount = max(abs(cd)) / 2;
    lineLength = -lineCount : lineCount/100:lineCount;
    drawLineY = lineLength;
    drawLineX = t1;
    plot(drawLineX,drawLineY,'r');
    set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
end



