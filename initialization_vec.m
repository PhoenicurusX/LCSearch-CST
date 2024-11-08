function [X]=initialization_vec(pop,ub,lb,dim) % 初始化粒子
    for i = 1:pop
        for j=1:dim
            X(i,j) =(ub(j)-lb(j))*rand()+lb(j);%在限定的范围内生成粒子
        end 
    end
end