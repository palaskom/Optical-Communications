% DT1, DT2 from Code_c
% DT1 = DM_val + DW_val
% DT2 = DT_val;

% DT1: polynomial fitting (degree = 3)
coff1 = polyfit(lamda,DT1,3);
figure, plot(lamda,DT1,'b')
tr = coff1(1)*lamda.^3 + coff1(2)*lamda.^2 + coff1(3)*lamda + coff1(4);
hold on, plot(lamda,tr,'r'), hold off

% DT2: polynomial fitting (degree = 3)
coff2 = polyfit(lamda,DT2,3);
figure, plot(lamda,DT2,'b')
tr = coff2(1)*lamda.^3 + coff2(2)*lamda.^2 + coff2(3)*lamda + coff2(4);
hold on, plot(lamda,tr,'r'), hold off

% plot slopes
slope1 = 3*coff1(1)*lamda.^2 + 2*coff1(2)*lamda + coff1(3);
slope2 = 3*coff2(1)*lamda.^2 + 2*coff2(2)*lamda + coff2(3);
figure
plot(lamda,1e-3*slope1,'b')
hold on 
plot(lamda,1e-3*slope2,'r')
legend('slope(D_W+D_M)', 'slope(D_T)')
xlabel('wavelength[um]')
ylabel('S [psnm^-^2km^-^1]')

%%
t = -40e3:10:40e3;
a = 1;
y = abs(sin(a*t)./(a*t));
plot(t,y)
xlim([-0.3e4,0.3e4])