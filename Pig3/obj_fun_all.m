function A = obj_fun_all(x, PigExp)


for i = 1:3
    
    A(i) = obj_fun(x, PigExp(i));
    
end


A = sum(A);
