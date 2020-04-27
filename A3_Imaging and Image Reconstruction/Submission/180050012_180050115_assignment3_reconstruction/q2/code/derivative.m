function slope = derivative(g, gamma, x)
%     gamma;
%     x
    h=10^(-9);
    slope = (g(x+h, gamma)-g(x,gamma))/h;
%     slope=slope(1);
end