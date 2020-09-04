%% Data from Kiel et al. read and assiged in MATLAB

SpecimenPairs = [2,2;
    3,1;
    4,3;
    5,4]; % First column Control, Second column Anemia and Anemia+Dobutamine case number.

names = {'Control','Anemia','Anemia+Dobutamine'};
SpecimenIDs = {'#10013','#10011','#10015','#10276'};

CPP = [40 ,60, 80, 100, 120, 140];

i = 3;

BloodGasMeasurementsControl = [
13.6	7.2	144	27	100	51.7	10.2	30;											
13.6	5.2	144	20	100	38.5	10.1	30;											
13.7	3.6	150	19	100	27.8	9.7	31.5;											
13.7	3.5	150	16	100	25.4	10.1	31;											
13.1	2.7	154	14	100	19.3	10	30.5;											
14      1.3	154	8	100	9.2	10	30.5;
];

BloodGasMeasurementsAnemia = [
9.1	3.3	151	19	100	34.3	6.25	20;											
9.1	2.6	151	18	100	27.2	7	19;											
6.9	2.6	138	16	100	27.9	6.3	18;											
6.9	1.9	138	14	100	20.2	7	21;											
5.5	1.8	148	13	100	21.8	5.7	18.5;											
8.6	1.2	150	11	100	13	6.15	19.5;
];

BloodGasMeasurementsDob = [
10.9	4.3	126	22	100	36.9	8.4	27;											
10.9	5.1	126	23	100	40.4	9.3	29;											
13.2	5.2	120	22	100	38.2	9.7	28.5;											
13.2	4.4	120	21	100	34.7	9.5	30;
11.8	2.6	133	14	100	20.3	9.1	29;
11.8	0.9	138	12	100	7.5     8.7	28.5;
];

Control{SpecimenPairs(i,1)}.LVweight = 81.87;
Anemia{SpecimenPairs(i,2)}.LVweight = 81.87;
Dob{SpecimenPairs(i,2)}.LVweight = 81.87;

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



