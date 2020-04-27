function [X, obj] = grad_descent_parallel(X, Y, g, alpha, gamma, step)

    X_r = [X(:,2:end) X(:,1)];
    X_l = [X(:,end) X(:,1:end-1)];
    X_t = [X(end,:); X(1:end-1,:)];
    X_b = [X(2:end,:); X(1,:)];
    X_r=derivative(g,gamma,X_r-X);
    X_l=derivative(g,gamma,X_l-X);
    X_t=derivative(g,gamma,X_t-X);
    X_b=derivative(g,gamma,X_b-X);
    grad = (1-alpha)*2*(X-Y);
    grad=grad+alpha*(X_r+X_l+X_t+X_b);
    
    X = X - step*grad;
    X_r = [X(:,2:end) X(:,1)];
    X_l = [X(:,end) X(:,1:end-1)];
    X_t = [X(end,:); X(1:end-1,:)];
    X_b = [X(2:end,:); X(1,:)];
    
    objj= (1-alpha)*(X-Y).^2;
    objj = objj+alpha*(g(X_r,gamma)+g(X_l,gamma)+g(X_t,gamma)+g(X_b,gamma));
    obj=sum(objj,'all');
end