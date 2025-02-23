function [d_repair]=get_dd_repair(mod,zone,t_repair,a_factor,m,n,delta_S,Q1,Q2)
% zone_d 代表着各网格修复的深度
% 直接完成多次维修
load F.mat
Q1L=floor(Q1*0.5);
Q1R=floor(Q1*0.5)+1;
Q2L=floor(Q2*0.5);
Q2R=floor(Q2*0.5)+1;
% 得到真实数据点(x,y,时间t,flag)
% flag=0,则踩踏无效，fkag=1，则按照原磨损速率计算，fkag=2，则按照新磨损速率计算
[act_dot_1L,dot_i_1L] = get_CenterDot(Q1L,1,m,n,t_repair);
[act_dot_1R,dot_i_1R] = get_CenterDot(Q1R,1,m,n,t_repair);
[act_dot_2L,dot_i_2L] = get_CenterDot(Q2L,0,m,n,t_repair);
[act_dot_2R,dot_i_2R] = get_CenterDot(Q2R,0,m,n,t_repair);
% 初始化
d_repair = zeros(n, m);
%%%%%%%%%%%%%%%%%%需要根据mod采取不同的模拟策略%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%表示完全翻新%%%%%%%%%%%%
if mod==0
    zone_0=zone;
    % 维修前，正常处理
    for i=1:dot_i_1L-1
        d_repair = d_repair+ alphal_1L(act_dot_1L(i,2),act_dot_1L(i,1),act_dot_1L(i,3),m,n,delta_S,F1L);
    end
    for i=1:dot_i_1R-1
        d_repair = d_repair+ alphal_1R(act_dot_1R(i,2),act_dot_1R(i,1),act_dot_1R(i,3),m,n,delta_S,F1R);      
    end
    for i=1:dot_i_2L-1
        d_repair = d_repair+ alphal_2L(act_dot_2L(i,2),act_dot_2L(i,1),act_dot_2L(i,3),m,n,delta_S,F2L);      
    end
    for i=1:dot_i_2R-1
        d_repair = d_repair+ alphal_2R(act_dot_2R(i,2),act_dot_2R(i,1),act_dot_2R(i,3),m,n,delta_S,F2R);
    end
    % 维修!假设维修只要一瞬间（相对于单位时间）
    for i=1:n
        for j=1:m
            if  zone_0(i,j)==1
                d_repair(i,j) = 0;
            end
        end
    end
    % 维修后，局部异常处理
    for i=dot_i_1L:length(Q1L)
        d_repair = d_repair+ alphal_repair(zone_0,a_factor,act_dot_1L(i,2),act_dot_1L(i,1),act_dot_1L(i,3),m,n,delta_S,F1L);
    end
    for i=dot_i_1R:length(Q1R)
        d_repair = d_repair+ alphal_repair(zone_0,a_factor,act_dot_1R(i,2),act_dot_1R(i,1),act_dot_1R(i,3),m,n,delta_S,F1R);      
    end
    for i=dot_i_2L:length(Q2L)
        d_repair = d_repair+ alphal_repair(zone_0,a_factor,act_dot_2L(i,2),act_dot_2L(i,1),act_dot_2L(i,3),m,n,delta_S,F2L);      
    end
    for i=dot_i_2R:length(Q2R)
        d_repair = d_repair+ alphal_repair(zone_0,a_factor,act_dot_2R(i,2),act_dot_2R(i,1),act_dot_2R(i,3),m,n,delta_S,F2R);
    end
%%%%%%%%%%%%表示不完全翻新%%%%%%%%%%%%
elseif mod==1

else
    disp('mod_wrong');
end

d_repair=d_repair*1730;


end

% function act_dot=Dot_process_0(act_dot,zone_0,t_repair)
% for i=1:length(act_dot)
%     if  zone_0(act_dot(i,2),act_dot(i,1))==1
%         if act_dot(i,3) > t_repair % 踩踏早于翻新时间，无效
%             act_dot(i,4)=0;
%         elseif act_dot(i,3) <= t_repair % 踩踏不早于翻新时间，按照新磨损速率计算
%             act_dot(i,4)=2;
%         end
%     end
% end
% end