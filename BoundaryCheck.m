function [X]=BoundaryCheck(X,ub,lb,dim)
    for i=1:dim
        if X(i)>ub(i)
            X(i)=ub(i);
        end
        if X(i)<lb(i)
            X(i)=lb(i);
        end
    end
    if (X(1) - X(2))<0
        X(2)  = X(1) - 0.01;
    end
end