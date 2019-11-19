load('teapots.mat')
data = teapotImages;
u = mean(data);
X = data - u;
C = cov(X);
[V, D] = eig(C);
[d, ind] = sort(diag(D),'descend');
d = d(1:3,:);
v = V(:,ind(1:3));
c = X*v;
X_hat = u+c*v';

for i = 1:10
    figure(i);
    colormap gray;
    subplot(1,2,1);
    imagesc(reshape(data(i,:),38,50));
    title('Original');
    axis image;
    subplot(1,2,2)
    imagesc(reshape(X_hat(i,:),38,50));
    title('PCA');
    axis image;
end

norm(data-X_hat)

