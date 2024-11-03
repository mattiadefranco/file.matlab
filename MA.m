clear
clc
close all

load Data_MA.mat

figure(1)
plot(y_MA)

figure(2)
autocorr(y_MA)

figure(3)
parcorr(y_MA)

n_eq=15;
PHI_eq = zeros(length(y_MA)-n_eq,n_eq);
for kk=1:n_eq
    PHI_eq(:,kk)=y_MA(n_eq+1-kk:end-kk);
end

theta_eq = PHI_eq\y_MA(n_eq+1:end);
y_hat_eq = PHI_eq*theta_eq;
err_eq = y_MA(n_eq+1:end)-y_hat_eq;

figure(4)
autocorr(err_eq)

[H_eq,P_eq]=lbqtest(err_eq);

y_M=y_MA(n_eq+1:end);
n_N=3;
PHI_MA = zeros(length(y_M)-n_N,n_N);
for kk=1:n_N
    PHI_MA(:,kk)=y_M(n_N+1-kk:end-kk);
end

theta_MA = PHI_MA\(y_M(n_N+1:end)-err_eq(n_N+1:end))
