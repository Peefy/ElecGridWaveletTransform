
%%% <Comment FunctionFile = "WT_Filter.m">
%%%     <Description>
%%%     С������Ӧ��ֵȥ�뺯��
%%%     </Description>
%%%     <InputParams>
%%%     @ filterBefore       �˲�ǰ���ź�
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ returnVal          �˲�����ź�
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function returnVal = WT_Filter(filterBefore)
%С���任����Ϊ5��
lev = 5;
%����С���任�˲�
returnVal = wden(filterBefore,'sqtwolog','s','sln',lev,'sym8');
