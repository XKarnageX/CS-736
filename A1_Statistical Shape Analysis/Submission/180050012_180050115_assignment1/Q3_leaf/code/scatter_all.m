function scatter_all(shapes1)
    [dim, np, ns] = size(shapes1);
   for n=1:ns
      xs(1:np) = shapes1(1,:,n);
      xs(np+1)=xs(1);
      ys(1:np) = shapes1(2,:,n);
      ys(np+1)=ys(1);
%       ys = shapes1(2,:,n);
      scatter(xs,ys, 5, [0 0 1], 'filled');
      hold on
   end
end