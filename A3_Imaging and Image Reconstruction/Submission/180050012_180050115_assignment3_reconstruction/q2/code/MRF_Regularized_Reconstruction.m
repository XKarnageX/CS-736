function x = MRF_Regularized_Reconstruction(A, b, g, lambda,im)
%     x = zeros([128*128,1]);
    x = im;
%     x = normrnd(0,255,[128*128,1]);
    threshold = 10^-4;
    step = 10^-3;
    
    [MRF_obj,MRF_grad] = calc_MRF_obj_grad(x,lambda,g);
%     MRF_obj
%     sum(MRF_grad,'all')
%     max(MRF_grad,[],'all')
    objx = (1-lambda)*sum((A*x-b).^2) + MRF_obj;
    grad = (1-lambda)*(A.')*(A*x-b) + MRF_grad;
%     sum(grad,'all')
%     max(grad,[],'all')
    xn = x - step*grad;
    
    [m1,~] = calc_MRF_obj_grad(xn,lambda,g);
%     m1
    objxn = (1-lambda)*sum((A*xn-b).^2) + m1;
        
    i = 1;
    while objxn<(1-threshold)*objx
%         i;
        if objxn>objx
            step = 0.5*step;
            xn = x - step*grad;
            [m1,~] = calc_MRF_obj_grad(xn,lambda,g);
            objxn = (1-lambda)*sum((A*xn-b).^2) + m1;
            i = i+1;
        else
            step = 1.1*step;
            x = xn;
            objx = objxn;
            [~,g1] = calc_MRF_obj_grad(x,lambda,g);
            grad = g1;
%             sum(grad)
            xn = x - step*grad;
            [m2,~] = calc_MRF_obj_grad(xn,lambda,g);
            objxn = (1-lambda)*sum((A*xn-b).^2) + m2;
            i = i+1;
        end
    end
end