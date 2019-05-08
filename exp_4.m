% MATLAB Project 1.4 [ DSP ]
% Author: Hagar Usama
% Created: 2018-12-20
%%%%%%%%%%%%%%%%%%%%%%%%%%% input a sound file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[y,fs] = audioread('what-1.wav');
%display(fs)
%sound(y, fs);	

time=(1:length(y))/fs;	
figure;
subplot(2,2,1)
plot(time, y);
title('Original Sample in time domain')

n2 = linspace(-fs/2,fs/2,length(time));
Y2 = fft(y/fs);
Y2 = fftshift(Y2);
Y2_mag = abs(Y2);

subplot(2,2,2)
plot(n2 , Y2_mag); % H(w)
title('Original Sample in frequency domain')
xlim([-10000 10000])

%%%%%%%%%%%%%%%%%%%%%%%%%%%  impulse response %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

impulse = zeros(1,length(time));
impulse(1) =1;
impulse(44000) =0.5;

%stem(time , impulse);

numa = [ 1 , 0.5];
dena = 1;

y_fil = filter(numa , dena ,y);

%%%% playing filtered sound
sound(y_fil , fs);


n2 = linspace(-fs/2,fs/2,length(time));
Y2 = fft(y_fil/fs);
Y2 = fftshift(Y2);
Y2_mag = abs(Y2);

subplot(2,2,4)
grid on;
plot(n2 , Y2_mag); % H(w)
title('Modified Sample using filter')
xlim([-10000 10000])
%%%% freq response H(w) is now higher whereas amplitude in some case is lower

%wavwrite(y,fs,'new_what');
audiowrite('new_what.wav',y_fil,fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% bonus %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% fc is the cutoff frequency, you can change as you like
% I chose 4000 so frequency will not exceed 4000 HZ :)
fc =4000;
[b,a] = butter(7,fc/(fs/2));
bonus = filter(b,a,y);


subplot(2,2,3)
grid on;
plot(time , bonus); % H(w)
title('Modified Sample using filter')



n2 = linspace(-fs/2,fs/2,length(time));
Y2 = fft(bonus/fs);
Y2 = fftshift(Y2);
Y2_mag = abs(Y2);
figure;
subplot(2,2,1:2)
grid on;
plot(n2 , Y2_mag); % H(w)
title('My lowpass filter <bonus>')
xlim([-5000 5000])

sound(bonus, fs);

% telephone effect : telephone bandwidth 300 - 3400 Hz 