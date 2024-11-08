close all
clear
clc
% 微带线特性阻抗,这个是正确的，原来那个程序里面的微带线计算有误！LC应该是正确的
Z_TL1=260;
Z_TL2=3;
Z_TL3=5;

% 微带线电长度
ELE_L_TL1=90;
ELE_L_TL2=60;
ELE_L_TL3=60;
% 使用1GHZ的微带线
f=9.89e9;
Z0=377;


%求解频率范围，单位GHz
f_start=2;
f_stop=18;
f_step=0.01;
%光速
c=299792458;
%求解范围
freq_solve=[f_start:f_step:f_stop]*1e9;
%计算物理长度，单位m
l_TL1=ELE_L_TL1/360*c/f;
l_TL2=ELE_L_TL2/360*c/f;
l_TL3=ELE_L_TL3/360*c/f;

%计算不同频率下的相移常数beta
beta=2*pi*freq_solve/c;
% %转换到lamda域
% theta=(beta*l);
syms theta1 theta2 theta3 L1 C1
% 构建ABCD矩阵
ABCD_TL1=[cos(theta1),1j*Z_TL1*sin(theta1);1j*sin(theta1)/Z_TL1 cos(theta1)];
ABCD_TL2=[1 0; (1 / (1j * w * L1) + 1j * w * C1) 1];
ABCD_TL3=[cos(theta3),1j*Z_TL3*sin(theta3);1j*sin(theta3)/Z_TL3 cos(theta3)];
% 构建ABCD矩阵级联
% ABCD=ABCD_TL1*ABCD_TL2*ABCD_TL3;
ABCD=ABCD_TL1;
A=ABCD(1,1);B=ABCD(1,2);C=ABCD(2,1);D=ABCD(2,2);
% ABCD矩阵转换为S参数
S11=(A+B/Z0-C*Z0-D)/(A+B/Z0+C*Z0+D);
% 带入计算
S11=subs(S11,{theta1 theta2 theta3},{beta*l_TL1 beta*l_TL2 beta*l_TL3});
S11=double(S11);
% 画图
plot([2:0.01:18],20*log10(abs(S11)));
grid on;
%%
% Parameters
% Parameters
clear all;
clc;
L = 2.0971e-9;          % Inductance in H (2.0971 nH)
C = 0.123568e-12;       % Capacitance in F (0.123568 pF)
Z0_TL = 260.154;        % Characteristic impedance of the transmission line in Ohms
f = 9.89e9;             % Frequency in Hz (9.89 GHz)
beta_d = pi / 2;        % Electrical length (phase) at 9.89 GHz, given as pi/2
Z0_port = 377;          % Port characteristic impedance in Ohms
j = 0;
omega = 2 * pi * f;
j = j+1;
% 1. ABCD matrix for parallel L and C
Z_LC = 1 / (1 / (1j * omega * L) + 1j * omega * C); % Equivalent impedance of L and C in parallel
A_LC = 1;
B_LC = 0;
C_LC = 1 / Z_LC;
D_LC = 1;
ABCD_LC = [A_LC, B_LC; C_LC, D_LC];

% 2. ABCD matrix for the transmission line with electrical length of pi/2
A_TL = cos(beta_d);
B_TL = 1j * Z0_TL * sin(beta_d);
C_TL = 1j * sin(beta_d) / Z0_TL;
D_TL = cos(beta_d);
ABCD_TL = [A_TL, B_TL; C_TL, D_TL];

% 3. Total ABCD matrix (cascaded network of parallel LC and transmission line)
ABCD_total = ABCD_LC * ABCD_TL;

% Extract ABCD matrix elements
A = ABCD_total(1, 1);
B = ABCD_total(1, 2);
C = ABCD_total(2, 1);
D = ABCD_total(2, 2);

% 4. Calculate S21 parameter
S21 = 2 / (A + B / Z0_port + C * Z0_port + D);

% Convert S21 to dB
S21_dB = 20 * log10(abs(S21));
% Calculate angular frequency
% for i = 2:0.01:18
%     omega = 2 * pi * f;
% j = j+1;
% % 1. ABCD matrix for parallel L and C
% Z_LC = 1 / (1 / (1j * omega * L) + 1j * omega * C); % Equivalent impedance of L and C in parallel
% A_LC = 1;
% B_LC = 0;
% C_LC = 1 / Z_LC;
% D_LC = 1;
% ABCD_LC = [A_LC, B_LC; C_LC, D_LC];
% 
% % 2. ABCD matrix for the transmission line with electrical length of pi/2
% A_TL = cos(beta_d);
% B_TL = 1j * Z0_TL * sin(beta_d);
% C_TL = 1j * sin(beta_d) / Z0_TL;
% D_TL = cos(beta_d);
% ABCD_TL = [A_TL, B_TL; C_TL, D_TL];
% 
% % 3. Total ABCD matrix (cascaded network of parallel LC and transmission line)
% ABCD_total = ABCD_LC * ABCD_TL;
% 
% % Extract ABCD matrix elements
% A = ABCD_total(1, 1);
% B = ABCD_total(1, 2);
% C = ABCD_total(2, 1);
% D = ABCD_total(2, 2);
% 
% % 4. Calculate S21 parameter
% S21(j) = 2 / (A + B / Z0_port + C * Z0_port + D);
% 
% % Convert S21 to dB
% S21_dB(j) = 20 * log10(abs(S21(j)));
% 
% end
% plot(S21_dB);
% Display results
disp('ABCD matrix of parallel LC circuit:');
disp(ABCD_LC);
disp('ABCD matrix of transmission line with pi/2 electrical length:');
disp(ABCD_TL);
disp('Total ABCD matrix of the circuit:');
disp(ABCD_total);
disp('S21 parameter of the circuit (linear):');
disp(S21);
disp('S21 parameter of the circuit (dB):');
disp(S21_dB);

