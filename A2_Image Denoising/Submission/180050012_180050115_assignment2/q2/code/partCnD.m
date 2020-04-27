function [f,R,G,B] = partCnD(X,Y,data,i,g1,g2,g3,A)
   names1 = ["R","G","B"];
   colormap("gray");
   
   figure(8*i-7);
   f(8*i-7)=imshow(uint8(A));
   title("noiseless");
   colorbar;
   figure(8*i-6);
   f(8*i-6)=imshow(uint8(Y));
   title("Channel "+names1(i)+" noisy");
   colorbar;
   [R, ~, obj_vec1] = denoising(X, Y, g1, data(i,1,1), 0.1, data(i,1,2));
   [G, ~, obj_vec2] = denoising(X, Y, g2, data(i,2,1), 0.1, data(i,2,2));
   [B, ~, obj_vec3] = denoising(X, Y, g3, data(i,3,1), 0.1, data(i,3,2));
 
    f(8*i-5)=figure(8*i-5);
    imshow(uint8(R));
    title("Channel" +names1(i)+" denoised with g1 prior");
    colorbar;
    f(8*i-4)=figure(8*i-4);
    imshow(uint8(G));
    title("Channel" +names1(i)+" denoised with g2 prior");
    colorbar;
    f(8*i-3)=figure(8*i-3);
    imshow(uint8(B));
    title("Channel" +names1(i)+" denoised with g3 prior");
    colorbar;
    
    f(8*i-2)=figure(8*i-2);
    plot(obj_vec1);
    title("Objective for channel "+names1(i)+" with g1 prior");
    f(8*i-1)=figure(8*i-1);
    plot(obj_vec2);
    title("Objective for channel "+names1(i)+" with g2 prior");
    f(8*i)=figure(8*i);
    plot(obj_vec3);
    title("Objective for channel "+names1(i)+" with g3 prior");
end

