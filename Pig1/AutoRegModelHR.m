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


Control = (Control);
Dob = (Dob);
Anemia = (HD);

PigExp = [Control, Anemia, Dob];

%% Parameter initialization and estimation
names = {'Control','Anemia','Anemia+Dobutamine'};
SpecimenIDs = {'#10013','#10011','#10015','#10276'};
CPP = [40 ,60, 80, 100, 120, 140];

BloodATP;

Control{SpecimenPairs(i,1)} = Calculations(Control{SpecimenPairs(i,1)});

Anemia{SpecimenPairs(i,2)} = Calculations(Anemia{SpecimenPairs(i,2)});

Dob{SpecimenPairs(i,2)} = Calculations(Dob{SpecimenPairs(i,2)});

h = figure;
Rn = Control{SpecimenPairs(i,1)}.RAmid(4);
pl(1,1) = plot(CPP,(Rn./Control{SpecimenPairs(i,1)}.RAmid(1:5)).^(1/4),'o-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on

Control{SpecimenPairs(i,1)}.Dbar_mid(1:5) = (Rn./Control{SpecimenPairs(i,1)}.RAmid(1:5)).^(1/4);
Control{SpecimenPairs(i,1)}.Dbar_endo(1:5) = (Rn./Control{SpecimenPairs(i,1)}.RAendo(1:5)).^(1/4);
Control{SpecimenPairs(i,1)}.Dbar_epi(1:5) = (Rn./Control{SpecimenPairs(i,1)}.RAepi(1:5)).^(1/4);

pl(1,2) = plot(CPP,(Rn./Control{SpecimenPairs(i,1)}.RAendo(1:5)).^(1/4),'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
pl(1,3) = plot(CPP,(Rn./Control{SpecimenPairs(i,1)}.RAepi(1:5)).^(1/4),'o-.','linewidth',1.5,'Color',[0    0.4470    0.7410]);

pl(2,1) = plot(CPP,(Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4),'o-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);

Anemia{SpecimenPairs(i,2)}.Dbar_mid(1:5) = (Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4);
Anemia{SpecimenPairs(i,2)}.Dbar_endo(1:5) = (Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAendo(1:5)).^(1/4);
Anemia{SpecimenPairs(i,2)}.Dbar_epi(1:5) = (Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAepi(1:5)).^(1/4);

pl(2,2) = plot(CPP,(Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAendo(1:5)).^(1/4),'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
pl(2,3) = plot(CPP,(Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAepi(1:5)).^(1/4),'o-.','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);

pl(3,1) = plot(CPP,(Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4),'o-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);

Dob{SpecimenPairs(i,2)}.Dbar_mid(1:5) = (Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4);
Dob{SpecimenPairs(i,2)}.Dbar_endo(1:5) = (Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAendo(1:5)).^(1/4);
Dob{SpecimenPairs(i,2)}.Dbar_epi(1:5) = (Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAepi(1:5)).^(1/4);

pl(3,2) = plot(CPP,(Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAendo(1:5)).^(1/4),'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
pl(3,3) = plot(CPP,(Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAepi(1:5)).^(1/4),'o-.','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);

% set(gca,'xtick',[1 2 3],'XTickLabel',names);
pl = pl';
L = legend(pl(:),{'C-Midwall','C-Subendo','C-Subepi','A-Midwall','A-Subendo','A-Subepi','D-Midwall','D-Subendo','D-Subepi'},'Location','best');
L.NumColumns = 3;
xlabel('CPP (mmHg)','Interpreter','Latex');
ylabel('$\bar{D}$ (-)','Interpreter','Latex');
box on;

saveas(h,['Dbar',num2str(i),'.png']);

%% Autoregulation model


% for k = 1:1000
%     x0(2) = 0 + k*0.01;
%     D(k,:) = vasodilation(x0, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)});
% end
% figure;plot(D(:,1))
%     D0    C_pass      C_pass_p    C_act   C_act_p   C_act_s   C_myo  C_meta   C_HR         C0         S0 
x0 = [0.6	100         13.431      10000     0.6	  5         0.01        0.01     0.01    0.5          0.03 ];    
xl = [0.1   0           0           1000       0         0.5       0.0       0         0         0         0.01 ];
xu = [1.8   500         20.0        10000     1.8       10       .05      0.05     0.05       1             0.05];


objfun_mid = @(x) ArcieroModelHR_obj(x, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)}, 'mid');
objfun_endo = @(x) ArcieroModelHR_obj(x, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)}, 'endo');
objfun_epi = @(x) ArcieroModelHR_obj(x, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)}, 'epi');

% options = optimset('MaxFunEvals',160000,'MaxIter',160000,'TolX',1e-16,'TolFun',1e-16,'TolX',1e-16,'Display','iter');
% x = fmincon(objfun, x0, [], [], [], [], xl,xu,[],options);

nvar = 11;
gaoptions = GA_setup();

xmid = ga(objfun_mid, nvar, [], [], [], [], xl, xu, [], gaoptions);

xendo = ga(objfun_endo, nvar, [], [], [], [], xl, xu, [], gaoptions);

xepi = ga(objfun_epi, nvar, [], [], [], [], xl, xu, [], gaoptions);

%% Plots
PostPlots(Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)}, 'endo', i, xendo)

PostPlots(Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)}, 'mid', i, xmid)

PostPlots(Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)}, 'epi', i, xepi)




