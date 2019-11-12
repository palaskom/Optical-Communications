% run:
% Code_a -> Code_b -> Code_d -> Code_c

DT1 = DM_val + DW_val;
plot(lamda,DT1,'b')
xlabel('wavelength[um]')
ylabel('D_W + D_M [psnm^-^1km^-^1]')
title('D_T = D_W + D_M')
hold on
DT2 = DT_val;
plot(lamda,DT2,'r')
legend('D_W + D_M', 'D_T')






