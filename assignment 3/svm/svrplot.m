function svrplot(X,Y,ker,beta,bias,e,mag,xaxis,yaxis,input)
%SVRPLOT Support Vector Regression Plotting routine for 1D function
%
%  Usage: svrplot(X,Y,ker,alpha,bias,e,mag,xaxis,yaxis,input)
%
%  Parameters: X      - Training inputs
%              Y      - Training targets
%              ker    - kernel function
%              beta   - Difference of Lagrange Multipliers
%              bias   - Bias term 
%              e      - e insensitive value
%              mag    - display magnification 
%              xaxis  - xaxis input (default: 1) 
%              input  - vector of input values (default: zeros(no_of_inputs))
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin < 5 | nargin > 8) % check correct number of arguments
    help svrplot
  else

    epsilon = 1e-4;  
    if (nargin < 9) input = zeros(1,size(X,2));, end
    if (nargin < 8) xaxis = 1;, end
    if (nargin < 7) mag = 0;, end
    if (nargin < 6) e = 0;, end
    
    xmin = min(X(:,xaxis));, xmax = max(X(:,xaxis)); 
    xa = (xmax - xmin);, xmin = xmin - mag*xa;, xmax = xmax + mag*xa;

    % Plot function value

    n = size(X,1);
    x = [xmin:(xmax-xmin)/300:xmax]; 
    z = bias*ones(size(x));
    for x1 = 1 : length(x)
      input(xaxis) = x(x1);
      for i = 1 : length(Y)
          if (abs(beta(i)) > epsilon)
    	    z(x1) = z(x1) + beta(i)*svkernel(ker,input,X(i,:));
          end
      end
    end
    plot(x,z,'k','linewidth',2);
    axis off
    hold on
    
    % Plot e insensitive zone
    if (e > 0)
       plot(x,z+e,'b:')
       plot(x,z-e,'b:')
    end
 
    % Plot Training points
    
    for i = 1:size(Y)
      plot(X(i),Y(i),'k+') 
      if (abs(beta(i)) > epsilon)
        plot(X(i),Y(i),'ro','markersize',10) % Support Vector
      end
    end
    set(gca,'XLim',[xmin xmax]);  
    hold off

  end    
 
