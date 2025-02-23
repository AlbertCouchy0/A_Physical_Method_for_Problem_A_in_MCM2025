% 模拟实际磨损深度
function [d_act]=get_d_original(m,n,delta_S,Q1,Q2)
load F.mat
Q1L=floor(Q1*0.5);
Q1R=floor(Q1*0.5)+1;
Q2L=floor(Q2*0.5);
Q2R=floor(Q2*0.5)+1;

% 得到真实数据点
[act_dot_1L,temp] = get_CenterDot(Q1L,1,m,n,0);
[act_dot_1R,temp]= get_CenterDot(Q1R,1,m,n,0);
[act_dot_2L,temp] = get_CenterDot(Q2L,0,m,n,0);
[act_dot_2R,temp] = get_CenterDot(Q2R,0,m,n,0);

d_act = zeros(n, m);
iteration=0;
for i=1:length(act_dot_1L)
    d_act = d_act + alphal_1L(act_dot_1L(i,2),act_dot_1L(i,1),act_dot_1L(i,3),m,n,delta_S,F1L);
    iteration=iteration+1;
end
for i=1:length(act_dot_1R)
    d_act = d_act + alphal_1R(act_dot_1R(i,2),act_dot_1R(i,1),act_dot_1R(i,3),m,n,delta_S,F1R);
    iteration=iteration+1;
end
for i=1:length(act_dot_2L)
    d_act = d_act + alphal_2L(act_dot_2L(i,2),act_dot_2L(i,1),act_dot_2L(i,3),m,n,delta_S,F2L);
    iteration=iteration+1;
end
for i=1:length(act_dot_2R)
    d_act = d_act + alphal_2R(act_dot_2R(i,2),act_dot_2R(i,1),act_dot_2R(i,3),m,n,delta_S,F2R);
    iteration=iteration+1;
end
end