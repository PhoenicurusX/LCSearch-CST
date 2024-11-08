 %% 前期准备
clc;
clear all;
%添加路径
warning("off");
global count;
count = 0;
path=pwd;
filename='\test4.cst';
fullname = [path filename];
%CST文件初始化
cst = actxserver('CSTStudio.application');%首先载入CST应用控件
mws = invoke(cst, 'OpenFile',fullname);%打开CST文件,必须关闭当前cst文件才可以用
% mws = invoke(cst, 'NewMWS');%新建一个MWS项目
app = invoke(mws, 'GetApplicationName');%获取当前应用名称
ver = invoke(mws, 'GetApplicationVersion');%获取当前应用版本号
% invoke(mws, 'SaveAs', fullname, 'True');%True表示保存到目前为止的结果
invoke(mws, 'DeleteResults');%删除之前的结果。注：在有结果的情况下修改模型会出现弹窗提示是否删除结果，这样运行的程序会停止，需等待手动点击弹窗使之消失
%%CST文件初始化结束

%%全局单位初始化
units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'ghz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);
%%全局单位初始化结束
% 
solver = invoke(mws, 'Solver');
invoke(solver, 'FrequencyRange', "6", "13");
release(solver);

% 删除命令：
delet = invoke(mws,'Component');
invoke(delet, 'Delete', "component1");
release(delet);

% 设置自己的材料
brick = invoke(mws, 'Material');
invoke(brick, 'Reset');
invoke(brick, 'Name', "SelfMat1");
invoke(brick, 'Folder', "");
invoke(brick, 'Rho', "0.0");
invoke(brick, 'ThermalType', "Normal");
invoke(brick, 'ThermalConductivity', "0");
invoke(brick, 'SpecificHeat', "0", "J/K/kg");
invoke(brick, 'DynamicViscosity', "0");
invoke(brick, 'Emissivity', "0");
invoke(brick, 'MetabolicRate', "0.0");
invoke(brick, 'VoxelConvection', "0.0");
invoke(brick, 'BloodFlow', "0");
invoke(brick, 'MechanicsType', "Unused");
invoke(brick, 'IntrinsicCarrierDensity', "0");
invoke(brick, 'FrqType', "all");
invoke(brick, 'Type', "Normal");
invoke(brick, 'MaterialUnit', "Frequency", "GHz");
invoke(brick, 'MaterialUnit', "Geometry", "mm");
invoke(brick, 'MaterialUnit', "Time", "ns");
invoke(brick, 'MaterialUnit', "Temperature", "Kelvin");
invoke(brick, 'Epsilon', "2.1");
invoke(brick, 'Mu', "1");
invoke(brick, 'Sigma', "0");
invoke(brick, 'TanD', "0.0");
invoke(brick, 'TanDFreq', "0.0");
invoke(brick, 'TanDGiven', "False");
invoke(brick, 'TanDModel', "ConstTanD");
invoke(brick, 'SetConstTanDStrategyEps', "AutomaticOrder");
invoke(brick, 'ConstTanDModelOrderEps', "3");
invoke(brick, 'DjordjevicSarkarUpperFreqEps', "0");
invoke(brick, 'SetElParametricConductivity', "False");
invoke(brick, 'ReferenceCoordSystem', "Global");
invoke(brick, 'CoordSystemType', "Cartesian");
invoke(brick, 'SigmaM', "0");
invoke(brick, 'TanDM', "0.0");
invoke(brick, 'TanDMFreq', "0.0");
invoke(brick, 'TanDMGiven', "False");
invoke(brick, 'TanDMModel', "ConstTanD");
invoke(brick, 'SetConstTanDStrategyMu', "AutomaticOrder");
invoke(brick, 'ConstTanDModelOrderMu', "3");
invoke(brick, 'DjordjevicSarkarUpperFreqMu', "0");
invoke(brick, 'SetMagParametricConductivity', "False");
invoke(brick, 'DispModelEps', "None");
invoke(brick, 'DispModelMu', "None");
invoke(brick, 'DispersiveFittingSchemeEps', "Nth Order");
invoke(brick, 'MaximalOrderNthModelFitEps', "10");
invoke(brick, 'ErrorLimitNthModelFitEps', "0.1");
invoke(brick, 'DispersiveFittingSchemeMu', "Nth Order");
invoke(brick, 'MaximalOrderNthModelFitMu', "10");
invoke(brick, 'ErrorLimitNthModelFitMu', "0.1");
invoke(brick, 'UseGeneralDispersionEps', "False");
invoke(brick, 'UseGeneralDispersionMu', "False");
invoke(brick, 'NLAnisotropy', "False");
invoke(brick, 'NLAStackingFactor', "1");
invoke(brick, 'NLADirectionX', "1");
invoke(brick, 'NLADirectionY', "0");
invoke(brick, 'NLADirectionZ', "0");
invoke(brick, 'Colour', "0", "1", "1");
invoke(brick, 'Wireframe', "False");
invoke(brick, 'Reflection', "False");
invoke(brick, 'Allowoutline', "True");
invoke(brick, 'Transparentoutline', "False");
invoke(brick, 'Transparency', "0");
invoke(brick, 'Create');
release(brick);

