function err = svrerror(trnX,tstX,tstY,ker,beta,bias,loss,e)
%SVRERROR Calculate SVR Error
%
%  Usage: err = svrerror(trnX,tstX,tstY,ker,beta,bias,loss,e)
%
%  Parameters: trnX   - Training inputs
%              tstX   - Test inputs
%              tstY   - Test targets
%              ker    - kernel function
%              beta   - Difference of Lagrange Multipliers
%              bias   - bias
%              loss   - loss function
%              e      - e insensitive 
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin < 6 | nargin > 8) % check correct number of arguments
    help svrerror
  else

    if (nargin < 8), e = 0.0;, end
    if (nargin < 7), loss = 'eInsensitive';, end
    n = size(trnX,1);
    m = length(tstY);
    H = zeros(m,n);  
    for i=1:m
      for j=1:n
        H(i,j) = svkernel(ker,tstX(i,:),trnX(j,:));
      end
    end
    errvec = (H*beta - tstY+bias);

    switch lower(loss)
      case 'einsensitive',
        errvec = abs(errvec) - e;
        err = mean(errvec.*(errvec > 0));
      case 'quadratic',
        err = mean(errvec.*errvec);
      otherwise, disp('Error: Unknown Loss Function\n');
    end  

  end
