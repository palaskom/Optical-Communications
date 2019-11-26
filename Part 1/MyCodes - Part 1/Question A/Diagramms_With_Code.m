% clear;clc

% [n1, n2, n3]      n1 > n2 > n3

% direction-y: TE & TM modes
[neff_TE_ty, neff_TM_ty] = APDWG(1.55, 0.05, 3.45, 1.45, 1);
[neff_TE_hy, neff_TM_hy] = APDWG(1.55, 0.22, 3.45, 1.45, 1);

k = 0;
p = 0.3:0.005:1;
neff_TE1 = zeros(1,length(p));
neff_TE2 = zeros(1,length(p));
neff_TE3 = zeros(1,length(p));
neff_TM1 = zeros(1,length(p));
neff_TM2 = zeros(1,length(p));

for w = p
    
    k = k+1;
    % direction-x
    % 2D - TE modes
    [a, neff_TM_x] = APDWG(1.55, w, neff_TE_hy, neff_TE_ty, neff_TE_ty);
    neff_TE_2D = neff_TM_x;
    neff_TE1(k) = neff_TE_2D(1);
    if length(neff_TE_2D)>=2 
        neff_TE2(k) = neff_TE_2D(2);
    end
    if length(neff_TE_2D)>=3 
        neff_TE3(k) = neff_TE_2D(3);
    end
    
    % 2D - TM modes
    [neff_TE_x, b] = APDWG(1.55, w, neff_TM_hy, 1.45, 1.45);
    neff_TM_2D = neff_TE_x;
    neff_TM1(k) = neff_TM_2D(1);
    if length(neff_TM_2D)>=2 
        neff_TM2(k) = neff_TM_2D(2);
    end
 
end

plot(p,neff_TE1)
hold on
plot(p,neff_TE2)
plot(p,neff_TE3)
plot(p,neff_TM1)
plot(p,neff_TM2)
legend('TE_1', 'TE_2', 'TE_3', 'TM_1', 'TM_2')



