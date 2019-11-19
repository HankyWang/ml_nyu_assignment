% load data from .mat file
load('shoesducks.mat')

% randomly split the training and testing set
n = randperm(size(X,1));
test_size = round(size(X,1)*0.5);
X_train = X(n(1:test_size), :);
Y_train = Y(n(1:test_size), :);
X_test  = X(n(test_size:end), :);
Y_test  = Y(n(test_size:end), :);


% choose the kernel we want to experiment on
kernal = 'rbf'; %'linear','rbf','poly'

% p1 stands for polynominal order when using poly kernel, stands for sigma when using rbf kernel. 
global p1;
p1 = 0.25;

% record the performances changes
c_list      = [];
p1_list      = [];
nsv_list    = [];
alpha_list  = [];
margin_list = [];
acc_list    = [];

% Experiment the value of C
for i=1:15
    if i<=8
        c = 0.1^(8-i);
    else
        c = c+1;
    end
    [nsv, alpha, bias, margin] = svc(X_train, Y_train, kernal, c);
    err = svcerror(X_train, Y_train, X_test, Y_test, kernal, alpha, bias);
    c_list = [c_list c];
    nsv_list =[nsv_list nsv];
    alpha_list=[alpha_list sum(alpha)];
    margin_list=[margin_list margin];
    acc_list=[acc_list 1-err/72];
end


% Draw
figure('Name','rbf(sigma=1)')
subplot(2,2,1)
plot(1:15,nsv_list)
xticks(1:15)
xticklabels(c_list)
ylabel('# of support vectors')
title('C/NSV')
subplot(2,2,2)
plot(1:15, alpha_list)
xticks(1:15)
xticklabels(c_list)
ylabel('Sum of alphas')
title('C/Aplha')
subplot(2,2,3)
plot(1:15, margin_list)
xticks(1:15)
xticklabels(c_list)
ylabel('Margin')
title('C/Margin')
subplot(2,2,4)
plot(1:15, acc_list)
xticks(1:15)
xticklabels(c_list)
ylabel('Accuracy(%)')
title('C/Accuracy')


% Experiment the value of polynominal order and rbf sigma values
% for i=1:15
%     p1 = 1+0.5*(i-1);
%     [nsv, alpha, bias, margin] = svc(X_train, Y_train, kernal, 1);
%     err = svcerror(X_train, Y_train, X_test, Y_test, kernal, alpha, bias);
%     p1_list = [p1_list p1];
%     nsv_list =[nsv_list nsv];
%     alpha_list=[alpha_list sum(alpha)];
%     margin_list=[margin_list margin];
%     acc_list=[acc_list 1-err/72];
% end
% 

% Draw
% figure('Name','rbf(sigma=1)')
% subplot(2,2,1)
% plot(1:15,nsv_list)
% xticks(1:15)
% xticklabels(p1_list)
% ylabel('# of support vectors')
% title('Order/NSV')
% subplot(2,2,2)
% plot(1:15, alpha_list)
% xticks(1:15)
% xticklabels(p1_list)
% ylabel('Sum of alphas')
% title('Order/Aplha')
% subplot(2,2,3)
% plot(1:15, margin_list)
% xticks(1:15)
% xticklabels(p1_list)
% ylabel('Margin')
% title('Order/Margin')
% subplot(2,2,4)
% plot(1:15, acc_list)
% xticks(1:15)
% xticklabels(p1_list)
% ylabel('Accuracy(%)')
% title('Order/Accuracy')

