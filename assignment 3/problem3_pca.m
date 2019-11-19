load('teapots.mat')
X = teapotImages;
[coeff3, score3] = pca(X,'Algorithm','eig','Rows','all','NumComponents',3);
X_hat3 = mean(X)+score3*coeff3';
[coeff6, score6] = pca(X,'Algorithm','eig','Rows','all','NumComponents',6);
X_hat6 = mean(X)+score6*coeff6';
[coeff32, score32] = pca(X,'Algorithm','eig','Rows','all','NumComponents',32);
X_hat32 = mean(X)+score32*coeff32';


figure(1);
colormap gray;
subplot(2,2,1);
imagesc(reshape(data(10,:),38,50));
title('Original');
axis image;
subplot(2,2,2)
imagesc(reshape(X_hat3(10,:),38,50));
title('top-3');
axis image;
subplot(2,2,3)
imagesc(reshape(X_hat6(10,:),38,50));
title('top-6');
axis image;
subplot(2,2,4)
imagesc(reshape(X_hat32(10,:),38,50));
title('top-32');
axis image;


