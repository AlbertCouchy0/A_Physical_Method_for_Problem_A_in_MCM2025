
function d=alphal_repair(zone_0,a_factor,ii,jj,tau,m,n,delta_S,F_way)
%需有1<=ii<=32,1<jj<=120
ii=33-ii;
[sigma,beta]=Archard_time();
pre_d=zeros(n+24,m+8);
d=zeros(n,m);
F_way=F_way.*delta_S;%单位：N
if jj>=1 && jj<=120
    if ii>=1 && ii<=32
        iii=ii+11;
        jjj=jj+3;
        for i=1:24% i as y
            for j=1:8% j as x
                pre_d(i+iii-12,j+jjj-4)=sigma.*F_way(i,j).*(tau^(beta));
            end
        end
    else
        disp('wrong');
    end
else
    disp('wrong');
end
for i=1:n
    for j=1:m
        d(i,j)=pre_d(i+11,j+3);
    end
end
amp_nor=(sum(sum(pre_d)));
amp_now=(sum(sum(d)));
rou=amp_nor/amp_now;
d=d.*rou;

% 维修处理（只针对区域内）
for i=1:n
    for j=1:m
        if  zone_0(i,j)==1
            d(i,j)=d(i,j)*a_factor;
        end
    end
end

end



