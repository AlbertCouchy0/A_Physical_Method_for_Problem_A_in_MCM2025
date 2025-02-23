% 计算理论磨损深度
function [d_theo]=d_calculate_new(m,n,t_max,t_min,delta_S,Q1,Q2)
% Q1,Q2要求维度是t_max
load F.mat
load P.mat
delta_t = t_max - t_min;
d_theo = zeros(n,m,delta_t);
delta_d_theo = zeros(n,m);
% 初始化
U_1L = zeros(n,m,t_max);
U_1R = zeros(n,m,t_max);
U_2L = zeros(n,m,t_max);
U_2R = zeros(n,m,t_max);
for i=1:t_max
    U_1L(:,:,i)=Q1(i)*(0.5)*f1L;
    U_1R(:,:,i)=Q1(i)*(0.5)*f1R;
    U_2L(:,:,i)=Q2(i)*(0.5)*f2L;
    U_2R(:,:,i)=Q2(i)*(0.5)*f2R;
end
% 第一次运算
for tau=1:t_min
    for i=1:n
        for j=1:m
            d_theo(:,:,1) = d_theo(:,:,1) + alphal_1L(i,j,tau,m,n,delta_S,F1L).*U_1L(33-i,j,tau) + ...
                alphal_1R(i,j,tau,m,n,delta_S,F1R).*U_1R(33-i,j,tau) + ...
                alphal_2L(i,j,tau,m,n,delta_S,F2L).*U_2L(33-i,j,tau) + ...
                alphal_2R(i,j,tau,m,n,delta_S,F2R).*U_2R(33-i,j,tau) ;
        end
    end
end
% 后面追加的运算
for tau=1:delta_t
    for i=1:n
        for j=1:m
            delta_d_theo = delta_d_theo + alphal_1L(i,j,tau,m,n,delta_S,F1L).*U_1L(33-i,j,tau) + ...
                alphal_1R(i,j,tau,m,n,delta_S,F1R).*U_1R(33-i,j,tau) + ...
                alphal_2L(i,j,tau,m,n,delta_S,F2L).*U_2L(33-i,j,tau) + ...
                alphal_2R(i,j,tau,m,n,delta_S,F2R).*U_2R(33-i,j,tau) ;
        end
    end
    % 每更新一次tau，则更新d_theo矩阵分量
    d_theo(:,:,tau+1)=d_theo(:,:,tau)+delta_d_theo;
    delta_d_theo = zeros(n,m);
end

end