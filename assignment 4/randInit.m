function [mu,covar,mix] = randInit(inputs,M)
%
% function [mu,covar,mix] = randInit(inputs,M)
%
%
%  inputs      are the data, columns are dimensions, rows are points
%  M           is # clusters to fit
%
%  mu          are the resulting means (cols are dimensions)
%  cov         are the resulting covariance matricies stacked vertically
%              (i.e. cov is M*dim rows by dim cols)
%  mix         is a column vector of the component mixtures
%
%  D is dimensionality
%  N is # data points in set to fit
%  R is inverse of covariance matrix

dim1 = 1;
dim2 = 2;
vscale = 2;
grain = 40;

[N,D]=size(inputs); 	

% Randomly initialize M Gaussians

mx = max(inputs);
mn = min(inputs);
initmu = (mx+mn)/2;
initsd = (mx-mn)/(M^(1/D));

mu = [];
for (i=1:M)
  mux = (rand(size(mx)).*(mx-mn) + mn);
  mu  = [mu; mux];
end

initcv = diag((initsd/vscale).^2,0);

R=zeros(M*D,D);
for i=1:M
  q = rand(size(initcv))-0.5*ones(size(initcv));
  q = q*q'*2*mean(initsd);
  scal = (mean(initsd)/M)*(mean(initsd)/M);
  q = scal*eye(size(initcv));
  R((i-1)*D+1:i*D,:)=inv(q);
end

mix = ones(M,1)/M;

clf
axis([mn(dim1) mx(dim1) mn(dim2) mx(dim2)]);
for i=1:M
  covar((i-1)*D+1:i*D,:)=inv(R((i-1)*D+1:i*D,:));
end

plot(inputs(:,dim1),inputs(:,dim2),'g.');
hold on; plotClust(mu,covar,dim1,dim2); hold off;
axis('image');
drawnow;



