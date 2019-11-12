function der = odefcn(t,NP,I,tpulse)
% der -> derivative
% 2x2 system of differential equations

% Parameter initialization
    V = 1.5*1e-16;
    N0 = 1.5e8;
    G = 0.4;
    
    %---------------------------%
    b = 0; 
%     b = 0.01;
    %---------------------------%

    tc = 1e-9;
    tp = 3e-12;
    
    %---------------------------%
%     eNL = 3.33e-8; 
    eNL = 3.33e-7;
    %---------------------------%

    s0 = 2.5e-20;
    c = 3e8;
    vg = c/3.527;
    g0 = s0*vg;
    e = 1.6021e-19;     

    I = interp1(tpulse,I,t);
    der(1) = I/e - NP(1)/tc - (1/V)*g0*(NP(1)-N0)*NP(2)/(1+eNL*NP(2));
    der(2) = (1/V)*G*g0*(NP(1)-N0)*NP(2)/(1+eNL*NP(2)) - NP(2)/tp + G*b*NP(1)/tc;
    
    der = [der(1); der(2)];
end

