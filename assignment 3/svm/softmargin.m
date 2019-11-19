function y = softmargin(x)
%SOFTMARGIN Support Vector Classification Softmargin
%
%  Usage: y = softmargin(x)
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin ~= 1) % check correct number of arguments
    help softmargin
  else

    y = x;
    y(find(x < -1)) = -1;
    y(find(x > 1)) = 1;

  end    
