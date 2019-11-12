
% g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
%         -1i*sqrt(b)*besselh(1,1,1i*V*sqrt(b))/besselh(0,1,1i*V*sqrt(b));
    
% g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))*besselh(0,1,1i*V*sqrt(b))...
%         -1i*besselj(0,V*sqrt(1-b))*sqrt(b)*besselh(1,1,1i*V*sqrt(b)); 
% V = ;
% g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
%         -sqrt(b)*besselk(1,V*sqrt(b))/besselk(0,V*sqrt(b));
%     
% b = fsolve(g,0.9);
 
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

%     g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))*besselh(0,1,1i*V*sqrt(b))...
%             -1i*besselj(0,V*sqrt(1-b))*sqrt(b)*besselh(1,1,1i*V*sqrt(b));
%     g = @(b) sqrt(1-b)*besselj(1,V*sqrt(1-b))/besselj(0,V*sqrt(1-b))...
%         -1i*sqrt(b)*besselh(1,1,1i*V*sqrt(b))/besselh(0,1,1i*V*sqrt(b));
%     if (V<=1)
%         b0 = 0.05;
%     if (V<=1)
%         b0 = 0.1;
%     elseif (V<=2)
%         b0 = 0.3;
%     elseif (V<=2.5)
%         b0 = 0.35;
%     elseif (V<=3)
%         b0 = 0.55;
%     elseif (V<=3.5)
%         b0 = 0.65;
%     elseif (V<=4)
%         b0 = 0.75;    
%     elseif (V<=4)
%         b0 = 0.7;
%     elseif (V<=3)
%         b0 = 0.55;
%     elseif (V<=5)
%         b0 = 0.8;
%     elseif (V<=6)
%         b0 = 0.85;    
%     elseif (V<=7)
%         b0 = 0.9;
%     elseif (V<=9)
%         b0 = 0.93;    
%     elseif (V<=10)
%         b0 = 0.96;
%     elseif (V<=11)
%         b0 = 0.97;
%     else
%         b0 = 0.99;
%     end