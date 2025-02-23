function [U_1L,U_1R,U_2L,U_2R,f_1L,f_1R,f_2L,f_2R]=Estimate_Process(f_n,f_estimated,m,n)
U_1L=0;U_1R=0;U_2L=0;U_2R=0;
f_1L=zeros(n,m);f_1R=zeros(n,m);f_2L=zeros(n,m);f_2R=zeros(n,m);
for k=1:f_n
    if f_estimated(k,3)==1 %上行
        if f_estimated(k,4)==1 %左脚
            U_1L=U_1L+1;
            f_1L(33-f_estimated(k,2),f_estimated(k,1))=f_1L(33-f_estimated(k,2),f_estimated(k,1))+1;
        elseif f_estimated(k,4)==0  %右脚
            U_1R=U_1R+1;
            f_1R(33-f_estimated(k,2),f_estimated(k,1))=f_1R(33-f_estimated(k,2),f_estimated(k,1))+1;
        end
    elseif  f_estimated(k,3)==0%下行
        if f_estimated(k,4)==1 %左脚
            U_2L=U_2L+1;
            f_2L(33-f_estimated(k,2),f_estimated(k,1))=f_2L(33-f_estimated(k,2),f_estimated(k,1))+1;
        elseif f_estimated(k,4)==0  %右脚
            U_2R=U_2R+1;
            f_2R(33-f_estimated(k,2),f_estimated(k,1))=f_2R(33-f_estimated(k,2),f_estimated(k,1))+1;
        end
    end
end

end
