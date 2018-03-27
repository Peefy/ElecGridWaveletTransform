
%%% <Comment FunctionFile = "DQ_GetVrms.m">
%%%     <Description>
%%%     由输入信号获得Vrms信号
%%%     </Description>
%%%     <InputParams>
%%%     @ v             输入信号
%%%     </InputParams>
%%%     <OutputParams>
%%%     @ v_rms         返回Vrms信号
%%%     </OutputParams>
%%%     <Author>Han</Author> 
%%%     <LastRenewTime>2017/4/13</LastRenewTime>
%%% </Comment>

function  v_rms = DQ_GetVrms(v,ts_total)
Tcount = 200;
v_length = length(v);   %3001
v_rms = linspace(0,ts_total,v_length);
for count = 1:(v_length - (Tcount - 1))
    s = v(1:1,count:(count + Tcount - 1));
    
    a = zeros(1,length(s));
    for i = 1:length(s)
        a(i) = s(i) .* s(i);
    end
    b = 0;
    for i = 1:length(s)
        b = a(i) + b;
    end
    
    v_rms(count) = sqrt(b/length(s));
end
    
for count = (v_length - (Tcount - 2)) : v_length
    v_rms(count) = 220.2;
end

