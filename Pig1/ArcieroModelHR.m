function [D, A] = ArcieroModelHR(Params, CPP, ATP, HR) 


D0 = Params(1);

options = optimset('TolX', 1e-9);

for i = 1:length(CPP)
    
    F0 = @(x, T_total)EquilibriumHR(x, CPP(i), ATP(i), HR(i), Params);
    [D(i), fx, ~] = bisection(F0,D0*0.1,D0*1.3,0,options);
    
    T_total(i) = CPP(i)/D(i);    
    
    C_pass = Params(2);
    C_pass_p = Params(3);
    
    T_pass(i) = C_pass * exp(C_pass_p*(D(i)/D0 - 1));
    
    C_act = Params(4);
    C_act_p = Params(5);
    C_act_s = Params(6);
    
    T_max(i) = C_act * exp( -((D(i)/D0-C_act_p)/C_act_s).^2 );
    
    C_myo = Params(7);
    S_myo = C_myo*T_total(i);
    
    C_meta = Params(8);
    S_meta = C_meta*ATP(i);
    
    C_HR = Params(9);
    S_HR = C_HR*HR(i);
    
    S0 = Params(10);
    S = S_myo - S_meta - S_HR + S0;
    
    A(i) = 1/(1 + exp(-S));
    
end


