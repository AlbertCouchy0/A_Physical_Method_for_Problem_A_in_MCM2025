% 计算理论磨损深度
function [d_theo]=get_d_theo_rep(m,n,T,delta_S,Q1,Q2,zone,a_factor,mode)
% 一定要注意，第三列的t代表的不是总时间，而是翻新时间
load F.mat
load PP.mat
d_theo = zeros(n,m,T);
delta_d_theo = zeros(n,m);
d_alt = zeros(n,m,T);
delta_d_alt = zeros(n,m);
% 初始化
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

%%%%%%%%%%%%%%%%%%正常运算（历史时间T确定，与t_repair无关）%%%%%%%%%%%%%%%%%%
for tau=1:T
    for i=1:n
        for j=1:m
            d_theo(:,:,1) = d_theo(:,:,1)  + alphal_1L(i,j,tau,m,n,delta_S,F1L).*U_1L(33-i,j,tau) + ...
                                            alphal_1R(i,j,tau,m,n,delta_S,F1R).*U_1R(33-i,j,tau) + ...
                                            alphal_2L(i,j,tau,m,n,delta_S,F2L).*U_2L(33-i,j,tau) + ...
                                            alphal_2R(i,j,tau,m,n,delta_S,F2R).*U_2R(33-i,j,tau) ;
        end
    end
end
for k=1:T-1
    d_theo(:,:,k+1)=d_theo(:,:,k);
end

%%%%%%%%%%%%%%%%%%需要根据mod采取不同的模拟策略,针对区域内再做运算%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%表示完全翻新%%%%%%%%%%%%
if mode==0
    zone_0=zone;
    %%%%%%%%%%%%%%%%%%另类运算（历史时间T确定）%%%%%%%%%%%%%%%%%%
    % 在区域内，则t_repair实质上扮演T的角色，也就是说！，我们实质上是在对T进行估算
    % 而且alphal_repair保证了只对区域内的磨损速率区别对待
    t_rep=1;
    % 第一次运算
    for i=1:n
        for j=1:m % 此处的i，j是落脚中心点！
            d_alt(:,:,1) = d_alt(:,:,1) + alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F1L).*U_1L(33-i,j,t_rep) + ...
                alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F1R).*U_1R(33-i,j,t_rep) + ...
                alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F2L).*U_2L(33-i,j,t_rep) + ...
                alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F2R).*U_2R(33-i,j,t_rep) ;
        end
    end
    % 后续追加运算
    for t_rep=2:T
        for i=1:n
            for j=1:m
                delta_d_alt = delta_d_alt  + alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F1L).*U_1L(33-i,j,t_rep) + ...
                alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F1R).*U_1R(33-i,j,t_rep) + ...
                alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F2L).*U_2L(33-i,j,t_rep) + ...
                alphal_repair(zone_0,a_factor,i,j,t_rep,m,n,delta_S,F2R).*U_2R(33-i,j,t_rep) ;
            end
        end
        % 每更新一次t_rep，则更新d_theo矩阵分量
        d_alt(:,:,t_rep)=d_alt(:,:,t_rep-1)+delta_d_alt;
        delta_d_alt = zeros(n,m);
    end
    %%%%%%%%%%%%%%%%%%对特殊区域进行分析%%%%%%%%%%%%%%%%%%
    for i=1:n
        for j=1:m
            if  zone_0(i,j)==1
                % 在区域内
                d_theo(i,j,:)=d_alt(i,j,:);
            end
        end
    end

%%%%%%%%%%%%表示不完全翻新%%%%%%%%%%%%
elseif mode==1

else
    disp('mod_wrong');
end








end