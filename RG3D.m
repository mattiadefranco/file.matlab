clear
clc
close all

load data_3d.mat

data.set = length(y);
N_train = round(0.8*data.set);
N_test = round(0.2*data.set);

figure
scatter3(X(:,1),X(:,2),y,'Filled');
hold on;

x_train = X(1:N_train,:);
x_test = X(N_train+1:end,:);
y_train = y(1:N_train,:);
y_test = y(N_train+1:end,:);

PHI_train = [x_train(:,1) x_train(:,2) ones(N_train,1)];
PHI_test = [x_test(:,1) x_test(:,2) ones(N_test,1)];
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
err_test = y_pred - y_test(:);
TSS_test = sum(y_test-mean(y_test).^2);
RSS_test = sum(err_test.^2);
Rsq_test = 1-RSS_test/TSS_test;
Mse_test = mean(err_test.^2);

%plottiamo il piano di regressione

a = linspace(min(X(:,1)),max(X(:,1)),50)';
b = linspace(min(X(:,2)),max(X(:,2)),50)';
[xx,yy] = meshgrid(a,b);
Z = reshape ([xx(:),yy(:),ones(size(xx(:)))]*theta_ls,numel(a),[]);

surf(xx,yy,Z,'FaceAlpha',0.5,'EdgeColor','none');
xlabel('Feature 1')
ylabel('Feature 2')
zlabel('Target')
hold off;
