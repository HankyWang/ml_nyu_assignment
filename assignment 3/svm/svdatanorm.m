function [X, A, B] = svdatanorm(X,ker,isotropic)
%SVDATANORM normalises the data X for the kernel ker 
%
%  Usage: [X A B] = svdatanorm(X,ker)
%
%  Parameters: X         - training data
%              ker       - kernel type
%              isotropic - isotropic (1:default) or anisotropic (0) scaling
%              
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin <2 | nargin>3) % check correct number of arguments
     help svdatanorm
  else
    if (nargin < 3) isotropic = 0;, end
 
    switch lower(ker)
      case {'curvspline','spline', 'anovaspline1', 'anovaspline2', 'anovaspline2'}
        lb = 0;, ub = 1;
      case {'fourier'}
        lb = -pi/2;, ub = pi/2;
      case {'temp'}
        lb = 0.15;, ub = 0.85;
      otherwise
        lb = -1;, ub = 1;
    end
    
    n = size(X,2); % input dimension 
    sca = zeros(n,1);
    mina = zeros(n,1);
    maxa = zeros(n,1);
    A = zeros(n,1);
    B = zeros(n,1);
    for i=1:n
       mina(i) = min(X(:,i));
       maxa(i) = max(X(:,i));
       sca(i) = maxa(i) - mina(i);
    end
       
    for i=1:n
       if (isotropic)
          sca(i) = max(sca);
       end
       if sca(i)
          A(i) = (ub - lb)/sca(i);
          B(i) = lb - A(i)*mina(i);
          X(:,i) = A(i)*X(:,i) + B(i);
       end
    end
    
       
  end
