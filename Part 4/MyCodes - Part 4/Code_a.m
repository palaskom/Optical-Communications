%% Parameter initialization
clear;clc
    V = 1.5e-16;
    N0 = 1.5e8;
    G = 0.4;
    b = 0.01;
    tc = 1e-9;
    tp = 3e-12;
    eNL = 3.33e-7;
    s0 = 2.5e-20;
    L = 300e-6;
    c = 3e8;
    vg = c/3.527;
    g0 = s0*vg;
    R = 0.3;
    lamda = 1.55e-6;
    e = 1.6021e-19; 
    h = 6.626e-34;

%% (i)
Nth = N0 + V/(G*g0*tp);
Ith = e*Nth/tc;

I = linspace(0,5*Ith,100);
Ph = G*tp*(I-Ith)/e;
Pe_theoretical = vg*log(1/R)*h*c*Ph/(2*L*lamda);
Pe_theoretical(I<Ith) = 0;
plot(I,1e3*Pe_theoretical)
xlabel('I [A]'), ylabel('P_e [mW]')
title('Current-Power Characteristic')
grid on

%% (ii)
xsol = [0 0];
for k = 1:length(I)
    current = I(k);
    xsol = fsolve(@(x)NPsolve(x,current),xsol);
    N(k) = xsol(1);
    P(k) = xsol(2);
end

Pe_fsolve = vg*log(1/R)*h*c*P/(2*L*lamda);
hold on, grid on
plot(I,1e3*Pe_fsolve)
xlabel('I [A]'), ylabel('P_e [mW]')
title('Current-Power Characteristic')
legend('Pe(i)','Pe(ii)')
hold off

% error
error = sum((Pe_fsolve-Pe_theoretical).^2)/length(Pe_fsolve)
    
    