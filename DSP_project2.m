% MATLAB Project 2 [ DSP ]
% Author: Hagar Usama
% Created: 2018-12-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Part I %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%  1-3   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = 16E+3;
t = 0:1/fs:1;
%t2 = 1:1/fs:2;

f1 = 3E+3;
f2 = 5E+3;

%noise = 2*randn(1,length(t));
 
s1 = sin(2*pi*t*f1);
s2= sin(2*pi*t*f2);

s=  s1 + s2;
sound(s , fs);

n1 = linspace(-fs/2,fs/2,length(t));
Y1 = fft(s/fs);
Y1 = fftshift(Y1);
Y1_mag = abs(Y1);
figure;
subplot(2,2,1)
grid on;
plot(n1 , Y1_mag); 
title('dual tone signal in frequency domain')


subplot(2,2,2)
specgram(s);

subplot(2,2,4);
pspectrum(s)


fc =4000;
[b,a] = butter(3,fc/(fs/2));
% order is low so accuracy is low, the higher the better
% on increasing the order,the frequency > 4000 will vanish
s_mod = filter(b,a,s);

Y2 = fft(s_mod/fs);
Y2 = fftshift(Y2);
Y2_mag = abs(Y2);


subplot(2,2,3)
grid on;
plot(n1 , Y2_mag); 

title('Modified Signal using filter')


sound(s_mod , fs);

%%%% 4- 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y,Fs] = audioread('you-call-that-fun.wav');
sound(y, Fs);	
time=(1:length(y))/Fs;	
figure;
subplot(2,2,1)
plot(time, y);
title('Original Signal in time domain')


n1 = linspace(-Fs/2,Fs/2,length(time));
Y3 = fft(y/Fs);
Y3 = fftshift(Y3);
Y3_mag = abs(Y3);

subplot(2,2,2)
grid on;
plot(n1 , Y3_mag); 
title('Signal in frequency domain')

subplot(2,2,3);
specgram(y(:,1))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc =4000;
[b,a] = butter(3,fc/(Fs/2));
% order is low so accuracy is low, the higher the better
% on increasing the order,the frequency > 4000 will vanish
y_mod = filter(b,a,y);
n1 = linspace(-Fs/2,Fs/2,length(time));
Y4 = fft(y_mod/Fs);
Y4 = fftshift(Y4);
Y4_mag = abs(Y4);

subplot(2,2,4)
grid on;
plot(n1 , Y4_mag); 
title('filtered voice signal in frequency domain')
%sound(y_mod, Fs);	