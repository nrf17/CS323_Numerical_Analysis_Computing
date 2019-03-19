clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('nrh1.txt','r');
inType = '%f';
temp = [1 Inf];
inArr = fscanf(fileIn,inType,temp);
inSize = size(inArr);

%get poly degree, numbers in poly, X0, error, and max iterations
deg = inArr(1);
nums = inArr(2:inSize(2)-3);
x0 = inArr(inSize(2)-2);
epsilon = inArr(inSize(2)-1);
N = inArr(inSize(2));
numsSize = size(nums);

%-----------------------------------------------------------------------

%Do at least 1 iteration of horners, same as last algo
alpha = nums(numsSize(2));
beta = nums(numsSize(2));
i = numsSize(2)-1;
while i >= 1
  if i == 1
  alpha = alpha * x0 + nums(i);
  else 
  alpha = alpha * x0 + nums(i);
  beta = beta * x0 + alpha;
  end 
  i = i - 1; 
end

%------------------------------------------------------------------------

%Continue to do iterations, until you reach max iterations or you are
%within error range
%compute new x1 by newtons method
N = N - 1;
x1 = x0 - (alpha/beta);
err = abs(x1 - x0);

while err > epsilon && N > 0
    %I personally just continued to use my x0 variable, its the new x
    x0 = x1;
    alpha = nums(numsSize(2));
    beta = nums(numsSize(2));
    i = numsSize(2)-1;
    while i >= 1
        if i == 1
            alpha = alpha * x0 + nums(i);
        else
            alpha = alpha * x0 + nums(i);
            beta = beta * x0 + alpha;
        end
        i = i - 1;
    end
    %mark down iterations, compute new x and then error
    N = N - 1;
    x1 = x0 - (alpha/beta);
    err = abs(x1 - x0);
end

%------------------------------------------------------------------------

%display result, if max iterations reached let user know
if N > 0
    fprintf("One root of the polynomial is: " + x0 + "\n");
else
    fprintf("Max number of iterations given as an input reached, so the algorithm halted.\n");
end

fclose(fileIn);