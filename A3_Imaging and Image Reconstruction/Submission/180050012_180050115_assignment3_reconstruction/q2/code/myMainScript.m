%%
%Part A
im = double(imread("Data/ChestPhantom.png"));
f1 = figure(1);
imshow(im,[]);
title('Original Image')

[m,n] = size(im);
A = makeBasis(m,n);
s1 = size(A);

vim = reshape(im,[m*n,1]);
b = A*vim;
R = reshape(b,[185,180]);

%%
%Part B
s = 0.02*(max(R,[],'all')-min(R,[],'all'));
noise = normrnd(0,s,185,180);

noisyR = R + noise;
vecNoisyR = reshape(noisyR,[185*180,1]);

%%
%Part C
rIm = iradon(noisyR,0:179,'linear','Cosine',1,128);
vrIm = reshape(rIm,[128*128,1]);
f2 = figure(2);
imshow(rIm,[]);
title('FBP reconstruction from noisy Radon Transform')
% i1 = imresize(reconstructedIm,[128,128]);
err1 = RRMSE(im,rIm);
disp(['RRMSE of image with FBP reconstruction is ',num2str(err1)])

%%
%Part D

% %Code for finding optimal regularization parameter:
% vec1 = zeros(50);
% for i = 1:50
%     i
%     temp1 = regularizedReconstruction(A,vecNoisyR,i/50);
%     r1 = RRMSE(im,reshape(temp1,[128,128]))
%     vec1(i) = r1;
% end
% 
% [~,min1] = min(vec1);
% f7 = figure(7);
% plot(vec1);

%Optimal lambda opt = 0.04
%Optimal RRMSE is 0.1410
%at lambda = 0.8*opt, RRMSE is 0.1411
% at lambda = 1.2*opt, RRMSE is 0.1425

%%
tIm1 = regularizedReconstruction(A,vecNoisyR,0.04);
f3 = figure(3);
tIm = reshape(tIm1,[128,128]);
imshow(tIm,[]);
title('Reconstructed image using Tikhonov Regularization')
err2 = RRMSE(im,tIm);
disp(['Optimal regularization parameter, lambda is ',num2str(0.04)])
disp(['RRMSE of the image reconstructed by Tikhonov Regularization at this value of lambda is: ',num2str(0.1410)])
disp(['RRMSE at lambda = 0.8*opt is ',num2str(0.1411)])
disp(['RRMSE at lambda = 1.2*opt is ',num2str(0.1425)])
% disp(['RRMSE at lambda = 0.8*opt is ',num2str(RRMSE(im,reshape(regularizedReconstruction(A,vecNoisyR,0.032),[128,128])))])
% disp(['RRMSE at lambda = 1.2*opt is ',num2str(RRMSE(im,reshape(regularizedReconstruction(A,vecNoisyR,0.048),[128,128])))])
%%
%Part E

g1 = @(x,gamma) ((x.^2)/gamma); %Quadratic Potential
g2 = @(x,gamma) (0.5*(x.^2).*(abs(x)<=gamma) + (gamma*abs(x)-0.5*gamma^2).*(abs(x)>gamma)); %Huber Potential
g3 = @(x,gamma) (gamma*abs(x) - (gamma^2)*log(1+(abs(x)/gamma))); %Adaptive Potential

%%
% %Code for finding optimal regularization parameters
% vec2 = zeros([50,1]);
% for i = 1:50
%     i
%     temp1 = MRF_Regularized_Reconstruction(A,vecNoisyR,g2,i/50,vrIm);
%     r2 = RRMSE(im,reshape(temp1,[128,128]))
%     vec2(i,1) = r2;
% end
% [tr2,min2] = min(vec2);
% f8 = figure(8);
% plot(vec2);


%%
mrfIm1 = MRF_Regularized_Reconstruction(A,vecNoisyR,g1,0.96,vrIm);
mrfIm11 = reshape(mrfIm1,[128,128]);
f4 = figure(4);
imshow(mrfIm11,[]);
title('MRF prior with quadratic potential')
err11 = RRMSE(im,mrfIm11);
disp(['Optimal regularization parameter for MRF with quadratic potential is ',num2str(0.96)])
disp(['RRMSE of the image reconstructed by MRF Regularization at this value of lambda is: ',num2str(0.1364)])
disp(['RRMSE at lambda = 0.8*opt is ',num2str(0.2617)])
disp(['RRMSE at lambda = 1.2*opt is ',num2str(0.1365)])

%%

mrfIm2 = MRF_Regularized_Reconstruction(A,vecNoisyR,g2,0.98,vrIm);
mrfIm22 = reshape(mrfIm2,[128,128]);
f5 = figure(5);
imshow(mrfIm22,[]);
title('MRF prior with huber potential')
err22 = RRMSE(im,mrfIm22);
disp(['Optimal regularization parameter for MRF with Huber potential is ',num2str(0.98)])
disp(['RRMSE of the image reconstructed by MRF Regularization at this value of lambda is: ',num2str(0.1364)])
disp(['RRMSE at lambda = 0.8*opt is ',num2str(0.1365)])
disp(['RRMSE at lambda = 1.2*opt is ',num2str(0.1365)])

%%

mrfIm3 = MRF_Regularized_Reconstruction(A,vecNoisyR,g3,0.96,vrIm);
mrfIm33 = reshape(mrfIm3,[128,128]);
f6 = figure(6);
imshow(mrfIm33,[]);
title('MRF prior with adaptive potential')
err33 = RRMSE(im,mrfIm33);
disp(['Optimal regularization parameter for MRF with adaptive potential is ',num2str(0.98)])
disp(['RRMSE of the image reconstructed by MRF Regularization at this value of lambda is: ',num2str(0.1364)])
disp(['RRMSE at lambda = 0.8*opt is ',num2str(0.1365)])
disp(['RRMSE at lambda = 1.2*opt is ',num2str(0.1365)])