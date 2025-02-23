function [dot,dot_index] = get_CenterDot(Q,type1,m,n,t_repair)
dot=zeros(sum(Q),4); % 4-flag
dot_index=zeros(length(t_repair),1); % 时间分段点
dot(:,4)=1;
point_repair=1;
if type1 == 1 %上行
    point=0;
    for tau=1:length(Q)

        if tau==t_repair(point_repair)
            dot_index(point_repair)=tau;
            if point_repair<length(t_repair)
                point_repair=point_repair+1;
            end
        end

        for i=1:Q(tau)
            dot(i+point,1) = round(normrnd(m/2, m/8));
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
        
        if tau==t_repair(point_repair)
            dot_index(point_repair)=tau;
            if point_repair<length(t_repair)
                point_repair=point_repair+1;
            end
        end

        for i=1:Q(tau)
            dot(i+point,1) = round(normrnd(m/2, m/8));
            dot(i+point,1) = min(max(dot(i,1), 1), m);  %确保值在 [1, m] 范围内

            dot(i+point,2) = round(normrnd(n/2-6, n/8));
            dot(i+point,2) = min(max(dot(i,2), 1), n-12);   %确保值在 [1, n-12] 范围内

            dot(i+point,3) = tau;
        end
        point = point+Q(tau);
    end
end
end