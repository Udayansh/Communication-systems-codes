close all
clearvars

start_time = -100;
sampling_time = 0.1;
stop_time = 1000;
time = (start_time:sampling_time:stop_time);
%if the convolution graphs is going out of bounds, 
% just increase the time limits

x=1.*(time>-20).*(time<20); %signal "x" with time limits as booleans
h=1.*(time>-10).*(time<10); %signal "h" with time limits as booleans

%zero padding both signals
len_x=length(x);
len_h=length(h);
y_len = len_h+len_x-1;
z_len = y_len;
X=[x,zeros(1,y_len-len_x)];
H=[h,zeros(1,y_len-len_h)];
G=fliplr(H);

%convolution of X and H using inbuilt function for checking purpose
C=conv(X,H);

%convolution of X and H using own code implementation of basic formula
for i=1:y_len
    Y(i)=0;
    Z(i)=0;
    for j=1:len_x
        if(i-j+1>0)
            Y(i)=Y(i)+X(j)*H(i-j+1);
            Z(i)=Z(i)+X(j)*G(i-j+1);
        else
        end
    end
end

%graph for signal X
figure;
subplot(5,1,1); 
plot(time, x); 
xlabel('t');
ylabel('X'); 
grid on;
title('signal X');

%graph for signal H
subplot(5,1,2); 
plot(time, h);
xlabel('t'); 
ylabel('H[n]'); 
grid on;
title('signal H');

%graph for signal Y (convolution using OWN code)
subplot(5,1,3); 
plot(time, Y(1:length(time)));
xlabel('t');
ylabel('Y[n]'); 
grid on;
title('convolution of Two Signals using own code');

%graph for signal C (convolution using inbuilt function)
subplot(5,1,4);
plot(time, C(1:length(time)));
xlabel('t');
ylabel('C[n]');
grid on;
title('convolution of signals using inbuilt conv() function');

%graph for signal Z (cross correlation using OWN code)
subplot(5,1,5); 
plot(time, Z(1:length(time)));
xlabel('t');
ylabel('Z[n]'); 
grid on;
title('cross-correlation of Two Signals using own code');