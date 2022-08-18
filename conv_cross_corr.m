clc;
close all;

start_time = -10;
sampling_time = 0.01;
stop_time = 10;
time = (start_time:sampling_time:stop_time);

k = 2*start_time:sampling_time:2*stop_time;

x=sin(time);
y=(time>0).*(time<10);
z=fliplr(y);

CV = myconvolution(x, y);
CV_IBF = conv(x, y);
CC = myconvolution(x, fliplr(y));

figure;
subplot(6, 1, 1);
plot(time, x);
title('x');

subplot(6, 1, 2);
plot(time, y);
title('y');

subplot(6, 1, 3);
plot(k, CV);
title('conv. using own code');

subplot(6, 1, 4);
plot(k, CV_IBF);
title('conv. using inbuilt function');


subplot(6, 1, 5);
plot(k, CC);
title('cross-correlation using own code');

