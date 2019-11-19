function [] = plotClust(mu,c,d1,d2)
%plotClust(mu,c,d1,d2)
%
%PLOT THE PROJECTION OF A GAUSSIAN CLUSTER
%This function plots the projection of a gaussian cluster
%in two dimensions.


M = size(mu,1);
D = size(mu,2);

%hold on;
for i=1:M
  plotGauss(mu(i,d1),mu(i,d2),c(d1+(i-1)*D,d1),c(d2+(i-1)*D,d2),...
               c(d1+(i-1)*D,d2));
end