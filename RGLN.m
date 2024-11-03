clear
clc
close all

load data_2d.mat

data.set = length(y);
N_train = round(0.8*data.set);
N_test = round(0.2*data.set);

figure;
scatter(X,y,'Filled');
hold on;

x_train = X(1:N_train,:);
x_test = X(N_train+1:end,:);

y_train = y(1:N_train,:);
y_test = y(N_train+1:end,:);


PHI_train = [x_train ones(N_train,1)];
PHI_test = [x_test ones(N_test,1)];

theta_ls = PHI_train\y_train;

%statistiche del training
y_hat = PHI_train*theta_ls;
err_train = y_hat - y_train(:);
TSS_train = sum(y_train - mean(y_train).^2);
RSS_train = sum(err_train.^2);
Rsq_train = 1-TSS_train/RSS_train;
Mse_train = RSS_train/N_train;

%statistiche del test set
y_pred = PHI_test*theta_ls;
err_test = y_pred - y_test(:);
TSS_test = sum(y_test - mean(y_test).^2);
RSS_test = sum(err_test.^2);
Rsq_test = 1-RSS_test/TSS_test;
Mse_test = mean(err_test.^2);

%plottiamo la retta di regressione
plot(x_train,y_hat,'r','LineWidth',2);
xlabel('Feature')
ylabel('Target')
hold off;

