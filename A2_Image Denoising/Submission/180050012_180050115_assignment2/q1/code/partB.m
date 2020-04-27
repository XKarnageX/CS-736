function partB(X,Y,data,i,j,g1,g2,g3,A)
    
        disp("Optimal Values using g"+j+" prior:")
        disp("alpha = "+data(i,j,2));
        disp("gamma = "+data(i,j,1));
        disp(" ")
        if j==1
            g=g1;
        elseif j==2
            g=g2;
        elseif j==3
            g=g3;
        end
        mult = @(x) (x*1.2*((x*1.2)<1)+0.99*(x*1.2>=1));
        [X_opt, ~, ~] = denoising(X, Y, g, data(i,j,1), 0.1, data(i,j,2));
        disp("RRMSE(alpha,gamma) = "+ RRMSE(X_opt,A));
        [X_opt, ~, ~] = denoising(X, Y, g, data(i,j,1), 0.1, 0.8*data(i,j,2));
        disp("RRMSE(0.8*alpha,gamma) = "+ RRMSE(X_opt,A));
        [X_opt, ~, ~] = denoising(X, Y, g, data(i,j,1), 0.1, mult(data(i,j,2)));
        disp("RRMSE(1.2*alpha,gamma) = "+ RRMSE(X_opt,A));
        if j~=1
            [X_opt, ~, ~] = denoising(X, Y, g, 0.8*data(i,j,1), 0.1, data(i,j,2));
            disp("RRMSE(alpha,0.8*gamma) = "+ RRMSE(X_opt,A));
            [X_opt, ~, ~] = denoising(X, Y, g, 1.2*data(i,j,1), 0.1, data(i,j,2));
            disp("RRMSE(alpha,1.2*gamma) = "+ RRMSE(X_opt,A));
        end
        disp(" ")
        

end

