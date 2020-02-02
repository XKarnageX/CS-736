function [mod_arr] = mod_a(arr,b)
    a = size(arr,2);
    mod_arr=zeros(1, a);
    for i = 1:a
        mod_arr(i)=mod1(arr(i), b);
    end
end
