function [bmin, bmax] = ParamBounds()

% [(1) C_pa, (2) x*R0m, (3) V01, (4) C11, (5) cf1, (6) rf1, (7) Vc_factor
% (8) L_pa
% (9) R_pa]
% (10) beta
% Control: (11) fact40, (12) fact60, (13) fact80, (14) fact120, (15) fact140, 


bmin = [0.001,    1,       0.05,   0.001,  0.1, 1.0, 0.0, ...
    1, 1, 1,  0.001, 0.001, ...
    0.001, ...
    0.5, ...
    0.5];

bmax = [0.1      , 5,       1,      0.01,   1.0, 3.0, 0.95, ...
    10, 10 , 10, 1, 1, ...
    1.0, ...
    10.0, ...
    10.0];
