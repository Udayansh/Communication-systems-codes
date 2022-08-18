%Cross_Correlation without Using corr(A,B)
clc;
close all;

%first sequence
x=input('Enter x\n');
l1=input('Enter the lower limit:\n');
u1=input('Enter the upper limit:\n');
x1=l1:1:u1;%limit of sequence x(n)

%second sequence
y=input('Enter h:\n');
l2=input('Enter the lower limit:\n');
u2=input('Enter the upper limit:\n');
y1=l2:1:u2;%limit of sequence h(n)

z=fliplr(y);% elements flipped left to right
l3=-u2;%lower limit of y(-n)
u3=-l2;%upper limit of y(-n)
h3=l3:1:u3;%limit of y(-n)

l=l1+l3;
u=u1+u3;

a=l:1:u;%limit of output sequence y(n)

m=length(x);%length of sequence x(n)
n=length(z);%length of sequence h(n)

X=[x,zeros(1,n)];
subplot(311)
disp('x(n) is:')
disp(x)
stem(x1,x)
xlabel('n')
ylabel('x(n)')
title('First Sequence')
grid on;

Y=[y,zeros(1,m)];
Z=[z,zeros(1,m)];

subplot(312)
disp('z(n) is:')
disp(z)
stem(h3,z)
xlabel('n')
ylabel('z(n)')
title('Second folded Sequence')
grid on;

for i=1:n+m-1
    A(i)=0;
    for j=1:m
        if((i-j+1)>0)
            A(i)=A(i)+(X(j)*Z(i-j+1));
        else
        end
    end
end

subplot(313)
disp('y(n) is:')
disp(A)
stem(a,A)
xlabel('n')
ylabel('y(n)')
title('Output Sequence')
grid on;