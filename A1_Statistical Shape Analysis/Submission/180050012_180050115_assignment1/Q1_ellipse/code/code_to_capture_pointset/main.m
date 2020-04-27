BW = imread(['data/68.jpg']);
BW = im2bw(BW);
im = imshow(BW);
axis on
% dim = size(BW);
% [x2, y2] = getpts

mat = [114 228 324 2];

B = bwboundaries(BW);
B = B{1, 1};
% figure(3)
hold on
plot(B(:, 2), B(:, 1), 'g');

a = mean(B, 1);
y = B - a;
y = sum(y.^2, 2);
len = size(B, 1)
[M1, a1] = maxk(y, 25);
[M2, b1] = mink(y, 25);
major=a1'
minor=b1'
I1=a1(1);
I2=b1(1);

main1 = zeros(2, 16);
for k=1:3
    mat1 = mat(k);
    mat2 = mat(k+1);
    step = round(mod1(mat2-mat1, len)/4);
    ind = mat1:step:(mat1+3*step);
    main1(:, 4*k-3:4*k) = B(mod_a(ind, len), :)';
end

mat1 = mat(4);
mat2 = mat(1);
step = round(mod1(mat2-mat1, len)/4);
ind = mat1:step:(mat1+3*step);
main1(:, 13:16) = B(mod_a(ind, len), :)'

plot(main1(2, :), main1(1, :), 'sb');



plot([a(2) B(I1, 2)], [a(1) B(I1, 1)], 'xr');
plot([a(2) B(I2, 2)], [a(1) B(I2, 1)], 'xr');

i = mod1(round(I2+(I1-I2)/2), len);
plot([a(2) B(i, 2)], [a(1) B(i, 1)], 'xr');

i = mod1(round(I2+(I1-I2)*0.25), len);
plot([a(2) B(i, 2)], [a(1) B(i, 1)], 'xr');

i = mod1(round(I2+(I1-I2)*0.75), len);
plot([a(2) B(i, 2)], [a(1) B(i, 1)], 'xr');
