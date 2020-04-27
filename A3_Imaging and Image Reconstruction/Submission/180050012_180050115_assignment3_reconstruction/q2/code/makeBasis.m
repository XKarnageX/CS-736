function radonBasis = makeBasis(m,n)
    
    temp = zeros(m*n,1);
    radonBasis = zeros(180*185,m*n);
    
    for i = 1:m*n
        temp(i) = 1;
        im = reshape(temp,[m,n]);
        radonBasis(:,i) = reshape(radon(im),[180*185,1]);
        temp(i) = 0;
    end
    
end