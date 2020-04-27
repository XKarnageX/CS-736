function [X, obj] = grad_descent(X, Y, g, alpha, gamma, step)
    [r, c] = size(X);
    X = reshape(X, [r*c,1]);
    Y = reshape(Y, [r*c,1]);
%     sigma = std(X-Y);
    N=size(X,1);
    nbrs = [1 N-1 r N-r];
    for i=1:N
        grad = (1-alpha)*2*(X(i,1)-Y(i,1));
        for j=nbrs
%             alpha
%             xx=(X(i,1)-X(mod(i+j-1,N)+1,1))
            grad = grad + alpha*derivative(g,gamma,(X(i,1)-X(mod(i+j-1,N)+1,1)));
        end
%         size(X(i))
%         size(step)
%         size(grad)
        X(i,1) = X(i,1) - step*grad;
    end
%     sigma = std(X-Y);
    obj = (1-alpha)*sum((X-Y).^2);
    X = reshape(X, [r,c]);
    for i=1:c
        obj=obj+2*alpha*sum(g(X(:,i)-X(:,mod(i,c)+1), gamma));
    end
    for i=1:r
        obj=obj+2*alpha*sum(g(X(i,:)-X(mod(i,r)+1,:), gamma));
    end
    
end