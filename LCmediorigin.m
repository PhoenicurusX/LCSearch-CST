function [S21,S11] = LCmediorigin(C1,C2,L1,L2,f,a1,a2,er1,er2,ff0,theta,theta0)% 原型，输入的是c1c2z1z2归一化之后的值
% Z0 = 377;
% f1 = 8.5e9;
% f2 = 11.5e9;
% w1 = 2*pi*f1;
% w2 = 2*pi*f2;
% % w = f;
% Z0 = 377;
% C1 = C1/Z0;
% Z1 = Z1*Z0;
% Z2 = Z2*Z0;
% C2 = C2/Z0;
% % % 定义LC元件值
% f0 = 9.89;
% w = (f/f0 - f0/f)/0.3;
% % 计算角频率
% AFSS1 = [1 0; 1j*C1*w 1];
% AFSS2 = [1 0; 1j*C2*w 1];
% AD1 = [0 Z1*1j; 1j/Z1 0];
% AD2 = [0 Z2*1j; 1j/Z2 0];
% ABCD = AFSS1*AD1*AFSS2*AD1*AFSS1;
% coreFunc = 0.5*((ABCD(1,2)/(Z0*1j)) - (ABCD(2,1)*Z0/1j));
% S21 = 10*log10(1/(1+coreFunc^2));
% S11 = 10*log10(1 - 1/(1+coreFunc^2));
e0 = 8.854187817e-12;
u0 = 12.566370614359172953850573533118e-7;
Z0TE = sqrt(u0/e0)/cos(theta);
Z0TM = sqrt(u0/e0)*cos(theta);
d1 = ElecThick(a1, er1, theta, theta0, f, ff0);
d2 = ElecThick(a2, er2, theta, theta0, f, ff0);
[Z1,z1] = fzz(er1,theta);
[Z2,z2] = fzz(er2,theta);
Z0 = Z0TE;
C1 = C1/Z0;
Z1 = Z0TE*Z1;
Z2 = Z0TE*Z2;
C2 = C2/Z0;
% % 定义LC元件值
f0 = 9.89;
w = (f/f0 - f0/f)/0.3;
% 计算角频率
AFSS1 = [1 0; 1j*C1*w 1];
AFSS2 = [1 0; 1j*C2*w 1];
AD1 = [cos(d1) sin(d1)*Z1*1j; sin(d1)*1j/Z1 cos(d1)];
AD2 = [cos(d2) sin(d2)*Z2*1j; sin(d2)*1j/Z2 cos(d2)];
ABCD = AFSS1*AD1*AFSS2*AD1*AFSS1;
coreFunc = 0.5*((ABCD(1,2)/(Z0*1j)) - (ABCD(2,1)*Z0/1j));
S21 = 10*log10(1/(1+coreFunc^2));
S11 = 10*log10(1 - 1/(1+coreFunc^2));
end

