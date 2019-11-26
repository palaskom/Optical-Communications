function Sz_ratio = Power_Ratio_h_1D(A,w)

% In A (2xN matrix) we store the Sz values 
% Cover:     1
% Layer1:    3.45
% Substrate: 1.45
% h = 0.22 um
 
    x = A(:,1); % x
    p = A(:,2); % Sz(x)
    
    x1 = find(x==0);
    x2 = find(x==w);
    
    x_down = x1; 
    x_up = x2; 
    
    % trapezoidal method for numerical integration of the Poynting vector
    s = 0;
    for j = (x_down+1):(x_up-1)
        s = s + p(j);
    end
    sum_guide = p(x_down) + p(x_up) + 2*s;
    sum_total = p(1) + p(end) + 2*(sum(p)-p(1)-p(end)); 
    
    Sz_ratio = sum_guide/sum_total;
end
