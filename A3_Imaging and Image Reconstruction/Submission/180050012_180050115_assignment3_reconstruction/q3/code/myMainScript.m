%% ChestCT
clear;

A1 = double(imread("../data/ChestCT.png"));
for i = 0:179
    theta = [i:i+150];
    R = radon(A1,theta);
    S = iradon(R,theta,'linear','Ram-Lak',1,512);
    RRMSE_A1(i+1) = RRMSE(A1,S);
end

[val, ind] = min(RRMSE_A1);
theta_optimal = [ind-1:ind+149];
R1 = radon(A1,theta_optimal);
S1 = iradon(R1,theta_optimal,'linear','Ram-Lak',1,512);

disp('ChestCT image');
disp(['optimal value of theta_i = ', num2str(ind-1)]);
disp(['Corresponding minimum RRMSE = ', num2str(val)]);

f1=figure(1);
plot(RRMSE_A1);
xlabel('i');
ylabel('RRMSE');
title('RRMSE vs theta_i for ChestCT image');

f2=figure(2);
subplot(1,2,1);
imshow(A1,[]);
title('Original');
subplot(1,2,2);
imshow(S1,[]);
title('optimal reconstruction');

%%  SheppLogan256

% clear;
A2 = double(imread("../data/SheppLogan256.png"));
for i = 0:179
    theta = [i:i+150];
    R = radon(A2,theta);
    S = iradon(R,theta,'linear','Ram-Lak',1,256);
    RRMSE_A2(i+1) = RRMSE(A2,S);
end

[val, ind] = min(RRMSE_A2);
theta_optimal = [ind-1:ind+149];
R2 = radon(A2,theta_optimal);
S2 = iradon(R2,theta_optimal,'linear','Ram-Lak',1,256);

disp('SheppLogan256 image');
disp(['optimal value of theta_i = ', num2str(ind-1)]);
disp(['Corresponding minimum RRMSE = ', num2str(val)]);

f3=figure(3);
plot(RRMSE_A2);
xlabel('i');
ylabel('RRMSE');
title('RRMSE vs theta_i for SheppLogan256 image');

f4=figure(4);
subplot(1,2,1);
imshow(A2,[]);
title('Original');
subplot(1,2,2);
imshow(S2,[]);
title('optimal reconstruction');

%%
%