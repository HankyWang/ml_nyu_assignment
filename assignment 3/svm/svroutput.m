function tstY = svroutput(trnX,tstX,ker,beta,bias)
%SVRMSE Calculate SVR Output
%
%  Usage: tstY = svroutput(trnX,tstX,ker,beta,bias)
%
%  Parameters: trnX   - Training inputs
%              tstX   - Test inputs
%              ker    - kernel function
%              beta   - Difference of Lagrange Multipliers
%              bias   - bias
%              comp   - sparse components
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin ~= 5) % check correct number of arguments
    help svroutput
  else

    n = size(trnX,1);
    m = size(tstX,1);
    H = zeros(m,n);  
    for i=1:m
      for j=1:n
        H(i,j) = svkernel(ker,tstX(i,:),trnX(j,:));
      end
    end
    tstY = (H*beta +bias);

  end
