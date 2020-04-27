load("dataPointsetFinal.mat");
shapes = dataset;
shapes111=shapes;
shapes(2, :, :) = -shapes(2, :, :);
f1=figure(1);
plot_all(shapes);
title("Raw Pointsets");
aligned_shapes = shapes;
[dim,nP,nS] = size(shapes);
n_iter = 100;

%Translate to origin and normalize pointsets
for n=1:nS
    xx1 = shapes(1,:,n);
    yy1 = shapes(2,:,n);
    shapes(1,:,n) = shapes(1,:,n)-mean(xx1);
    shapes(2,:,n) = shapes(2,:,n)-mean(yy1);
    shapes(:,:,n) = shapes(:,:,n)/norm(shapes(:,:,n),'fro');
end
% plot_all(shapes);
mean1 = shapes(:,:,1);
for i=1:n_iter
for n=1:nS
    ps = aligned_shapes(:,:,n);
    aligned_shapes(:,:,n) = align(mean1,ps);
end
mean1 = mean(aligned_shapes,3);
end

for n=1:nS
ps = aligned_shapes(:,:,n);
xs = ps(1,:);
ys = ps(2,:);
xs = xs - mean(xs);
ys = ys - mean(ys);
aligned_shapes(1,:,n) = xs;
aligned_shapes(2,:,n) = ys;
end
mean1 = mean(aligned_shapes,3);
mean2 = mean1;
mean2(:,nP+1)=mean2(:,1);
f2=figure(2);
plot_all(aligned_shapes);
title("Aligned Pointsets");

f3=figure(3);
plot_all(aligned_shapes);
plot(mean2(1,:),mean2(2,:),'Linewidth',3,"Color","y");
title("Mean with aligned pointsets")

cdim = dim*nP;
data = reshape(aligned_shapes,[cdim,nS]);
% cov1 = zeros([cdim,cdim]);
% for n=1:nS
% %     data(:,n) = data(:,n)/norm(data(:,n));
%     cov1 = cov1 + data(:,n)*data(:,n)';
% end
% cov1 = cov1/nS;
cov1 = data*data'/nS;

[V,D] = eig(cov1);
[d,ind] = sort(diag(D),'descend');
Ds = D(ind,ind);
Vs = V(:,ind);
m1 = reshape(mean1,[cdim,1]);
dd = diag(Ds);
f4=figure(4);
plot(dd(2:end),"-o");
title("Variances along modes of variation");
msd1 = zeros([cdim, 3]);
msd2 = zeros([cdim, 3]);
for n=1:3
    l1 = sqrt(Ds(n+1,n+1));
    v1 = Vs(:,n+1);
    figure(4+n);
    scatter_all(aligned_shapes);
    plot1(m1, 'k');
    hold on
    msd1(:, n) = m1+3*l1*v1;
    plot1(msd1(:, n), 'r');
    hold on
    msd2(:, n) = m1-3*l1*v1;
    plot1(msd2(:, n), 'm');
    title("n="+n+ " mode of variation. (black=Mean)");
end
[~, I1] = min(sum((data-m1).^2, 1));
[~, I2] = min(sum((data-msd1(:, 1)).^2, 1));
[~, I3] = min(sum((data-msd2(:, 1)).^2, 1));
hold off

f8=figure(8);
imshow("mri_image_"+I1+".png")
hold on
plot([shapes111(1, :, I1) shapes111(1, 1, I1)], [shapes111(2, :, I1) shapes111(2, 1, I1)], '-o', 'Color','r', "MarkerFaceColor",'r', 'LineWidth',2);
% plot1(m1, 'k');
title("pointset closest to mean(Mean=black)");

f9=figure(9);
imshow("mri_image_"+I2+".png")
hold on
plot([shapes111(1, :, I2) shapes111(1, 1, I2)], [shapes111(2, :, I2) shapes111(2, 1, I2)], '-o', 'Color','r', "MarkerFaceColor",'r', 'LineWidth',2);
% plot1(msd1(:, 1), 'k');
title("pointset closest to mean+3*S.D.(Mean=black)");

f10=figure(10);
imshow("mri_image_"+I3+".png")
hold on
plot([shapes111(1, :, I3) shapes111(1, 1, I3)], [shapes111(2, :, I3) shapes111(2, 1, I3)], '-o', 'Color','r', "MarkerFaceColor",'r', 'LineWidth',2);
% plot1(msd2(:, 1), 'k');
title("pointset closest to mean-3*S.D.(Mean=black)");
f7 = figure(7);
f5 = figure(5);
f6 = figure(6);