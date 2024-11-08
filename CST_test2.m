clc;
clear;
close all;
%添加路径
path=pwd;
filename='\test2.cst';
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
sCommand = '';
sCommand = [sCommand 'With Units' ];
sCommand = [sCommand 10 '.Geometry "mm"'];%10在这里是换行的作用
sCommand = [sCommand 10 '.Frequency "ghz"' ];
sCommand = [sCommand 10 '.Time "ns"'];
sCommand = [sCommand 10 'End With'] ;
invoke(mws, 'AddToHistory','define units', sCommand);
%%全局单位初始化结束

% 这都是在cst中方便建立好的参数，先手动建模
L1 = 8;
ring_t = 0.0005;
L2 = 5.35;
wem = 0.5;
m_t = 3.48;
Frq=[10,25];%工作频率，单位：GHz

%%工作频率设置
sCommand = '';
sCommand = [sCommand 'Solver.FrequencyRange '  num2str(Frq(1)) ',' num2str(Frq(2)) ];
invoke(mws, 'AddToHistory','define frequency range', sCommand);
%%工作频率设置结束
%删除命令：   Component.Delete "component1"
%  sCommand = '';
%  sCommand = [sCommand 'Component.Delete "component1"'];
%  invoke(mws, 'AddToHistory','delete component', sCommand);



%设置自定义材料参数  这一部分在历史树里面自己做会很方便
%

%%使Bounding Box显示,这段代码不用保存进历史树
plot = invoke(mws, 'Plot');
invoke(plot, 'DrawBox', 'True');
%%使Bounding Box显示结束

%%建立一个导体：
period = num2str(L1);
start_point = num2str(L1/2);
end_point = num2str(-L1/2);
start_point2 = num2str(L2/2);
end_point2 = num2str(-L2/2);
start_point3 = num2str((L2+2*wem)/2);
end_point3 = num2str(-(L2+2*wem)/2);
PEC_theta = num2str(-0.0005);
sCommand = '';
sCommand = [sCommand 'With Brick'];
sCommand = [sCommand 10 '.Reset'];
sCommand = [sCommand 10 '.Name ', '"solid1"'];
sCommand = [sCommand 10 '.Component ', '"component1"'];
sCommand = [sCommand 10 '.Material ', '"PEC"'];
sCommand = [sCommand 10 '.Xrange ', end_point,',', start_point];
sCommand = [sCommand 10 '.Yrange ', end_point,',', start_point];
sCommand = [sCommand 10 '.Zrange ', PEC_theta,',', '"0"'];
sCommand = [sCommand 10 '.Create'];
sCommand = [sCommand 10 'End With'];
invoke(mws, 'AddToHistory','define brick', sCommand);

sCommand = '';
sCommand = [sCommand 'With Brick'];
sCommand = [sCommand 10 '.Reset'];
sCommand = [sCommand 10 '.Name ', '"solid2"'];
sCommand = [sCommand 10 '.Component ', '"component1"'];
sCommand = [sCommand 10 '.Material ', '"PEC"'];
sCommand = [sCommand 10 '.Xrange ', end_point2,',', start_point2];
sCommand = [sCommand 10 '.Yrange ', end_point2,',', start_point2];
sCommand = [sCommand 10 '.Zrange ', PEC_theta,',', '"0"'];
sCommand = [sCommand 10 '.Create'];
sCommand = [sCommand 10 'End With'];
invoke(mws, 'AddToHistory','define brick', sCommand);

sCommand = '';
sCommand = [sCommand 'With Brick'];
sCommand = [sCommand 10 '.Reset'];
sCommand = [sCommand 10 '.Name ', '"solid3"'];
sCommand = [sCommand 10 '.Component ', '"component1"'];
sCommand = [sCommand 10 '.Material ', '"PEC"'];
sCommand = [sCommand 10 '.Xrange ', end_point3,',', start_point3];
sCommand = [sCommand 10 '.Yrange ', end_point3,',', start_point3];
sCommand = [sCommand 10 '.Zrange ', PEC_theta,',', '"0"'];
sCommand = [sCommand 10 '.Create'];
sCommand = [sCommand 10 'End With'];
invoke(mws, 'AddToHistory','define brick', sCommand);

sCommand = '';
sCommand = [sCommand 'Solid.Subtract "component1:solid1", "component1:solid3"'];
invoke(mws, 'AddToHistory','boolean add shapes', sCommand);

