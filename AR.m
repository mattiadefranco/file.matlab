clear
clc
close all

load data_AR.mat

figure(1)
plot(y)

figure(2)
autocorr(y)

figure(3)
parcorr(y)

N=2000;
n_D = 3;

PHI = zeros(N-n_D,n_D);

for kk=1:n_D
    PHI(:,kk)=y(n_D+1-kk:N-kk);
end

theta_AR = PHI\y(n_D+1:N)
y_hat = PHI*theta_AR;
err = y(n_D+1:N)-y_hat;

figure(4)
autocorr(err)
title('autocorr rimasti')

[H,P] = lbqtest(err);

if H==0 && P<0.95
    disp('non rigetto la statistica');
else
    disp('rigetto la statistica');
end

y_val = y(N+1:end);
PHI_val = zeros(length(y_val)-n_D,n_D);

for kk=1:n_D
    PHI_val(:,kk) = y_val(n_D+1-kk:end-kk);
end

y_hat_val = PHI_val * theta_AR;
err_val = y_val(n_D+1:end)-y_hat_val;

figure(5)
autocorr(err_val)
title('autocorr err valutazione')

[H_val,P_val]=lbqtest(err_val);

if H_val==0 && P_val<0.95
    disp('non rigetto la statistica');
else
    disp('rigetto la statistica');
end
