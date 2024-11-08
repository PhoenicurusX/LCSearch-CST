% 该程序文件是为了验证LCmedi，做到这个程度就可以了，高频本来适配性就更差
clear all;
clc;
close all;
J = 0;
% C1 = 0.123568;
% C2 = 0.244511;
C1 = 1.23568e-13;
C2 =  2.24854e-13;
% C1 = 1.59628;
% C2 = 3.03942;
L1 =  20.971e-10;
L2 =  11.5245e-10;
Z1 = 0.600685;
Z2 = 191.6072;
f1 = 2;
f2 = 18;
ff0 = 9.8869;
er1 = 2.1;
er2 = 2.78298;
a1 = 0.005778;
a2 = 0.004889;
theta0 = 38 * pi/180;
theta = 0 * pi/180;
for i=f1:0.01:f2
    J=J+1;
  
%     [S122(J),S2(J)] = LCmediorigin(C1,C2,L1,L2,i,a1,a2,er1,er2,ff0,theta,theta0);
% [S122(J),S2(J)] = LCmediorigin(C1,C2,L1,L2,Z1,Z2,i);
    [S122(J),S11(J)] = LCmedimid(C1,C2,L1,L2,i,a1,a2,er1,er2,ff0,theta,theta0);
%     [S122(J),S2(J)] = LCmediFull(C1,C2,L1,L2,Z1,Z2,i);
% LCmedimid(C1,C2,L1,L2,9.89,a1,a2,er1,er2,ff0,theta,theta0)
end
J =0; 
% for i = f1:0.1:f2
%     J = J+1;
%     c = (i/ff0 - ff0 / i)/0.3;
%     [S122(J),S2(J)] = LCmedioriginTM(C1,C2,L1,L2,i,a1,a2,er1,er2,ff0,theta,theta0);
%     coreFunc = 0.35*(4*c^3 - 3*c);
%     S21(J) = 10*log10(1/(1+coreFunc^2));
% end
x = [f1:0.01:f2];
x2 = [f1:0.01:f2]';
% 1/(2*pi*sqrt(2.07336*10^-9*1.24982*10^-13))
% 1/(2*pi*sqrt(1.38224*10^-9*1.87473*10^-13))
% plot(x2,B);
% hold on;
% plot(x2,C);
% hold on;
% plot(x2,(B-C));
% grid on;
% figure;
% plot(x2,c1);
% hold on;
% plot(x2,c2);
% grid on;
figure;
plot(x2,S122);
hold on;
plot(x2,S11);
grid on;
% figure;
% plot(x2,kk);
% figure;
% plot(x2,dd);
% hold on;
% plot(x2,S21);
% S21 = S21';
grid on;
S122 = S122';
x = x';