% 建立一层介质
e_theta = num2str((-0.0005-3.48));
sCommand = '';
sCommand = [sCommand 'With Brick'];
sCommand = [sCommand 10 '.Reset'];
sCommand = [sCommand 10 '.Name ', '"selfmat"'];
sCommand = [sCommand 10 '.Component ', '"component1"'];
sCommand = [sCommand 10 '.Material ', '"SelfMat"'];
sCommand = [sCommand 10 '.Xrange ', end_point,',', start_point];
sCommand = [sCommand 10 '.Yrange ', end_point,',', start_point];
sCommand = [sCommand 10 '.Zrange ', e_theta,',', '"-0.0005"'];
sCommand = [sCommand 10 '.Create'];
sCommand = [sCommand 10 'End With'];
invoke(mws, 'AddToHistory','define brick', sCommand);


%%设置边界条件
sCommand = '';
sCommand = [sCommand 'With Boundary'];
sCommand = [sCommand 10 '.Xmin ', '"unit cell"'];
sCommand = [sCommand 10 '.Xmax ', '"unit cell"'];
sCommand = [sCommand 10 '.Ymin ', '"unit cell"'];
sCommand = [sCommand 10 '.Ymax ', '"unit cell"'];
sCommand = [sCommand 10 '.Zmin ', '"expanded open"'];
sCommand = [sCommand 10 '.Zmax ', '"expanded open"'];
sCommand = [sCommand 10 '.Xsymmetry ', '"none"'];
sCommand = [sCommand 10 '.Ysymmetry ', '"none"'];
sCommand = [sCommand 10 '.Zsymmetry ', '"none"'];
sCommand = [sCommand 10 '.ApplyInAllDirections ', '"False"'];
sCommand = [sCommand 10 '.OpenAddSpaceFactor ', '"0.5"'];
sCommand = [sCommand 10 '.XPeriodicShift ', '"0.0"'];
sCommand = [sCommand 10 '.YPeriodicShift ', '"0.0"'];
sCommand = [sCommand 10 '.ZPeriodicShift ', '"0.0"'];
sCommand = [sCommand 10 '.PeriodicUseConstantAngles ', '"False"'];
sCommand = [sCommand 10 '.SetPeriodicBoundaryAngles ', '"0.0"',',','"0.0"'];
sCommand = [sCommand 10 '.SetPeriodicBoundaryAnglesDirection ', '"outward"'];
sCommand = [sCommand 10 '.UnitCellFitToBoundingBox ', '"True"'];
sCommand = [sCommand 10 '.UnitCellDs1 ', '"0.0"'];
sCommand = [sCommand 10 '.UnitCellDs2 ', '"0.0"'];
sCommand = [sCommand 10 '.UnitCellAngle ', '"90.0"'];
sCommand = [sCommand 10 'End With'];
invoke(mws, 'AddToHistory','define boundaries', sCommand);
% 端口设置
sCommand = '';
sCommand = [sCommand 'With FloquetPort'];
sCommand = [sCommand 10 '.Reset'];
sCommand = [sCommand 10 '.SetDialogTheta ', '"0"'];
sCommand = [sCommand 10 '.SetDialogPhi ', '"0"'];
sCommand = [sCommand 10 '.SetPolarizationIndependentOfScanAnglePhi ', '"0.0"',',','"False"'];
sCommand = [sCommand 10 '.SetSortCode ', '"+beta/pw"'];
sCommand = [sCommand 10 '.SetCustomizedListFlag ', '"False"'];
sCommand = [sCommand 10 '.Port ', '"Zmin"'];
sCommand = [sCommand 10 '.SetNumberOfModesConsidered ', '"2"'];
sCommand = [sCommand 10 '.SetDistanceToReferencePlane ', '"0.0"'];
sCommand = [sCommand 10 '.SetUseCircularPolarization ', '"False"'];
sCommand = [sCommand 10 '.Port ', '"Zmax"'];
sCommand = [sCommand 10 '.SetNumberOfModesConsidered ', '"2"'];
sCommand = [sCommand 10 '.SetDistanceToReferencePlane ', '"0.0"'];
sCommand = [sCommand 10 '.SetUseCircularPolarization ', '"False"'];
sCommand = [sCommand 10 'End With'];
invoke(mws, 'AddToHistory','define Floquet port boundaries', sCommand);
% 仿真开始
solver=invoke(mws,'FDSolver');
invoke(solver,'Start');
invoke(mws, 'Save');%保存

% 保存结果
SelectTreeItem=invoke(mws,'SelectTreeItem','1D Results\S-Parameters\SZmax(1),Zmax(1)');
ASCIIExport=invoke(mws,'ASCIIExport');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',strcat(['I:\MATLAB\Project\CST_LC\Test2\test2','.txt']));
invoke(ASCIIExport,'Execute');




