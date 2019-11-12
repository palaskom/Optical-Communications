plot(TM0(:,1),TM0(:,2),'b')
hold on
plot(TM1(:,1),TM1(:,2),'--b')
plot(TM2(:,1),TM2(:,2),'-.b')

plot(TE0(:,1),TE0(:,2),'r')
plot(TE1(:,1),TE1(:,2),'--r')

ylabel('n_e_f_f')
xlabel('w(ìm)')
legend('TE_0', 'TE_1', 'TE_2', 'TM_0', 'TM_1')
