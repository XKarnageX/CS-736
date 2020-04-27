function Z = RRMSE(A,B)
    Z = norm(A-B,'fro')/norm(A,'fro');
end