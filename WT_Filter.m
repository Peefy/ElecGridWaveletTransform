
%%% <Comment FunctionFile = "WT_Filter.m">
%%%     <Description>
%%%     小波自适应阈值去噪函数
%%%     </Description>
%%%     <InputParams>
%%%     @ filterBefore       滤波前的信号
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ returnVal          滤波后的信号
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function returnVal = WT_Filter(filterBefore)
%小波变换层数为5层
lev = 5;
%采用小波变换滤波
returnVal = wden(filterBefore,'sqtwolog','s','sln',lev,'sym8');
