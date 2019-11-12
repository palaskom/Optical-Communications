%% z=0: Time & Frequency domain

% x -> time domain
% X -> frequency domain

clear;clc
A = 1;
sigma = 20*1e-12;
b2 = -2.1*1e-26;
z = 40000; % distance
NFFT = 2^11;

% Fs choice: satisfies the follow creteria:
%   1. length(t) = NFFT 
%   2. Fs: (1 -> 2)*1e12 
Fs = NFFT/(50*sigma);
t = -25*sigma:1/Fs:25*sigma; %time base

var = sigma^2;
x_t0 = A*exp(-t.^2/(2*var));
L = length(x_t0);

figure
subplot(2,1,1)
plot(t,x_t0,'b');
title(['Gaussian Pulse \sigma=', num2str(sigma),'s']);
xlabel('Time[s]');
ylabel('Amplitude');
xlim([-4*sigma 4*sigma])
 

% Fourier of input pulse
Xin_0 = fftshift(fft(x_t0,NFFT));
f = Fs*(-NFFT/2:NFFT/2-1)/NFFT; %Frequency Vector

subplot(2,1,2)
plot(f,abs(Xin_0)/max(Xin_0),'r');
title('Normalized Magnitude of FFT');
xlabel('Frequency (Hz)')
ylabel('Magnitude |X(f)|');
xlim([-0.4*1e11 0.4*1e11])

%% Plot theoretical & fft Xin_0
figure
plot(f,abs(Xin_0)/max(Xin_0),'b')
xlim([-0.4*1e11 0.4*1e11])
hold on
Xin_theoretical = A*sigma*sqrt(2*pi)*exp(-2*pi^2*var*f.^2);
plot(f,Xin_theoretical/max(Xin_theoretical),'r')
xlim([-0.4*1e11 0.4*1e11])


%% Pulse in Time Domain - distance 'z'
Xout = Xin_0.*exp(1i*2*pi^2*b2*z*f.^2);
x_tz_ifft = ifft(ifftshift(Xout));

a = var^2 + (b2*z)^2;
s = var + (b2*z)^2/var;
DT = (1/Fs)*(-NFFT/2:NFFT/2-1);
tout = linspace(-5*sqrt(s),5*sqrt(s),NFFT);
x_tz_theoretical = ((A*sigma)/a^0.25)*exp(-(sigma*tout).^2/(2*a));

figure
plot(DT,abs(x_tz_ifft),'r')
hold on
plot(tout,x_tz_theoretical,'b')
xlim([-5*sqrt(s) 5*sqrt(s)])
