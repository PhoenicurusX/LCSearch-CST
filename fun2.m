function fitness=fun2(mws, Le1, Le2, wempty, count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0)
%     适应度函数
global count;
    [SP] = fun_invoke(mws, Le1, Le2, wempty, count);
    if count == 0
        count = count+1;
    end
    x = SP(:,1)';
    y = SP(:,2)';
    limy = min(y);
    sele_10 = 10;
    sele_5 = 40;
    sele_0 = 70;
    [y_selected,x_selected] = SelectPointavg(0,-5,sele_0,x,y);
    x_0_q = x_selected;
    y_0_q = y_selected;
%     plot(x_10,y_10,'bp')
%     hold on;
    [y_selected,x_selected] = SelectPointavg(-5,-10,sele_5,x,y);
    x_5_q = x_selected;
    y_5_q = y_selected;
    [y_selected,x_selected] = SelectPointavg(-10,limy,sele_10,x,y);
    x_10_q = x_selected;
    y_10_q = y_selected;
    XX = cat(2,x_0_q,x_5_q, x_10_q);
    YY = cat(2,y_0_q,y_5_q, y_10_q);
    [xx_sorted, indices] = sort(XX);
    yy_sorted = YY(indices);
    for i = 1:1:length(xx_sorted)
        [S21(i),S11(i)] = LCmedisingle(C1,C2,L1,L2,xx_sorted(i),a1,a2,er1,er2,ff0,theta,theta0);
%         [S21,S11] = LCmedisingle(targetL,targetC,Z1,xx_sorted);
    end
%     plot(x_10_q,y_10_q,'bp')
%     hold on;
%     plot(x_5_q,y_5_q,'gp');
%     hold on;
%     plot(x_0_q,y_0_q,'yp')
%     hold on;
%     figure;
%     plot(x,y,'rp',XX,YY,'b*')
%     hold on;
%     plot(xx_sorted, S21,'y-');
    fitness = sum(abs(yy_sorted-S21))/length(S21);  % 计算方差，这个地方就是唯一的适应度函数
end