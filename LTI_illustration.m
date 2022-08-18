clc;
clear all;

start_time = -100;
sampling_time = 0.1;
stop_time = 100;
time = (start_time:sampling_time:stop_time);
k = (2*start_time:sampling_time:2*stop_time);

h =cos(time); %define impulse response of the system
x = (time>0); %input signal#1
y = (time>0).*(time<10); %input signal#2
precision = 0.0001; %the precision we need to call the system LTI

a=2;
b=3;
s = x.*a + y.*b;
conv_s = conv(h, s);

conv_x = conv(h, x);
conv_y = conv(h, y);
conv_axby = conv_x.*a + conv_y.*b;

figure;

subplot(4,1,1);
plot(k, conv_x);

subplot(4,1,2);
plot(k, conv_y);

subplot (4,1,3);
plot(k, conv_s);

subplot(4,1,4);
plot(k, conv_axby);

islti = 1;
for i=1:length(conv_s)
    if (abs(conv_s(i)-conv_axby(i))>precision)
        islti = 0;
    else
    end
end

if (islti==1)
    disp('system is Linear');
else
    disp('system is Non Linear');
end

 



