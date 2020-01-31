function [meanShape] = findMean(shapes)
    
    meanShape = shapes(:, :, 1);
    iterations = 10;
    
    for iter = 1:iterations
        shapesAdj = zeros(2, 56, 40);
        for i = 1:40
            shapesAdj(:, :, i) = alignRotation(shapes(:, :, i), meanShape);
        end
        meanShape = sum(shapesAdj, 3) ./ 40;
        
    size_ = sqrt(sum(meanShape .^ 2), 'all');
    meanShape = meanShape ./ size_(i);
    end
end