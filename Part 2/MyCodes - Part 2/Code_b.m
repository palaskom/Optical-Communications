v = 0.1:0.1:12;
b = zeros(1,length(v));
k = 0;
b0 = 0;

for V = v
    k = k + 1;
    g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
            -sqrt(b)*besselk(1,V*sqrt(b))/besselk(0,V*sqrt(b));
    b(k) = fsolve(g,0.99);
end
    
plot(v,b)
xlabel('V')
ylabel('b')
title('LP_0_1')
set(get(gca,'ylabel'),'rotation',0)

