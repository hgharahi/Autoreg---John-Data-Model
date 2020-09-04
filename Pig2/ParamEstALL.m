clear;clc;close all;

% Created Sep 16 by HG

addpath('../SRC');
load AllResults.mat
load DoBResults.mat
load HDResults.mat
%% Reading data / modeling / analysis based on Pzf data from John Tune:

SpecimenPairs = [2,2;
    3,1;
    4,3;
    5,4]; % First column Control, Second column Anemia and Anemia+Dobutamine case number.

i = 1;

Control = flip(Control);
Dob = flip(Dob);
Anemia = flip(HD);

PigExp = [Control, Anemia, Dob];
%% Parameter initialization and estimation
[bmin, bmax] = ParamBounds();

% parpool(25);

fun = @(x)obj_fun_all(x, PigExp);


%% GA
[gaoptions, nvar] = GA_setup();

startTime = tic;

gasol = ga(fun, nvar, [], [], [], [], bmin, bmax, [], gaoptions);

optTime = toc(startTime);

save GA_RES

%% Final Evaulation
Final_Eval;