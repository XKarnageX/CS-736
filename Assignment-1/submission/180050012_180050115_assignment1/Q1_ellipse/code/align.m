function psA=align(ps1,ps2)%ps1 is fixed
    x1 = ps1(1,:);
    [~,n] = size(x1);
    y1 = ps1(2,:);
    x2 = ps2(1,:);
    y2 = ps2(2,:);
    X1 = sum(x1);
    X2 = sum(x2);
    Y1 = sum(y1);
    Y2 = sum(y2);
    W = n;
    Z = sum(x2.^2)+sum(y2.^2);
    C1 = sum(x1.*x2)+sum(y1.*y2);
    C2 = sum(y1.*x2)-sum(y2.*x1);
    A = [X2,-1*Y2,W,0;Y2,X2,0,W;Z,0,X2,Y2;0,Z,-1*Y2,X2];
    B = [X1,Y1,C1,C2]';
    sol = linsolve(A,B);
    ax = sol(1);
    ay = sol(2);
    tx = sol(3);
    ty = sol(4);
    R = [ax,-1*ay;ay,ax];
    meanShift = repmat([tx;ty],1,n);
    psA = R*ps2+meanShift;
    return;
end