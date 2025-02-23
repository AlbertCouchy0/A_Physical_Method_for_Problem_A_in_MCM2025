
function d2L=alphal_2L(ii,jj,tau,m,n,delta_S,F2L)
%需有1<=ii<=32,1<jj<=120
ii=33-ii;
[sigma,beta]=Archard_time();
pre_d2L=zeros(n+24,m+8);
d2L=zeros(n,m);
F2L=F2L.*delta_S;%单位：N
if jj>=1 && jj<=120
    if ii>=1 && ii<=32
        iii=ii+11;
        jjj=jj+3;
        for i=1:24% i as y
            for j=1:8% j as x
                pre_d2L(i+iii-12,j+jjj-4)=sigma.*F2L(i,j).*(tau^(beta));
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
        d2L(i,j)=pre_d2L(i+11,j+3);
    end
end
amp_nor=(sum(sum(pre_d2L)));
amp_now=(sum(sum(d2L)));
rou=amp_nor/amp_now;
d2L=d2L.*rou;
end