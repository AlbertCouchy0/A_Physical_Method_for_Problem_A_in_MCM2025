
function dot = produce_dot(Q,type1,m,n)
dot=zeros(sum(Q),3);
if type1 == 1 %上行
    point=0;
    for tau=1:length(Q)
        for i=1:Q(tau)
            dot(i+point,1) = round(normrnd(m/3*2, m/8));
            dot(i+point,1) = min(max(dot(i,1), 1), m);  %确保值在 [1, m] 范围内

            dot(i+point,2) = round(normrnd(n/2-6, n/8));
            dot(i+point,2) = min(max(dot(i,2), 1), n-12);   %确保值在 [1, n-12] 范围内

            dot(i+point,3) = tau;
        end
        point = point+Q(tau);
    end
else %下行
    point=0;
    for tau=1:length(Q)
        for i=1:Q(tau)
            dot(i+point,1) = round(normrnd(m/3, m/8));
            dot(i+point,1) = min(max(dot(i,1), 1), m);  %确保值在 [1, m] 范围内

            dot(i+point,2) = round(normrnd(n/2-6, n/8));
            dot(i+point,2) = min(max(dot(i,2), 1), n-12);   %确保值在 [1, n-12] 范围内

            dot(i+point,3) = tau;  
        end
        point = point+Q(tau);
    end
end
end