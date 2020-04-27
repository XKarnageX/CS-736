function [k] = mod1(a, b)
    k = mod(a, b);
    if k==0
        k=b;
    end
end