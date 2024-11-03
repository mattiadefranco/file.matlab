clear
clc
close all

n=3;

A = [0.2 0.4 2;
    0 0.3 0.4;
    0 0 1];

b = [1 0 0]';
C = [1 1 1];

T=1000;

x = zeros(n,T);
y = zeros(1,T);

x0 = rand(n,1);

x(:,1) = x0;

for kk=1:T-1
    x(:,kk) = A*x(:,kk) + b*rand(1);
    y(:,kk) = C*x(:,kk);
end

plot(y,'LineWidth',2);


