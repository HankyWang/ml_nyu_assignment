function [] = plotGauss(mu1,mu2,var1,var2,covar)
%plotGauss(mu1,mu2,var1,var2,covar)
%
%PLOT A 2D Gaussian
%This function plots the given 2D gaussian on the current plot.

t = -pi:.01:pi;
k = length(t);
x = sin(t);
y = cos(t);

R = [var1 covar; covar var2];

[vv,dd] = eig(R);
A = real((vv*sqrt(dd))');
%A = real((vv*dd)');
z = [x' y']*A;

hold on;
plot(mu1,mu2,'X');
plot(z(:,1)+mu1,z(:,2)+mu2,'.');