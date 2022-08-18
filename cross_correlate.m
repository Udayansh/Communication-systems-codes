clc;
close all;

start_time = -10;
sampling_time = 0.1;
stop_time = 10;
time = (start_time:sampling_time:stop_time);

x=sin(time);
y=(time>0);
z = fliplr(y);

l = length(x);
m = length(y);
n = length(z);

X = [x, zeros(1, n)];
Y = [y, zeros(1, l)];
Z = [z, zeros(1, l)];
CV_IBF = conv(X, Y);
CC_IBF = xcorr2(X, Y);

for i=1:l+m-1
    CV(i)=0;
    CC(i)=0;
    for j=1:l
        if ((i-j+1)>0)
            CV(i)=CV(i)+(X(j)*Y(i-j+1));
            CC(i)=CC(i)+(X(j)*Z(i-j+1));
        else
        end
    end
end

figure;
subplot(6, 1, 1);
plot(time, x);
title('x');

subplot(6, 1, 2);
plot(time, y);
title('y');

subplot(6, 1, 3);
plot(time, CV(1:length(time)));
title('conv. using own code');

subplot(6, 1, 4);
plot(time, CV_IBF(1:length(time)));
title('conv. using inbuilt function');


subplot(6, 1, 5);
plot(time, CC(1:length(time)));
title('cross-correlation using own code');

%subplot(6, 1, 6);
%plot(time, CC_IBF(1:length(time)));
%title('cross-correlation using inbuilt function');

