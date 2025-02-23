function [U_1,U_2,f_1,f_2]=True_Process(f_n,dot_true,m,n)
U_1=0;U_2=0;
f_1=zeros(n,m);f_2=zeros(n,m);
for k=1:f_n
    if dot_true(k,3)==1 %上行
        U_1=U_1+1;
        f_1(33-dot_true(k,2),dot_true(k,1))=f_1(33-dot_true(k,2),dot_true(k,1))+1;
    elseif  dot_true(k,3)==0%下行
        U_2=U_2+1;
        f_2(33-dot_true(k,2),dot_true(k,1))=f_2(33-dot_true(k,2),dot_true(k,1))+1;
    end
end
end
