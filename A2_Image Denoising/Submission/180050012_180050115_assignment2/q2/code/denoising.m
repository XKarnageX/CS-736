function [X, obj,obj_vec] = denoising(X, Y, g,gamma, step, alpha)
%     [X, obj] = grad_descent_parallel(X, Y, g, alpha, gamma, step);
    X_r = [X(:,2:end) X(:,1)];
    X_l = [X(:,end) X(:,1:end-1)];
    X_t = [X(end,:); X(1:end-1,:)];
    X_b = [X(2:end,:); X(1,:)];
    objj= (1-alpha)*(X-Y).^2;
    objj = objj+alpha*(g(X_r,gamma)+g(X_l,gamma)+g(X_t,gamma)+g(X_b,gamma));
    obj=sum(objj,'all');
    obj_vec=[obj];
    threshhold = 10^(-6);
%     i=0
    
    while true    
        [X1, obj_new1] = grad_descent(X, Y, g, alpha, gamma, step);
        if obj_new1>obj
            step=step/2;
        elseif abs(obj_new1-obj)/obj>threshhold
            step=step*1.1;
            X=X1;
            obj=obj_new1;
            obj_vec=[obj_vec obj];
        else
            X=X1;
            obj=obj_new1;
            obj_vec=[obj_vec obj];
            break
        end
%         i=i+1
    end
end

