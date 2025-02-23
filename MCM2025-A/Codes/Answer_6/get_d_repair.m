function [d_repair]=get_d_repair(mod,zone,t_repair,a_factor,m,n,delta_S,Q1,Q2)
% zone_d 代表着各网格修复的深度

load F.mat
T=length(Q1);
Q1L=floor(Q1*0.5);
Q1R=floor(Q1*0.5)+1;
Q2L=floor(Q2*0.5);
Q2R=floor(Q2*0.5)+1;
% 得到真实数据点(x,y,type-上行/下行,flag)
% flag=0,则踩踏无效，fkag=1，则按照原磨损速率计算，fkag=2，则按照新磨损速率计算
act_dot_1L = get_CenterDot(Q1L,1,m,n);
act_dot_1R = get_CenterDot(Q1R,1,m,n);
act_dot_2L = get_CenterDot(Q2L,0,m,n);
act_dot_2R = get_CenterDot(Q2R,0,m,n);
% 初始化
d_repair = zeros(n, m);
%%%%%%%%%%%%%%%%%%需要根据mod采取不同的模拟策略%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%表示完全翻新%%%%%%%%%%%%
if mod==0
    zone_0=zone;
    % 维修情况下，处理各点
    act_dot_1L = Dot_process_0(act_dot_1L,zone_0,t_repair);
    act_dot_1R = Dot_process_0(act_dot_1R,zone_0,t_repair);
    act_dot_2L = Dot_process_0(act_dot_2L,zone_0,t_repair);
    act_dot_2R = Dot_process_0(act_dot_2R,zone_0,t_repair);
    % 各点计算造成的磨损
    for i=1:length(act_dot_1L)
        if act_dot_1L(i,4)>0 % 先排除无效情况
            if act_dot_1L(i,4)==1
                d_repair = d_repair + alphal_1L(act_dot_1L(i,2),act_dot_1L(i,1),act_dot_1L(i,3),m,n,delta_S,F1L);
            elseif act_dot_1L(i,4)==2
                d_repair = d_repair + a_factor*alphal_1L(act_dot_1L(i,2),act_dot_1L(i,1),act_dot_1L(i,3),m,n,delta_S,F1L);
            end
        end
    end

    for i=1:length(act_dot_1R)
        if act_dot_1R(i,4)>0 % 先排除无效情况
            if act_dot_1R(i,4)==1
                d_repair = d_repair + alphal_1R(act_dot_1R(i,2),act_dot_1R(i,1),act_dot_1R(i,3),m,n,delta_S,F1R);
            elseif act_dot_1R(i,4)==2
                d_repair = d_repair + a_factor*alphal_1R(act_dot_1R(i,2),act_dot_1R(i,1),act_dot_1R(i,3),m,n,delta_S,F1R);
            end
        end
    end

    for i=1:length(act_dot_2L)
        if act_dot_2L(i,4)>0 % 先排除无效情况
            if act_dot_2L(i,4)==1
                d_repair = d_repair + alphal_2L(act_dot_2L(i,2),act_dot_2L(i,1),act_dot_2L(i,3),m,n,delta_S,F2L);
            elseif act_dot_2L(i,4)==2
                d_repair = d_repair + a_factor*alphal_2L(act_dot_2L(i,2),act_dot_2L(i,1),act_dot_2L(i,3),m,n,delta_S,F2L);
            end
        end
    end

    for i=1:length(act_dot_2R)
        if act_dot_2R(i,4)>0 % 先排除无效情况
            if act_dot_2R(i,4)==1
                d_repair = d_repair + alphal_2R(act_dot_2R(i,2),act_dot_2R(i,1),act_dot_2R(i,3),m,n,delta_S,F2R);
            elseif act_dot_2R(i,4)==2
                d_repair = d_repair + a_factor*alphal_2R(act_dot_2R(i,2),act_dot_2R(i,1),act_dot_2R(i,3),m,n,delta_S,F2R);
            end
        end
    end
    %%%%%%%%%%%%表示不完全翻新%%%%%%%%%%%%
elseif mod==1

else
    disp('mod_wrong');
end
end

function act_dot=Dot_process_0(act_dot,zone_0,t_repair)
for i=1:length(act_dot)
    if  zone_0(act_dot(i,2),act_dot(i,1))==1
        if act_dot(i,3) > t_repair % 踩踏早于翻新时间，无效
            act_dot(i,4)=0;
        elseif act_dot(i,3) <= t_repair % 踩踏不早于翻新时间，按照新磨损速率计算
            act_dot(i,4)=2;
        end
    end
end
end