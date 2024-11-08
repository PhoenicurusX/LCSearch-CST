function betad = ElecThick(aa, er, theta, theta0, Freq, Freq0)
e0 = 8.854187817e-12;
u0 = 12.566370614359172953850573533118e-7;
beta = Freq0*pi*sqrt(e0*u0)*sqrt(er - sin(theta0)^2)*2e9;% 这里的所有都要以中心频率为准
% betad = beta*aa* sqrt(er - sin(theta)^2)/sqrt(er - sin(theta0)^2);
betad = beta*aa*(Freq/Freq0)* sqrt(er - sin(theta)^2)/sqrt(er - sin(theta0)^2);
end

