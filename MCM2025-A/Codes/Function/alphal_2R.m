
function d2R=alphal_2R(ii,jj,tau,m,n,delta_S,F2R)
%需有1<=ii<=32,1<jj<=120
ii=33-ii;
[sigma,beta]=Archard_time();
pre_d2R=zeros(n+24,m+8);
d2R=zeros(n,m);
F2R=F2R.*delta_S;%单位：N
if jj>=1 && jj<=120
    if ii>=1 && ii<=32
        iii=ii+11;
        jjj=jj+3;
        for i=1:24% i as y
            for j=1:8% j as x
                pre_d2R(i+iii-12,j+jjj-4)=sigma.*F2R(i,j).*(tau^(beta));
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
        d2R(i,j)=pre_d2R(i+11,j+3);
    end
end
amp_nor=(sum(sum(pre_d2R)));
amp_now=(sum(sum(d2R)));
rou=amp_nor/amp_now;
d2R=d2R.*rou;
end