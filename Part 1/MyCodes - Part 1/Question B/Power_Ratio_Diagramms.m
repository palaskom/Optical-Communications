w = [0.3:0.025:0.7, 0.75:0.05:1];
h_TE = 0.8084;
h_TM = 0.5344;

plot(w, h_TE*PowerRatioTE,'b')
hold on
plot(w, h_TM*PowerRatioTM,'r')
xlabel('w[um]')
ylabel('confinement factor')
legend('TE_2_D','TM_2_D')
