
%% ArtO2Cnt	CVO2Cnt	ArtPO2	CvPO2	ArtO2Sat CvO2Sat Hgb HCT											

BloodGasMeasurementReading;

% this pigs does not have blood gas measurements, thus CPP140 is deleted
% from analysis for now!
CPP(end) = [];
%% Metabolic signal

Control{SpecimenPairs(i,1)} = ATPconcentration(Control{SpecimenPairs(i,1)});

Anemia{SpecimenPairs(i,2)} = ATPconcentration(Anemia{SpecimenPairs(i,2)});

Dob{SpecimenPairs(i,2)} = ATPconcentration(Dob{SpecimenPairs(i,2)});

h = figure;
pl(1,1) = plot(CPP, Control{SpecimenPairs(i,1)}.Tv_mid,'o-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on
pl(1,2) = plot(CPP, Control{SpecimenPairs(i,1)}.Tv_endo,'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
pl(1,3) = plot(CPP, Control{SpecimenPairs(i,1)}.Tv_epi,'o-.','linewidth',1.5,'Color',[0    0.4470    0.7410]);

pl(2,1) = plot(CPP, Anemia{SpecimenPairs(i,2)}.Tv_mid,'o-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
pl(2,2) = plot(CPP, Anemia{SpecimenPairs(i,2)}.Tv_endo,'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
pl(2,3) = plot(CPP, Anemia{SpecimenPairs(i,2)}.Tv_epi,'o-.','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);

pl(3,1) = plot(CPP, Dob{SpecimenPairs(i,2)}.Tv_mid,'o-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
pl(3,2) = plot(CPP, Dob{SpecimenPairs(i,2)}.Tv_endo,'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
pl(3,3) = plot(CPP, Dob{SpecimenPairs(i,2)}.Tv_epi,'o-.','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);

plot([40 120],[28.151 28.151],'-k','linewidth',1.5);
% legend(Res,names,'Location','north');
xlabel('CPP (mmHg)');
ylabel('Venous Plasma ATP concentration (nM)');
pl = pl';
L = legend(pl(:)',{'C-Midwall','C-Subendo','C-Subepi','A-Midwall','A-Subendo','A-Subepi','D-Midwall','D-Subendo','D-Subepi'},'Location','best');
L.NumColumns = 3;
box on;
saveas(h,['ATP_',num2str(i),'.png']);