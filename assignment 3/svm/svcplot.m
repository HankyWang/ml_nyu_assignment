function [h] = svcplot(X,Y,ker,alpha,bias,aspect,mag,xaxis,yaxis,input)
%SVCPLOT Support Vector Machine Plotting routine
%
%  Usage: svcplot(X,Y,ker,alpha,bias,zoom,xaxis,yaxis,input)
%
%  Parameters: X      - Training inputs
%              Y      - Training targets
%              ker    - kernel function
%              alpha  - Lagrange Multipliers
%              bias   - Bias term 
%              aspect - Aspect Ratio (default: 0 (fixed), 1 (variable))
%              mag    - display magnification 
%              xaxis  - xaxis input (default: 1) 
%              yaxis  - yaxis input (default: 2)
%              input  - vector of input values (default: zeros(no_of_inputs))
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin < 5 | nargin > 10) % check correct number of arguments
    help svcplot
  else

    epsilon = 1e-5;  
    if (nargin < 10) input = zeros(1,size(X,2));, end
    if (nargin < 9) yaxis = 2;, end
    if (nargin < 8) xaxis = 1;, end
    if (nargin < 7) mag = 0.1;, end
    if (nargin < 6) aspect = 0;, end
    
    % Scale the axes
    xmin = min(X(:,xaxis));, xmax = max(X(:,xaxis)); 
    ymin = min(X(:,yaxis));, ymax = max(X(:,yaxis)); 
    xa = (xmax - xmin);, ya = (ymax - ymin);
    if (~aspect)
       if (0.75*abs(xa) < abs(ya)) 
          offadd = 0.5*(ya*4/3 - xa);, 
          xmin = xmin - offadd - mag*0.5*ya;, xmax = xmax + offadd + mag*0.5*ya;
          ymin = ymin - mag*0.5*ya;, ymax = ymax + mag*0.5*ya;
       else
          offadd = 0.5*(xa*3/4 - ya);, 
          xmin = xmin - mag*0.5*xa;, xmax = xmax + mag*0.5*xa;
          ymin = ymin - offadd - mag*0.5*xa;, ymax = ymax + offadd + mag*0.5*xa;
       end
    else
       xmin = xmin - mag*0.5*xa;, xmax = xmax + mag*0.5*xa;
       ymin = ymin - mag*0.5*ya;, ymax = ymax + mag*0.5*ya;
    end
    
    set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);  

    % Plot function value

    [x,y] = meshgrid(xmin:(xmax-xmin)/50:xmax,ymin:(ymax-ymin)/50:ymax); 
    z = bias*ones(size(x));
    wh = waitbar(0,'Plotting...');
    for x1 = 1 : size(x,1)
      for y1 = 1 : size(x,2)
        input(xaxis) = x(x1,y1);, input(yaxis) = y(x1,y1);
        for i = 1 : length(Y)
          if (abs(alpha(i)) > epsilon)
    	    z(x1,y1) = z(x1,y1) + Y(i)*alpha(i)*svkernel(ker,input,X(i,:));
          end
        end
      end
      waitbar((x1)/size(x,1))
    end
    close(wh)
    l = (-min(min(z)) + max(max(z)))/2.0;
    sp = pcolor(x,y,z);
    shading interp  
    set(sp,'LineStyle','none');
    set(gca,'Clim',[-l  l],'Position',[0 0 1 1])
    axis off
    load cmap
    colormap(colmap)

    % Plot Training points

    hold on
    for i = 1:size(Y)
      if (Y(i) == 1)
        h(1) = plot(X(i,xaxis),X(i,yaxis),'b+','LineWidth',4); % Class A
      else
        h(2) = plot(X(i,xaxis),X(i,yaxis),'r+','LineWidth',4); % Class B
      end
      if (abs(alpha(i)) > epsilon)
        plot(X(i,xaxis),X(i,yaxis),'wo') % Support Vector
      end
    end 

    % Plot Boundary contour

    hold on
    contour(x,y,z,[0 0],'w')
    contour(x,y,z,[-1 -1],'w:')
    contour(x,y,z,[1 1],'w:')
    hold off

  end    
