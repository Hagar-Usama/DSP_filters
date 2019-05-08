% MATLAB Project 1 [ signals ]
% Author: Hagar Usama
% Created: 2018-11-24

%%%%%%%%%%%%%%%%%%%%%%%%% Welcome & Instructions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

welcome();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Taking Inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = [];
t1 = [];

x2 = [];
t2 = [];
flag = 0;

fprintf("**************m(t)*************\n");

prompt = 'Enter sampling Frequency >> ';
    sample_freq = input(prompt);

prompt = 'Enter Start Point >> ';
    start_point = input(prompt);
    %start = start_point;
prompt = 'Enter End Point >> ';
    end_point = input(prompt);

prompt = 'Enter # of break-points >> ';
    bk_num = input(prompt);
    
bk = zeros(bk_num);
 
 for i = 1: length(bk)
  fprintf('Break-point #%i position', i);
  prompt = '>> ';
  bk(i) = input(prompt);   
 end
 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  for i = 1:length(bk)
    fprintf('Select input #%i', i);
    prompt = ' >> ';
    input1 = input(prompt);
  [a ,b] =  select_signal(input1 , start_point , bk(i) , sample_freq );
        t1 = [t1 a];
        x1 = [x1 b];
    start_point = bk(i);
    
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Taking last one %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  fprintf('Select input #%i', i+1);
  prompt = ' >> ';
  input1 = input(prompt);
  [a, b] = select_signal(input1 , bk(length(bk)) , end_point , sample_freq );
    t1 = [t1 a];
    x1 = [x1 b];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% repeating steps for impulse response %%%%%%%%%%%%%%%%%%%


fprintf('**************h(t)*************\n');

%prompt = 'Enter sampling Frequency >> ';
    %sample_freq = input(prompt);


prompt = 'Enter Start Point >> ';
    start_point = input(prompt);
    %start = start_point;
prompt = 'Enter End Point >> ';
    end_point = input(prompt);

prompt = 'Enter # of break-points >> ';
    bk_num = input(prompt);

bk = [];    
bk = zeros(bk_num);
 
 for i = 1: length(bk)
  fprintf('Break-point #%i position', i);
  prompt = '>> ';
  bk(i) = input(prompt);   
 end
 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  for i = 1:length(bk)
    fprintf('Select input #%i', i);
    prompt = ' >> ';
    input1 = input(prompt);
  [a ,b] =  select_signal(input1 , start_point , bk(i) , sample_freq );
        t2 = [t2 a];
        x2 = [x2 b];
    start_point = bk(i);
    
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Taking last one %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  fprintf('Select input #%i', i+1);
  prompt = ' >> ';
  input1 = input(prompt);
  [a, b] = select_signal(input1 , bk(length(bk)) , end_point , sample_freq );
    t2 = [t2 a];
    x2= [ x2 b];
   

%%%%%%%%%%%%%%%%%%%%%%%% Adding Noise %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y = conv(x1,x2);
prompt = 'Enter Sigma to generate noise (0 if no noise) >> ';
    sigma = input(prompt);
    noise = 0.01*sigma*randn(1,length(y));
y = y + noise;  %% adding noise to y(t)

%%%%%%%%%%%%%%%%%%%%%%%% getting y(t) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% y = conv(x1,x2);
conv_t_start = t1(1)+t2(1);
conv_t_end = t1(length(x1)) + t2(length(x2)) ;
conv_t = linspace(conv_t_start,conv_t_end,length(y));

figure;
grid on;
subplot(2,2,1)
plot(conv_t , y); % m(t) * h(t)


%%%%%%%%%%%%%%%%%% Getting m(t) using deconv (noise added) %%%%%%%%%%%%%%%%%%%%%

% deconv ( y(t) , h(t) )
h= x2;

if(h(1) == 0)
h(1) = [];
%%printf('non-zero now\n');
flag = 1;
end

[q,r] = deconv(y,h); % q is m(t) with noise
%%a = deconv(y,x1);

tq = t1;
if(flag)
q(1) = [];
tq(1) = [];
end

subplot(2,2,2)
grid on;
plot(tq,q); % m(t) from deconv

%%%%%%%%%%%%%%%%%%%%%%%% plotting time domain %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,3)
grid on;
plot(t1,x1); % m(t)

subplot(2,2,4)
plot(t2,x2); % h(t)

xlabel('t')
ylabel('y(t)')
grid on;
%%%%%%%%%%%%%%%%%%%%%%%% plotting Frequency domain %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Fs = sample_freq;
n = linspace(-Fs/2,Fs/2,length(t1));
X1 = fft(x1/Fs);
X1 = fftshift(X1);
X1_mag = abs(X1);
figure;
grid on;
subplot(2,2,1)
plot(n , X1_mag); % M(w)
xlabel('f')
ylabel('|X1|')
grid on;

n2 = linspace(-Fs/2,Fs/2,length(t2));
X2 = fft(x2/Fs);
X2 = fftshift(X2);
X2_mag = abs(X2);

subplot(2,2,2)
grid on;
plot(n2 , X2_mag); % H(w)



%Y_angle = angle(Y);
%figure;
%plot(n,Y_angle)
%xlabel('f')
%ylabel('<Y')
%grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Exp #3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


num = [1];
den = [1 0.5 0.5 ];
prompt = 'Enter numerator of Transfer Fucntion>> ';
   num= input(prompt);
prompt = 'Enter denominator of Transfer Fucntion>> ';
    den = input(prompt);

x_fil = filter(num , den ,q);

% reverse sys (ricoprocal of tf1)
num2 = den;
den2 = num;

%%%%%%%%%%%%% checking stability %%%%%%%%%%%%%%%%%%%%%%%%
%% unfortunately not available on octave
[k1,v] = tf2latc(num,den);
  k1 = abs(k1);
[k2,v] = tf2latc(num2,den2);
  k2 = abs(k2);
if(k1 < 1)
  fprintf('System 1 is stable\n');
end  
if(k2 < 1)
  fprintf('System 2 (recover) is stable\n');
end  

 figure;
 subplot(2,2,1)
 plot(tq , x_fil);
 
 x_fil_rev = filter(num2 , den2 ,x_fil);
 subplot(2,2,3)
 plot(tq,x_fil_rev);
 
n3 = linspace(-Fs/2,Fs/2,length(tq));
X3 = fft(x_fil/Fs);
X3 = fftshift(X3);
X3_mag = abs(X3);

subplot(2,2,2)
grid on;
plot(n3 , X3_mag); % filtered m(t) using diff equation

X3 = fft(x_fil_rev/Fs);
X3 = fftshift(X3);
X3_mag = abs(X3);

subplot(2,2,4)
grid on;
plot(n3 , X3_mag); % filtered m(t) using diff equation


sys1 = tf(num,den,0.001,'variable','z^-1');
sys2 = tf(den,num,0.001,'variable','z^-1');

figure
subplot(2,2,1)
pzmap(sys1);
subplot(2,2,2)
pzmap(sys2);
subplot(2,2,3)
impulse(sys1);
subplot(2,2,4)
impulse(sys2);
bode(sys1);
bode(sys2);