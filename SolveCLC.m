
 
% 假设的初始猜测
x0 = [0.1, 0.1,1.5,0.6];
 
% 调用fsolve
[x, fval, exitflag, output] = fsolve(@myfun, x0);
 
% 输出结果
disp(x);