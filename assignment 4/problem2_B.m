% Part B
load("problem2");

maxiter = 100;
p = randperm(1000);
x_train = dataset(p(1:500),:);
x_test  = dataset(p(501:1000),:);
train = [];
test = [];
for i=1:5
    [ltrain,ltest,alpha,mix]=EM(x_train, x_test, i, maxiter);
    n = size(ltrain', 1);
%     figure(i)
%     subplot(1,2,1);
%     plot(1:n,ltrain');
%     title(['train', 1]);
%     xlabel('iteration');
%     ylabel('likelihood');
    train = [train ltrain(1,n)];
%     subplot(1,2,2);
%     plot(1:n,ltest');
%     title(['test', 2]);
%     xlabel('iteration');
%     ylabel('likelihood');
    test = [test ltest(1,n)];
end

figure(6)
subplot(1,2,1)
plot(1:5,train);
title('train');
xlabel('K');
ylabel('likelihood');
subplot(1,2,2)
plot(1:5,test);
title('test');
xlabel('K');
ylabel('likelihood');