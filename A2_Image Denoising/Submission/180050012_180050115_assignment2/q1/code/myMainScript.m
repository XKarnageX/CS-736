%%
A = double(imread("../data/mri_image_noiseless.png"));

g1 = @(x,gamma) ((x.^2)/gamma);
g2 = @(x,gamma) (0.5*(x.^2).*(abs(x)<=gamma) + (gamma*abs(x)-0.5*gamma^2).*(abs(x)>gamma));
g3 = @(x,gamma) (gamma*abs(x) - (gamma^2)*log(1+(abs(x)/gamma)));

data=zeros([3,3,2]);
data(1,:,:)=([[1,0.08];[1,0.78];[0.9,0.82]]);
data(2,:,:)=([[1,0.16];[0.9,0.9];[1,0.9]]);
data(3,:,:)=([[1,0.24];[1,0.92];[1.1,0.92]]);
name=["low","medium","high"];

%%
for i=1:3
    Y = double(imread("../data/mri_image_noise_level_"+name(i)+".png"));
    disp("Noise Level "+name(i)+" Image");
    disp("RRMSE b/w noisy and noiseless image = " + RRMSE(Y,A));
    X=2*Y;
    for j=1:3
        partB(X,Y,data,i,j,g1,g2,g3,A);        
    end
end

%%
for i=1:3
    Y = double(imread("../data/mri_image_noise_level_"+name(i)+".png"));
    disp("Noise Level "+name(i)+" Image");
    disp(" ");
    X=2*Y;
    [f] = partCnD(X,Y,data,i,g1,g2,g3,A);
    save("results-img"+i+".mat", "f");
end

%%
% code to find optimal gamma given alpha
% N=30;
% obj_vec=zeros([N,1]);
% error_vec=zeros([N,1]);
% for i = 1:N
%     i
%     gamma = 0.1*i;
%     [X_opt, obj] = denoising(X, Y, g3, gamma, 0.1, 0.82);
%     error = RRMSE(X_opt,A)
%     obj_vec(i)=obj;
%     error_vec(i)=error;
% end

%%
% Code to find the optimal alpha
% N=50;
% obj_vec=zeros([N,1]);
% error_vec=zeros([N,1]);
% for i = 1:N
%     i
%     alpha = (i-1)/N;
%     [X_opt, obj] = denoising(X, Y, adaptive, 1, 0.1, alpha);
%     obj
%     error = RRMSE(X_opt,A)
%     obj_vec(i)=obj;
%     error_vec(i)=error;
% end
%%