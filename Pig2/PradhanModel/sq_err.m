function [e] = sq_err(F,INE)

% parameters
T0 = 28.151;
J0 = 283.388e3;
S0 = 0.0387;
SA = 0.955;
Vc = 0.04;
H  = 0.40;
C0 = 476;
g0 = 0.63e-3;
Kb = 0.3507e-3;
Kf = 0.9797e-3;
Km = 22.767;
M0 = 33.535;

% model equations
M  = Km*INE + M0;
P  = 0.0000*M + 105.41; 
SV = SA - M/(F*C0*H);
T = ((Vc*H*J0*S0)/(F*(SA-SV)))*exp(-SA/S0)*(exp((SA - SV)/S0) - 1) + T0;
gb = Kb*(T-T0);
gf = Kf*INE;
G  = gb + gf + g0;
F1 = G*P;

e = (F-F1)^2;