brick = invoke(mws, 'Material');
invoke(brick, 'Reset');
invoke(brick, 'Name', "SelfMat2");
invoke(brick, 'Folder', "");
invoke(brick, 'Rho', "0.0");
invoke(brick, 'ThermalType', "Normal");
invoke(brick, 'ThermalConductivity', "0");
invoke(brick, 'SpecificHeat', "0", "J/K/kg");
invoke(brick, 'DynamicViscosity', "0");
invoke(brick, 'Emissivity', "0");
invoke(brick, 'MetabolicRate', "0.0");
invoke(brick, 'VoxelConvection', "0.0");
invoke(brick, 'BloodFlow', "0");
invoke(brick, 'MechanicsType', "Unused");
invoke(brick, 'IntrinsicCarrierDensity', "0");
invoke(brick, 'FrqType', "all");
invoke(brick, 'Type', "Normal");
invoke(brick, 'MaterialUnit', "Frequency", "GHz");
invoke(brick, 'MaterialUnit', "Geometry", "mm");
invoke(brick, 'MaterialUnit', "Time", "ns");
invoke(brick, 'MaterialUnit', "Temperature", "Kelvin");
invoke(brick, 'Epsilon', "2.78");
invoke(brick, 'Mu', "1");
invoke(brick, 'Sigma', "0");
invoke(brick, 'TanD', "0.0");
invoke(brick, 'TanDFreq', "0.0");
invoke(brick, 'TanDGiven', "False");
invoke(brick, 'TanDModel', "ConstTanD");
invoke(brick, 'SetConstTanDStrategyEps', "AutomaticOrder");
invoke(brick, 'ConstTanDModelOrderEps', "3");
invoke(brick, 'DjordjevicSarkarUpperFreqEps', "0");
invoke(brick, 'SetElParametricConductivity', "False");
invoke(brick, 'ReferenceCoordSystem', "Global");
invoke(brick, 'CoordSystemType', "Cartesian");
invoke(brick, 'SigmaM', "0");
invoke(brick, 'TanDM', "0.0");
invoke(brick, 'TanDMFreq', "0.0");
invoke(brick, 'TanDMGiven', "False");
invoke(brick, 'TanDMModel', "ConstTanD");
invoke(brick, 'SetConstTanDStrategyMu', "AutomaticOrder");
invoke(brick, 'ConstTanDModelOrderMu', "3");
invoke(brick, 'DjordjevicSarkarUpperFreqMu', "0");
invoke(brick, 'SetMagParametricConductivity', "False");
invoke(brick, 'DispModelEps', "None");
invoke(brick, 'DispModelMu', "None");
invoke(brick, 'DispersiveFittingSchemeEps', "Nth Order");
invoke(brick, 'MaximalOrderNthModelFitEps', "10");
invoke(brick, 'ErrorLimitNthModelFitEps', "0.1");
invoke(brick, 'DispersiveFittingSchemeMu', "Nth Order");
invoke(brick, 'MaximalOrderNthModelFitMu', "10");
invoke(brick, 'ErrorLimitNthModelFitMu', "0.1");
invoke(brick, 'UseGeneralDispersionEps', "False");
invoke(brick, 'UseGeneralDispersionMu', "False");
invoke(brick, 'NLAnisotropy', "False");
invoke(brick, 'NLAStackingFactor', "1");
invoke(brick, 'NLADirectionX', "1");
invoke(brick, 'NLADirectionY', "0");
invoke(brick, 'NLADirectionZ', "0");
invoke(brick, 'Colour', "0", "1", "1");
invoke(brick, 'Wireframe', "False");
invoke(brick, 'Reflection', "False");
invoke(brick, 'Allowoutline', "True");
invoke(brick, 'Transparentoutline', "False");
invoke(brick, 'Transparency', "0");
invoke(brick, 'Create');
release(brick);

