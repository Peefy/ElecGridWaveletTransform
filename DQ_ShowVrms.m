
%%% <Comment FunctionFile = "DQ_ShowVrms.m">
%%%     <Description>
%%%     ���˲����źź�Vrms��ͼ
%%%     </Description>
%%%     <InputParams>
%%%     @ v_filter       �����ź�
%%%     @ v_rms          Vrms�ź�
%%%     @ t              ����ʱ������ 
%%%     @ titleStr       ��ʾfigure�ı���
%%%     @ subTitle       ͼ����ӱ���
%%%     @ t1             ͼ���к�ɫ���ߵĺ�����1
%%%     @ t2             ͼ���к�ɫ���ߵĺ�����2
%%%     </InputParams>
%%%     <OutputParams>
%%%     Null
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/14</LastRenewTime>
%%% </Comment>

function DQ_ShowVrms(v_filter,v_rms,t,titleStr,subTitle,t1,t2,t3,t4)

%�½�ͼ��
h = figure;
%�趨figure�����x��y����ʾ
set(h,'name',titleStr,'Numbertitle','off');
%�������ź�
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

xlabel('ʱ��/t');ylabel(['��ѹ/','V']);   
%��Vrms�ź�
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
xlabel('ʱ��/t');ylabel(['��ѹ/','V']);   
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');