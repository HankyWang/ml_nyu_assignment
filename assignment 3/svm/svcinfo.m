function svcinfo(trn,tst,ker,alpha,bias)
%SVCINFO Support Vector Classification Results
%
%  Usage: svcinfo(trn,tst,ker,alpha,bias)
%
%  Parameters: trn    - Training set
%              tst    - Test set
%              ker    - kernel function
%              alpha  - Lagrange Multipliers
%              bias   - Bias term 
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin ~= 5) % check correct number of arguments
    help svcinfo
  else

    [ data no_inputs no_outputs] = readdata(trn);
    trnX = data(:,1:no_inputs);
    trnY = data(:,no_inputs+1);
    trnX = svdatanorm(trnX,ker);
    [ data no_inputs no_outputs] = readdata(tst);
    tstX = data(:,1:no_inputs);
    tstY = data(:,no_inputs+1);
    tstX = svdatanorm(tstX,ker);
    epsilon = 1e-10;  
    n = length(trnY);
    m = length(tstY);
    correct = 0;
    for j = 1 : m
      z = bias;
      for i = 1 : n
        if (abs(alpha(i)) > epsilon)
          z = z + trnY(i)*alpha(i)*svkernel(ker,tstX(j,:),trnX(i,:));
        end
      end
      z
      if (sign(z) == tstY(j))
          correct = correct + 1;
      end
      fprintf('Class : %d Predicted: %d\n',tstY(j),sign(z));
    end
   
    fprintf('Classification: %d/%d\n',correct,m); 

  end    
