clear;clc;close all;
addpath('../SRC');
load AllResults.mat
load DoBResults.mat
load HDResults.mat

Control = (Control);
Dob = (Dob);
Anemia = (HD);

%% ArtO2Cnt	CVO2Cnt	ArtPO2	CvPO2	ArtO2Sat CvO2Sat Hgb HCT											

BloodGasMeasurementReading;


%% Metabolic signal

Control{SpecimenPairs(i,1)} = ATPconcentration(Control{SpecimenPairs(i,1)});

Anemia{SpecimenPairs(i,2)} = ATPconcentration(Anemia{SpecimenPairs(i,2)});

Dob{SpecimenPairs(i,2)} = ATPconcentration(Dob{SpecimenPairs(i,2)});

h = figure;
Res(1) = plot(CPP, Control{SpecimenPairs(i,1)}.Tv_mid,'o-','linewidth',1.5);
hold on;
Res(2) = plot(CPP, Anemia{SpecimenPairs(i,2)}.Tv_mid,'o-','linewidth',1.5);
Res(3) = plot(CPP, Dob{SpecimenPairs(i,2)}.Tv_mid,'o-','linewidth',1.5);
plot([40 140],[28.151 28.151],'-k','linewidth',1.5);
legend(Res,names,'Location','north');
xlabel('CPP (mmHg)');
ylabel('Venous Plasma ATP concentration (nM)');
box on;
saveas(h,['ATP_',num2str(i),'.png']);

h = figure;
box on
plot(CPP(2:end), Control{SpecimenPairs(i,1)}.Tv_mid(2:end),'o-','linewidth',1.5);
hold on;
plot(CPP(2:end), Anemia{SpecimenPairs(i,2)}.Tv_mid(2:end),'o-','linewidth',1.5);
plot(CPP(2:end), Dob{SpecimenPairs(i,2)}.Tv_mid(2:end),'o-','linewidth',1.5);
plot([60 140],[28.151 28.151],'-k','linewidth',1.5);
ylim([20 50]);
legend(Res,names,'Location','north');
saveas(h,['ATP60_',num2str(i),'.png']);


h = figure;
Res(1) = plot(CPP, Control{SpecimenPairs(i,1)}.MVO2_mid,'o-','linewidth',1.5);
hold on;
Res(2) = plot(CPP, Anemia{SpecimenPairs(i,2)}.MVO2_mid,'o-','linewidth',1.5);
Res(3) = plot(CPP, Dob{SpecimenPairs(i,2)}.MVO2_mid,'o-','linewidth',1.5);

legend(Res,names,'Location','best');
xlabel('CPP (mmHg)');
ylabel('MVO_2 (\mul O_2/min/g)');
box on;

saveas(h,['MVO2_',num2str(i),'.png']);


h = figure;
Res(1) = plot(CPP, Control{SpecimenPairs(i,1)}.CvO2Sat,'o-','linewidth',1.5);
hold on;
Res(2) = plot(CPP, Anemia{SpecimenPairs(i,2)}.CvO2Sat,'o-','linewidth',1.5);
Res(3) = plot(CPP, Dob{SpecimenPairs(i,2)}.CvO2Sat,'o-','linewidth',1.5);

legend(Res,names,'Location','best');
xlabel('CPP (mmHg)');
ylabel('S_V (-)');
box on;
saveas(h,['SV_',num2str(i),'.png']);


h = figure;
Res(1) = plot(CPP, Control{SpecimenPairs(i,1)}.CVO2Cnt,'o-','linewidth',1.5);
hold on;
Res(2) = plot(CPP, Anemia{SpecimenPairs(i,2)}.CVO2Cnt,'o-','linewidth',1.5);
Res(3) = plot(CPP, Dob{SpecimenPairs(i,2)}.CVO2Cnt,'o-','linewidth',1.5);

legend(Res,names,'Location','best');
xlabel('CPP (mmHg)');
ylabel('Venous Oxygen Content (nl O_2/dl)');
box on;
saveas(h,['O2cnt_',num2str(i),'.png']);

h = figure;
Res(1) = plot(CPP, Control{SpecimenPairs(i,1)}.HCT,'o-','linewidth',1.5);
hold on;
Res(2) = plot(CPP, Anemia{SpecimenPairs(i,2)}.HCT,'o-','linewidth',1.5);
Res(3) = plot(CPP, Dob{SpecimenPairs(i,2)}.HCT,'o-','linewidth',1.5);

legend(Res,names,'Location','best');
xlabel('CPP (mmHg)');
ylabel('H_t (-)');
box on;
saveas(h,['HT_',num2str(i),'.png']);

movefile('*.png',['./Figs']);