function ER = ArcieroModelHR_obj(x, Control, Anemia, Dob, layer)


%%%%%%%%%%%%%% Preparation
CPP = [40, 60, 80, 100, 120];

Control = ATPconcentration(Control, x(11));

Anemia = ATPconcentration(Anemia, x(11));

Dob = ATPconcentration(Dob, x(11));

eval(['ATP_Control = Control.Tv_',layer,';']);
eval(['ATP_Anemia = Anemia.Tv_',layer,';']);
eval(['ATP_Dob = Dob.Tv_',layer,';']);
eval(['ATP_Dob = Dob.Tv_',layer,';']);

%%%%%%%%%%%%%% Control
for j = 1:length(CPP)
HR(j) = 1/Control.Testset(j).T*60;
eval(['Pim(j) = CPP(j) - Control.Pim_',layer,'(j);']);
end
eval(['Dbar_mid_Control = Control.Dbar_',layer,'(1:5);']);

[D_est_Control, ~] = ArcieroModelHR(x, Pim, ATP_Control, HR);


%%%%%%%%%%%%%% Anemia
for j = 1:length(CPP)
HR(j) = 1/Anemia.Testset(j).T*60;
eval(['Pim(j) = CPP(j) - Anemia.Pim_',layer,'(j);']);
end
eval(['Dbar_mid_Anemia = Anemia.Dbar_',layer,'(1:5);']);

[D_est_Anemia, ~] = ArcieroModelHR(x, Pim, ATP_Anemia, HR);

%%%%%%%%%%%%%% Dob+Anemia
for j = 1:length(CPP)
HR(j) = 1/Dob.Testset(j).T*60;
eval(['Pim(j) = CPP(j) - Dob.Pim_',layer,'(j);']);
end
eval(['Dbar_mid_Dob = Dob.Dbar_',layer,'(1:5);']);

[D_est_Dob, ~] = ArcieroModelHR(x, Pim, ATP_Dob, HR);

%%%%%%%%%%%%%% Objective function
DbarExp = [Dbar_mid_Control    , Dbar_mid_Anemia   ,Dbar_mid_Dob];
DbarMod = [D_est_Control       , D_est_Anemia      ,D_est_Dob];

ER = norm(DbarExp - DbarMod);