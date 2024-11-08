function [X]=initialization(pop,ub,lb,dim) % 初始化粒子
    pop_count = 1;
    while pop_count <= pop
        for j=1:dim
            temp(j) =(ub(j)-lb(j))*rand()+lb(j);%在限定的范围内生成粒子
        end 
        if (temp(1) - temp(2) - 2 * temp(3) >0)
%                 X(pop_count,j)=(ub(j)-lb(j))*rand()+lb(j);%在限定的范围内生成粒子
                for k = 1:dim
                    X(pop_count,k) = temp(k);
                end
                pop_count = pop_count + 1;
        end
    end
end