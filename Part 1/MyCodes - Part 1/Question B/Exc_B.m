n = 5;
m = 4;

x = randn(n,1);
y = randn(m,1);

c1 = conv(x,y);

Y = toeplitz([y; zeros(n-1,1)], [y(1), zeros(1,n-1)]);
c2 = Y*x;

% C = circulant(y);

% x = x';
% y = y';
% C = toeplitz([y(1) fliplr(y(end-length(x)+2:end))], y);
% c3 = x*C;

xfft = [x; zeros(m-1,1)];
yfft = [y; zeros(n-1,1)];
c4 = ifft(fft(xfft).*fft(yfft));
