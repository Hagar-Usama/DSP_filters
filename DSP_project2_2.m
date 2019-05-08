% MATLAB Project 2  part II[ DSP ]
% Author: Hagar Usama
% Created: 2018-12-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 20E+3;

t = 0:1/fs:0.1;

f1 = 0.1E+3;
f2 = 2E+3;
f3 = 7E+3;
 
s1 = sin(2*pi*t*f1);
s2= sin(2*pi*t*f2);
s3= sin(2*pi*t*f3);

s=  s1 + s2 + s3;

subplot(2,2,1)
plot(t,s);
title('triple tone signal in time domain x(t)')

h = [1.0000 0.7303 0.5334  0.3895  0.2845  0.2077  0.1517  0.1108  0.0809  0.0591];
g = [0.0432 0.0315 0.023 0.0168 0.0123 0.009 0.0065 0.0048 0.0035 0.0026 0.0019];
h = [h g];
g= [0.0014 0.001 0.0007];
h = [h g];

y = filter(h,1,s); % 1 >> FIR


subplot(2,2,3)
plot(t,y);

title('triple tone signal in time domain y(t)')


n1 = linspace(-fs/2,fs/2,length(t));
Y3 = fft(y/fs);
Y3 = fftshift(Y3);
Y3_mag = abs(Y3);

subplot(2,2,2)
grid on;
plot(n1 , Y3_mag); 
title('Filtered Signal in frequency domain')

Y4 = fft(s/fs);
Y4 = fftshift(Y4);
Y4_mag = abs(Y4);

subplot(2,2,4)
grid on;
plot(n1 , Y4_mag); 
title('Signal in frequency domain')

%figure
%u =1:length(h);
%plot(u , h);
