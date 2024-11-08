function [Best_Pos,Best_fitness,IterCurve]=PSO(mws,count,pop,dim,ub,lb,fobj,vmax,vmin,maxIter,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0,state)
c1=1.2;  % 加速常数,这个值如果等于C2有点太大了我觉得，应该小一点
c2=2.0;  % 加速常数
weight = 1; % 惯性因子
if state == 2
    %% 读取上次的训练记录,从X到V到fitness
filename = 'output.xlsx';

% 指定读取范围，读取前30行的3列数据 (即A1:C30)
range = 'A31:G60';

% 使用readmatrix读取指定范围的数据
savedata = readmatrix(filename, 'Range', range);
X = savedata(:,1:3);
V = savedata(:,4:6); 
fitness =  savedata(:,7);
%% 训练意外中断，需要从第八代接着开始
filename = 'PSOresult.xlsx';

% 读取整个Excel文件的数据
data = readmatrix(filename);

% 获取最后一行第一列的值
last_row = data(end, 1);
best = data(end, 2:5);
else
        V=initialization_vec(pop,vmax,vmin,dim);
    X=initialization(pop,ub,lb,dim);   % 初始化粒子
    fitness=zeros(1,pop)';
     last_row = 0;
end
%% 迭代和计算过程
for i=1:pop
    fitness(i)=fobj(mws,X(i,1),X(i,2),X(i,3),count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0);
    pause(1);
end
pBest=X;
pBestFitness=fitness;
[~,index]=min(fitness);
if state == 2
    gBestFitness = best(4);
    gBest=best(1:3);
else
    gBestFitness=fitness(index);
gBest=X(index,:);
end
Xnew=X;
fitnessNew=fitness;
for t=last_row+1:1:maxIter
     %% 保存旧的粒子
    filename = 'output.xlsx';
    saveold = [X,V,fitness];
% 读取当前数据
if t > 1
    previousData = readmatrix(filename, 'Range', 'A31:E60'); % 读取上次存储的数据
else
    previousData = []; % 第一次存储时没有前一次数据
end

% 将上次数据写入第1-30行
if ~isempty(previousData)
    writematrix(previousData, filename, 'Sheet', 1, 'Range', 'A1');
end

% 将当前数据写入第31-60行
writematrix(saveold, filename, 'Sheet', 1, 'Range', 'A31');

    % 输出确认信息
    disp(['二维数组已保存到Excel文件: ', filename]);
    %%
    for i=1:pop
        r1=rand(1,dim);
        r2=rand(1,dim);  % 随机数，不知道干什么用的
        V(i,:)=weight * V(i,:)+c1.*r1.*(pBest(i,:)-X(i,:))+ c2.*r2.*(gBest-X(i,:));
        V(i,:)=BoundaryCheck(V(i,:),vmax,vmin,dim);
        Xnew(i,:)=X(i,:)+V(i,:);
        fitnessNew(i)=fobj(mws,Xnew(i,1),Xnew(i,2),Xnew(i,3),count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0);
        pause(3);
        if fitnessNew(i)<pBestFitness(i)
            pBest(i,:)=Xnew(i,:);
            pBestFitness(i)=fitnessNew(i);
        end
        if fitnessNew(i)<gBestFitness   % 这里表明了是寻找最小值
            gBestFitness=fitnessNew(i);
            gBest=Xnew(i,:);
        end
    end

    %%
    X=Xnew;
    fitness=fitnessNew;
    Best_Pos=gBest;
    Best_fitness=gBestFitness;
    IterCurve(t)=gBestFitness;  % 第t次迭代大的结果
    newRow = {t,Best_Pos(1),Best_Pos(2),Best_Pos(3),gBestFitness};
    disp(['最优适应度值：', num2str(gBestFitness)]);
    filePath = 'PSOresult.xlsx';
    T = readtable(filePath);
    Tnew = [T; newRow];
    % 将更新后的表格写回Excel文件
    writetable(Tnew, filePath);
end
end