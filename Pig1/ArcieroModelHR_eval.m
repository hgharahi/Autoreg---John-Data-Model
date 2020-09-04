function [DbarMod, DbarExp, Amod] = ArcieroModelHR_eval(x, Control, Anemia, Dob)

CPP = [40, 60, 80, 100, 120];

ATP = Control.Tv_mid;
for j = 1:length(CPP)
HR(j) = 1/Control.Testset(j).T*60;
end
Dbar_mid_control = Control.Dbar_mid(1:5);

[D_est_Control, A_Control] = ArcieroModelHR(x, CPP, ATP, HR);


ATP = Anemia.Tv_mid;
for j = 1:length(CPP)
HR(j) = 1/Anemia.Testset(j).T*60;
end
Dbar_mid_anemia = Anemia.Dbar_mid(1:5);

[D_est_Anemia, A_Anemia] = ArcieroModelHR(x, CPP, ATP, HR);


ATP = Dob.Tv_mid;
for j = 1:length(CPP)
HR(j) = 1/Dob.Testset(j).T*60;
end
Dbar_mid_dob = Dob.Dbar_mid(1:5);

[D_est_Dob, A_Dob] = ArcieroModelHR(x, CPP, ATP, HR);


DbarExp = [Dbar_mid_control    ; Dbar_mid_anemia   ;Dbar_mid_dob];
DbarMod = [D_est_Control       ; D_est_Anemia      ;D_est_Dob];

Amod = [A_Control;      A_Anemia;       A_Dob];
