function x = regularizedReconstruction(A,b,lambda)
    x = zeros([128*128,1]);
    threshold = 10^-3;
    step = 10^-6;
    
    objx = (1-lambda)*sum((A*x-b).^2) + lambda*(sum(x.^2));
    grad = (1-lambda)*(A'*(A*x-b))+lambda*x;
    
    xn = x - step*grad;
    objxn = (1-lambda)*sum((A*xn-b).^2) + lambda*(sum((xn).^2));
    
    i = 1;
    while objxn<(1-threshold)*objx
        %i %uncomment to see iteration number
        if objxn>objx
            step = 0.5*step;
            xn = x - step*grad;
            objxn = (1-lambda)*(norm(A*xn-b)^2) + lambda*(norm(xn)^2);
            i = i+1;
        else
            step = 1.1*step;
            x = xn;
            objx = objxn;
            grad = (1-lambda)*(A'*(A*x-b))+lambda*x;
            xn = x - step*grad;
            objxn = (1-lambda)*(norm(A*xn-b)^2) + lambda*(norm(xn)^2);
            i = i+1;
        end
    end
    
end