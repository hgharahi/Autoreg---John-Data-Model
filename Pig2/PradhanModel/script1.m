clear;
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

INE = 0.0:0.25:15;
opts = optimoptions('fsolve','Display','iter','MaxFunEvals',200);
F(1) = fsolve(@sq_err,[1],optimoptions('fsolve','Display','iter'),INE(1));
M(1)  = Km*INE(1) + M0;
P(1)  = 0.0463*M(1) + 96; 
SV(1) = SA - M(1)/(F(1)*C0*H);
T(1) = ((Vc*H*J0*S0)/(F(1)*(SA-SV(1))))*exp(-SA/S0)*(exp((SA - SV(1))/S0) - 1) + T0;
gb(1) = Kb*(T(1)-T0);
gf(1) = Kf*INE(1);
G(1)  = gb(1) + gf(1) + g0;
for i = 2:length(INE)
  F(i) = fsolve(@sq_err,F(i-1),optimoptions('fsolve','Display','iter'),INE(i));
  M(i)  = Km*INE(i) + M0;
  P(i)  = 0.000*M(i) + 105.41; 
  SV(i) = SA - M(i)/(F(i)*C0*H);
  T(i) = ((Vc*H*J0*S0)/(F(i)*(SA-SV(i))))*exp(-SA/S0)*(exp((SA - SV(i))/S0) - 1) + T0;
  gb(i) = Kb*(T(i)-T0);
  gf(i) = Kf*INE(i);
  G(i)  = gb(i) + gf(i) + g0;
end

figure(1); plot(SV,T); xlabel('S_V'); ylabel('T');
figure(3); plot(M,gf./(gb+gf+g0),M,gb./(gb+gf+g0)); axis([0 300 0 1]); grid
