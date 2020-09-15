function test = ATPconcentration(test, So)


CPP = [40 ,60, 80, 100, 120, 140];

% this pigs does not have blood gas measurements, thus CPP140 is deleted
% from analysis for now!
CPP(end) = [];

[Q_endo, Q_mid, Q_epi] = CycleAvg(test,'Q1');

% [V_endo, V_mid, V_epi] = CycleAvg(test,'V1');


for j = 1:length(CPP)
    
    Vc = 0.04;
    J0 = 283.388e3;
    Ta = 28.151;
    C0 = 476;
    nH = 2.7;
    P50 = 26;
    
    q_endo = Q_endo(j)*60 / (test.LVweight * 1/3); % the last 1/3 is roughly for subendo layer
    q_mid = Q_mid(j)*60 / (test.LVweight * 1/3); % the last 1/3 is roughly for mid layer
    q_epi = Q_epi(j)*60 / (test.LVweight * 1/3); % the last 1/3 is roughly for subepi layer
    
    Ht = test.HCT(j)/100;


    PaO2 = test.ArtPO2(j);
    PvO2 = test.CvPO2(j);
    
    Sa = test.ArtO2Sat(j)/100;
    Sv = test.CvO2Sat(j)/100;
        
    test.MVO2_endo(j) = (q_endo)*(test.ArtO2Cnt(j) - test.CVO2Cnt(j))/3*10;
    test.MVO2_epi(j) = (q_mid)*(test.ArtO2Cnt(j) - test.CVO2Cnt(j))/3*10;
    test.MVO2_mid(j) = (q_mid)*(test.ArtO2Cnt(j) - test.CVO2Cnt(j))/3*10;
    
    test.Tv_endo(j) = Vc*Ht*J0*So/(q_endo*(Sa-Sv)) * exp(-Sa/So) * ( exp( (Sa-Sv)/So ) - 1) + Ta;
    test.Tv_mid(j)  = Vc*Ht*J0*So/(q_mid*(Sa-Sv)) * exp(-Sa/So) * ( exp( (Sa-Sv)/So ) - 1) + Ta;
    test.Tv_epi(j)  = Vc*Ht*J0*So/(q_epi*(Sa-Sv)) * exp(-Sa/So) * ( exp( (Sa-Sv)/So ) - 1) + Ta;
    
end

