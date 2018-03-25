
%%% <Comment FunctionFile = "VoltageKindShowPlot.m">
%%%     <Description>
%%%     ��ԭʼ�źš��������źš��˲����źŵ�ͼ
%%%     </Description>
%%%     <InputParams>
%%%     @ v              ԭʼ�ź�
%%%     @ v_noise        �������ź�
%%%     @ v_filter       �˲����ź�
%%%     @ t              ����ʱ������ 
%%%     @ titleStr       ��ʾfigure�ı���
%%%     @ vStr           ����(��ѹ��)�ĵ�λ
%%%     @ t1             ͼ���к�ɫ���ߵĺ�����1
%%%     @ t2             ͼ���к�ɫ���ߵĺ�����2
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ v_return       ԭʼ��ѹ�źŷ���ֵ
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function v_return = VoltageKindShowPlot(v,v_noise,v_filter,t,titleStr,vStr,t1,t2)
% ������ֵ��ֵ
v_return = v;
%�½�ͼ��
h = figure;
%�趨figure�����x��y����ʾ
set(h,'name',titleStr,'Numbertitle','off');

%��ԭʼ�ź�
plot(t,v);
xlabel('ʱ��/t');ylabel(['��ѹ/',vStr]);   
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
%�½�ͼ��
h = figure;
str = '(��������)';
set(h,'name',[titleStr,str],'Numbertitle','off');
%���������ź�
plot(t,v_noise);
xlabel('ʱ��/t');ylabel(['��ѹ/',vStr]);   
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
%�½�ͼ��
h = figure;
str = '(С������Ӧ��ֵȥ���)';
set(h,'name',[titleStr,str],'Numbertitle','off');
%���˲����ź�
plot(t,v_filter);
xlabel('ʱ��/t');ylabel(['��ѹ/',vStr]);   
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


