function fitness=fun(mws, Le1, Le2, wempty, count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0)
%     适应度函数
global count;
    [SP] = fun_invoke(mws, Le1, Le2, wempty, count);
    if count == 0
        count = count+1;
    end
    x = SP(:,1)';
    y = SP(:,2)';
    sele_10 = 10;
    sele_5 = 40;
    sele_0 = 100;
    index1 = y(y<(-10));  % 数据
    x_10 = x(find(y<(-10)));
    y_10 = index1;
    if (length(x_10) > sele_10)
      [y_10_q, selectedIndices] = selectPoints(y_10, sele_10);
      x_10_q = x_10(selectedIndices);
    else
        x_10_q = x_10;
        y_10_q = y_10;
    end
%     plot(x_10,y_10,'bp')
%     hold on;
    index2 = y(y>(-10) & y<(-3));
    x_5 = x(find(y>(-10) & y<(-3)));
    y_5 = index2;
    if (length(x_5) > sele_5)
      [y_5_q, selectedIndices] = selectPoints(y_5, sele_5);
      x_5_q = x_5(selectedIndices);
    else
        x_5_q = x_5;
        y_5_q = y_5;
    end
    index3 = y(y>(-3));
    x_0 = x(find(y>(-3)));
    y_0 = index3;
    if (length(x_0) > sele_0)
        [y_0_q, selectedIndices] = selectPoints(y_0, sele_0);
      x_0_q = x_0(selectedIndices);
    else
        x_0_q = x_0;
        y_0_q = y_0;
    end
    XX = cat(2,x_0_q,x_5_q, x_10_q);
    YY = cat(2,y_0_q,y_5_q, y_10_q);
    [xx_sorted, indices] = sort(XX);
    yy_sorted = YY(indices);
    for i = 1:1:length(xx_sorted)
        [S21(i),S11(i)] = LCmedisingle(C1,C2,L1,L2,xx_sorted(i),a1,a2,er1,er2,ff0,theta,theta0);
%         [S21,S11] = LCmedisingle(targetL,targetC,Z1,xx_sorted);
    end
%     plot(x_10,y_10,'bp')
%     hold on;
%     plot(x_5_q,y_5_q,'gp');
%     hold on;
%     plot(x_0_q,y_0_q,'yp')
%     hold on;
%     figure;
%     plot(x,y,'rp',XX,YY,'b*')
%     hold on;
%     plot(xx_sorted, S21,'y-');
    fitness = sum(abs(yy_sorted-S21)) / length(yy_sorted);  % 计算方差，这个地方就是唯一的适应度函数
end

