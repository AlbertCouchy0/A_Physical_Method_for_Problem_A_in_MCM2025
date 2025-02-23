
function d1R=alphal_1R(ii,jj,tau,m,n,delta_S,F1R)
%需有1<=ii<=32,1<jj<=120
ii=33-ii;
[sigma,beta]=Archard_time();
pre_d1R=zeros(n+24,m+8);
d1R=zeros(n,m);
F1R=F1R.*delta_S;%单位：N
if jj>=1 && jj<=120
    if ii>=1 && ii<=32
        iii=ii+11;
        jjj=jj+3;
        for i=1:24% i as y
            for j=1:8% j as x
                pre_d1R(i+iii-12,j+jjj-4)=sigma.*F1R(i,j).*(tau^(beta));
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
        d1R(i,j)=pre_d1R(i+11,j+3);
    end
end
amp_nor=(sum(sum(pre_d1R)));
amp_now=(sum(sum(d1R)));
rou=amp_nor/amp_now;
d1R=d1R.*rou;
end

