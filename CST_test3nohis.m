clc;
clear;
close all;
L1 = 8.3;
ring_t = 0.0005;
L2 = 5.35;
wem = 0.4;
m_t = 3.48;
% Frq=[10,25];%工作频率，单位：GHz
%添加路径
path=pwd;
filename='\test3.cst';
fullname = [path filename];
%%CST文件初始化
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

solver = invoke(mws, 'Solver');
invoke(solver, 'FrequencyRange', "8", "22");
release(solver);

% 删除命令：
delet = invoke(mws,'Component');
invoke(delet, 'Delete', "component1");
release(delet);

% 设置自己的材料
brick = invoke(mws, 'Material');
invoke(brick, 'Reset');
invoke(brick, 'Name', "SelfMat");
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
invoke(brick, 'Epsilon', "1.8413");
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

% 建立一个导体
period = num2str(L1);
start_point = num2str(L1/2);
end_point = num2str(-L1/2);
start_point2 = num2str(L2/2);
end_point2 = num2str(-L2/2);
start_point3 = num2str((L2+2*wem)/2);
end_point3 = num2str(-(L2+2*wem)/2);
PEC_theta = num2str(-0.0005);
brick = invoke(mws, 'Brick');
invoke(brick, 'Reset');
invoke(brick, 'Name', "solid1");
invoke(brick, 'Component', "component1");
invoke(brick, 'Material', "PEC");
invoke(brick, 'Xrange', end_point, start_point);
invoke(brick, 'Yrange', end_point, start_point);
invoke(brick, 'Zrange', PEC_theta, "0");
invoke(brick, 'Create');
release(brick);

brick = invoke(mws, 'Brick');
invoke(brick, 'Reset');
invoke(brick, 'Name', "solid2");
invoke(brick, 'Component', "component1");
invoke(brick, 'Material', "PEC");
invoke(brick, 'Xrange', end_point2, start_point2);
invoke(brick, 'Yrange', end_point2, start_point2);
invoke(brick, 'Zrange', PEC_theta, "0");
invoke(brick, 'Create');
release(brick);

brick = invoke(mws, 'Brick');
invoke(brick, 'Reset');
invoke(brick, 'Name', "solid3");
invoke(brick, 'Component', "component1");
invoke(brick, 'Material', "PEC");
invoke(brick, 'Xrange', end_point3, start_point3);
invoke(brick, 'Yrange', end_point3, start_point3);
invoke(brick, 'Zrange', PEC_theta, "0");
invoke(brick, 'Create');
release(brick);

subs = invoke(mws, 'Solid');  % 这个地方只要点开那一条按照.分解即可
invoke(subs, 'Subtract', "component1:solid1", "component1:solid3");
release(subs);


% 建立一层介质
e_theta = num2str((-0.0005-3.48));
brick = invoke(mws, 'Brick');
invoke(brick, 'Reset');
invoke(brick, 'Name', "selmat");
invoke(brick, 'Component', "component1");
invoke(brick, 'Material', "SelfMat");
invoke(brick, 'Xrange', end_point, start_point);
invoke(brick, 'Yrange', end_point, start_point);
invoke(brick, 'Zrange', e_theta, "-0.0005");
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
invoke(brick, 'SetPeriodicBoundaryAngles', "0.0", "0.0");
invoke(brick, 'SetPeriodicBoundaryAnglesDirection', "outward");
invoke(brick, 'UnitCellFitToBoundingBox', "True");
invoke(brick, 'UnitCellDs1', "0.0");
invoke(brick, 'UnitCellDs2', "0.0");
invoke(brick, 'UnitCellAngle', "90.0");
release(brick);
%端口设置
brick = invoke(mws, 'FloquetPort');
invoke(brick, 'Reset');
invoke(brick, 'SetDialogTheta', "0");
invoke(brick, 'SetDialogPhi', "0");
invoke(brick, 'SetPolarizationIndependentOfScanAnglePhi', "0.0", "False");
invoke(brick, 'SetSortCode', "+beta/pw");
invoke(brick, 'SetCustomizedListFlag', "False");
invoke(brick, 'Port', "Zmin");
invoke(brick, 'SetNumberOfModesConsidered', "1");
invoke(brick, 'SetDistanceToReferencePlane', "0.0");
invoke(brick, 'SetUseCircularPolarization', "False");
invoke(brick, 'Port', "Zmax");
invoke(brick, 'SetNumberOfModesConsidered', "1");
invoke(brick, 'SetDistanceToReferencePlane', "0.0");
invoke(brick, 'SetUseCircularPolarization', "False");
release(brick);
% 设置仿真数 计算加速
brick = invoke(mws, 'FDSolver');
invoke(brick, 'Reset');
invoke(brick, 'SetMethod', "Tetrahedral", "General purpose");
invoke(brick, 'OrderTet', "Second");
invoke(brick, 'OrderSrf', "First");
invoke(brick, 'Stimulation', "Zmax", "TE(0,0)");
invoke(brick, 'SetNumberOfResultDataSamples', "300");
invoke(brick, 'MaxCPUs', "1024");
invoke(brick, 'MaximumNumberOfCPUDevices', "6");
release(brick);

% 仿真开始
solver=invoke(mws,'FDSolver');
invoke(solver,'Start');
invoke(mws, 'Save');%保存

% 保存结果
SelectTreeItem=invoke(mws,'SelectTreeItem','1D Results\S-Parameters\SZmax(1),Zmax(1)');
ASCIIExport=invoke(mws,'ASCIIExport');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',strcat(['I:\MATLAB\Project\CST_LC\Test2\test3','.txt']));
invoke(ASCIIExport,'Execute');

