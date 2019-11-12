function F = NPsolve(x,I)
% Non-linear system of equations

    V = 1.5e-16;
    N0 = 1.5e8;
    G = 0.4;
    b = 0.01;
    tc = 1e-9;
    tp = 3e-12;
    eNL = 3.33e-7;
    s0 = 2.5e-20;
    c = 3e8;
    vg = c/3.527;
    g0 = s0*vg;
    e = 1.6021e-19; 
    
    F(1) = I/e - x(1)/tc - (1/V)*g0*(x(1)-N0).*x(2)./(1+eNL*x(2));
    F(2) = (1/V)*G*g0*(x(1)-N0).*x(2)./(1+eNL*x(2)) - x(2)/tp + G*b*x(1)/tc;

end