%%
L = 2.0971e-9;               % Inductance in H (2.0971 nH)
C = 0.123568e-12;            % Capacitance in F (0.123568 pF)
Z0_TL = 260.154;             % Characteristic impedance of the transmission line in Ohms
f_target = 9.89e9;           % Target frequency in Hz (9.89 GHz)
Z0_port = 377;               % Port characteristic impedance in Ohms
c = 3e8;                     % Speed of light in m/s

% Calculate the physical length d based on pi/2 phase shift at 9.89 GHz
d = c / (4 * f_target);

% Effective dielectric constant (based on pi/2 phase shift at 9.89 GHz)
epsilon_eff = (c / (2 * f_target * d))^2;

% Frequency for calculation (can be changed to any desired frequency)
f = 9.89e9; % Frequency in Hz

% Calculate angular frequency
omega = 2 * pi * f;

% Calculate beta * d for the given frequency
beta_d = (2 * pi * f * d / c) * sqrt(2.1);

% 1. ABCD matrix for parallel L and C
Z_LC = 1 / (1 / (1j * omega * L) + 1j * omega * C); % Equivalent impedance of L and C in parallel
A_LC = 1;
B_LC = 0;
C_LC = 1 / Z_LC;
D_LC = 1;
ABCD_LC = [A_LC, B_LC; C_LC, D_LC];

% 2. ABCD matrix for the transmission line with calculated beta * d
A_TL = cos(beta_d);
B_TL = 1j * Z0_TL * sin(beta_d);
C_TL = 1j * sin(beta_d) / Z0_TL;
D_TL = cos(beta_d);
ABCD_TL = [A_TL, B_TL; C_TL, D_TL];

% 3. Total ABCD matrix (cascaded network of parallel LC and transmission line)
ABCD_total = ABCD_LC * ABCD_TL;

% Extract ABCD matrix elements
A = ABCD_total(1, 1);
B = ABCD_total(1, 2);
C = ABCD_total(2, 1);
D = ABCD_total(2, 2);

% 4. Calculate S21 parameter
S21 = 2 / (A + B / Z0_port + C * Z0_port + D);

% Convert S21 to dB
S21_dB = 20 * log10(abs(S21));

% Display results
disp('ABCD matrix of parallel LC circuit:');
disp(ABCD_LC);
disp('ABCD matrix of transmission line with variable beta_d:');
disp(ABCD_TL);
disp('Total ABCD matrix of the circuit:');
disp(ABCD_total);
disp('S21 parameter of the circuit (linear):');
disp(S21);
disp('S21 parameter of the circuit (dB):');
disp(S21_dB);
%%
% Parameters
L = 2.0971e-9;          % Inductance in H (2.0971 nH)
C = 0.123568e-12;       % Capacitance in F (0.123568 pF)
Z0_TL = 260.154;        % Characteristic impedance of the transmission line in Ohms
Z0_port = 377;          % Port characteristic impedance in Ohms
epsilon_r = 2.1;        % Relative dielectric constant
c = 3e8;                % Speed of light in m/s

% Frequency for calculation
f = 7.8e9;             % Frequency in Hz

% Calculate angular frequency and beta*d
omega = 2 * pi * f;
beta_d = (pi/2)*f*(10e8)/9.89;

% ABCD matrix for parallel L and C
Z_LC = 1 / (1 / (1j * omega * L) + 1j * omega * C); % Impedance of parallel LC
ABCD_LC = [1, 0; 1 / Z_LC, 1];

% ABCD matrix for transmission line
ABCD_TL = [cos(beta_d), 1j * Z0_TL * sin(beta_d); 1j * sin(beta_d) / Z0_TL, cos(beta_d)];

% Total ABCD matrix
ABCD_total = ABCD_LC * ABCD_TL;

% Calculate S21 parameter in dB
A = ABCD_total(1, 1);
B = ABCD_total(1, 2);
C = ABCD_total(2, 1);
D = ABCD_total(2, 2);
S21 = 2 / (A + B / Z0_port + C * Z0_port + D);
S21_dB = 20 * log10(abs(S21));

% Display result
disp('S21 parameter of the circuit (dB):');
disp(S21_dB);
