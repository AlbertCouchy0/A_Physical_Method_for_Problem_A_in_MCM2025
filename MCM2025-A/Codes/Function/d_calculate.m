% 计算理论磨损深度
function [d_theo,U_1L]=d_calculate(m,n,T,delta_S,Q1,Q2)
% Q1,Q2要求维度是t_max
load F.mat
load P.mat
d_theo = zeros(n,m);
% 计算理论磨损次数分布（含小数）
U_1L = zeros(n,m,T);
U_1R = zeros(n,m,T);
U_2L = zeros(n,m,T);
U_2R = zeros(n,m,T);
for i=1:T
    U_1L(:,:,i)=Q1(i)*(0.5)*f1L;
    U_1R(:,:,i)=Q1(i)*(0.5)*f1R;
    U_2L(:,:,i)=Q2(i)*(0.5)*f2L;
    U_2R(:,:,i)=Q2(i)*(0.5)*f2R;
end
for i=1:n
    for j=1:m
        for tau=1:T
            d_theo = d_theo + alphal_1L(i,j,tau,m,n,delta_S,F1L).*U_1L(33-i,j,tau) + ...
                              alphal_1R(i,j,tau,m,n,delta_S,F1R).*U_1R(33-i,j,tau) + ...
                              alphal_2L(i,j,tau,m,n,delta_S,F2L).*U_2L(33-i,j,tau) + ...
                              alphal_2R(i,j,tau,m,n,delta_S,F2R).*U_2R(33-i,j,tau) ;
        end
    end
end
end