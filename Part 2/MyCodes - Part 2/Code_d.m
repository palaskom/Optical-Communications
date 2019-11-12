v = 0.8:0.01:2.4;
b = zeros(1,length(v));
Aeff_n = zeros(1,length(v));
k = 0;

for V = v
    k = k + 1;
    g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
            -sqrt(b)*besselk(1,V*sqrt(b))/besselk(0,V*sqrt(b));
    b = fsolve(g,0.99);
    
    u = V*sqrt(1-b);
    w = V*sqrt(b);
    p = besselj(0,u)/besselk(0,w);
    bessj1 = @(x) x.*(besselj(0,u*x)).^2;
    intj1 = integral(bessj1,0,1);
    bessj2 = @(x) x.*(besselj(0,u*x)).^4;
    intj2 = integral(bessj2,0,1);
    bessk1 = @(x) x.*(besselk(0,w*x)).^2;
    intk1 = integral(bessk1,1,Inf);
    bessk2 = @(x) x.*(besselk(0,w*x)).^4;
    intk2 = integral(bessk2,1,Inf);
    % normalized Aeff
    Aeff_n(k) = 2*((intj1 + p^2*intk1)^2)/(intj2 + p^4*intk2);
end
    
plot(v,Aeff_n)
xlabel('V')
ylabel('A_e_f_f_,_n')
