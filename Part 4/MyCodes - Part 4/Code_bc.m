%% Parameter initialization
clear;clc
    V = 1.5e-16;
    N0 = 1.5e8;
    G = 0.4;
    b = 0.01;
    tc = 1e-9;
    tp = 3e-12;
    eNL = 3.33e-7;
    s0 = 2.5e-20;
    L = 300e-6;
    c = 3e8;
    vg = c/3.527;
    g0 = s0*vg;
    R = 0.3;
    lamda = 1.55e-6;
    e = 1.6021e-19; 
    h = 6.626e-34;
    
Nth = N0 + V/(G*g0*tp);
Ith = e*Nth/tc;

%% Rectangular Pulse p(t) - 2ns
tpulse = 0:0.01:10;
pulse = zeros(1,length(tpulse));
pulse(find(tpulse==2):find(tpulse==4)) = 1;
tpulse = tpulse*1e-9;
figure, plot(tpulse,pulse)

%% Train Pulse p(t) 
N = 5;
p = PRBS(N);
num_pulse = 2^N-1;
% 5Gbps -> 200ps  % 10Gbps -> 100ps
T_pulse = 100; % [ps] 
tpulse = 1:num_pulse*T_pulse;
r = length(tpulse)/2;
pulse = ones(1,length(tpulse));

index = find(p==0);
for i = 1:length(index)
    k = T_pulse*index(i)-(T_pulse-1) : T_pulse*index(i);
    pulse(k) = 0;
end

pulse = [zeros(1,r) pulse zeros(1,r)]; % pulse train
tpulse = [-(r-1):0 tpulse (length(tpulse)+1):(length(tpulse)+r)];
tpulse = (tpulse-1)*1e-12; % time
figure, plot(tpulse,pulse,'b')
xlabel('Time[s]'), ylabel('Amplitude')
title('IN - Pulse Train')

%% I(t)
Im = 1.4*Ith;
Ib = 1.1*Ith;
I = Ib + Im*pulse;
figure, plot(tpulse,I)

%% Pe(t)-t  &  N(t)/Nth-t
NP0 = [2e8 2e5];
[tdiff,NPdiff] = ode45(@(t,NP) odefcn(t,NP,I,tpulse),[tpulse(1) tpulse(end)],NP0);
Pe = vg*log(1/R)*h*c*NPdiff(:,2)/(2*L*lamda);

figure
yyaxis left, plot(1e9*tpulse,I)
yyaxis right, plot(1e9*tdiff,Pe)
xlabel('t[ns]'), legend('I(t)','P_e(t)')
title(['B_T = ' num2str(1e3/T_pulse) 'Gbps'])

figure
yyaxis left, plot(1e9*tpulse,I)
yyaxis right, plot(1e9*tdiff,NPdiff(:,1)/Nth)
xlabel('t[ns]'), legend('I(t)','N(t)/N_t_h')
title(['B_T = ' num2str(1e3/T_pulse) 'Gbps'])
grid on


%% eye diagramm
dt = abs(tpulse(2)-tpulse(1));

eyePe = interp1(tdiff,Pe,tpulse);
% eyediagram(eyePe(120:end),round(T_pulse*1e-12/dt)) % 2.5Gbps
% eyediagram(eyePe(100:end),round(T_pulse*1e-12/dt)) % 5Gbps
eyediagram(eyePe(40:end),round(T_pulse*1e-12/dt)) % 10Gbps

title(['B_T = ' num2str(1e3/T_pulse) 'Gbps'])
ylim([-0.0001 0.02])
