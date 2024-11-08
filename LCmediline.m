function [S21_dB] = LCmediline(C1,C2,L1,L2,f,a1,a2,er1,er2,ff0,theta,theta0)% 输入的都是真实值
L = 2.0971e-9;          % Inductance in H (2.0971 nH)
C = 0.123568e-12;       % Capacitance in F (0.123568 pF)
Z0_TL = 260.154;        % Characteristic impedance of the transmission line in Ohms
Z0_port = 377;          % Port characteristic impedance in Ohms
epsilon_r = 2.1;        % Relative dielectric constant
c = 3e8;                % Speed of light in m/s

% Frequency for calculation
f = f*10e8;             % Frequency in Hz

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
end

