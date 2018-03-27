
%%% <Comment FunctionFile = "WT_GetData.m">
%%%     <Description>
%%%     С���任��ȡ����ϵ����ϸ��ϵ������ϸ��ϵ����ͼ
%%%     </Description>
%%%     <InputParams>
%%%     @ v_filter       ��С���任���ź�
%%%     @ wname          С���任��ʽ����
%%%     @ level          С���任�ֽ�Ĳ���
%%%     @ ts_toal        ������ʱ�� 
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ ca1       ��һ��С���任�Ľ���ϵ��
%%%     @ ca2       �ڶ���С���任�Ľ���ϵ��
%%%     @ cd1       ��һ��С���任��ϸ��ϵ��
%%%     @ cd2       �ڶ���С���任��ϸ��ϵ��
%%%     @ cd3       ������С���任��ϸ��ϵ��
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function [ca1,ca2,cd1,cd2,cd3] = WT_GetData(v_filter,wname,level,ts_total)

%(��Ҫ)С���ֽ��ϵͳ����
[C,L] = wavedec(v_filter,level,wname);  
%(��Ҫ)С���ع���ϵͳ����
[cd1,cd2,cd3] = detcoef(C,L,[1,2,3]);     
%С���ع� 1����Ʒ���
ca1 = appcoef(C,L,wname,1);       
%С���ع� 2����Ʒ���
ca2 = appcoef(C,L,wname,2);             
%���һ��С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd1 = size(cd1);
lenth_cd1 = size_cd1(2);
%��ڶ���С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd2 = size(cd2);
lenth_cd2 = size_cd2(2);
%�������С��ϸ��ϵ���ĳ��� ��С��ϸ��ϵ���Ǹ�һά��������
size_cd3 = size(cd3);
lenth_cd3 = size_cd3(2);
%���һ��С������ϵ���ĳ��� ��С������ϵ���Ǹ�һά��������
size_ca1 = size(ca1);
lenth_ca1 = size_ca1(2);
%��ڶ���С������ϵ���ĳ��� ��С������ϵ���Ǹ�һά��������
size_ca2 = size(ca2);
lenth_ca2 = size_ca2(2);
%����С������ϵ����ϸ��ϵ���ĳ��ȹ��컭ͼ��ʱ����
t_cd1 = linspace(0,ts_total,lenth_cd1);
t_cd2 = linspace(0,ts_total,lenth_cd2);
t_cd3 = linspace(0,ts_total,lenth_cd3);
%t_ca1 = linspace(0,ts_total,lenth_ca1);
%t_ca2 = linspace(0,ts_total,lenth_ca2);

%�½�figure
h = figure;
%����figure�ı���
str1 = '�ź��˲��� С��';
str2 = wname;
str3 = '�任��1��ֽ�ϸ��ϵ��';
set(h,'name',[str1,str2,str3],'Numbertitle','off');
%����һ�����ϵ����ͼ
plot(t_cd1,cd1);
xlabel('ʱ��/t');ylabel('cd1');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%�½�figure
h = figure;
%����figure�ı���
str1 = '�ź��˲��� С��';
str2 = wname;
str3 = '�任��2��ֽ�ϸ��ϵ��';
set(h,'name',[str1,str2,str3],'Numbertitle','off');
%���ڶ������ϵ����ͼ
plot(t_cd2,cd2);
xlabel('ʱ��/t');ylabel('cd2');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');
%�½�figure
h = figure;
%����figure�ı���
str1 = '�ź��˲��� С��';
str2 = wname;
str3 = '�任��3��ֽ�ϸ��ϵ��';
set(h,'name',[str1,str2,str3],'Numbertitle','off');
%�����������ϵ����ͼ
plot(t_cd3,cd3);
xlabel('ʱ��/t');ylabel('cd3');
set(gca,'Fontname','times new Roman'); 
set(get(gca,'XLabel'),'Fontname','times new Roman');
set(get(gca,'YLabel'),'Fontname','times new Roman');