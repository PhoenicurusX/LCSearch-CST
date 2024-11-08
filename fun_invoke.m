function [S11] = fun_invoke(mws, L1, L2, wempty, flag)
%flag �����ж��Ƿ��һ�ν��룬����ǵ�һ�ξ���Ҫ����һЩ����

invoke(mws, 'DeleteResults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
%%CST�ļ���ʼ������
% ɾ�����
if flag>0
    delet = invoke(mws,'Component');
    invoke(delet, 'Delete', "component1");
    release(delet);
end
 pause(3)

% ����һ������
% period = num2str(L1);
start_point = num2str(L1/2);
end_point = num2str(-L1/2);
start_point2 = num2str(L2/2);
end_point2 = num2str(-L2/2);
start_point3 = num2str((L2-2*wempty)/2);
end_point3 = num2str(-(L2-2*wempty)/2);
PEC_theta = num2str(0);
medi_theta1 = num2str(-5.77852);
medi_theta2 = num2str(-2.37969-1.36928);
medi_theta3 = num2str(-2.37969-1.36928-1.36928);
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

subs = invoke(mws, 'Solid');  % ����ط�ֻҪ�㿪��һ������.�ֽ⼴��
invoke(subs, 'Subtract', "component1:solid1", "component1:solid2");
release(subs);


% ����һ�����,����д������


brick = invoke(mws, 'Brick');
invoke(brick, 'Reset');
invoke(brick, 'Name', "selmat1");
invoke(brick, 'Component', "component1");
invoke(brick, 'Material', "SelfMat1");
invoke(brick, 'Xrange', end_point, start_point);
invoke(brick, 'Yrange', end_point, start_point);
invoke(brick, 'Zrange', medi_theta1, "0");
invoke(brick, 'Create');
release(brick);

% brick = invoke(mws, 'Brick');
% invoke(brick, 'Reset');
% invoke(brick, 'Name', "selmat2");
% invoke(brick, 'Component', "component1");
% invoke(brick, 'Material', "SelfMat1");
% invoke(brick, 'Xrange', end_point, start_point);
% invoke(brick, 'Yrange', end_point, start_point);
% invoke(brick, 'Zrange', medi_theta2, medi_theta1);
% invoke(brick, 'Create');
% release(brick);
% 
% 
% brick = invoke(mws, 'Brick');
% invoke(brick, 'Reset');
% invoke(brick, 'Name', "selmat3");
% invoke(brick, 'Component', "component1");
% invoke(brick, 'Material', "SelfMat2");
% invoke(brick, 'Xrange', end_point, start_point);
% invoke(brick, 'Yrange', end_point, start_point);
% invoke(brick, 'Zrange', medi_theta3, medi_theta2);
% invoke(brick, 'Create');
% release(brick);
% % ƽ�����ã��������ó�����FSS�ſ��ԣ�
% brick = invoke(mws, 'Transform');
% invoke(brick, 'Reset');
% invoke(brick, 'Name', "component1:solid1");
% invoke(brick, 'Vector', "0", "0", medi_theta1);
% invoke(brick, 'UsePickedPoints', "False");
% invoke(brick, 'InvertPickedPoints', "False");
% invoke(brick, 'MultipleObjects', "True");
% invoke(brick, 'GroupObjects', "False");
% invoke(brick, 'Repetitions', "1");
% invoke(brick, 'MultipleSelection', "True");
% invoke(brick, 'Destination', "");
% invoke(brick, 'Material', "");
% invoke(brick, 'AutoDestination', "True");
% invoke(brick, 'Transform', "Shape", "Translate");
% release(brick);
% brick = invoke(mws, 'Transform');
% invoke(brick, 'Reset');
% invoke(brick, 'Name', "component1:solid3");
% invoke(brick, 'Vector', "0", "0", medi_theta1);
% invoke(brick, 'UsePickedPoints', "False");
% invoke(brick, 'InvertPickedPoints', "False");
% invoke(brick, 'MultipleObjects', "True");
% invoke(brick, 'GroupObjects', "False");
% invoke(brick, 'Repetitions', "1");
% invoke(brick, 'MultipleSelection', "True");
% invoke(brick, 'Destination', "");
% invoke(brick, 'Material', "");
% invoke(brick, 'AutoDestination', "True");
% invoke(brick, 'Transform', "Shape", "Translate");

%�˿�����
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
if flag == 0
% ���÷�����
brick = invoke(mws, 'FDSolver');
invoke(brick, 'Reset');
invoke(brick, 'SetMethod', "Tetrahedral", "General purpose");
invoke(brick, 'OrderTet', "Second");
invoke(brick, 'OrderSrf', "First");
invoke(brick, 'Stimulation', "Zmax", "TE(0,0)");
release(brick);
% ������٣�����֮ǰ�ٽ�����һ����
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
end
% ���濪ʼ
solver=invoke(mws,'FDSolver');
invoke(solver,'Start');
pause(2);
invoke(mws, 'Save');%����
pause(2);

% ������
SelectTreeItem=invoke(mws,'SelectTreeItem','1D Results\S-Parameters\SZmin(1),Zmax(1)');
ASCIIExport=invoke(mws,'ASCIIExport');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',strcat(['I:\MATLAB\Project\CST_LC\Test2\FSS2\test3','.txt']));
pause(1);
invoke(ASCIIExport,'Execute');

% release(plot);
% release(pick);
% release(monitor);
% release(port);
% release(brick);
% release(solver);
% release(mws);
% release(cst);
data = importdata('test3.txt');
S11 = data.data;
end

