
%%% <Comment FunctionFile = "WT_GetDataCompare.m">
%%%     <Description>
%%%     �Ƚ�����С���任��ʽϸ��ϵ��cd1��cd2����ͬ
%%%     </Description>
%%%     <InputParams>
%%%     @ wname1           С���任��ʽ����1
%%%     @ wname2           С���任��ʽ����2
%%%     @ wname3           С���任��ʽ����3
%%%     @ wname4           С���任��ʽ����4
%%%     @ level            С���任�ֽ�Ĳ���
%%%     @ v_filter         ��С���任�ź�
%%%     @ ts_total         ������ʱ�� 
%%%     </InputParams>
%%%     <OutputParams>
%%%     Null
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function WT_GetDataCompare(wname1,wname2,wname3,wname4,level,v_filter,ts_total)

%�½�figure
h = figure;
%����figure����
set(h,'name',['С���任��ʽ��',wname1,',',wname2,',',wname3,',',wname4,'��ϸ��ϵ��cd1��cd2�ıȽ�'],'Numbertitle','off');
%(��Ҫ)С���ֽ��ϵͳ����
[C,L] = wavedec(v_filter,level,wname1);  
%(��Ҫ)С���ع���ϵͳ����
[cd1,cd2] = detcoef(C,L,[1,2]);    
%���һ��С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd1 = size(cd1);
lenth_cd1 = size_cd1(2);
%��ڶ���С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd2 = size(cd2);
lenth_cd2 = size_cd2(2);
%����С��ϸ��ϵ���ĳ��ȹ��컭ͼ��ʱ����
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
%��wname1��С��ϸ��ϵ��cd1��cd2��ͼ
subplot(241);
plot(t_cd1,cd1);
xlabel('ϸ��ϵ��d1');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
subplot(245);
plot(t_cd2,cd2);
xlabel('ϸ��ϵ��d2');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%(��Ҫ)С���ֽ��ϵͳ����
[C,L] = wavedec(v_filter,level,wname1);  
%(��Ҫ)С���ع���ϵͳ����
[cd1,cd2] = detcoef(C,L,[1,2]);    
%���һ��С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd1 = size(cd1);
lenth_cd1 = size_cd1(2);
%��ڶ���С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd2 = size(cd2);
lenth_cd2 = size_cd2(2);
%����С��ϸ��ϵ���ĳ��ȹ��컭ͼ��ʱ����
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
%��wname2��С��ϸ��ϵ��cd1��cd2��ͼ
subplot(242);
plot(t_cd1,cd1);
xlabel('ϸ��ϵ��d1');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
subplot(246);
plot(t_cd2,cd2);
xlabel('ϸ��ϵ��d2');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%(��Ҫ)С���ֽ��ϵͳ����
[C,L] = wavedec(v_filter,level,wname1);  
%(��Ҫ)С���ع���ϵͳ����
[cd1,cd2] = detcoef(C,L,[1,2]);    
%���һ��С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd1 = size(cd1);
lenth_cd1 = size_cd1(2);
%��ڶ���С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd2 = size(cd2);
lenth_cd2 = size_cd2(2);
%����С��ϸ��ϵ���ĳ��ȹ��컭ͼ��ʱ����
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
%��wname3��С��ϸ��ϵ��cd1��cd2��ͼ
subplot(243);
plot(t_cd1,cd1);
xlabel('ϸ��ϵ��d1');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
subplot(247);
plot(t_cd2,cd2);
xlabel('ϸ��ϵ��d2');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%(��Ҫ)С���ֽ��ϵͳ����
[C,L] = wavedec(v_filter,level,wname1);  
%(��Ҫ)С���ع���ϵͳ����
[cd1,cd2] = detcoef(C,L,[1,2]);    
%���һ��С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd1 = size(cd1);
lenth_cd1 = size_cd1(2);
%��ڶ���С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd2 = size(cd2);
lenth_cd2 = size_cd2(2);
%����С��ϸ��ϵ���ĳ��ȹ��컭ͼ��ʱ����
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
%��wname4��С��ϸ��ϵ��cd1��cd2��ͼ
subplot(244);
plot(t_cd1,cd1);
xlabel('ϸ��ϵ��d1');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
subplot(248);
plot(t_cd2,cd2);
xlabel('ϸ��ϵ��d2');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');