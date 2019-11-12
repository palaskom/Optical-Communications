syms f(x)
syms a1 a2 a3
syms b1 b2 b3
syms x c lamda


f(x) = (1 + (a1*x^2)/(x^2-b1) + (a2*x^2)/(x^2-b2) + (a3*x^2)/(x^2-b3))^(1/2);
% df1 = diff(f(x));
df2 = diff(f(x),2);
DM = -(x/c)*df2;

lamda = subs(1.2:0.0025:1.7);
DM = subs(DM, {a1 a2 a3 b1 b2 b3 c x}, ...
                 {0.6961663      0.4079426     0.8974994 ...
                  0.004629148    0.01351206    97.934062 ...
                  3*10^8         lamda});

DM_val = double(DM)*1e12;
plot(lamda,DM_val)
xlabel('wavelength[um]')
ylabel('D_M [psnm^-^1km^-^1]')





