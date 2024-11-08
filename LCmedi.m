function [S21,S11] = LCmedi(C1,C2,L1,L2,f,a1,a2,er1,er2,ff0,theta,theta0)% 输入的都是真实值
w = pi*f*2e9;
e0 = 8.854187817e-12;
u0 = 12.566370614359172953850573533118e-7;
Z0TE = sqrt(u0/e0)/cos(theta);
Z0TM = sqrt(u0/e0)*cos(theta);
d1 = ElecThick(a1, er1, theta, theta0, f, ff0);
d2 = ElecThick(a2, er2, theta, theta0, f, ff0);
[Z1,z1] = fzz(er1,theta);
[Z2,z2] = fzz(er2,theta);
Z0 = Z0TE;
Z1 = Z0TE*Z1;
Z2 = Z0TE*Z2;
% 计算角频率
% ASPACE = [cos(theta) Z0*1j*sin(theta);1j*sin(theta)/Z0 cos(theta)];
ASPACE = [0 Z0*1j;1j/Z0 0];
AFSS1 = [1 0; (1j*C1*w)+(1/(1j*L1*w)) 1];
AFSS2 = [1 0; (1j*C2*w)+(1/(1j*L2*w)) 1];
AD1 = [cos(d1) sin(d1)*Z1*1j; sin(d1)*1j/Z1 cos(d1)];
AD2 = [cos(d2) sin(d2)*Z2*1j; sin(d2)*1j/Z2 cos(d2)];
ABCD = ASPACE* AFSS1*AD1*AFSS2*AD2*AFSS2*AD1*AFSS1*ASPACE;
% ABCD = AFSS1*AD1;
A = ABCD(1,1);
B = ABCD(1,2);
C = ABCD(2,1);
D = ABCD(2,2);
S21 = 20*log10(abs(2/(A+B/Z0+C*Z0+D)));
S11 = 20*log10(abs((A+B/Z0-C*Z0-D)/(A+B/Z0+C*Z0+D)));
% coreFunc = 0.5*((ABCD(1,2)/(Z0*1j)) - (ABCD(2,1)*Z0/1j));
% S21 = 10*log10(1/(1+coreFunc^2));
% S11 = 10*log10(1 - 1/(1+coreFunc^2));
end

