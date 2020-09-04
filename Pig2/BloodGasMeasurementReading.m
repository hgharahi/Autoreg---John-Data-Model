%% Data from Kiel et al. read and assiged in MATLAB

SpecimenPairs = [2,2;
    3,1;
    4,3;
    5,4]; % First column Control, Second column Anemia and Anemia+Dobutamine case number.

names = {'Control','Anemia','Anemia+Dobutamine'};
SpecimenIDs = {'#10013','#10011','#10015','#10276'};

CPP = [40 ,60, 80, 100, 120, 140];

i = 2;

BloodGasMeasurementsControl = [
14.7	6.6     184     25      100     44.9	10.45	33;
14.7	5.2     184     20      100     34.4	10.9	34;
12.9	3.9     190     17      97.2	26      11      32.5;
12.9	2.9     190     15      97.2	19.4	10.8	34;
15.1	2.9     196     14      100     19.4	10.7	33.5;
14.9	2.5     186     12      100     17.3	10.55	33;
];

BloodGasMeasurementsAnemia = [
7.6     3.5     195     25      100     48.3	5.1     17.5
7.6     3.3     195     21      100     44.5	4.8     19
7.1     2       199     20      100     30.2	5       15.5
7.1     2       199     19      100     29.3	4.9     18
7.1     2       195     17      100     25.9	5.6     17
7.1     1.8     200     16      100     23.4	5.6     17
];

BloodGasMeasurementsDob = [];

Control{SpecimenPairs(i,1)}.LVweight = 82.27;
Anemia{SpecimenPairs(i,2)}.LVweight = 82.27;
Dob{SpecimenPairs(i,2)}.LVweight = 82.27;

VisCorrection = @(x) 14.5583*x.^3 + 3.0897*x.^2 + 3.4796*x + 1.0000; % Curve fitted to curve in Fig. 7 of Pries et al paper.

for j = 1:length(CPP)
    
    Control{SpecimenPairs(i,1)}.ArtO2Cnt(j) =   BloodGasMeasurementsControl(6-j+1,1);
    Control{SpecimenPairs(i,1)}.CVO2Cnt(j)  =   BloodGasMeasurementsControl(6-j+1,2);
    Control{SpecimenPairs(i,1)}.ArtPO2(j)   =   BloodGasMeasurementsControl(6-j+1,3);
    Control{SpecimenPairs(i,1)}.CvPO2(j)    =   BloodGasMeasurementsControl(6-j+1,4);
    Control{SpecimenPairs(i,1)}.ArtO2Sat(j) =   BloodGasMeasurementsControl(6-j+1,5);
    Control{SpecimenPairs(i,1)}.CvO2Sat(j)  =   BloodGasMeasurementsControl(6-j+1,6);
    Control{SpecimenPairs(i,1)}.Hgb(j)      =   BloodGasMeasurementsControl(6-j+1,7);
    Control{SpecimenPairs(i,1)}.HCT(j)      =   BloodGasMeasurementsControl(6-j+1,8);
    
    Anemia{SpecimenPairs(i,2)}.ArtO2Cnt(j) =   BloodGasMeasurementsAnemia(6-j+1,1);
    Anemia{SpecimenPairs(i,2)}.CVO2Cnt(j)  =   BloodGasMeasurementsAnemia(6-j+1,2);
    Anemia{SpecimenPairs(i,2)}.ArtPO2(j)   =   BloodGasMeasurementsAnemia(6-j+1,3);
    Anemia{SpecimenPairs(i,2)}.CvPO2(j)    =   BloodGasMeasurementsAnemia(6-j+1,4);
    Anemia{SpecimenPairs(i,2)}.ArtO2Sat(j) =   BloodGasMeasurementsAnemia(6-j+1,5);
    Anemia{SpecimenPairs(i,2)}.CvO2Sat(j)  =   BloodGasMeasurementsAnemia(6-j+1,6);
    Anemia{SpecimenPairs(i,2)}.Hgb(j)      =   BloodGasMeasurementsAnemia(6-j+1,7);
    Anemia{SpecimenPairs(i,2)}.HCT(j)      =   BloodGasMeasurementsAnemia(6-j+1,8);
    
    
    Dob{SpecimenPairs(i,2)}.ArtO2Cnt(j) =   BloodGasMeasurementsDob(6-j+1,1);
    Dob{SpecimenPairs(i,2)}.CVO2Cnt(j)  =   BloodGasMeasurementsDob(6-j+1,2);
    Dob{SpecimenPairs(i,2)}.ArtPO2(j)   =   BloodGasMeasurementsDob(6-j+1,3);
    Dob{SpecimenPairs(i,2)}.CvPO2(j)    =   BloodGasMeasurementsDob(6-j+1,4);
    Dob{SpecimenPairs(i,2)}.ArtO2Sat(j) =   BloodGasMeasurementsDob(6-j+1,5);
    Dob{SpecimenPairs(i,2)}.CvO2Sat(j)  =   BloodGasMeasurementsDob(6-j+1,6);
    Dob{SpecimenPairs(i,2)}.Hgb(j)      =   BloodGasMeasurementsDob(6-j+1,7);
    Dob{SpecimenPairs(i,2)}.HCT(j)      =   BloodGasMeasurementsDob(6-j+1,8);   
    
end


Control{SpecimenPairs(i,1)}.VisRatio = VisCorrection(Control{SpecimenPairs(i,1)}.HCT/100);

Anemia{SpecimenPairs(i,2)}.VisRatio = VisCorrection(Anemia{SpecimenPairs(i,2)}.HCT/100) / mean(Control{SpecimenPairs(i,1)}.VisRatio);

Dob{SpecimenPairs(i,2)}.VisRatio = VisCorrection(Dob{SpecimenPairs(i,2)}.HCT/100) / mean(Control{SpecimenPairs(i,1)}.VisRatio);

Control{SpecimenPairs(i,1)}.VisRatio = Control{SpecimenPairs(i,1)}.VisRatio./mean(Control{SpecimenPairs(i,1)}.VisRatio);



