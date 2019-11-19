function b = binomial(n,k)
%BINOMIAL compute binomial coefficient
%
%  Usage: b = binomial(n,k)
%
%  Parameters:     ( n )
%              b = (   )
%                  ( k )
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin ~=2 | k>n | k<0 | n<0) % check correct number of arguments
    help binomial
  else
     
     b = prod(k+1:n)/prod(1:(n-k));
     
  end
