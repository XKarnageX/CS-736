function [MRF_obj,MRF_grad] = calc_MRF_obj_grad(x,lambda,g)
    gamma = 1;
    X = reshape(x,[128,128]);
    
    X_r = [X(:,2:end) X(:,1)];
    X_l = [X(:,end) X(:,1:end-1)];
    X_t = [X(end,:); X(1:end-1,:)];
    X_b = [X(2:end,:); X(1,:)];

    MRF_obj = sum(lambda*(g(X_r,gamma)+g(X_l,gamma)+g(X_t,gamma)+g(X_b,gamma)),'all');
    
    X_rd=derivative(g,gamma,X_r-X);
    X_ld=derivative(g,gamma,X_l-X);
    X_td=derivative(g,gamma,X_t-X);
    X_bd=derivative(g,gamma,X_b-X);
    
    MRF_grad = reshape(lambda*(X_rd + X_ld + X_td + X_bd),[128*128,1]);
    end