function [DbarMod, DbarExp, Amod] = ArcieroModel_eval(x, Control, Anemia, Dob)

CPP = [40, 60, 80, 100, 120];

ATP = Control.Tv_mid;
Dbar_mid_control = Control.Dbar_mid(1:5);

[D_est_Control, A_Control] = ArcieroModel(x, CPP, ATP);

ATP = Anemia.Tv_mid;
Dbar_mid_anemia = Anemia.Dbar_mid(1:5);

[D_est_Anemia, A_Anemia] = ArcieroModel(x, CPP, ATP);


ATP = Dob.Tv_mid;
Dbar_mid_dob = Dob.Dbar_mid(1:5);

[D_est_Dob, A_Dob] = ArcieroModel(x, CPP, ATP);


DbarExp = [Dbar_mid_control    ; Dbar_mid_anemia   ;Dbar_mid_dob];
DbarMod = [D_est_Control       ; D_est_Anemia      ;D_est_Dob];

Amod = [A_Control;      A_Anemia;       A_Dob];
