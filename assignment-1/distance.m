function [distance] = distance(shape1, shape2)
    
%     distance=0;
    shape1 = reshape(shape1, [112, 1]);
    shape2 = reshape(shape2, [112, 1]);

    difference = (shape1-shape2) .^ 2;
    distance = sqrt(sum(difference));    

end