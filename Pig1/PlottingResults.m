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

BloodGasMeasurementReading;

% this pigs does not have blood gas measurements, thus CPP140 is deleted
% from analysis for now!
CPP(end) = [];
% for i = 1:4
%     clf;
%     h = figure;
%     Res(1) = plot(CPP,Control{SpecimenPairs(i,1)}.RAmid(:),'o-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on
%     plot(CPP,Control{SpecimenPairs(i,1)}.RAendo(:),'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
%     plot(CPP,Control{SpecimenPairs(i,1)}.RAepi(:),'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
% 
%     Res(2) = plot(CPP,Anemia{SpecimenPairs(i,2)}.RAmid(:),'o-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
%     plot(CPP,Anemia{SpecimenPairs(i,2)}.RAendo(:),'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
%     plot(CPP,Anemia{SpecimenPairs(i,2)}.RAepi(:),'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
% 
%     Res(3) = plot(CPP,Dob{SpecimenPairs(i,2)}.RAmid(:),'o-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
%     plot(CPP,Dob{SpecimenPairs(i,2)}.RAendo(:),'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
%     plot(CPP,Dob{SpecimenPairs(i,2)}.RAepi(:),'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
%     
%     % set(gca,'xtick',[1 2 3],'XTickLabel',names);
%     legend(Res,names);
%     xlabel('CPP (mmHg)');
%     ylabel('Res (mmHg/(mL/s))');
%     box on;
%         saveas(h,['Res_pair_',num2str(i),'.png']);
% 
% end

% for i = 3:3
%     clf
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
% end

% 
% for i = 1:4
%     clf;
%     h = figure;
%     
%     [V_endo, V_mid, V_epi] = CycleAvg(Control{SpecimenPairs(i,1)},'V1');
%     V_endo = V_endo/Control{SpecimenPairs(i,1)}.gasol(3);
%     V_mid = V_mid/Control{SpecimenPairs(i,1)}.gasol(3);
%     V_epi = V_epi/Control{SpecimenPairs(i,1)}.gasol(3);    
%     Vn = V_mid(4);
%     Res(1) = plot(CPP,(V_mid/Vn).^(1/2),'o-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on
% %     plot(CPP,(V_endo/Vn).^(1/2),'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
% %     plot(CPP,(V_epi/Vn).^(1/2),'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
%     
%     [V_endo, V_mid, V_epi] = CycleAvg(Anemia{SpecimenPairs(i,2)},'V1');
%     V_endo = V_endo/Anemia{SpecimenPairs(i,2)}.gasol(3);
%     V_mid = V_mid/Anemia{SpecimenPairs(i,2)}.gasol(3);
%     V_epi = V_epi/Anemia{SpecimenPairs(i,2)}.gasol(3);
%     Res(2) = plot(CPP,(V_mid/Vn).^(1/2),'o-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
% %     plot(CPP,(V_endo/Vn).^(1/2),'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
% %     plot(CPP,(V_epi/Vn).^(1/2),'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
%     
%     [V_endo, V_mid, V_epi] = CycleAvg(Dob{SpecimenPairs(i,2)},'V1');
%     V_endo = V_endo/Dob{SpecimenPairs(i,2)}.gasol(3);
%     V_mid = V_mid/Dob{SpecimenPairs(i,2)}.gasol(3);
%     V_epi = V_epi/Dob{SpecimenPairs(i,2)}.gasol(3);    
%     Res(3) = plot(CPP,(V_mid/Vn).^(1/2),'o-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
% %     plot(CPP,(V_endo/Vn).^(1/2),'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
% %     plot(CPP,(V_epi/Vn).^(1/2),'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
%     
%     % set(gca,'xtick',[1 2 3],'XTickLabel',names);
%     legend(Res,names);
%     xlabel('CPP (mmHg)');
%     ylabel('V (mL)');
%     box on;
%     
%     saveas(h,['D_bar_V_',num2str(i),'.png']);
% end
% 
% 
% for i = 1:4
%     
%     clf;
%     h = figure;
%     
%     EnControl = 1./(Control{SpecimenPairs(i,1)}.BaselineParams.cf2*Control{SpecimenPairs(i,1)}.BaselineParams.C12);
%     Res(1) = plot(CPP,log10(Control{SpecimenPairs(i,1)}.Elastance_mid),'o-','linewidth',1.5,'Color',[0    0.4470    0.7410]); hold on
% %     plot(CPP,V_endo,'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
% %     plot(CPP,V_epi,'o--','linewidth',1.5,'Color',[0    0.4470    0.7410]);
% 
%     EnAnemia = 1./(Anemia{SpecimenPairs(i,2)}.BaselineParams.cf2*Anemia{SpecimenPairs(i,2)}.BaselineParams.C12);
%     Res(2) = plot(CPP,log10(Anemia{SpecimenPairs(i,2)}.Elastance_mid*EnControl/EnAnemia),'o-','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
% %     plot(CPP,V_endo,'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
% %     plot(CPP,V_epi,'o--','linewidth',1.5,'Color',[0.8500    0.3250    0.0980]);
% 
%     EnDob = 1./(Dob{SpecimenPairs(i,2)}.BaselineParams.cf2*Dob{SpecimenPairs(i,2)}.BaselineParams.C12);
%     Res(3) = plot(CPP,log10(Dob{SpecimenPairs(i,2)}.Elastance_mid*EnControl/EnDob),'o-','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
% %     plot(CPP,V_endo,'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
% %     plot(CPP,V_epi,'o--','linewidth',1.5,'Color',[0.9290    0.6940    0.1250]);
%     
%     % set(gca,'xtick',[1 2 3],'XTickLabel',names);
%     legend(Res,names);
%     xlabel('CPP (mmHg)');
%     ylabel('Log10(E/E0)');
%     box on;
%     saveas(h,['E_pair_',num2str(i),'.png']);
% 
% end

movefile('*.png',['./Figs']);