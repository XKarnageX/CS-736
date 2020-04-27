%%
A = double(imread("../data/histology_noiseless.png"));
Y1 = double(imread("../data/histology_noisy.png"));

g1 = @(x,gamma) ((x.^2)/gamma);
g2 = @(x,gamma) (0.5*(x.^2).*(abs(x)<=gamma) + (gamma*abs(x)-0.5*gamma^2).*(abs(x)>gamma));
g3 = @(x,gamma) (gamma*abs(x) - (gamma^2)*log(1+(abs(x)/gamma)));

data=zeros([3,3,2]);
data(1,:,:)=([[1,0.74];[1,0.98];[1.1,0.98]]);
data(2,:,:)=([[1.1,0.64];[0.8,0.98];[0.9,0.98]]);
data(3,:,:)=([[1,0.78];[1,0.98];[1.2,0.98]]);
name=["R","G","B"];
dRGB = [];

%%
 for i=1:3
      Y = Y1(:,:,i);
      disp("Optimizing color channel "+name(i)+" of the Image");
      disp("RRMSE b/w noisy and noiseless "+name(i)+" channels = " + RRMSE(Y,A(:,:,i)));
      X=2*Y;
      for j=1:3
          partB(X,Y,data,i,j,g1,g2,g3,A(:,:,i));        
      end
  end
%%
  for i=1:3
 %      Y = double(imread("mri_image_noise_level_"+name(i)+".png"));
      Y = Y1(:,:,i);
      disp("Denoising color channel "+name(i)+" of the Image");
      disp(" ");
      X=2*Y;
     [f,Cg1,Cg2,Cg3] = partCnD(X,Y,data,i,g1,g2,g3,A(:,:,i));
     dRGB = cat(3,dRGB,Cg1,Cg2,Cg3);
     save("results_img"+i+".mat","f");
  end
  
  img_g1 = uint8(cat(3,dRGB(:,:,1),dRGB(:,:,4),dRGB(:,:,7))); 
  img_g2 = uint8(cat(3,dRGB(:,:,2),dRGB(:,:,5),dRGB(:,:,8))); 
  img_g3 = uint8(cat(3,dRGB(:,:,3),dRGB(:,:,6),dRGB(:,:,9))); 
  
  OK(3) = figure(25);
  imshow(uint8(A));
  title("Noiseless RGB");
  
  OK(3) = figure(26);
  imshow(uint8(Y1));
  title("Noisy RGB");
  
  OK(3) = figure(27);
  imshow(img_g1);
  title("RGB Image denoised using g1 prior");
  
  OK(4) = figure(28);
  imshow(img_g2);
  title("RGB Image denoised using g2 prior");
  
  OK(5) = figure(29);
  imshow(img_g3);
  title("RGB Image denoised using g3 prior");
 
  save("results_RGB.mat","OK");

%%

% X1=2*Y1;
% 
%  R1 = X1(:,:,1);
%  G1 = X1(:,:,2);
%  B1 = X1(:,:,3);
%  
%  R2 = Y1(:,:,1);
%  G2 = Y1(:,:,2);
%  B2 = Y1(:,:,3);
% code to find optimal gamma given alpha
% N=30;
% obj_vec=zeros([N,1]);
% error_vec=zeros([N,1]);
% for i = 1:N
%     i
%     gamma = 0.1*i;
%     [X_opt, obj] = denoising(R1, R2, g3, gamma, 0.1, 0.82);
%     error = RRMSE(X_opt,A(:,:,1))
%     obj_vec(i)=obj;
%     error_vec(i)=error;
% end


% Code to find the optimal alpha
% N=50;
% obj_vec=zeros([N,1]);
% error_vec=zeros([N,1]);
% for i = 1:N
%     i
%     alpha = (i-1)/N;
%     [X_opt, obj] = denoising(R1, R2, adaptive, 1, 0.1, alpha);
%     obj
%     error = RRMSE(X_opt,A(:,:,1))
%     obj_vec(i)=obj;
%     error_vec(i)=error;
% end
