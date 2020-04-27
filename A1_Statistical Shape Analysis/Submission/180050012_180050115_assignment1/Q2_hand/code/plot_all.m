function plot_all(shapes1)
    [dim,nP, nS]=size(shapes1);
   for n=1:nS
      xs(1:nP) = shapes1(1,:,n);
      xs(nP+1)=xs(1);
      ys(1:nP) = shapes1(2,:,n);
      ys(nP+1)=ys(1);
%       ys = shapes1(2,:,n);
      plot(xs,ys,"-o");
      hold on
   end
end