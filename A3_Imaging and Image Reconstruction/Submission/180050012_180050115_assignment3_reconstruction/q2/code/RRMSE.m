function diff = RRMSE(A,B)
    diff = norm(double(A-B),'fro')/norm(double(A),'fro');
end