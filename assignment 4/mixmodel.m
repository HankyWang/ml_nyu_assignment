function [like,mu,covar,mix]=mixmodel(inputs,M,maxiter)
%
% function [like,mu,covar,mix]=mixmodel(inputs,M,maxiter)
%
% inputs = training data as D dimensional row vectors
% M = number of Gaussians to fit
% maxiter = max number of iterations
% like = vector of log likelihoods at each iteration
%
N=size(inputs,1);
D=size(inputs,2);
like=[];
thresh=1e-6;
converged=0;
iter=0;
ll=-inf;
[mu,covar,mix]=randInit(inputs,M);
while (iter<maxiter) & ~converged
  prev=ll;
  ll=0;
  for i=1:M
    detcov = det(covar(D*(i-1)+1:D*(i-1)+D,:));
    invcov = inv(covar(D*(i-1)+1:D*(i-1)+D,:)+1e-6*eye(D));
    for n=1:N
      tau(n,i) = mix(i)*(2*pi)^(-D/2)*detcov^(-.5)*exp(-.5*(inputs(n,:)-mu(i,:))*invcov*(inputs(n,:)-mu(i,:))');
    end
  end
  for n=1:N
    l=sum(tau(n,:));
    tau(n,:)=tau(n,:)/l;
    ll=ll+log(l);
  end
  if (ll-prev<thresh)
    converged=1;
  end
  like=[like ll];
  for i=1:M
    sumtau=sum(tau(:,i));
    mu(i,:)=0;
    for n=1:N
      mu(i,:) = mu(i,:) + tau(n,i)*inputs(n,:);
    end
    mu(i,:)=mu(i,:)/sumtau;
    covar(D*(i-1)+1:D*(i-1)+D,:)=0;
    for n=1:N
      covar(D*(i-1)+1:D*(i-1)+D,:) = covar(D*(i-1)+1:D*(i-1)+D,:) + tau(n,i)*(inputs(n,:)-mu(i,:))'*(inputs(n,:)-mu(i,:));
    end
    covar(D*(i-1)+1:D*(i-1)+D,:) = covar(D*(i-1)+1:D*(i-1)+D,:)/sumtau + (1e-5)*eye(D);
    mix(i)=sumtau/N;
  end
  iter=iter+1;
  if (iter==0)
      figure(1)
      plot(inputs(:,1),inputs(:,2),'g.');
      hold on;
      plotClust(mu,covar,1,2); hold off;
      drawnow;
  end
  if (iter==2)
      figure(2)
      plot(inputs(:,1),inputs(:,2),'g.');
      hold on;
      plotClust(mu,covar,1,2); hold off;
      drawnow;
  end
  figure(3)
  clf;
  plot(inputs(:,1),inputs(:,2),'g.');
  hold on;
  plotClust(mu,covar,1,2); hold off;
  drawnow;
end

    
    
    
    