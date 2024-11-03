clear
clc
close all

load multi_regr_data3.mat

data.set = length(y);
N_train = round(0.7*data.set);
N_test = round(0.3*data.set);

x_train = x(1:N_train,:);
x_test = x(N_train+1:end,:);

y_train = y(1:N_train,:);
y_test = y(N_train+1:end,:);

w_train = w(1:N_train,:);
w_test = w(N_train+1:end,:);

z_train = z(1:N_train,:);
z_test = z(N_train+1:end,:);

PHI_train = [x_train w_train z_train ones(N_train,1)];
PHI_test = [x_test w_test z_test ones(N_test,1)];

theta_ls = PHI_train\y_train;

%statistiche del training
y_hat = PHI_train*theta_ls;
err_train = y_hat - y_train(:);
TSS_train = sum(y_train-mean(y_train).^2);
RSS_train = sum(err_train.^2);
Rsq_train = 1-RSS_train/TSS_train;
Mse_train = RSS_train/N_train;

%statistiche del test set
y_pred = PHI_test*theta_ls;
err_test = y_pred -y_test(:);
TSS_test = sum(y_test-mean(y_test).^2);
RSS_test = sum(err_test.^2);
Rsq_test = 1-RSS_test/TSS_test;
Mse_test = mean(err_test.^2);
