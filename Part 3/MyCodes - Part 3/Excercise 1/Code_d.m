%% new V calculation & b(V)-polynomial fitting
c = 3*10^8;
d = 8.2; % fabric diameter [um]
D = 3e-3; 
A = pi*d*sqrt(2*D); 
h = 0.0025;
lamda = 1.2:h:1.7;

syms f(x)
syms a1 a2 a3
syms b1 b2 b3

f(x) = (1 + (a1*x^2)/(x^2-b1) + (a2*x^2)/(x^2-b2) + (a3*x^2)/(x^2-b3))^(1/2);
n1 = double(subs(f, {a1 a2 a3 b1 b2 b3 x}, ...
                       {0.6961663      0.4079426     0.8974994 ...
                        0.004629148    0.01351206    97.934062 ...
                        lamda}));
v = A*n1./lamda;
b = zeros(1,length(v));
k = 0;
for V = v
    k = k + 1;
    g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
            -sqrt(b)*besselk(1,V*sqrt(b))/besselk(0,V*sqrt(b));
    b(k) = fsolve(g,0.99);
end

plot(lamda,b,'b')

p = polyfit(lamda,b,2);
tr = p(1)*lamda.^2 + p(2)*lamda + p(3);
hold on
plot(lamda,tr,'r')

%% DT-plot
syms n(x) b(x)
syms a1 a2 a3
syms b1 b2 b3
syms p1 p2 p3
syms c D

n(x) = (1 + (a1*x^2)/(x^2-b1) + (a2*x^2)/(x^2-b2) + (a3*x^2)/(x^2-b3))^(1/2);
% pretty(n)

b(x) = p1*x^2 + p2*x + p3;
% pretty(b)

beta = 2*pi*(n(x)/x)*sqrt(1-2*D*(1-b(x)));
% pretty(beta)

Dt = -x*(x*diff(beta,2)+2*diff(beta,1))/(2*pi*c);
% pretty(Dt)

Dt = subs(Dt, {a1 a2 a3 b1 b2 b3 ...
               p1 p2 p3 c D}, ...
              {0.6961663      0.4079426     0.8974994 ...
               0.004629148    0.01351206    97.934062 ...
               p(1)   p(2)   p(3)  3*10^8   0.003} );

DT_val = 1e12*double(subs(Dt,lamda));
plot(lamda,DT_val)
xlabel('wavelength[um]')
ylabel('D_T [psnm^-^1km^-^1]')
title('D_T - direct calculation')
