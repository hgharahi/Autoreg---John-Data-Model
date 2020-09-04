function [DbarMod, DbarExp] = vasodilation(x, Control, Anemia, Dob)

Cmet = x(1);
Cmyo = x(2);
S0 = x(3);
Dactive = x(4);

ATP = Control.Tv_mid;
Tension = Control.Tension(1:5);
Dbar_mid_control = Control.Dbar_mid(1:5);

S = -Cmet*ATP + Cmyo*Tension + S0;

D_est_Control = ( -Cmet*ATP + Cmyo*Tension + S0 ) * Dactive;


ATP = Anemia.Tv_mid;
Tension = Anemia.Tension(1:5);
Dbar_mid_anemia = Anemia.Dbar_mid(1:5);


S = -Cmet*ATP + Cmyo*Tension + S0;

D_est_Anemia = ( -Cmet*ATP + Cmyo*Tension + S0 ) * Dactive;


ATP = Dob.Tv_mid;
Tension = Dob.Tension(1:5);
Dbar_mid_dob = Dob.Dbar_mid(1:5);

S = -Cmet*ATP + Cmyo*Tension + S0;

D_est_Dob = ( -Cmet*ATP + Cmyo*Tension + S0 ) * Dactive;

DbarExp = [Dbar_mid_control    ; Dbar_mid_anemia   ;Dbar_mid_dob];
DbarMod = [D_est_Control       ; D_est_Anemia      ;D_est_Dob];



