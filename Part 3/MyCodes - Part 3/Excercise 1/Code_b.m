%% n1 - calculation @ 1550nm

syms f(x)
syms a1 a2 a3
syms b1 b2 b3

f(x) = (1 + (a1*x^2)/(x^2-b1) + (a2*x^2)/(x^2-b2) + (a3*x^2)/(x^2-b3))^(1/2);
n1 = double(subs(f, {a1 a2 a3 b1 b2 b3 x}, ...
                       {0.6961663      0.4079426     0.8974994 ...
                        0.004629148    0.01351206    97.934062 ...
                        1.55}));

%% b(lamda) - calculation

c = 3*10^8;
d = 8.2; % fabric diameter [um]
D = 3e-3; 
A = pi*d*n1*sqrt(2*D); 
h = 0.0025;

lamda = 1.2:h:1.7; %[um]
v = A./lamda;
b = zeros(1,length(v));

k = 0;
for V = v
    k = k + 1;
    g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
            -sqrt(b)*besselk(1,V*sqrt(b))/besselk(0,V*sqrt(b));
    b(k) = fsolve(g,0.99);
end

figure, plot(lamda,b,'b')
% polynomial fitting
p = polyfit(lamda,b,2);
tr = p(1)*lamda.^2 + p(2)*lamda + p(3);
hold on, plot(lamda,tr,'r')

B = n1*D/c;
DW = -2*B*p(1)*lamda;
DW_val = DW*1e12;
figure, plot(lamda,DW_val)
xlabel('wavelength[um]')
ylabel('D_W [psnm^-^1km^-^1]')
