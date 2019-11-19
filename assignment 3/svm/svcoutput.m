function predictedY = svcoutput(trnX,trnY,tstX,ker,alpha,bias,actfunc)
%SVCOUTPUT Calculate SVC Output
%
%  Usage: predictedY = svcoutput(trnX,trnY,tstX,ker,alpha,bias,actfunc)
%
%  Parameters: trnX   - Training inputs
%              trnY   - Training targets
%              tstX   - Test inputs
%              ker    - kernel function
%              beta   - Lagrange Multipliers
%              bias   - bias
%              actfunc- activation function (0(default) hard | 1 soft) 
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin < 6 | nargin > 7) % check correct number of arguments
    help svcoutput
  else

    if (nargin == 6)
      actfunc = 0;
    end
    n = size(trnX,1);
    m = size(tstX,1);
    H = zeros(m,n);  
    for i=1:m
      for j=1:n
        H(i,j) = trnY(j)*svkernel(ker,tstX(i,:),trnX(j,:));
      end
    end
    if (actfunc)
      predictedY = softmargin(H*alpha + bias);
    else
      predictedY = sign(H*alpha + bias);
    end
  end
