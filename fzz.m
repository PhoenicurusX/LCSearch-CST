function [zzTE,zzTM] = fzz(er,theta)
zzTE= cos(theta)/sqrt(er - sin(theta)^2);
zzTM= sqrt(er - sin(theta)^2)/(cos(theta)*er);
end

