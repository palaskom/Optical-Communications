function Sz_ratio = Power_Ratio_TM_2D(A,w)
 
% TEx
% Cover:     1.6107
% Layer1:    2.8051
% Substrate: 1.6107
% w -> [0.3, 1]
 
    x = A(:,1); % x
    p = A(:,2); % Sz(x)
    
    x1 = find(x==-w/2);
    x2 = find(x==w/2);
    x_down = x1(2); % <0
    x_up = x2(1); % >0
   
    % trapezoidal method for numerical integration of the Poynting vector
    s = 0;
    for j = (x_down+1):(x_up-1)
        s = s + p(j);
    end
    sum_guide = p(x_down) + p(x_up) + 2*s;
    sum_total = p(1) + p(end) + 2*(sum(p)-p(1)-p(end)-p(x_down)-p(x_up)); 
    
    Sz_ratio = sum_guide/sum_total;
    
end
