load('data.mat')

% shapes = reshape(shapes, [112, 40]);   % [2, 56, 40]
% pgon = polyshape(shapes(1, :, 3), shapes(2, :, 3));

figure(1)
for i = 1:40
    hold on
    plot(shapes(1, :, i), shapes(2, :, i));
end
hold off

% plot(shapes(1, :, 3), shapes(2, :, 3), shapes(1, :, 1), shapes(2, :, 1))

[shapesOrigin] = centroidToOrigin(shapes);

figure(2)
for i = 1:40
    hold on
    plot(shapesOrigin(1, :, i), shapesOrigin(2, :, i));
end
hold off

