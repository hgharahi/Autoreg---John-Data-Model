function Testset = sort_experiments(Testset)
%% this function sorts the experiment cases from 40 to 140 mmHG


t_final = [Testset(1).t(end), Testset(2).t(end),...
    Testset(3).t(end), Testset(4).t(end), ...
    Testset(5).t(end), Testset(6).t(end)];

for i = 1:6
    Testset(i).t_final = t_final(i);
end

Testset = flip(Testset);