function [f] = partCnD(X,Y,data,i,g1,g2,g3,A)
   colormap("gray");
   
   f(8*i-7)=figure(8*i-7);
   imshow(uint8(A));
   title("noiseless");
   colorbar;
   f(8*i-6)=figure(8*i-6);
   imshow(uint8(Y));
   title("Image "+i+" noisy");
   colorbar;
   [X_opt_1, ~, obj_vec1] = denoising(X, Y, g1, data(i,1,1), 0.1, data(i,1,2));
   [X_opt_2, ~, obj_vec2] = denoising(X, Y, g2, data(i,2,1), 0.1, data(i,2,2));
   [X_opt_3, ~, obj_vec3] = denoising(X, Y, g3, data(i,3,1), 0.1, data(i,3,2));
   
   f(8*i-5)=figure(8*i-5);
   imshow(uint8(X_opt_1));
   title("Image "+i+" g1");
   colorbar;
   f(8*i-4)=figure(8*i-4);
   imshow(uint8(X_opt_2));
   title("Image "+i+" g2");
   colorbar;
   f(8*i-3)=figure(8*i-3);
   imshow(uint8(X_opt_3));
   title("Image "+i+" g3");
   colorbar;
   
   f(8*i-2)=figure(8*i-2);
   plot(obj_vec1);
   title("Image "+i+" g1");
   f(8*i-1)=figure(8*i-1);
   plot(obj_vec2);
   title("Image "+i+" g2");
   f(8*i)=figure(8*i);
   plot(obj_vec3);
   title("Image "+i+" g3");
end

