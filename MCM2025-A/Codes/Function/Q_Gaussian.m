% 随机生成 Q
function [Q,Q1,Q2]=Q_Gaussian(Q_min,Q_max,ratio,T)
rng(42);
Q_avg=(Q_max+Q_min)/2;
Q = zeros(T,1);
for i=1:T
    Q(i) = Q_avg*( 1 + 0.05*randn) ;
end
Q1=round(Q*(ratio/(ratio+1)));
Q2=round(Q*(1/(ratio+1)));
end