
%%% <Comment FunctionFile = "WT_DrawOneTwoLine.m">
%%%     <Description>
%%%     ��ԭʼͼ���ϻ�����һ����������
%%%     </Description>
%%%     <InputParams>
%%%     @ v_filter  ����Ĵ�С���任���ź�
%%%     @ wname     С���任��������
%%%     @ t1        ͼ���к�ɫ���ߵĺ�����1
%%%     @ t2        ͼ���к�ɫ���ߵĺ�����2
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



