function plot1(dvec, clr)
    a = size(dvec, 1)/2;
    xs(1:a) = dvec(1:2:end);
    xs(a+1) = xs(1);
    ys(1:a) = dvec(2:2:end);
    ys(a+1) = ys(1);
    plot(xs,ys,'Linewidth',3, 'Color', clr)
    hold on
end