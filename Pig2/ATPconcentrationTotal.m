function test = ATPconcentrationTotal(test)


CPP = [40 ,60, 80, 100, 120, 140];

% [Q_endo, Q_mid, Q_epi] = CycleAvg(test,'Q1');

% [Q_t] = CycleAvg2(test,'Q_ima');
% [Q_t1] = CycleAvg2(test,'Q_PA');
% [V_endo, V_mid, V_epi] = CycleAvg(test,'V1');

Q_total = test.Q_sim;

for j = 1:length(CPP)
    
    Vc = 0.04;
    J0 = 283.388e3;
    So = 0.0587;
    Ta = 28.151;
    C0 = 476;
    nH = 2.7;
    P50 = 26;
    
    q_total = Q_total(j) / test.LVweight; % the last 1/3 is roughly for subendo layer
    
    Ht = test.HCT(j)/100;


    PaO2 = test.ArtPO2(j);
    PvO2 = test.CvPO2(j);
    
    Sa = test.ArtO2Sat(j)/100;
    Sv = test.CvO2Sat(j)/100;
        
    test.MVO2_total(j) = (q_total)*(test.ArtO2Cnt(j) - test.CVO2Cnt(j))*10;
    
    test.Tv_total(j) = Vc*Ht*J0*So/(q_total*(Sa-Sv)) * exp(-Sa/So) * ( exp( (Sa-Sv)/So ) - 1) + Ta;
    
end