% 边界条件设置
brick = invoke(mws, 'Boundary');
invoke(brick, 'Xmin', "unit cell");
invoke(brick, 'Xmax', "unit cell");
invoke(brick, 'Ymin', "unit cell");
invoke(brick, 'Ymax', "unit cell");
invoke(brick, 'Zmin', "expanded open");
invoke(brick, 'Zmax', "expanded open");
invoke(brick, 'Xsymmetry', "none");
invoke(brick, 'Ysymmetry', "none");
invoke(brick, 'Zsymmetry', "none");
invoke(brick, 'ApplyInAllDirections', "False");
invoke(brick, 'OpenAddSpaceFactor', "0.5");
invoke(brick, 'XPeriodicShift', "0.0");
invoke(brick, 'YPeriodicShift', "0.0");
invoke(brick, 'ZPeriodicShift', "0.0");
invoke(brick, 'PeriodicUseConstantAngles', "False");
invoke(brick, 'SetPeriodicBoundaryAngles', "38", "0.0");
invoke(brick, 'SetPeriodicBoundaryAnglesDirection', "outward");
invoke(brick, 'UnitCellFitToBoundingBox', "True");
invoke(brick, 'UnitCellDs1', "0.0");
invoke(brick, 'UnitCellDs2', "0.0");
invoke(brick, 'UnitCellAngle', "90.0");
release(brick);
% mws = CSTinit();
%%
% L1 = 8.3;
% L2 = 5.35;
% wempty = 0.4;
% [S11] = fun_invoke(mws, L1, L2, wempty, count);
% count = count+1;
% % S22 = LCmedi(0.628,0.16,277.631,S11(:,1));
% % plot(S11(:,1),S11(:,2));
% % hold on;
% % plot(S11(:,1),S22);
% %% 定义目标函数
% 
% target_fun = var([S11(:,2)',S22']);  % 计算方差
%%


%pop——种群数量
%dim——问题维度
%ub——变量上界，[1,dim]矩阵
%lb——变量下界，[1,dim]矩阵
%fobj——适应度函数（指针）
%MaxIter——最大迭代次数
%Best_Pos——x的最佳值
%Best_Score——最优适应度L1是最外面，L2是环，L2-w是最里面小方块的边长

pop=30;  % 粒子数目
dim=3;
C1 = 1.23568e-13;
C2 =  2.4451e-13;
L1 =  2.0971e-9;
L2 =  1.0598e-9;
ff0 = 9.8869;
er1 = 2.1;
er2 = 2.78298;
a1 = 0.005778;
a2 = 0.004889;
theta0 = 38 * pi/180;
theta = 38 * pi/180;
ub=[8,7.9,0.8];  % L1 L2 WEMP
lb=[6.2,6,0.05];
vmax=[0.6,0.6,0.1];
vmin=[-0.6,-0.6,-0.1];
maxIter=120; % 最大迭代次数
% fobj=@(X)fun(X);
state = 2;%2是训练意外中断了
fobj = @(wms,Le1,Le2,wempty,count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0)fun2(mws, Le1, Le2, wempty, count,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0);
[Best_Pos,Best_fitness,IterCurve]=PSO(mws,count,pop,dim,ub,lb,fobj,vmax,vmin,maxIter,C1,C2,L1,L2,a1,a2,er1,er2,ff0,theta,theta0,state);
figure
plot(IterCurve,'r','linewidth',2);
grid on;
disp(['求解得到的x1，x2是:',num2str(Best_Pos(1)),' ',num2str(Best_Pos(2))]);
disp(['最优解对应的函数:',num2str(Best_fitness)]);

 

 



 

 

 
