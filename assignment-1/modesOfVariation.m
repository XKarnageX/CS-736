function [outputArg1,outputArg2] = modesOfVariation(shapes, meanShape)
%     shapes is centered at origin
    meanShape = reshape(shapes, [1, 112, 40]);
    covMat = cov(meanShape);
    
    
    
    
    
    
    
    
    outputArg1 = shapes;
    outputArg2 = shapes;
end

