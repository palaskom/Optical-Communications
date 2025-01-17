sne = 8.8e-28;
snh = 4.6e-28;
nSi0 = 3.45;
t = 0.05; %um
h = 0.22; %um
w = 0.5;  %um

k = 0;
N = 1e24:1e23:1e25;
% N = 1e25;
neff_TE_2D = zeros(1,length(N));
neff_TM_2D = zeros(1,length(N));

for n = N
    
    k = k + 1;
    nSi = nSi0 - n*sne - (n*snh)^0.8;
    
    % y-waveguide (TE_y, TM_y)
    % for each nSi value, more than one slab-nodes may exist 
    % a)slab_t -> TE_ty, TM_ty  
    % b)slab_h -> TE_hy, TM_hy
    [neff_TE_ty, neff_TM_ty] = APDWG(1.55, t, nSi, 1.45, 1);
    [neff_TE_hy, neff_TM_hy] = APDWG(1.55, h, nSi, 1.45, 1);
    
    % x-waveguide (TE_x, TM_x)
    
    % TE_2D = TM_x  (neff_TE_hy, neff_TE_ty, neff_TE_ty -> vectors)
    % Each combination of the above neffs entails a TM_x vector
    % Thus, the first mode must be obtained, i.e. the TM_x(1)
    neff_TM_x_MIN = 100;
    for i = 1:length(neff_TE_hy)
        for j = 1:length(neff_TE_ty)
            [a, neff_TM_x] = APDWG(1.55, w, neff_TE_hy(i), neff_TE_ty(j), neff_TE_ty(j));
            if (neff_TM_x(1) < neff_TM_x_MIN)
                neff_TM_x_MIN = neff_TM_x(1);
            end
        end
    end
    neff_TE_2D(k) = neff_TM_x_MIN;
    
    % TM_2D
    % TM_2D = TE_x  (neff_TM_hy -> vector, 1.45, 1.45)
    % Each value of the above neff_TM_hy entails a TM_x vector  
    % Thus, the first mode must be obtained, i.e. the TM_x(1)
    neff_TE_x_MIN = 100;
    for i = 1:length(neff_TM_hy)
        [neff_TE_x, b] = APDWG(1.55, w, neff_TM_hy(i), 1.45, 1.45);
        if(neff_TE_x(1) < neff_TE_x_MIN)
            neff_TE_x_MIN = neff_TE_x(1);
        end
    end
    neff_TM_2D(k) = neff_TE_x_MIN;
end

semilogx(N,neff_TE_2D, 'b')
hold on
semilogx(N,neff_TM_2D,'r')
xlabel('N [m^-^3]')
ylabel('n_e_f_f')
legend('TE_2_D','TM_2_D')
 
lo = 1.55;
L = (lo/2)/(neff_TE_2D(1)-neff_TE_2D(end));
phase = 2*(L/lo)*neff_TE_2D;
plot(neff_TE_2D,phase)
ylabel('phase')
xlabel('n_e_f_f')
title('TE')


