function [gaoptions] = GA_setup()

gaoptions = optimoptions('ga','MaxGenerations',1000,'Display','iter');
    gaoptions = optimoptions(gaoptions,'UseParallel',false);
    gaoptions = optimoptions(gaoptions,'PopulationSize',1000);
    gaoptions = optimoptions(gaoptions,'FunctionTolerance',1e-6);
    gaoptions = optimoptions(gaoptions,'OutputFcn',@GA_DISP);