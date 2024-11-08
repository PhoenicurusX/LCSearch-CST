function [S21,S11] = LCmediFull(C1,C2,L1,L2,Z1,Z2,f)% 输入的都是真实值
w = 2*pi*f*(10^9);
Z0 = 377;
% 这个程序不包含角度计算
ASPACE = [0 Z0*1j;1j/Z0 0];
AFSS1 = [1 0; (1j*C1*w)+1/(1j*w*L1) 1];
AFSS2 = [1 0; (1j*C2*w)+1/(1j*w*L2) 1];
AD1 = [0 Z1*1j; 1j/Z1 0];
AD2 = [0 Z2*1j; 1j/Z2 0];
ABCD = ASPACE* AFSS1*AD1*AFSS2*AD2*AFSS2*AD1*AFSS1*ASPACE;
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

