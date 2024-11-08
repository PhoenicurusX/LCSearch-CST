function [Best_Pos,Best_fitness,IterCurve]=PSO(mws,count,pop,dim,ub,lb,fobj,vmax,vmin,maxIter,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0,state)
c1=1.2;  % ���ٳ���,���ֵ�������C2�е�̫�����Ҿ��ã�Ӧ��Сһ��
c2=2.0;  % ���ٳ���
weight = 1; % ��������
if state == 2
    %% ��ȡ�ϴε�ѵ����¼,��X��V��fitness
filename = 'output.xlsx';

% ָ����ȡ��Χ����ȡǰ30�е�3������ (��A1:C30)
range = 'A31:G60';

% ʹ��readmatrix��ȡָ����Χ������
savedata = readmatrix(filename, 'Range', range);
X = savedata(:,1:3);
V = savedata(:,4:6); 
fitness =  savedata(:,7);
%% ѵ�������жϣ���Ҫ�ӵڰ˴����ſ�ʼ
filename = 'PSOresult.xlsx';

% ��ȡ����Excel�ļ�������
data = readmatrix(filename);

% ��ȡ���һ�е�һ�е�ֵ
last_row = data(end, 1);
best = data(end, 2:5);
else
        V=initialization_vec(pop,vmax,vmin,dim);
    X=initialization(pop,ub,lb,dim);   % ��ʼ������
    fitness=zeros(1,pop)';
     last_row = 0;
end
%% �����ͼ������
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
     %% ����ɵ�����
    filename = 'output.xlsx';
    saveold = [X,V,fitness];
% ��ȡ��ǰ����
if t > 1
    previousData = readmatrix(filename, 'Range', 'A31:E60'); % ��ȡ�ϴδ洢������
else
    previousData = []; % ��һ�δ洢ʱû��ǰһ������
end

% ���ϴ�����д���1-30��
if ~isempty(previousData)
    writematrix(previousData, filename, 'Sheet', 1, 'Range', 'A1');
end

% ����ǰ����д���31-60��
writematrix(saveold, filename, 'Sheet', 1, 'Range', 'A31');

    % ���ȷ����Ϣ
    disp(['��ά�����ѱ��浽Excel�ļ�: ', filename]);
    %%
    for i=1:pop
        r1=rand(1,dim);
        r2=rand(1,dim);  % ���������֪����ʲô�õ�
        V(i,:)=weight * V(i,:)+c1.*r1.*(pBest(i,:)-X(i,:))+ c2.*r2.*(gBest-X(i,:));
        V(i,:)=BoundaryCheck(V(i,:),vmax,vmin,dim);
        Xnew(i,:)=X(i,:)+V(i,:);
        fitnessNew(i)=fobj(mws,Xnew(i,1),Xnew(i,2),Xnew(i,3),count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0);
        pause(3);
        if fitnessNew(i)<pBestFitness(i)
            pBest(i,:)=Xnew(i,:);
            pBestFitness(i)=fitnessNew(i);
        end
        if fitnessNew(i)<gBestFitness   % �����������Ѱ����Сֵ
            gBestFitness=fitnessNew(i);
            gBest=Xnew(i,:);
        end
    end

    %%
    X=Xnew;
    fitness=fitnessNew;
    Best_Pos=gBest;
    Best_fitness=gBestFitness;
    IterCurve(t)=gBestFitness;  % ��t�ε�����Ľ��
    newRow = {t,Best_Pos(1),Best_Pos(2),Best_Pos(3),gBestFitness};
    disp(['������Ӧ��ֵ��', num2str(gBestFitness)]);
    filePath = 'PSOresult.xlsx';
    T = readtable(filePath);
    Tnew = [T; newRow];
    % �����º�ı��д��Excel�ļ�
    writetable(Tnew, filePath);
end
end