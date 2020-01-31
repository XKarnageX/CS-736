function [shapeRot] = rotateShape(shape, theta)
    
% rotates in CCW    
    
    shape = reshape(shape, [112, 1]);
    rotationMatrix = zeros(112, 112);
    rotMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    for i = 1:56
        rotationMatrix((2*i-1):(2*i), (2*i-1):(2*i))=rotMatrix;
    end
    shapeRot = rotationMatrix*shape;
    shapeRot = reshape(shapeRot, [2, 56]);
end

