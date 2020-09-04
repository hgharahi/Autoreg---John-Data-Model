function Y = Equilibrium(D, P, ATP, Params)

T_total = P/D;

D0 = Params(1);

C_pass = Params(2);
C_pass_p = Params(3);

T_pass = C_pass * exp(C_pass_p*(D/D0 - 1));

C_act = Params(4);
C_act_p = Params(5);
C_act_s = Params(6);

T_max = C_act * exp( -((D/D0-C_act_p)/C_act_s).^2 );

C_myo = Params(7);
S_myo = C_myo*T_total;

C_meta = Params(8);
S_meta = C_meta*ATP;

S0 = Params(9);

S = S_myo - S_meta + S0;

A = 1/(1 + exp(-S));

T_total = T_pass + A * T_max;

Y = P - T_total*D/2;

