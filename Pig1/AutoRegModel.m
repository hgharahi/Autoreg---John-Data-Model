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


h = figure;
Rn = Control{SpecimenPairs(i,1)}.RAmid(4);
pl(1,1) = plot(CPP,(Rn./Control{SpecimenPairs(i,1)}.RAmid(1:5)).^(1/4),'o-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on

Control{SpecimenPairs(i,1)}.Dbar_mid(1:5) = (Rn./Control{SpecimenPairs(i,1)}.RAmid(1:5)).^(1/4);

pl(1,2) = plot(CPP,(Rn./Control{SpecimenPairs(i,1)}.RAendo(1:5)).^(1/4),'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
pl(1,3) = plot(CPP,(Rn./Control{SpecimenPairs(i,1)}.RAepi(1:5)).^(1/4),'o-.','linewidth',1.5,'Color',[0    0.4470    0.7410]);

pl(2,1) = plot(CPP,(Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4),'o-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);

Anemia{SpecimenPairs(i,2)}.Dbar_mid(1:5) = (Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4);

pl(2,2) = plot(CPP,(Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAendo(1:5)).^(1/4),'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
pl(2,3) = plot(CPP,(Anemia{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Anemia{SpecimenPairs(i,2)}.RAepi(1:5)).^(1/4),'o-.','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);

pl(3,1) = plot(CPP,(Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4),'o-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);

Dob{SpecimenPairs(i,2)}.Dbar_mid(1:5) = (Dob{SpecimenPairs(i,2)}.VisRatio(1:5).*Rn./Dob{SpecimenPairs(i,2)}.RAmid(1:5)).^(1/4);

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
%     D0    C_pass      C_pass_p    C_act   C_act_p   C_act_s   C_myo  C_meta     S0 
x0 = [0.6	100         13.431      10000     0.6	  5         0.01        0.01    0.5];    
xl = [0.1   0           0           5000       0         0.5       0.0       0       -1  ];
xu = [1.8   500         20.0        20000     1.8       10       .05      0.05      1];


objfun = @(x) ArcieroModel_obj(x, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)});

options = optimset('MaxFunEvals',160000,'MaxIter',160000,'TolX',1e-16,'TolFun',1e-16,'TolX',1e-16,'Display','iter');
% x = fmincon(objfun, x0, [], [], [], [], xl,xu,[],options);

nvar = 9;
gaoptions = GA_setup();
x = ga(objfun, nvar, [], [], [], [], xl, xu, [], gaoptions);


clear pl;
y = x;

[DbarMod, DbarExp, A] = ArcieroModel_eval(y, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)})
% 
h = figure;
pl(1) = plot(CPP, DbarMod(1,:),'-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on
pl(2) = plot(CPP, DbarExp(1,:),'o','linewidth',1.5,'Color',[0    0.4470    0.7410]);

pl(3) = plot(CPP, DbarMod(2,:),'-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
pl(4) = plot(CPP, DbarExp(2,:),'o','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);

pl(5) = plot(CPP, DbarMod(3,:),'-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
pl(6) = plot(CPP, DbarExp(3,:),'o','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);

xlabel('CPP (mmHg)','Interpreter','Latex');
ylabel('$\bar{D}$ (-)','Interpreter','Latex');
box on;

% Passive
y(end) = -10000;

[DbarMod, DbarExp, A] = ArcieroModel_eval(y, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)})


pl(7) = plot(CPP, DbarMod(1,:),'--k','linewidth',1.5); 

% Fully active
y(end) = +10000;
[DbarMod, DbarExp, A] = ArcieroModel_eval(y, Control{SpecimenPairs(i,1)}, Anemia{SpecimenPairs(i,2)}, Dob{SpecimenPairs(i,2)})


pl(8) = plot(CPP, DbarMod(1,:),'-.k','linewidth',1.5); 

pl = pl';
L = legend(pl,{'Control Model','Control Exp.','Anemia Model','Anemia Exp.','Dob Model','Dob Exp.','Passive','Active'},'Location','best');

L.NumColumns = 2;

saveas(h,['Dbar_ParamEstNoHR',num2str(i),'.png']);

save('noHR.mat');



movefile('*.png',['./Figs']);