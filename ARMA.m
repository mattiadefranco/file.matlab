clear 
clc
close all

load data_ARMA.mat

figure(1)
plot(y_ARMA)

figure(2)
autocorr(y_ARMA)

figure(3)
parcorr(y_ARMA)

rho = autocorr(y_ARMA);
N=2000;
n_D=3;

for kk=1:n_D
    R(:,kk) = rho(n_D+1-kk:2*n_D+1-kk);
end

theta_AR = R\rho(n_D+1:2*n_D+1);
PHI_AR = zeros(length(y_ARMA)-n_D,n_D);

for kk=1:n_D
    PHI_AR(:,kk)=y_ARMA(n_D+1-kk:end-kk);
end

y_hat = PHI_AR*theta_AR;
my_eta = y_ARMA(n_D+1:end)-y_hat;

figure(4)
autocorr(my_eta)

figure(5)
parcorr(my_eta)

%Modello MA

n_eq=15;

PHI_eq = zeros(length(my_eta)-n_eq,n_eq);
for kk=1:n_eq
    PHI_eq(:,kk) = my_eta(n_eq+1-kk:end-kk);
end

theta_eq = PHI_eq\my_eta(n_eq+1:end);
y_hat_eq = PHI_eq*theta_eq;
err_eq = my_eta(n_eq+1:end)-y_hat_eq;

figure(6)
autocorr(err_eq)

my_eta_MA = my_eta(n_eq+1:end);
n_N=3;

PHI_MA = zeros(length(my_eta_MA)-n_N,n_N);
for kk=1:n_N
    PHI_MA(:,kk) = my_eta_MA(n_N+1-kk:end-kk);
end

theta_MA = PHI_MA\(my_eta_MA(n_N+1:end)-err_eq(n_N+1:end))
