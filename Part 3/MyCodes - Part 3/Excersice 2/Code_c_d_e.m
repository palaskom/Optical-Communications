%% time domain: in-pulses
clear; clc;

% constants
N = 6;
p = PRBS(N);
A0 = 1;
num_pulses = 2^N-1; 
NFFT = 2^14;
b2 = -2.1*10^-26;

%---------------change-------------------%

z = 80e3;
b3 = 1e4*1.3*1e-40;
% (c)
sigma = 20e-12; 
T = 10^-10; 
% (d)
% sigma = sqrt(abs(b2)*z/2);  
% T = 4*sqrt(abs(b2)*z);

%----------------------------------------%

% Pulse train 
t_end = 2*num_pulses*T;
f = NFFT/(50*sigma);
t_gaus = -30*sigma:1/f:30*sigma;
t_shift = linspace(0,t_end,NFFT);
dt = abs(t_shift(2)-t_shift(1));
Fs = 1/dt;

var = sigma^2;
gaus_pulse = A0*exp(-t_gaus.^2/(2*var));
d = [0:T:(num_pulses-1)*T ; p]';

xin = pulstran(t_shift,d,gaus_pulse,f);
first_max = find(xin>0.999 & xin<1);
t = t_shift - t_shift(first_max(1)); 

figure
plot(t,xin)
xlim([t(1) 7e-9])
% xlim([t(1) 11e-9])
title(['Gaussian Train IN-Pulses \sigma=', num2str(sigma),'s']);
xlabel('Time[s]')
ylabel('Amplitude')

%% Frequency domain: in-pulse
Xin = fftshift(fft(xin,NFFT));
f = Fs*(-NFFT/2:NFFT/2-1)/NFFT; %Frequency Vector
figure
plot(f,abs(Xin),'r')
title('Magnitude of FFT');
xlabel('Frequency (Hz)'), ylabel('Magnitude |X(f)|');
xlim([0 3e10])

%% Time Domain: out-pulse -> distance 'z'

Xout = Xin.*exp(1i*z*(2*pi^2*b2*f.^2+(4/3)*pi^3*b3*f.^3));
xout = ifft(ifftshift(Xout));

figure
plot(t,xin,'b')
hold on, plot(t,abs(xout),'r')
% xlim([t(1) 11e-9])
xlim([t(1) 7e-9])
title('IN-OUT Pulses')
xlabel('Time[s]'), ylabel('Amplitude')
legend('x_i_n','x_o_u_t')

%% eye diagramm
ax = abs(xout);

% (c)
% eyediagram(ax(95:end),floor(T/dt+1)) % 40km 
eyediagram(ax(50:end),floor(T/dt+1)) % 80km 

% (d)
% eyediagram(ax,floor(T/dt+1)) % 40km & 80km

% ylim([-0.1 0.8])
ylim([-0.1 1])
title((sprintf('Eye Diagram (z = %dkm)', z/1e3)))

%% Pin - Pout
a = 0.18/4.343; % [1/km]
Pin = abs(xin).^2;
plot(t,Pin)

Pout = Pin*exp(-a*z/1e3);
hold on, plot(t,Pout)
xlabel('Time[s]'), ylabel('Power')
legend('P_i_n','P_o_u_t')
title(sprintf('z = %dkm', z/1e3))
xlim([t(1) 7e-9])

%%
b3 = 1*1.3*1e-40;
s1 = 1 + (b2*z/2/sigma^2)^2
s2 = s1 + (1/32)*(b3*z/sigma^3)^2

