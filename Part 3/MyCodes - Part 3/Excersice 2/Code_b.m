%% time domain: in-pulses
clear;clc
T = 1e-10;
N = 3;
p = PRBS(N);
num_pulse = 2^N-1;
T_pulse = 100;
NFFT = 2^13; % NFFT>=2^13 for this code

t = 1:num_pulse*T_pulse;
r = (NFFT-length(t))/2;
xin = ones(1,length(t));

index = find(p==0);
for i = 1:length(index)
    k = 100*index(i)-99 : 100*index(i);
    xin(k) = 0;
end

xin = [zeros(1,r) xin zeros(1,r)]; % pulse train
t = [-(r-1):0 t (length(t)+1):(length(t)+r)];
t = (t-1)*1e-12; % time
dt = abs(t(2)-t(1));
L = length(xin);

figure, plot(t,xin,'b')
xlabel('Time[s]'), ylabel('Amplitude')
title('IN - Pulse Train')

%% Frequency domain: in-pulse
Xin = fftshift(fft(xin,NFFT));
Fs = 1e12;
f = Fs*(-NFFT/2:NFFT/2-1)/NFFT;

figure, plot(f,abs(Xin),'r') 
title('Magnitude of FFT')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X(f)|')
xlim([0 3e10])

%% Time Domain: out-pulse -> distance 'z'
b2 = -2.1*1e-26;
b3 = 1.3*1e-40;
z = 80e3;
Xout = Xin.*exp(1i*z*(2*pi^2*b2*f.^2+(4/3)*pi^3*b3*f.^3));
xout = ifft(ifftshift(Xout));

figure, plot(t,xin,'b') 
hold on, plot(t,abs(xout),'r')
title('IN-OUT Pulses')
xlabel('Time[s]'), ylabel('Amplitude')
legend('x_i_n','x_o_u_t')

%% eye diagram
eyediagram(abs(xout),floor(T/dt+1))
ylim([-0.1 1.5])
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
