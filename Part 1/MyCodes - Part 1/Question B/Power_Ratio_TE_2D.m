function Sz_ratio = Power_Ratio_TE_2D(A,w)
 
% TMx
% Cover:     1.45
% Layer1:    1.8748
% Substrate: 1.45
% w -> [0.3, 1]
 
    x = A(:,1); % x
    p = A(:,2); % Sz(x)
    
    x_down = find(x==-w/2); % <0
    x_up = find(x==w/2); % >0
       
    % trapezoidal method for numerical integration of the Poynting vector
    s = 0;
    for j = (x_down+1):(x_up-1)
        s = s + p(j);
    end
    sum_guide = p(x_down) + p(x_up) + 2*s;
    sum_total = p(1) + p(end) + 2*(sum(p)-p(1)-p(end)); 
    
    Sz_ratio = sum_guide/sum_total;  

end
