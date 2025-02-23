function d1L=alphal_1L(ii,jj,tau,m,n,delta_S,F1L)
%需有1<=ii<=32,1<jj<=120
ii=33-ii;
[sigma,beta]=Archard_time();
pre_d1L=zeros(n+24,m+8);
d1L=zeros(n,m);
F1L=F1L.*delta_S; % 单位：N
if jj>=1 && jj<=120
    if ii>=1 && ii<=32
        iii=ii+11;
        jjj=jj+3;
        for i=1:24% i as y
            for j=1:8% j as x
                pre_d1L(i+iii-12,j+jjj-4)=sigma.*F1L(i,j).*(tau^(beta));
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
        d1L(i,j)=pre_d1L(i+11,j+3);
    end
end
amp_nor=(sum(sum(pre_d1L)));
amp_now=(sum(sum(d1L)));
rou=amp_nor/amp_now;
d1L=d1L*rou;
end
