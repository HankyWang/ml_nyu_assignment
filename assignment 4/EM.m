function [like1,like2,alpha,mix]=EM(x_train,x_test, M,maxiter)
N=size(x_train,1);
D=size(x_train,2);
like1=[];
like2=[];
thresh=1e-5;
converged=0;
iter=0;
prev=-inf;
mix = ones(M)/M;
h=0;
for m = 1:M
    h = h+m;
end
for m = 1:M
    alpha(m) = m/h;
end
if M==1
    alpha(M)=0.99999;
end
nx_train = (sum(x_train'))';
nx_test = (sum(x_test'))';
while (iter<maxiter) & ~converged
  for i=1:M
    for n=1:N
      tau(n,i) = mix(i)*alpha(i)^nx_train(n)*(1-alpha(i))^(D-nx_train(n));
    end
  end
  for n=1:N
    l=sum(tau(n,:));
    tau(n,:)=tau(n,:)/l;
  end
  for i=1:M
    sumtau=sum(tau(:,i));
    alpha(i) = sum(tau(:,i).*nx_train)/D/sumtau;
    mix(i)=sumtau/N;
  end
  lh1=0;
  lh2=0;
  for n=1:N
    tp1=0;
    tp2=0;
    for i=1:M
        tp1=tp1+ mix(i)*alpha(i)^nx_train(n)*(1-alpha(i))^(D-nx_train(n));
        tp2=tp2+ mix(i)*alpha(i)^nx_test(n)*(1-alpha(i))^(D-nx_test(n));
    end
    lh1 = lh1 + log(tp1);
    lh2 = lh2 + log(tp2);
  end
  if (lh1-prev<thresh)
    converged=1;
    disp(iter);
    disp("coverged");
  end
  prev = lh1;
  like1 = [like1 lh1];
  like2 = [like2 lh2];
  iter=iter+1;
end

    
    
    
    
