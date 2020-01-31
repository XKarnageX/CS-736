function [shapesNew] = centroidToOrigin(shapes)
    
    centroid_ = zeros(2, 40);
    shapesMean = zeros(2, 56, 40);
%     shapesPreShape = zeros(2, 56, 40);
    
    for i = 1:40
        centroid_(1, i) = sum(shapes(1, :, i))/56;
        centroid_(2, i) = sum(shapes(2, :, i))/56;
        shapesMean(:, :, i) = shapes(:, :, i) - centroid_(:, i);
        
    end
    
%     size_ = zeros(40,1);
%     for i = 1:40
%         size_(i) = sqrt(sum(sum(shapesMean(:, :, i) .^ 2)));
%         shapesPreShape(:, :, i) = shapesMean(:, :, i) ./ size_(i);
%     end
    
    shapesNew = shapesMean;
end