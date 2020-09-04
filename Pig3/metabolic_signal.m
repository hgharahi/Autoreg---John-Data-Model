clear;clc;close all;
addpath('../SRC');
load AllResults.mat
load DoBResults.mat
load HDResults.mat
%% Metabolic signal 
Test1 = Control{1,1};
SubendoFlow = Control{1,1}.Results{1,7}.Q13;
SubendoVol = Control{1,1}.Results{1,7}.V13;
t = Control{1,1}.Results{1,7}.t;


Qendo = SubendoFlow(t>Test1.t_off(4)-2*Test1.Testset(4).T & t<=Test1.t_off(4));
Qendo = mean(Qendo);

Vendo = SubendoVol(t>Test1.t_off(4)-2*Test1.Testset(4).T & t<=Test1.t_off(4));
Vendo = mean(Vendo);

MVO2 = 71/60*1e-3*85/3; %285 is the estimated weight of the LAD perfusion region; 1/3 is roughly for subendo layer
c0 = 0.028;
Ht = 0.37;
Hd = 0.4;
R0 = 1.4*1e-9;
R1 = 0.891;
nH = 2.7;
P50 = 26;
PaO2 = 189;
PvO2 = 20;
C0 = 0.028;
kd = 1*1e-16;
% L0 = 0.01;

Vblood = Vendo; % comes from the 0D compartment 
Di = 0.01;
L0 = 1;%Vblood/(pi*Di^2/4);
L = L0;
xmp = 0.5*L;
xend = 1*L;
x0 = 0;

Q = Qendo;
Vtissue = 4*Vblood;

S0 = PaO2^nH/(P50^nH + PaO2^nH);
Send = PvO2^nH/(P50^nH + PaO2^nH);

MVO2 = (Qendo*c0*Ht)*(S0 - Send);
q = MVO2;

S = @(x) S0 - q*x/(Q*c0*Ht);

alpha = Ht*R0/(4*kd) * (sqrt(4*Vblood/(pi*L)) * (1+R1*S(x0)) - (1-Hd)*R1*q/(pi*c0*Hd*kd) );

beta = sqrt(4*Vblood/(pi*L))*(Ht*R0*R1*q)/(4*Q*c0*Hd*kd);

gamma = kd/((1-Hd)*Q)*pi*sqrt(4*Vblood/(pi*L));

C = @(x) alpha + beta*x + exp(gamma*(x0-x)).*(C0 - alpha - beta*x);

integrand = @(x) C(x);

Cmet1 = integral(integrand, xmp , xend)

